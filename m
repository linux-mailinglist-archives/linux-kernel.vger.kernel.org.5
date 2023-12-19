Return-Path: <linux-kernel+bounces-5496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D47EB818B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771FBB23976
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357AF1CAAA;
	Tue, 19 Dec 2023 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tUIQQvd8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BCA1CF86;
	Tue, 19 Dec 2023 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703000386; x=1703605186; i=markus.elfring@web.de;
	bh=ELfN4U9np08GBF/FMF+QrtAqU4uT40C8danVIjILAro=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=tUIQQvd8/gN+Npy+DiBKsakAWrd/g9z2P2I3/Do70Nqc9Zqrb5EAsprwgC+YTj8L
	 yeF7DuWERqZONc1QEpa3sidChmPXfG4k1p56ZMNFYWv4TC3G0EWBGFhuv0SlWm/lP
	 k39Auh35V7DtpuEqSHJ77WV1ICHyWfbNcQM6KCTR4TQPhS0d9Rh8NAZ9LYohuSV34
	 8xQt0IcEZ6j4NeDBqcCRD+vf6mZ5tOeSfFf6nmswr+Vk4Xlhc1SUzUC2ZHAlVYpSw
	 DsiR8351y77U3oq/jQvkDk2RG2aXm5/KGMZ8/C28pVmHgE1a1BcsOQULKcywhwi0r
	 IXybnJnMGvRZ4ddqFQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVJRl-1rhPgq3VKh-00STCY; Tue, 19
 Dec 2023 16:34:19 +0100
Message-ID: <f007f92c-a355-4bb9-a715-aa42ee6c647b@web.de>
Date: Tue, 19 Dec 2023 16:34:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/3] kobject: Improve a size determination in
 kobject_uevent_env()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <e0543d9d-a02a-4c9c-b341-36771cfb5353@web.de>
In-Reply-To: <e0543d9d-a02a-4c9c-b341-36771cfb5353@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JjhsMO2bB8+nD7c7+p6s/ulFW7kzBQgTwWHDT3htCK5RkSp7UH0
 eKIPW1jgIOUi/ZkvNRDAy2Y5QJJ5sHTpvk30jaJetwdy2oPIFsCUuCCazWWDM7L0RJB82wd
 ZFGktXCo2j8qBNnYrNIuTQ+ybpRoMe+wPDyPIGK55TDnSWv/uQ/IlA535TKPY6cQaii67t5
 KroN6Q4bfgxT8T2Cmh5kQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Gpmpv0Pfr5E=;xA1CMRucwhDJNYTvQs05e7/IJfQ
 o2QMZhuB7JHfeuEFaxjV8OhGeLjNFLUn+XydDjrJA+rHQZEayEYtA7TqB5z3J6uP+0sJPXi9F
 cTZlJxgu66eO/Zo8PPhnV9PWXkVvT2M3BrN0JPI6Kp7Eu7HkBH9Qhou17AFEym5aWAkyyq2nY
 s6DkXRwzMijEzmzwA3H8SWTWqO0EeevvVjgljPpXO1arQlnZHneP3EViQ/5n/SCg6nycfbtuR
 rqyqjDgUcG1cWB45APN0C57+IGFvxXZgWUL+Fn1EDoihXLQRCGKi5okMG45vKcpAV7O6OY+KP
 OxMZTnxaue9hh8lp12t4pHnhEnvB256gKv64TfP7d1rTpPolTQuB7lXvmV5k96151ra4DjJDi
 1tqlGJizHKlzw+liGVjSt/u7TBojtvmwNKbbzJ06JdhyWPMBPR+0YDysoqH703TAbW2+sppQk
 nSLM+lkl0gc+Ru+OnioNkiRDCIkVQq68WRYfVjPau76BGHMr+L/2cSybspiodHM5xSJ2WxmWf
 PxajztBRZqc6Cefk80hdM44QES+P529kI1gJkSH2C8QRhjNI1Vx/SKqMAhnU2AEbANaWTVvv2
 Eey1xqkHnqcTH7uTiItvODtjeZ+CZwDjMU/fXlwjSiAsyZcKYZ21xwGf84blhw1f9WGihQv+j
 qMT1OMaLzGG7CTtbsjlyOWwdZkY36WpNuqfZBAkIpJcln5rxCHF6Xgv72qBtmeoZ5r77bsVPL
 1VAgAZV/otKnFCR65yhhBKt8QlZ5uT2y7irIOJTM5ApcoOXaPN/on/wob79UmRj24u8CADRpz
 vN6c3s1korAktUYy/1AGryFFwz939tZq7rxRPawSK7lNM+CjVH+UYJX2WPWgJXltwdPbOmBj1
 PnAX+8A8aYzh4GFFYhoPeLpgxYA3Xms6gz4pIzu2+HWEeMafG9CEXBM9qOWjsqUjUOlkuyGy/
 yA5ksQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 19 Dec 2023 16:00:22 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 lib/kobject_uevent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 811e579ed89d..a9b1bc02f65c 100644
=2D-- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -521,7 +521,7 @@ int kobject_uevent_env(struct kobject *kobj, enum kobj=
ect_action action,
 	}

 	/* environment buffer */
-	env =3D kzalloc(sizeof(struct kobj_uevent_env), GFP_KERNEL);
+	env =3D kzalloc(sizeof(*env), GFP_KERNEL);
 	if (!env)
 		return -ENOMEM;

=2D-
2.43.0


