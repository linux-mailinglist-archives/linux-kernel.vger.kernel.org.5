Return-Path: <linux-kernel+bounces-124822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23462891CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F7D283BFD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595C91A437C;
	Fri, 29 Mar 2024 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLtfuxNm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D8C1A4365;
	Fri, 29 Mar 2024 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716233; cv=none; b=SG5CJOgJ1BbyHsYafd5EJOtxGe+Vz4E5vBQZnBCjMk+xeTwC+Q/tE/oSGTEO4KIXF8yW38x2M1/vOfRVS5pNhGdAJoBpO4ySre74TVwkerHNCGib+PCWB5eKdpUN03ZtmPo9KnCX1lY4aNnB2iKPqRNPItfYn0bpdkiN9EbKl+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716233; c=relaxed/simple;
	bh=0EtcZnQ2ML1W/UpP30qzVQ2kdJfgXO/n9Svx2XlLXWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tvj4J/ass63cO5l0vxLveyJIWJ4zv5q9UwifWsNHQeoUU3VPp+dmQgsfFCsfh/znwyYWGH9D3/6koEWrf6h9KloQN1jSdin+bPKGmPf4SIQ2whJuDLlORfY1TkVooiamlwF6TZ3ZGGiie69R3PaVFRFRSA4H2nZuk/RTqIO6m0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLtfuxNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11C5C43390;
	Fri, 29 Mar 2024 12:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716233;
	bh=0EtcZnQ2ML1W/UpP30qzVQ2kdJfgXO/n9Svx2XlLXWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tLtfuxNmyIkGB61ZkKS6FACEErmGkEpNQBQZEkLUTbjZ/6byo7RvvnfPVx9XyV1Bs
	 vnvM6CC7gJ3BJNshK0OZRh7dG5k9SJMxgHqbUBjgyjD9iJJi5ZqKonePJRyiBH+ISh
	 wQlPuajPqQJo0+eJHLcJhV9ZsjJnkuP/BXyoAg0jrZ99V5EQqFeqtHYwnYo3Pfk4Nc
	 zSNTDXJ395H6BMadG7u6NK3qfUYKXmlwgrwjjYUBfqRudNKaUHjI4j5Y3BP6BlMGaU
	 nA1Ug+xTtXHA3IGEZawHQ6YXy7BoJC3esGQr+1OORfmlJBJ+KIqxuF7joDpWNf5qjO
	 F07ArfG5RclBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 13/75] printk: For @suppress_panic_printk check for other CPU in panic
Date: Fri, 29 Mar 2024 08:41:54 -0400
Message-ID: <20240329124330.3089520-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: John Ogness <john.ogness@linutronix.de>

[ Upstream commit 0ab7cdd00491b532591ef065be706301de7e448f ]

Currently @suppress_panic_printk is checked along with
non-matching @panic_cpu and current CPU. This works
because @suppress_panic_printk is only set when
panic_in_progress() is true.

Rather than relying on the @suppress_panic_printk semantics,
use the concise helper function other_cpu_in_progress(). The
helper function exists to avoid open coding such tests.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240207134103.1357162-7-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0b3af1529778c..9ca10507f7c47 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2274,8 +2274,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (unlikely(suppress_printk))
 		return 0;
 
-	if (unlikely(suppress_panic_printk) &&
-	    atomic_read(&panic_cpu) != raw_smp_processor_id())
+	if (unlikely(suppress_panic_printk) && other_cpu_in_panic())
 		return 0;
 
 	if (level == LOGLEVEL_SCHED) {
-- 
2.43.0


