Return-Path: <linux-kernel+bounces-11943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC02F81EDFD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241A71F21C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E122C878;
	Wed, 27 Dec 2023 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="i0yqvxdi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D136A2C688;
	Wed, 27 Dec 2023 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703671494; x=1704276294; i=markus.elfring@web.de;
	bh=xHDdrd92yyItWY6iNqPqDxvi3VGdAbzM/GdBjxnBIjU=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=i0yqvxdibEe/ej4aoOGhrJ+jRkN1c/4v7nVEuREJzalFp5jep2qKiJb9N8EutEY7
	 jWLfSSEM0Fk3F0tu2FXYK+vH/P3q8U831CsjHNIHkepOKsGspQp/x30qYHjHRZDjw
	 x9zOqgYs8BQd8jB2AgRYajo1aPr6Qlx6mwAcxD65Vgu1+wtoXsM/Idvv+4P0ZvJKu
	 hFLV7n2Wthsgo1dWHb6PxpZMkOIBJODEeV6WOXwMzukKLr3LvNn6VQ6MkrcA8eCBj
	 gUqerzoYx2ff56ezZjXb7PwinNy8EXOQeCpQek1sscOdzAshyax8cCCy/g6jTHF8j
	 BhhZXSzU62GAeqh44Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M59jC-1rJWi20DFk-001LeM; Wed, 27
 Dec 2023 11:04:54 +0100
Message-ID: <3d16ddfe-f10a-4188-a9c6-e92655c0b01a@web.de>
Date: Wed, 27 Dec 2023 11:04:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] scsi: message: fusion: Improve data processing in
 mptsas_find_phyinfo_by_phys_disk_num()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-scsi@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
 kernel-janitors@vger.kernel.org, Sathya Prakash
 <sathya.prakash@broadcom.com>, Sreekanth Reddy
 <sreekanth.reddy@broadcom.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <c8b0d40c-2f48-46fa-8311-258985e9eee3@web.de>
In-Reply-To: <c8b0d40c-2f48-46fa-8311-258985e9eee3@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BXTXEcL23YW2+L4v3sU1O+CqZc9VLmoulmh0iGtLNO9bLfdJ2Py
 qEWNjvHmkGprxRLQJFq38Tl2jiUPQ2Yflt8EDKQOgoBsVCqGoFoEmEK0hxdNS1FgzAUaNji
 5Dc7sKFUWHs3BqAPNJ72IqbzZbCVecbHkDAdnag9IVBBLDg04WWMFyka/2jb4iXJeC0xrd6
 ZbmBv/W860kVn6g5bl7gg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aqVwaolc6BE=;EIRN57N0btRcuRJ3W4C5usXyncP
 stxFd72pw0T5isIca5Thm+fqD9O8fOUsGKshK/83BZBiR9e07lir80XRa78D/u/wGvJocyQr8
 WvKhzEjt+ndqNGXLYTLGg4GtBX1PvdrVUkFjQ2dgfmpEj4N/Waad/yrZh4sfkUDfChErWyi0t
 M4Ci/lOY5fYbRyUj7rrd1nJvrrmFad4m5eUaFupyuPy4qUlNjiAEovVJW/l0l0CvpshGRjWaV
 r5EFHh9jRIAt+P2yKEDflAAFkLSqDbKKCbnZ+xlCUf3pe2GfRtVxFH/p1uIY90LCaZbLMoBPK
 /67jghay0/WfqfSZyOpZEibZuz7oSRTSuMmXmS36Klv+aRhepaE1GIIA3/Duzmk2ZCJbLTFkE
 0j7Il9O0OHuXMEUjn1Sm3/apTXBeN+SHvif33yA7w3fHm+rIDpsfuwNVHrGQwbiKTQU9C/V7M
 WTtue0Sn0dNO9NWLhGIG6rIGzUeBJq5iargl8JE6+4RUJEEtWOPAW4bGEJfC+VhSqa2/ebglw
 rheV4n/Hdphy/r72r5NyzjMa/GZJAex+QZNnr/2GMmEbiGhlv9v/LVvm7b/SsEKjd+zyrN5dk
 KuNWKzKSV9OrMbTai5sYf+2aerR7w5G4DcQ6/ZfjP9Ij12F4Mg3K/wkYU5be+ZcVIL9EXzNr4
 p8zW5b8BdJ8DFqiySuhLttyX7TJFQOtFiUUZJVePRb8MLlAXbKpug2uRVa0w6TiqaCwnGOq6g
 CNim5BeYCRDPbm4mlil5MiicZsh+g5yaAJy3zTl7c/VXHStiGsP9hYyvw36ny4SwLLpxjHFgZ
 Jzka5W3eFkdZVGcJ+T1iEGUVAWAS1l9DFEKAfCltopP29NAY7YkR1g1+3CUqHpkRFLOwyL3o1
 wOwgv7bLW0S+ls2Oy486bROCWlzKL4cuR/M7fV2U0wRnqbwypJiF4ShRrI7J22UbpLY5THMSO
 aexB4TtOW3FeZmGDRBMRbq9utgs=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 10:23:09 +0100

The kfree() function was called in one case by the
mptsas_find_phyinfo_by_phys_disk_num() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

1. Thus use another label.

2. Delete an initialisation for the variable =E2=80=9Cphys_disk=E2=80=9D
   which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/message/fusion/mptsas.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mpts=
as.c
index 300f8e955a53..452635a50c4c 100644
=2D-- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -4171,7 +4171,7 @@ mptsas_find_phyinfo_by_phys_disk_num(MPT_ADAPTER *io=
c, u8 phys_disk_num,
 {
 	struct mptsas_phyinfo *phy_info =3D NULL;
 	struct mptsas_portinfo *port_info;
-	RaidPhysDiskPage1_t *phys_disk =3D NULL;
+	RaidPhysDiskPage1_t *phys_disk;
 	int num_paths;
 	u64 sas_address =3D 0;
 	int i;
@@ -4182,11 +4182,13 @@ mptsas_find_phyinfo_by_phys_disk_num(MPT_ADAPTER *=
ioc, u8 phys_disk_num,
 	/* dual port support */
 	num_paths =3D mpt_raid_phys_disk_get_num_paths(ioc, phys_disk_num);
 	if (!num_paths)
-		goto out;
+		goto lock_mutex;
+
 	phys_disk =3D kzalloc(offsetof(RaidPhysDiskPage1_t, Path) +
 	   (num_paths * sizeof(RAID_PHYS_DISK1_PATH)), GFP_KERNEL);
 	if (!phys_disk)
-		goto out;
+		goto lock_mutex;
+
 	mpt_raid_phys_disk_pg1(ioc, phys_disk_num, phys_disk);
 	for (i =3D 0; i < num_paths; i++) {
 		if ((phys_disk->Path[i].Flags & 1) !=3D 0)
@@ -4211,6 +4213,7 @@ mptsas_find_phyinfo_by_phys_disk_num(MPT_ADAPTER *io=
c, u8 phys_disk_num,
 	 * Extra code to handle RAID0 case, where the sas_address is not updated
 	 * in phys_disk_page_1 when hotswapped
 	 */
+lock_mutex:
 	mutex_lock(&ioc->sas_topology_mutex);
 	list_for_each_entry(port_info, &ioc->sas_topology, list) {
 		for (i =3D 0; i < port_info->num_phys && !phy_info; i++) {
=2D-
2.43.0


