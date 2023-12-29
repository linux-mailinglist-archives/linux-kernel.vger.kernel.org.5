Return-Path: <linux-kernel+bounces-13065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7AC81FF34
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054461F21B19
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640181118F;
	Fri, 29 Dec 2023 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dBX6iQY1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AE211181;
	Fri, 29 Dec 2023 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703849868; x=1704454668; i=markus.elfring@web.de;
	bh=JBK+I0+RWpVt/64+ENmmEbIiZBHu+wn1RAw0cM1AQC0=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=dBX6iQY144i8JIIiPa4nd36mumgVF/Az+KjQopmtaAXxAjpSikitbAh1IRBBTNUp
	 qcH+Su7ppyswZbkykOk50n8z89XEDKs9xUSyzUcojJ1EXJsH+RDCK1GYQjre8Q5xq
	 WGP6wgdsTGR4mc0xvfViCs8bGSS0W9JgnjKAwCg2nPRF3zZ/0YKf/qacLrvG2maYp
	 zm37ZQ5Y/VcbahcLJ7tFvInt0z513xcY4D6nNtEonBoGOjv3UYHNJ3aCpLoB+aDm8
	 XXi9m4amrIsP7U+KOibqeR1mQWvnnB669wB8hfgvygTpNozTQ9ntlKmjng0iF9pw3
	 9NmknIHHt9fG0LFT0A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLAVc-1raIMY3NSs-00IcLc; Fri, 29
 Dec 2023 12:37:48 +0100
Message-ID: <8c9488b0-4d91-48ac-bee7-6454e3045a9f@web.de>
Date: Fri, 29 Dec 2023 12:37:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] hugetlbfs: Improve a size determination in two functions
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-mm@kvack.org, kernel-janitors@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <9ce3f553-24bc-4ecd-ac5e-7ba27caeff57@web.de>
In-Reply-To: <9ce3f553-24bc-4ecd-ac5e-7ba27caeff57@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0fmZJp4JlhAFSU+/KR4BIDEALzLIgB7Yzk/1jVkAKXarioNoWp9
 LfcZBR4WpgfSElMkwfdr2Hs9mqEJru39lonItmW27YeBWTLgoLQv5uk2VGUbUrkIFQo9f8e
 kUvNv/9VOy0b6BPOdP3TZnzN9QOwe4PXoA7BShRlU/0L4Knx0fxD/fQ6q9h1fwhS6CM5c+e
 6Sa9LHZEp/jeGlXjfkXRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZqJ9W1MrSY4=;WtGwAIo7u/RkWqQAQncXsE90bRH
 BY1hXtTWszVKpfsn9IXuZ1/drNGI8vdPYhksYrqm2FqtsJ21s43NtRoY/74V00TzYhdq801fG
 r8Mt4+GQb5O5Hv2YuaFqpYMnPmapVCdInlr5BfF3sCsDmkxfyCl9iCPhIzYxu3o5FVt2KgenO
 ldJIajCiKDsAi4LkEJRu0B8E0PuIY5TvlyzF5hQNjX88mqmkzHKRcBAJvUkZFPi+igx+/5dM9
 SqSJZIU1z2wzjALREUOq8z9fz2a4DT7lSYfdbRqkaIHoONCgSKfdwEYI46FaQ5Q+mgUQmbcqr
 WB/s1HCx2al4jg2QNyFopRCCBqgckfnSPya0D+43x7229CCEaTTYnPL+7aXr6k7pC1qyA5bpU
 Vvy++aSrfP8zcOBVy1sg7JJvZ3ERZxvx5PkzeeGgjZ4ANhEHzE22tWfyUjtncDKQxr0jy5GC2
 mJk/mUjvjH4Wgxx2aikUhUN6Fos30jIjtpDAvE+yA8SH7dWibs6BTs/+EbYZubqZhg+QsCwLJ
 7zoE+bbo+uFOJnU9wW7FKE7diHFovRqil1qrB7fB1ZLs3s0jJC13QcjeWoLD1DVXi+KE+qlLr
 eqvsTdyWqrYujzOpv0cxhrex8JrLQtC1fuFGlcTwXLop5iOWsr395dGHniqH2vuDdiLBaoTDn
 BDIBOid11/fds3FWqi2krkYRTsXJH5fYxZfpDn36bRhO7aKL29f3b0n5M8agSE4CB/AmHQuAd
 hCQBLEyB0APFJBEDaCLMXrxLnpV3kl8+WsmoXYinAXXple2GYa9XjYrgFBICXpJo1O0Sm0WEC
 VNSmEUBHqRYihAKOXZJm3q2x6xWzmomwcJrV3TyzzJEKnaO92U1qPiXfUCa/XbmbM9Eb8pvR2
 oj1pN/VoM/nbnQlKUf80n7GIAT2QMxsccxThZULMNgCjJ7/DIMYJC4ppeowW1pbyM0tFaVS97
 cmuwnw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 29 Dec 2023 11:32:07 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator =E2=80=9Csizeof=E2=80=9D to make the cor=
responding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/hugetlbfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index ea5b8e57d904..24401a5046dd 100644
=2D-- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1460,7 +1460,7 @@ hugetlbfs_fill_super(struct super_block *sb, struct =
fs_context *fc)
 	struct hugetlbfs_fs_context *ctx =3D fc->fs_private;
 	struct hugetlbfs_sb_info *sbinfo;

-	sbinfo =3D kmalloc(sizeof(struct hugetlbfs_sb_info), GFP_KERNEL);
+	sbinfo =3D kmalloc(sizeof(*sbinfo), GFP_KERNEL);
 	if (!sbinfo)
 		return -ENOMEM;
 	sb->s_fs_info =3D sbinfo;
@@ -1530,7 +1530,7 @@ static int hugetlbfs_init_fs_context(struct fs_conte=
xt *fc)
 {
 	struct hugetlbfs_fs_context *ctx;

-	ctx =3D kzalloc(sizeof(struct hugetlbfs_fs_context), GFP_KERNEL);
+	ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;

=2D-
2.43.0


