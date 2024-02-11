Return-Path: <linux-kernel+bounces-60624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CD9850787
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 01:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C45681F21C53
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF7315D2;
	Sun, 11 Feb 2024 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="rYQG8Zxx"
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458F415B1;
	Sun, 11 Feb 2024 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707612027; cv=none; b=ZN29qOYL4uA7yiOBBfaKN2HTClpuiiiIO9PYmTv0Dvx05guur3UOXZ0ps6wzc+tzPgOoERSbmmzeqYq13O+qgCSGAvQEb47+aECKpBFKzz077zUBYZpp7/6xDSW0Cb4huewRbuWNeF1WFD/RohgOTUpg/KK6ebUNrd71GOHgqZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707612027; c=relaxed/simple;
	bh=wmHERYYN058/RFLczrPeOcXAoo/yUFyAt/tHzV8DLHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XSQ0IaZUG0O+rh5h0jppz+c1y9xbrXH30xKJxgb59G2/X5auds8wTR3jtU6f+xyvlRyLdsrlvNLWvAnWV1ETHvH2guuqO9rtfnTCdLDm+CSZpKa2/RVoobr2Qul8FX+aHE2EBaram3i513A72oNrrsEzuQfSfan1WTDqIlQQdP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=rYQG8Zxx; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=heusel.eu;
	s=s1-ionos; t=1707611992; x=1708216792; i=christian@heusel.eu;
	bh=wmHERYYN058/RFLczrPeOcXAoo/yUFyAt/tHzV8DLHc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=rYQG8Zxxn37LNmPQ2IrloJg4YF0tYXfeMdJeWAw2NuoTtT2imBfGnmnEhmzNbE9Y
	 mkRJXIqpeEmFTpvCJrpaSZ8chuKyjZZZ6d6S93U/f7NBlWEe/2/aMyJkj2tcRfBag
	 BkyJRCe/3YjPRUXsgFN+un6LnYVO5AMeQFobAxNsIjFMXqfVcmV/TxsbPqDUDqk/1
	 34IJ5X4PDBHhMvS5ZRlCn4Iz2pOrjYl02s7+dpjCcvvRZHKCJSVGtQiYL/9uwBvHU
	 X6eaje5bta3ocxoMOHu2w2/UujYtcbmOEYJcQThH4XK6dyfFd78d/+GXwFA5pEjU5
	 J0FIojCnhYRGHIB3tA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from meterpeter.INF524.stwhd ([141.70.80.5]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Msqpq-1qgBRA1HIm-00tGhj; Sun, 11 Feb 2024 01:39:52 +0100
From: Christian Heusel <christian@heusel.eu>
To: David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Christian Heusel <christian@heusel.eu>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
Subject: [PATCH] jffs2: print symbolic error name instead of error code
Date: Sun, 11 Feb 2024 01:39:04 +0100
Message-ID: <20240211003907.167891-1-christian@heusel.eu>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mdD+cC108pnAZXbGv+PQh7kUVRHEsQ7+KfabFD+Q5ylCBajXVwQ
 +3RET9o94ZZ71QCJpskyjPJvAMRbY4jidCoz5a7lci+4ts8IwctXPBczn4wJZkX+HmNb7zt
 3JHIDZQ9nyKxYuZXIJ7kW1x0Vr8w/6+Bg70MFNvB+DRKWEUoy7avmZh4BcX8tmLEDUn/T6n
 mZ/tfamT+oPSSc1NIMIEQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pinJemaaIv0=;vsBcASSi2Z1p+Lp65An5yLWwkcy
 LRfNErQyBdSATIHLfrW3qEeDiDDHmHXrWLlmImFBeQkI3sL4ELNSAnEk8CYvFI2Lk33eZRiYG
 kctBAHBn+Lya0INz4uM/PslB7hJvO0t07zpP/71hEFBDoltvW8OV8Zo11mPqtBc9HQyel358c
 TlVPrsRPqYL+HF5QztoF4+41vDnoZAre54DALKhm47TUOq2ALeMUEPFxCl7mUogno+OSleMx+
 fb6m5DNAu17khHcfffpd8qDN2qaXolV8EEIrAz6Y473MvPE7EE3xV9RZhThxqWUpIdnGYsskR
 TlaiVINg5612ED4saHJGXSvaMiSLDdLe4W/aQRvkwZujHLJWIx/TwrTsUixTLAavF7D+wSf56
 vskI54DQxEbsdI7tmpjaX1mDzs9D3T2i7fi2h47pYKSCemRzhWFAQfLJcGwjDBfni7wMHCsf6
 knzfEffgVGX8EhwvxcT+Yq4SQgVF+2EYbw9BuWBWop66ZS8Q43QabA2OlY8I+YokEV6yvZlnS
 bCvPwdc4IiYBE5+BwoQ94TNf7Jje9vprKuJko/C4qyUozIMYrPcVCMOPCRa51rn9swkVCiQLb
 LQdKpaavG7qM5tPuXJgDHqxuy58OpuyccOxEgjMqt7Jg/4+aLMA7g9sQdMt0h/obSY7jnsXXl
 JiYdMtNCtM21tQ2IGya08B8PAyrYCYyhL8guevNpgXRSL+I44McjTH9qUjtk5tFAooZIzEsN3
 DFX9Eju0oOsUZFtIPNX+rlaSAoRbYs6QSW4V22JRvXc5xhBUiN6Lr8=

Utilize the %pe print specifier to get the symbolic error name as a
string (i.e "-ENOMEM") in the log message instead of the error code to
increase its readablility.

This change was suggested in
https://lore.kernel.org/all/92972476-0b1f-4d0a-9951-af3fc8bc6e65@suswa.mou=
ntain/

Signed-off-by: Christian Heusel <christian@heusel.eu>
=2D--
 fs/jffs2/background.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jffs2/background.c b/fs/jffs2/background.c
index 6da92ecaf66d..bb0ee1a59e71 100644
=2D-- a/fs/jffs2/background.c
+++ b/fs/jffs2/background.c
@@ -44,8 +44,8 @@ int jffs2_start_garbage_collect_thread(struct jffs2_sb_i=
nfo *c)

 	tsk =3D kthread_run(jffs2_garbage_collect_thread, c, "jffs2_gcd_mtd%d", =
c->mtd->index);
 	if (IS_ERR(tsk)) {
-		pr_warn("fork failed for JFFS2 garbage collect thread: %ld\n",
-			-PTR_ERR(tsk));
+		pr_warn("fork failed for JFFS2 garbage collect thread: %pe\n",
+			tsk);
 		complete(&c->gc_thread_exit);
 		ret =3D PTR_ERR(tsk);
 	} else {
=2D-
2.43.1


