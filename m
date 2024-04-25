Return-Path: <linux-kernel+bounces-158862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FED8B25EA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0F4EB26A33
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD7614D2A4;
	Thu, 25 Apr 2024 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=florommel.de header.i=@florommel.de header.b="VL9/+SNG"
Received: from read.uberspace.de (read.uberspace.de [185.26.156.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A5214C58E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061019; cv=none; b=C/bKMWgnkQ8NllQFreGtquAb7k4nJEbCQxgUBm1mPZYDQFPLVr9jUrPCDR1GJWRZ7YWsF/mL22+B76S4GljqpnaWNRYpYsDYhBpuYJCcYWX9Fmid9xcyCTkPif0ighdUExEYHoqdVet0tasWh+DoWXJtU3JVJ/AzrZc48pGNX+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061019; c=relaxed/simple;
	bh=OqUDxo5jnbeq4E/p9TpxkO9IWm1pyo9rFs4m+YZepdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fm9NOTc42ckvFtBjbMoTUEJ87G7U48ZsQocL3j80lf4D+DJt+qVEvdW/pFCDF5fPQF0Cg2Bqzs1H7pDbXOW0IcDGy7Dz9W2ZbcUlLv7R2w/7olqIxDeAeOoWcaB09Et7wGECvK8wryp0V1GZWvN8wwezvAnRpBRCaso11hUJGfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de; spf=pass smtp.mailfrom=florommel.de; dkim=fail (0-bit key) header.d=florommel.de header.i=@florommel.de header.b=VL9/+SNG reason="key not found in DNS"; arc=none smtp.client-ip=185.26.156.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=florommel.de
Received: (qmail 30623 invoked by uid 990); 25 Apr 2024 15:36:36 -0000
Authentication-Results: read.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by read.uberspace.de (Haraka/3.0.1) with ESMTPSA; Thu, 25 Apr 2024 17:36:36 +0200
From: Florian Rommel <mail@florommel.de>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>
Cc: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Florian Rommel <mail@florommel.de>
Subject: [PATCH 1/4] scripts/gdb: Fix failing KGDB detection during probe
Date: Thu, 25 Apr 2024 17:34:58 +0200
Message-ID: <20240425153501.749966-2-mail@florommel.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425153501.749966-1-mail@florommel.de>
References: <20240425153501.749966-1-mail@florommel.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.997039) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.597039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=florommel.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=OqUDxo5jnbeq4E/p9TpxkO9IWm1pyo9rFs4m+YZepdY=;
	b=VL9/+SNGECJcTKGmEy8Q4ijlUWL/nGHUqvTWAYMCmJqSj6vY7gxcN6eQePey715nZnVndT3nrY
	0a+kZ5tNGX80BlgZh+p0Q6CRMBqU5FyHpCsSASpWfCWgbmo3jLrAbotJ8ZFjNf9e8jhQx0+8s9GG
	dRAvFwcEoERs0hGfNF3SRSjsz348BiurPeom1CNE/Pg3IsD15VK8ofQx4ZAGwVTLnspLAbVAN1BA
	4LoqW0FhWk8PEucfwTbiwPeZOWsWaxL0Sl14ok4iQdjMr8ZFaIXh9wBrIVukrRfO0F8xLLzZdhLw
	gzElLkz5hBGeNcch4s5j1ODGC8d0z397SlpzMZ/Qeoa09wHdDBTD/O85gUBRyixK4Z8B7lr+MKw6
	ydXz60+ndHfFhZzc19JJEa34Tgvv6Xw6BE4jsqYq/MxpxwaObaOiU4c/T7CiZxiJv04dp9xeaVSX
	Wu5Fnsu+/MueXMWcEUA5GPJBL86UXetQA13RdHiBl5QHSXGyN1UBNlvZ8sMX3dpzbui06MYDzxew
	ZaBRY93RmFVVyKttP7GEF9U+Y1O2peAesJyVBM6cx5wIaTyFUz8NvooIbrU/YQC3XcvBUrFdwJke
	6Q+TwnjBTZbhCv8At96cUgDbuS4F/o2vD172zCdntm4RusVxsOaju97Wn3wcLlJT7MBVyILfclz5
	A=

The KGDB probe function sometimes failed to detect KGDB for SMP machines as
it assumed that task 2 (kthreadd) is running on CPU 0, which is not
necessarily the case.  Now, the detection is agnostic to kthreadd's CPU.

Signed-off-by: Florian Rommel <mail@florommel.de>
---
 scripts/gdb/linux/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
index 7d5278d815fa..245ab297ea84 100644
--- a/scripts/gdb/linux/utils.py
+++ b/scripts/gdb/linux/utils.py
@@ -196,7 +196,7 @@ def get_gdbserver_type():
     def probe_kgdb():
         try:
             thread_info = gdb.execute("info thread 2", to_string=True)
-            return "shadowCPU0" in thread_info
+            return "shadowCPU" in thread_info
         except gdb.error:
             return False
 
-- 
2.44.0


