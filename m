Return-Path: <linux-kernel+bounces-158830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC0F8B257C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB43B28E80
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B519014BF89;
	Thu, 25 Apr 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=florommel.de header.i=@florommel.de header.b="Zp4TGPi7"
Received: from read.uberspace.de (read.uberspace.de [185.26.156.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89E514B086
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059821; cv=none; b=jgSkcb6vO7ZyJW/coPmahV0SDAhBTOyphCeGsPMg6e4nQLT+AAGIqjeaOoTePkgasmV/RDwOvj1yzMxWQx7j0QOF14uo2ugohof9NJrqFCdQ7zG89Hk6N5KOUKxw72Y7FTYq4f6bOczYhVnUqRmPoa1TdsB9XkoUb+APYzMMt0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059821; c=relaxed/simple;
	bh=PFSo08OuHGBuBBReLB/w3zYNHRv/sFj6evMDpx6HkYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c26Ww1O26L4Z9s+cM6bCTsqNWPvGerZpBVwf9KZA4Wxpoit0VmYoMSoWQ2/wtqtIwJt+/UbKGmfbDfNn0T1chQlKXqixPeckvQ+e8fznldEcnddXWdIvodQUq+33kHW8k56x5LuWIDWa654v02ZCEExS22m5Qf2NqY3QatWoQHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de; spf=pass smtp.mailfrom=florommel.de; dkim=fail (0-bit key) header.d=florommel.de header.i=@florommel.de header.b=Zp4TGPi7 reason="key not found in DNS"; arc=none smtp.client-ip=185.26.156.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=florommel.de
Received: (qmail 30745 invoked by uid 990); 25 Apr 2024 15:36:38 -0000
Authentication-Results: read.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by read.uberspace.de (Haraka/3.0.1) with ESMTPSA; Thu, 25 Apr 2024 17:36:38 +0200
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
Subject: [PATCH 4/4] scripts/gdb: Fix detection of current CPU in KGDB
Date: Thu, 25 Apr 2024 17:35:01 +0200
Message-ID: <20240425153501.749966-5-mail@florommel.de>
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
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.030286) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.630286
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=florommel.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=PFSo08OuHGBuBBReLB/w3zYNHRv/sFj6evMDpx6HkYE=;
	b=Zp4TGPi7xeJSc9YTX8EtU6Bx65jEzXjlS2pZzWZw+oRi6lIqFGL7CNR+h/AV9q6h+DGepffBht
	VB/3wG9PGeQ6+i3jnkWHoP9JBTB2EqFJ4X2qo5V5w1Ula/HBbDxSRTZKq0HZx1EfmR0pILMPbkGZ
	aL0DZikfMFCDaYo2iU53Ev48kB5QzYzj+8qdr+rLpsOZchEinkGKJ6TAg3fwJ6zGPNjaZ36WArR8
	iSs9Yq2ryvClBlKIiRtJLHQmIcmjd1ogUevu49EjI+x3eOeCAiv4gh8YGxvsN0bVUzlGNbppiVfh
	fuRjGGAaVbYpnC0XTOVLTIOhjLH1ed7vrCVphm8Ahl2kWFNuw2+694U11gP2nFFNgxGHWTNO1xkD
	ijX2N5mJ/wYIez/oYb+ONmutitIXFhsfUhOgeD0yxgCjuLYZ3rboiMoykqOSHY4FfdWHJvSOcMLu
	IFGdDM7K9Mktv+6CZYmCm2VaHeaHl2HB+iSF5ovrV6MGPXPQs4zmYisDDfwWSjfzRLtc+KOmahyk
	XEDQ8GsiZDVEQ7wuPkvxr4OyUlIBMJxPHz7U+DUG2IF7zcIrY4eAZVE13ZHrmVLjcdOn3IKuftbN
	nQT+OZRirC3vYkkh4UePpSjKS4V4eY0+0MsACCXmRGqj7XFihNW27LcPiEMJ9KEIP4TH+qhrOp2D
	8=

Directly read the current CPU number from the kgdb_active variable.

Before, the active CPU was obtained through the current task, which
required searching the task list for the pid of GDB's selected thread.
Obtaining the pid was buggy:
GDB may use selected_thread().ptid[1] (LWPID) instead of .ptid[2] (TID) to
store the threads pid; see
https://sourceware.org/gdb/current/onlinedocs/gdb.html/Threads-In-Python.html
As a result, the detection could return the wrong CPU number, leading to
incorrect results for $lx_per_cpu and $lx_current.

As a side effect, the patch significantly speeds up $lx_per_cpu and
$lx_current in KGDB by avoiding the task-list iteration.

Signed-off-by: Florian Rommel <mail@florommel.de>
---
 scripts/gdb/linux/cpus.py | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 2b51a3abd363..2f11c4f9c345 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -26,11 +26,7 @@ def get_current_cpu():
     if utils.get_gdbserver_type() == utils.GDBSERVER_QEMU:
         return gdb.selected_thread().num - 1
     elif utils.get_gdbserver_type() == utils.GDBSERVER_KGDB:
-        tid = gdb.selected_thread().ptid[2]
-        if tid > (0x100000000 - MAX_CPUS - 2):
-            return 0x100000000 - tid - 2
-        else:
-            return tasks.get_thread_info(tasks.get_task_by_pid(tid))['cpu']
+        return gdb.parse_and_eval("kgdb_active.counter")
     else:
         raise gdb.GdbError("Sorry, obtaining the current CPU is not yet "
                            "supported with this gdb server.")
-- 
2.44.0


