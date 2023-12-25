Return-Path: <linux-kernel+bounces-11131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEAD81E1D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 18:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF19EB2174A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 17:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C4252F92;
	Mon, 25 Dec 2023 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Znrfeoeo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED8C524CB;
	Mon, 25 Dec 2023 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703526027; x=1704130827; i=markus.elfring@web.de;
	bh=YNeHa6/Vcg1bfEGgSJaOADhspsb8ftwtO+I9y532uhg=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=Znrfeoeoa59CuOHeUzQmncuMsM1Y4VQ0XkncIqn7XtNZGwrtQMF0faBI9ovmnqhb
	 h/IHugT7JuSXCf4E+y4fjj0rYIIvdkf1cCMmGyf8+AQkhS+0eA5E4Z/3elC6imRjy
	 V7kWsL/8CGR+aPU5krKuRgqnQ+Y5tWEjeEVwqlmLJ25PBA1g8NExBt62VKYURorZM
	 dTs9/rZZOVKBb2hL4ZyAbAISHEpyy6hQ7C+3Y4Ata3jU8VICSyBJKyImuK8iRJ0Uh
	 o5B5vGcHSdv1SZbrKm0QPtorK5vAUjto67uD6jmhspT4ABLR8UO7dtVvW3fuzUzSE
	 ysn0oxYpMnauUtVUyw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJFhJ-1rXYP22PGN-00KnpZ; Mon, 25
 Dec 2023 18:40:27 +0100
Message-ID: <0dcdeebf-46f1-41c1-b5c8-050bca5d8e1f@web.de>
Date: Mon, 25 Dec 2023 18:40:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/7] EDAC/amd64: Adjust error handling in probe_one_instance()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Muralidhara M K <muralidhara.mk@amd.com>
References: <8c9e2c01-9ed0-4392-af40-4e8eb393cb67@web.de>
In-Reply-To: <8c9e2c01-9ed0-4392-af40-4e8eb393cb67@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f5Qp4CpqwjoAivwiBL1Lm2FPsM4kPStagXR0AuWP/yqBlb8rDYh
 TGsTJqc0JXESt00jJjej09r/B1RehbaWI5IBVPdDpmTTnq45BahACNmZVWDn3FRx81Zd019
 sESxkopVNXd9Li6wxaD1yUB92f3FCdgKHeIglGnCgXc6E1LV6H5BYmGXsNPYoA/2fk0nR41
 0g2SrHJ1AFtRe0pu1y22g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EXXReGOboJ8=;cYxIzNPVpcl2/7PE0W8rYHHT23K
 BzTu8iAVmMVC7ICXKdmlrhf1+juIOFkpxKHhAykqEVNbiExeP0gZssJg6NzdclPsMBh6LJF1x
 mIxgYlLHxqoBWJqzpF0vdgU9R2+iTKzphHRkGUosCZBzGll/YH0nSvjQsOWHEAXFu6oT3EC5u
 nuyUsgqWKhBv0jOVdTmAHVwaxqpH94S7Dar+yqFbrrD8VC7cs/OSDy8m9bPPas+i/tHT+H5pH
 4XjWXm5kWqYhvLE6n65QgB6XjAqzMHMV4757NmtWVLIzusA0qlD6oV45WxXTfQC/lfPz2WJFP
 9ye4LuYvVeoFxkGUXVITr/RtOg6pQUY8oDxc0+YHDD70q9XBnlHDeYX0y3M+tTyVJSpXWjxwk
 EN8zpC1QQ8jA/8mfEbUx1RJtd3B3J78tWamplcbKK7I95d79y8Xhr8YhcQ6KOoCZkqE/xI011
 F8WYA3GJL7/n1zCpSAD/Z5P8AeaNjtG/szFImOiX+ksczPROIWHLbKib1pR1gNtXtVPGAqFML
 4gOcDedLhpp7+pQLytALS+BGZFHQrr0AKmSxMFUHEF94rsTQkK5IK6PAwk7Td7PvTPGB75kbh
 dt79zorB+Q0fV1XFV0UGTQvoqedZDpWORXBLzhLSlNHJdUalzadfwfyWtUjuvqW7iJNp3Ayfu
 T1UabhreQACqC6XAmL5EU0AaFUvoEqAhesKe5+u8BcNONrzvFLifujRAiGwZgPCAj561M1Cnc
 61a+MBK4CtxqADV5ZPNwCEbh7Dai2QyzcSTjwSAONNwPRvW9lSAiDlFcC9sZw8nxcKPEVOGAd
 AzLs5sHV0dUEkRRIwxQmVjO/L/Q7Jwak7ZGQbi9G7vj5nzoUuohs+d9bTBo3vQTwCfHW6WQAP
 wfS7MGcL1PMl2Ip5LTgx9bNF5T/Ruy1jQ9sSSnKWuGwEPQmHUrQXfW5z210US20r7rOIm6uqe
 yNp/Ig==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 17:18:14 +0100

1. Return directly after a call of the function =E2=80=9Ckzalloc=E2=80=9D =
failed
   at the beginning.

2. Delete the label =E2=80=9Cerr_out=E2=80=9D which became unnecessary
   with this refactoring.

3. Move an error code assignment into an if branch.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/edac/amd64_edac.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 49f3d9b54902..64680de47cab 100644
=2D-- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4268,16 +4268,17 @@ static int probe_one_instance(unsigned int nid)
 	struct ecc_settings *s;
 	int ret;

-	ret =3D -ENOMEM;
 	s =3D kzalloc(sizeof(struct ecc_settings), GFP_KERNEL);
 	if (!s)
-		goto err_out;
+		return -ENOMEM;

 	ecc_stngs[nid] =3D s;

 	pvt =3D kzalloc(sizeof(struct amd64_pvt), GFP_KERNEL);
-	if (!pvt)
+	if (!pvt) {
+		ret =3D -ENOMEM;
 		goto err_settings;
+	}

 	pvt->mc_node_id	=3D nid;
 	pvt->F3 =3D F3;
@@ -4336,8 +4337,6 @@ static int probe_one_instance(unsigned int nid)
 err_settings:
 	kfree(s);
 	ecc_stngs[nid] =3D NULL;
-
-err_out:
 	return ret;
 }

=2D-
2.43.0


