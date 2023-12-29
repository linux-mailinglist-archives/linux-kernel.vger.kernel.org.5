Return-Path: <linux-kernel+bounces-13066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B29E881FF36
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51FA01F22D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3426211194;
	Fri, 29 Dec 2023 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aJPqrjSi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D81C10A3E;
	Fri, 29 Dec 2023 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703850014; x=1704454814; i=markus.elfring@web.de;
	bh=UHYDVlvrvWOSRegpd/VlmhDK9J+cjiRSKZxQmGzus70=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=aJPqrjSi6IOnqog50GT0ZJnWPo6T9J/P8/98PMs/aZq9AaqbnbRRFoyxlQVfP006
	 v5MMUwNFH5OLUzpcsflmb0UvK+VxvwsFMHmVdwYpGHzYBvLI8mubGl/QdyQi9FEmd
	 QdktHUWIERl4+M/A8klFCm8rl8NvCjxCVV66yBcIj5F7P1RyHMtSea+/010fGLrNp
	 IIqsp7sG5x0CBBKKJsaQhT6LjbhO3AY583hbHyHRg8ussdU+SWJFl03VURkheIxaw
	 hRNM0L+xTpiNa9s13KjMsfrj4DqMbVyamEWR6Js0+c5/tzwH/PP91pC/z3w41r2Zd
	 TiLThe8+2Zy9dCVxMA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuFD5-1qyVCi3oGz-00uPL1; Fri, 29
 Dec 2023 12:40:13 +0100
Message-ID: <b109b7dc-3972-4b2e-ae4c-89bf8eecf8f2@web.de>
Date: Fri, 29 Dec 2023 12:40:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] hugetlbfs: Improve exception handling in
 hugetlbfs_fill_super()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-mm@kvack.org, kernel-janitors@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <9ce3f553-24bc-4ecd-ac5e-7ba27caeff57@web.de>
In-Reply-To: <9ce3f553-24bc-4ecd-ac5e-7ba27caeff57@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QPFYYP3aCa+simUrAouMcW9QcK5xtcbjpkdZdiHYFJ+XmWYAPxj
 MAk7mAaomOMcC7dd+4bk3MS+xC1kiLqz9IwL3wFjPXgPy+wVyiqZr1CPu6ie84PIjbVEegE
 aD2E60sZGpEVmu/s0Mm1yTJDgBP0jEAyyFvpfmDrXsbvQjDvH5dII33uoh+IEhUl7LAOb9Y
 B7aEwLeGFLrhd/rtCVCLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R9CIMRG8WIo=;I1ZtYzDfS2V0P2/oJTEFDGzc7mE
 waxeyt9HIlp9n4gvok5KWoDW1+h9mpIgpqv2Ie0cP4Vw1waLrSMVN6RObZX4jyCn3vFOF6YqP
 g6XAsPN2GrLIxb59gmwUIO3BLvHWseyR6D4hIVtKMvpLQzNyhnrl7M9hthpRy46Fb3YQoVcxf
 kgL9qQwbSKK89YEpXQ0aYTmI/a9c39lSznzGb1xVGaqDoC633AIi+BF3Cl+37DwbiIuqb54Cp
 6y0XXzW3diz0T+w9GCf+nTGyhL7FagbzcIdIw7toB8UQ4r5TUo0TKnl+QEzyo39WdiythCO/U
 BZNzTgh8ha4XvlOC3m7W4sMAvjHkhSL5LqENUMZDxzz9L3+PEHVKY5irR4+objIaAj3n3zKIZ
 9/aC1SjFl/yQKOWLSPZxsZoBl6KFdU0wPHCbE8+hLHjk+ylv1oaPgGtcOY65Sw8TcDsk5KKFw
 FUHVwzmu0DMshBq8eB0LZ9ti3nk8C8IVoUkZtV23Gv/VvV85WVeikZy3bjedcEKOHzA9q01AE
 whGROhfkz1oSCwb2JEkTMYL35qH9YxeUwZWKwAgjf+2aiE8fnyGmuO5JOvtX/96QbpDKPbUJZ
 IEN0D+XErBg1mOZPprVfcTWqewzsZ5Q/qloNch8itL3Y58JH+KwRrc9pcugxVj9nrG57C+CLW
 nl0sZ2rl64GoRN5nSZyKgikgyBUkYBSpp9dExGyIgaQIkI0p3m1gr1sAbUqyZLIenau0JSnZj
 En4Gy9iGOpAIcyVrtxvJmnbDXM93LVsWBoUTjoUWLphEZHshMdckGT9/EoU7T7Pj87PjYfwWs
 cESdoxfqo+UI+nRTrzkZITwVkDvqLClv4TWLigVwgXZ3Wivr6X3NwLC67NGsIOtXMRfxrheqv
 sAninmNQwYMjP/GiOE53yfyOusvU3rOUpngN44XCAZNZbgrd0U82a34bT8gNS3LVkY/ENuqi8
 AJFvoA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 29 Dec 2023 11:46:32 +0100

The kfree() function was called in one case by
the hugetlbfs_fill_super() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus adjust jump targets.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/hugetlbfs/inode.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 24401a5046dd..5687ec574dc4 100644
=2D-- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1483,7 +1483,7 @@ hugetlbfs_fill_super(struct super_block *sb, struct =
fs_context *fc)
 						     ctx->max_hpages,
 						     ctx->min_hpages);
 		if (!sbinfo->spool)
-			goto out_free;
+			goto free_sbinfo;
 	}
 	sb->s_maxbytes =3D MAX_LFS_FILESIZE;
 	sb->s_blocksize =3D huge_page_size(ctx->hstate);
@@ -1499,10 +1499,12 @@ hugetlbfs_fill_super(struct super_block *sb, struc=
t fs_context *fc)
 	sb->s_stack_depth =3D FILESYSTEM_MAX_STACK_DEPTH;
 	sb->s_root =3D d_make_root(hugetlbfs_get_root(sb, ctx));
 	if (!sb->s_root)
-		goto out_free;
+		goto free_spool;
 	return 0;
-out_free:
+
+free_spool:
 	kfree(sbinfo->spool);
+free_sbinfo:
 	kfree(sbinfo);
 	return -ENOMEM;
 }
=2D-
2.43.0


