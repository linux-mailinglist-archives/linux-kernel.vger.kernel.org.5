Return-Path: <linux-kernel+bounces-12811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8A881FA50
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 18:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA501C20DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AEB101C1;
	Thu, 28 Dec 2023 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="woj0ouMH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E19F9C1;
	Thu, 28 Dec 2023 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703784246; x=1704389046; i=markus.elfring@web.de;
	bh=4XlxHJDHSmu9DTtlturBDNHee1wz7AQbL0bmz7RZbq0=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=woj0ouMHLYY7ibHMUL64iTcnX7olMYiuDthJKiG0aiwdNFxCjFdWrJdmvRen4gYg
	 SHqbn57hkBus4CTgbjtjLaJ9uYCutP+KzqWHQCBerfHQm1s+osrG6x7P0asxx4yRB
	 IUK1eK5Hfcx7zjJ9x2qjlLd/swBA3fJjo6D0ALXdjFONd/x4z8iDMVkKPXiPJZjjZ
	 Y+up3bOXLWNUEq8DFeH1jiF0MuUI2eeN8pBjudwmbr8XU0tMxwojjUHkHICCjQwV8
	 BpMv3idkQvYY7YGDDFtgXsucVClXHIdwsVqrDJl7WP0PoU8Q6KaIWxBkQHQWlDRon
	 xFN9fqGKIL8B4gPBzQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M43GU-1rIu7439Si-000Ft3; Thu, 28
 Dec 2023 18:24:06 +0100
Message-ID: <cef48477-8331-4d84-a3ee-8e6b2f6e34e8@web.de>
Date: Thu, 28 Dec 2023 18:24:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/4] scsi: lpfc: Return directly after a failed kzalloc() in
 lpfc_sli_read_link_ste()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 James Smart <james.smart@broadcom.com>,
 "James E. J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <48a127e8-ca4f-4fc4-81b7-226080fba720@web.de>
In-Reply-To: <48a127e8-ca4f-4fc4-81b7-226080fba720@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uIeGhHJ9SX2ZMZpWX85Jqs1cor36TOwqWrCC1YmAOQ9bZYmxpo9
 JaxrzdcpwFOx6pDeiYXUJbUUa6Qq3lLprlWCa+GnuKzgMrGr2kkeVmkV3qwZZD0N1dGu1cs
 fMnEjuqBqYXQzIOxXKkZqD5NjYFmufdbCGiG651kYOGxzrmxo3S7VkejiLxUHvYBvGH0s8p
 a25p4oBUcrSr2I+Q+VdVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DmmwTBIHlcM=;+v8eqOTTMeJo2NnLUZzwP3IWP/U
 ebNYeII958j7OGFbNxPZaxR4ksv6TRTf4qOwfmKCpPtsT5hhlIgK9jAHu9NRM6rmXKlEGz1gJ
 ClIAwTWUbrYJaagSyo893Nh6Ce2/eJzlJ2/7LkFxdIv+Ks4Orlt0yWA7DD84TRTYFfysn83nb
 vDIgDTivGvYhtcjaH9p2BCBNpuSShzjiPQMpSnEV62wCSagWzlOBvfzImxcDXDoC2mDqZDBOl
 sEkxmmOGuncbGXraij6wG+vJi9L7D9D/Uppe2DikDMdP7r2bnES/JUFQhdtbmj5BCAB7Rl2ww
 +jiKDXSwDQWF4hY/iYm9oAi8koYDSJHhXDfDbHufklpFfTtvnnJO9H6Q0q12J0R0h1lytT6DY
 BH0Ng72TXIdzny7QGJgzpC/QJGK0rgy1tXJsLi/gSAN0Fyv3WL4DKt5OD3LC5BywNvA6drnvb
 rtDo0qv21wQRbKePmjv2nMutGU34+kf8wkLb49wDnEYKY3SjxfjIjAPt6QsL9GZRIMKqwhdPR
 HGeK+BU2DZqpT7qD5IYGQDEna1BELAURaP1vGGD8CqpqBZIky5786mh97wbTyhl5kXqae0Z0C
 L9evAfZAvfAyMrqJyjCYOx4+wTIDmDgJkoeEA5iVi/GREwiOE30blI32RfuvkBGMFtRZ419LU
 8OzUEcrWIunzV2iuyeA9ViOxw0jzPV1+anSGOaee0fioWLA3FL/4wSV3gBdq/iLfOCGjoL7ek
 TImXNxf6QCqd4m3kzVcPJsFWyOgtwImVVl60YQbweA6UkBsfL/yqkxzSd8Q7zf55HHm8qrJpP
 vCQmqbqSmFVvR1Ij0FVFsjOtT1eOPCe6/4Jb6VcchH/Tk5XPUKiR4+pxm13gknqnH8Tru8bv5
 xIGK5RMXE+CsAVhdT1nBbceIt3sJh1JVGzViLWAxPYshRwrBpGqywbeHJ4l19IRAe45qPJbGi
 wIlz9A==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 28 Dec 2023 17:13:50 +0100

The kfree() function was called in one case by
the lpfc_sli_read_link_ste() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus return directly after a call of the function =E2=80=9Ckzalloc=E2=80=
=9D failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/scsi/lpfc/lpfc_sli.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 706985358c6a..93339425ce3c 100644
=2D-- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -20701,7 +20701,7 @@ lpfc_sli_read_link_ste(struct lpfc_hba *phba)
 	/* Get adapter Region 23 data */
 	rgn23_data =3D kzalloc(DMP_RGN23_SIZE, GFP_KERNEL);
 	if (!rgn23_data)
-		goto out;
+		return;

 	if (phba->sli_rev < LPFC_SLI_REV4)
 		data_size =3D lpfc_sli_get_config_region23(phba, rgn23_data);
=2D-
2.43.0


