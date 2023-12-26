Return-Path: <linux-kernel+bounces-11563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFB681E837
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92796B226FB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 15:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33594F5FA;
	Tue, 26 Dec 2023 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="m6qaxfUa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F624F5E6;
	Tue, 26 Dec 2023 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703606191; x=1704210991; i=markus.elfring@web.de;
	bh=uWBMhje7ZnzueSLD7LuYeqWtZzVY1uT5I4jy8esiVbk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=m6qaxfUaiAQ/owAQgBLoODQqGpf2+ppC7/X2Z8mm5JlP/stKKFIzyHU1Ksje0D+Y
	 nywqF1yvOm0qlSpLarVuWBK31QHGAfgz+oeHD5pvvP7REk4usU1hAWYEciLkK9WqA
	 AZ+9AqGbs24tMhv0GAohedrTWLxqaKTkjjqB05JIJLlYzgR92XI73+LwZfBjVXJYd
	 whsv27bM/WxFpPfLW7hlpAYbWtZ9UfHWOXLtOAwyoQp+BQJ2TJ9BCUw1apL4zFZVR
	 iSDM6uMbhiu+IBH/W6qVTQYigWCjylm/ja0V5Z9o3MvgGrjAWi2fSHPzc0hoRmb17
	 5o+Eew0h5NOTNI8rBg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVrg7-1rjp0s2pAz-00Rv8A; Tue, 26
 Dec 2023 16:56:31 +0100
Message-ID: <85066512-983d-480c-a44d-32405ab1b80e@web.de>
Date: Tue, 26 Dec 2023 16:56:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] drm/sched: One function call less in drm_sched_init()
 after error detection
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <12b3e9cb-3241-40cc-b7a4-43c45b9eedc9@web.de>
In-Reply-To: <12b3e9cb-3241-40cc-b7a4-43c45b9eedc9@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kFHY9yzY0ytYPPNU9cHVZlo/ERarFH9Ioj7KihE9pad6kKHxIsk
 ar7pLsPSyAM659MpM2okcf9zWYIir43459sPBCIw8RFGfPE2vfDLenLDFBrVaj//o0/MUx7
 Tmit/ZcHm7Ezwnppn4xKBRiv1j9wbAzOUXe+/xzfTQ72d7VLa4ySFCK7ApzFSrVhaJKhfDG
 /ynRvpJKJSLxAs5hKgIpA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N9GZXRsOf+Q=;QML2pte76YXDPlKHPaBzAAwpJSc
 SXf7TY/2ebPLuHjIFTcB4EMl0/eTkBOpr34V/BEH8GljMMlV2D9saR5zF/s9xhYmHOKZIju1d
 uP5zqwr2y+gn2yUP4YU1cF+UUtJCfMRDLgm7VFPBFv+B1WwSIk3JEkWW3datKMZMB6QTC3Ao2
 jOtfAtd8mf08LwLPCLKalPPjWtUz2B6OkZKZuIYJIvBDcVBMco6kyNBIF31ILr03TUXAQs7Dm
 Cyd4xFg4B8P4eoxF7EnDX0lR3Gc6HcdjcGc30NfajJ9PThCazXNufcCWxIYYwh65y+7AY2fPt
 PTTvgsypNAH7vigHKFitd1lFt/kgv+Z8OKxUpM4NrdpM6YMis0++afgWk1Z50WO4KFrYmCA7D
 cULfbWjOnc1Axnima1T4dSLJMeAdZhPaoQMNsb89Hvil9I8i8H0teUEptDRt7LtVnml1Xv/Q4
 R3Z0nUFGqnd8NSDB6AwFZgBD1MKrVP32KA8VYcOTiVfOhVeLpugqTNk9mSPDst92uPk+xQmXG
 fMAjhLjqyf9NqNOCviXyJRvRuN4lMn1AyNZnsaAyQfuSrZ+hZAMBLulEDLpG09iFMUynJeBL9
 62ooIfW5SBvqa56s+tFxyC/7mE+iycFUjMznrbuHsbs4nxxWEyMG1yHkzEg06AyAnuP0It8kV
 GgimqiRBXmyEm1UG7UiaJoGWlOENPo9U9RW3X5UhuabE5Ac7LiR5XVMiMr85twnmq2suSt+HF
 RZNTsjXn/N8D4aRlHD/mPBqsC7TlynxJEQVDaaw6jbbCnmaxxgMj6Vqg6pSbnxG8lXW+jU6G3
 zJB9TR/WzO9zCqfSMjzbCygPxjGeXrg+FAJECSJzJ+WBPcRsw3998Ium9dSH4U/S1dt/dy3t5
 RVJjcMc8WxDDWhe2AC4UMSUeuqLGU7VOLYyXlzkWm3y/QP5inuvyhdha/8aWD3+nW8UZSgfH7
 B8glyA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 16:30:25 +0100

The kfree() function was called in one case by the
drm_sched_init() function during error handling
even if the passed data structure member contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus adjust a jump target.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/scheduler/sched_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sche=
duler/sched_main.c
index 550492a7a031..b99d4e9ff109 100644
=2D-- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1289,7 +1289,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 	sched->sched_rq =3D kmalloc_array(num_rqs, sizeof(*sched->sched_rq),
 					GFP_KERNEL | __GFP_ZERO);
 	if (!sched->sched_rq)
-		goto Out_free;
+		goto Out_check_own;
 	sched->num_rqs =3D num_rqs;
 	for (i =3D DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++) {
 		sched->sched_rq[i] =3D kzalloc(sizeof(*sched->sched_rq[i]), GFP_KERNEL)=
;
@@ -1314,9 +1314,10 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 Out_unroll:
 	for (--i ; i >=3D DRM_SCHED_PRIORITY_KERNEL; i--)
 		kfree(sched->sched_rq[i]);
-Out_free:
+
 	kfree(sched->sched_rq);
 	sched->sched_rq =3D NULL;
+Out_check_own:
 	if (sched->own_submit_wq)
 		destroy_workqueue(sched->submit_wq);
 	drm_err(sched, "%s: Failed to setup GPU scheduler--out of memory\n", __f=
unc__);
=2D-
2.43.0


