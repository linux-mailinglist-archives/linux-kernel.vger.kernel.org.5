Return-Path: <linux-kernel+bounces-16635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886398241A1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE0D1C21A22
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C750219E1;
	Thu,  4 Jan 2024 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="wZUB/1KU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D0822301;
	Thu,  4 Jan 2024 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704370908; x=1704975708; i=markus.elfring@web.de;
	bh=CM2cef1ckyh3aeLZ3H3C8Q/8Yfvaf5jJIOf1Yk9mDyk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=wZUB/1KU+78EYC/8EnDNvkEjklcLnvniJUTGUDD4aFzGf1N9j7iiSinLs/FYS+mu
	 2LK3ACiE4XYGcnLDUxxRCLKcRNleq/3I9OHWK25fK/hNTmSLnzcMEauoraIeuQv0l
	 b16Ese/qS3BCzT6FhP/ASwrlosR0NhtTOY26otnHGAM6yhaLplMwR7l7z1wTQ4Vu0
	 whUTl+h80i1YQIaai0kU/IZxRcMpU3YXXehGVBRADu9yVSYnnE81wXKmxkGk4vIgy
	 G9RKHN8IWrAGCmWBceNarCzHVezG2u5QECnjld6jMD+76yOb0Uk/Jp1kwwRgMpwmF
	 EnxeJkg5zrV74ty6eQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M5j1q-1rIdhW330c-007bL1; Thu, 04
 Jan 2024 13:21:48 +0100
Message-ID: <1ab4ea7c-731a-4b8d-8f6f-c9bf5f0f02e4@web.de>
Date: Thu, 4 Jan 2024 13:21:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [1/3] drm: property: One function call less in
 drm_property_create() after error detection
Content-Language: en-GB
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Simon Ser <contact@emersion.fr>
References: <ff7ce5d0-59fa-470c-8dd6-68dbe65c18e5@web.de>
 <9b1e7330-f4f6-47f8-a568-eaea1624bb6f@web.de>
 <37647c33-7f9d-4763-8bf4-cfc5c9a811de@mailbox.org>
 <c5f1a7bf-b444-4934-a205-3c2b3a045ff7@web.de>
 <dd300771-851f-4cfb-b9a2-d87d2b4399aa@mailbox.org>
 <93cfabee-9692-491c-8d38-dec142e90252@web.de>
 <ff58a489-105c-4fdc-9af5-59efb9d05ec0@mailbox.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ff58a489-105c-4fdc-9af5-59efb9d05ec0@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZjA7m6hOg2b8XD2dDwIjNKbIX/BJ0afrZlGsqq4t3Ue5m7p2Fa2
 V7m4gj+Xi7klUcvwxAOVrLpBSjsrWkN8GgRSJzGL1Dp0nH07N9gDbcH7v/jBCb8uJIwys+a
 hcrZLKDMOfoMe0vkZXVTjLQTE5GllV7biwODL+RNsaPAGN6tinfT3Kqw5FP5YIZzDLIlAmL
 g4TJvVzeychmg1OCQWOtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dAMZO8I92jE=;vhF3KLbYbyO37AA1WXmmtroYNT+
 /v6UKA7rNB9/QFdyhcjMEEi8gv4m32E6+zup+9VIDT+Dro24JCnFMvbdJBOy/nv2XTKhO5H9z
 0AJeBGsyF16sZgipQ57Fk8QFNC3me/suULDgpuwvG9iRUonwTOnLfXNkykxwlKw2OY9T/0XDz
 fAj8FTvyYsCK07SsdDMGO5ga+jn+zB3pYATssmTw2RRIzbhXpwgVmc4yLk5DIXzyTevEcdQKg
 8cX74pnZTdJrGITmHXeqcvIO3mHhRFgl4vVZfcBIjKeZZvtEkoLGtlpVfHpbo7BjnUp11O4Ln
 s0cscoxC/GNpElPFLQzSQPG+wClcWbr/j59DpNpKjeYc2Rv40W9IwsURCfQnSSc6W2lyotvuC
 QTcWIIhbxxDCB9J0h4o9xSNoO+ygSZHRwNQDPN/KPOe5h80luPrA4DhRy3TWeFoht6A7FNJHB
 LN7IDqYJ+AP8iTvlvZ81a19jR1tD6loIPukQm6Lv/BNmyscsrT2XvI+bXJEbB2uvldk1ofMTy
 OC7vEeJh4vmAQBfeYAngjQOpuMaVxBHF3MgAxcoGapTQ2c3wNeucs5+w02OiQPCBSHXRTUujQ
 fJQAme8l9kEwoojmDcMmXBE7uFSPTZf1yrXilsR+D/qNNbF9HF3oPG0IGqM16Uwt9ITnHdfIF
 FYVJoUsT4vaeb5gvz62SHlFr40GCtNQSrAR0MZuqJuTd/l9PlUkBPj7mh4txvJpN9aelP6Pk7
 UsSgTLoqg6Acpum/7vjJRaAu/jTXU8EIQ96kzx2xvPPwR4u2mzmgSIsOmlpY7HRtecbofZMaJ
 FFq/wY2wTA+PV8PXrxjyrPUSs7r0u4u9FjnsYS2G4Qrp8F/NYqLoP/wZ7k5V1cKg30wnXkLrj
 PMivYoYYNFIOvoQwwevbvVobFVWqeOZV2SLBKg/HeR284z5zugh5po5E6htW4scAJbzBTikMv
 0mPmId4bSJLqDYcGTVZk1fVDnPeQo1CD15WnUpYGuFe8YXWaAz/GTUATl0IoNKtAaPxsPw==

> The commit log says:
>
>  This issue was detected by using the Coccinelle software.
>
> Either that's inaccurate then,

No.


> or you should be able to provide the corresponding output from Coccinell=
e.

Do you find data (like the following) more helpful for the adjustment
of affected implementation details?


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> LANG=3DC git =
status && spatch =E2=80=A6/Projekte/Coccinelle/janitor/show_jumps_to_kfree=
_with_null_pointer.cocci drivers/gpu/drm/drm_property.c
HEAD detached at next-20240104
=E2=80=A6
@@ -114,9 +114,6 @@ struct drm_property *drm_property_create
        property->dev =3D dev;

        if (num_values) {
-               property->values =3D kcalloc(num_values, sizeof(uint64_t),
-                                          GFP_KERNEL);
-               if (!property->values)
                        goto fail;
        }

@@ -133,8 +130,6 @@ struct drm_property *drm_property_create
        list_add_tail(&property->head, &dev->mode_config.property_list);

        return property;
-fail:
-       kfree(property->values);
        kfree(property);
        return NULL;
 }


How do you think about to extend the application of script variants
for the semantic patch language?

Regards,
Markus

