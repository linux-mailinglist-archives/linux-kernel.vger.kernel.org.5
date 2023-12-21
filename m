Return-Path: <linux-kernel+bounces-8041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ECE81B14A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722001C237E6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FD94E1D0;
	Thu, 21 Dec 2023 08:59:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D774C62B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id B9A791868C8B;
	Thu, 21 Dec 2023 11:59:22 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id awnM1zYKUyd1; Thu, 21 Dec 2023 11:59:22 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id 6FFDB1866581;
	Thu, 21 Dec 2023 11:59:22 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mU5WqeFFNcR2; Thu, 21 Dec 2023 11:59:22 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.25])
	by mail.astralinux.ru (Postfix) with ESMTPSA id 93F8A1862935;
	Thu, 21 Dec 2023 11:59:21 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: David Howells <dhowells@redhat.com>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] afs: remove redundant overwriting of ret
Date: Thu, 21 Dec 2023 11:58:49 +0300
Message-Id: <20231221085849.1463-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ret is the result of dns lookup. There are several
ways to handle different errors (described by switch).
So it is necessary to keep the return value of afs_dns_query.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d5c32c89b208 ("afs: Fix cell DNS lookup")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 fs/afs/cell.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 988c2ac7cece..9a112e03bee1 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -409,7 +409,6 @@ static int afs_update_cell(struct afs_cell *cell)
 		if (ret =3D=3D -ENOMEM)
 			goto out_wake;
=20
-		ret =3D -ENOMEM;
 		vllist =3D afs_alloc_vlserver_list(0);
 		if (!vllist)
 			goto out_wake;
--=20
2.30.2


