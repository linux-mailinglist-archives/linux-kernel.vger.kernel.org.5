Return-Path: <linux-kernel+bounces-122367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D1588F5BC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2608329E4B2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAEF2D046;
	Thu, 28 Mar 2024 03:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OK3Cxoyk"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA4A17BB9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 03:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711595339; cv=none; b=KVLqAj0W4T8dpTSYdV7BgOrzJIQ6qkS7JjCPkz4rOx0z3XYICxetW94HoR4g+UKmDXY+3Obngp+YWiSKf7HSqVVL1BasKEWU2Don41/mZSbL98aZUR/SoECwYg1A70PMY99gyznayJcQzovHhYN335LFT2+49k9EkJ+6Wd/ZwxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711595339; c=relaxed/simple;
	bh=UN43fTQ8DEjX47nS5VsOZtfiJt9jbgy161r6XtNmkBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpHOjesdTqErJQ8QgdavpXsY46bngZjr3e1/QjyaOGSeWQhaTdsoeAD+LXtqKu/o1NuIOEd/kIvjlX94rH1PXgmOuhag5iQ2bvVZaa4hvgrXN+XBb/RxGOJJH2WtttUUcMuZdD25wAq+EpFs9yqbrMTcc/LN6+QuvvuxZLnX7Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OK3Cxoyk; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso331583a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711595337; x=1712200137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JbUg1/8W4lnY9jEOzWjcb9pipkJTBqtEMv41Xz2F04=;
        b=OK3CxoykQ4VfKnwRVSrniTyHELne3XoIhcrbb28gOzl9PwJuAb0fsHk5/4rdSrGXV9
         6x22MOoNYpxDjfREVpdl7OeGHLKekAGDx4MiJFw5xW9l0h1kHYcNZbgR5oCKkOwxlZzM
         rmatbCtzWCivNxm3xHByf6KD3BkkSYZQ6H/A7D4OmA6CHzF9B6jPULECiW3raNqkwklP
         hIfwaWjkTEZB3UmPwRjfhm8sPbYXDeBvC+nqyV42cR7JMuTALbg5cuDSyAYEfDsgk/QX
         4TRaWG0SwHN2FX75UDlTXdnjmuZtYQmr5hE61/oJSxZcvFt/ZmNwWapm0t1BCshlbYe2
         dQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711595337; x=1712200137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JbUg1/8W4lnY9jEOzWjcb9pipkJTBqtEMv41Xz2F04=;
        b=t0GtE6V0mECXFw4sW/bn7A9otCW9NrTJcNRsDDGnBVRGqktpSgcf3REd3IfZPPDb/n
         06kJ7WVfJs61UDNr2tjAiMGmLo6bkrbSedN3lJDwfdy5e6cGBnEAFMO1cBnlkqRz/wy0
         Fhgla9sMNEeusE/Euq3EUoMcXt5khhLF8BdvIWgouLR6lyPn3cHH3r5ynQ+3Icwgp8Wo
         rB3e6al8jor5j4YK4hS5inerhlqyTYGO3/39ED8rDPtZOmCmg321i5Y/tcGngfPXm/5Y
         kdeugUNARN+KtUyUapLbPMPzHhLF2+QKlFfWcAUGrhndwlJJPaKHum0Ns8ytOiIl9CdN
         bOKg==
X-Forwarded-Encrypted: i=1; AJvYcCVflLciQ+vLo4GomigLwWI1oojED752YQ5ywiWhEWPZdIpdy/0lmCBrl0JHwQayPHVaDw+TsQaRoS4/y69bt5L1APaUZ9vXk+e4d447
X-Gm-Message-State: AOJu0Yw8y7D/AQNTzm+CXMOnZnL4ZrZPHOINEGJPyvx/RzOCo4Br2s/Q
	2w5fbw/++9AfnrGEOECWXEqzw3QSmSTz4x3dVrtMQE2/I1ax3IT/P2XU7w9s1uNSAQJBJho3P7/
	HHR3GI0w8nR9JCBvHikW2phh38jg=
X-Google-Smtp-Source: AGHT+IHW70Qvi9bbhqfYQ9h2KqQnuqI6cgGc6j0/u2kopPAqC7d7T1Ny9gjijWM9ZiyLmlsj8kVmX+XN7k5SA1XrcJA=
X-Received: by 2002:a05:6a20:5498:b0:1a5:6a16:f6c3 with SMTP id
 i24-20020a056a20549800b001a56a16f6c3mr1663466pzk.38.1711595336575; Wed, 27
 Mar 2024 20:08:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326173142.2324624-1-sunil.khatri@amd.com>
In-Reply-To: <20240326173142.2324624-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Mar 2024 23:08:44 -0400
Message-ID: <CADnq5_ONivR7io0w6vkHsQSSMnNCRJU=XdDD6D6SQZ8t9o3FAA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add IP's FW information to devcoredump
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Hawking Zhang <Hawking.Zhang@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 1:31=E2=80=AFPM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Add FW information of all the IP's in the devcoredump.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Might want to include the vbios version info as well, e.g.,
atom_context->name
atom_context->vbios_pn
atom_context->vbios_ver_str
atom_context->date

Either way,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 122 ++++++++++++++++++
>  1 file changed, 122 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 44c5da8aa9ce..d598b6520ec9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -69,6 +69,124 @@ const char *hw_ip_names[MAX_HWIP] =3D {
>         [PCIE_HWIP]             =3D "PCIE",
>  };
>
> +static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev,
> +                                      struct drm_printer *p)
> +{
> +       uint32_t version;
> +       uint32_t feature;
> +       uint8_t smu_program, smu_major, smu_minor, smu_debug;
> +
> +       drm_printf(p, "VCE feature version: %u, fw version: 0x%08x\n",
> +                  adev->vce.fb_version, adev->vce.fw_version);
> +       drm_printf(p, "UVD feature version: %u, fw version: 0x%08x\n", 0,
> +                  adev->uvd.fw_version);
> +       drm_printf(p, "GMC feature version: %u, fw version: 0x%08x\n", 0,
> +                  adev->gmc.fw_version);
> +       drm_printf(p, "ME feature version: %u, fw version: 0x%08x\n",
> +                  adev->gfx.me_feature_version, adev->gfx.me_fw_version)=
;
> +       drm_printf(p, "PFP feature version: %u, fw version: 0x%08x\n",
> +                  adev->gfx.pfp_feature_version, adev->gfx.pfp_fw_versio=
n);
> +       drm_printf(p, "CE feature version: %u, fw version: 0x%08x\n",
> +                  adev->gfx.ce_feature_version, adev->gfx.ce_fw_version)=
;
> +       drm_printf(p, "RLC feature version: %u, fw version: 0x%08x\n",
> +                  adev->gfx.rlc_feature_version, adev->gfx.rlc_fw_versio=
n);
> +
> +       drm_printf(p, "RLC SRLC feature version: %u, fw version: 0x%08x\n=
",
> +                  adev->gfx.rlc_srlc_feature_version,
> +                  adev->gfx.rlc_srlc_fw_version);
> +       drm_printf(p, "RLC SRLG feature version: %u, fw version: 0x%08x\n=
",
> +                  adev->gfx.rlc_srlg_feature_version,
> +                  adev->gfx.rlc_srlg_fw_version);
> +       drm_printf(p, "RLC SRLS feature version: %u, fw version: 0x%08x\n=
",
> +                  adev->gfx.rlc_srls_feature_version,
> +                  adev->gfx.rlc_srls_fw_version);
> +       drm_printf(p, "RLCP feature version: %u, fw version: 0x%08x\n",
> +                  adev->gfx.rlcp_ucode_feature_version,
> +                  adev->gfx.rlcp_ucode_version);
> +       drm_printf(p, "RLCV feature version: %u, fw version: 0x%08x\n",
> +                  adev->gfx.rlcv_ucode_feature_version,
> +                  adev->gfx.rlcv_ucode_version);
> +       drm_printf(p, "MEC feature version: %u, fw version: 0x%08x\n",
> +                  adev->gfx.mec_feature_version, adev->gfx.mec_fw_versio=
n);
> +
> +       if (adev->gfx.mec2_fw)
> +               drm_printf(p, "MEC2 feature version: %u, fw version: 0x%0=
8x\n",
> +                          adev->gfx.mec2_feature_version,
> +                          adev->gfx.mec2_fw_version);
> +
> +       drm_printf(p, "IMU feature version: %u, fw version: 0x%08x\n", 0,
> +                  adev->gfx.imu_fw_version);
> +       drm_printf(p, "PSP SOS feature version: %u, fw version: 0x%08x\n"=
,
> +                  adev->psp.sos.feature_version, adev->psp.sos.fw_versio=
n);
> +       drm_printf(p, "PSP ASD feature version: %u, fw version: 0x%08x\n"=
,
> +                  adev->psp.asd_context.bin_desc.feature_version,
> +                  adev->psp.asd_context.bin_desc.fw_version);
> +
> +       drm_printf(p, "TA XGMI feature version: 0x%08x, fw version: 0x%08=
x\n",
> +                  adev->psp.xgmi_context.context.bin_desc.feature_versio=
n,
> +                  adev->psp.xgmi_context.context.bin_desc.fw_version);
> +       drm_printf(p, "TA RAS feature version: 0x%08x, fw version: 0x%08x=
\n",
> +                  adev->psp.ras_context.context.bin_desc.feature_version=
,
> +                  adev->psp.ras_context.context.bin_desc.fw_version);
> +       drm_printf(p, "TA HDCP feature version: 0x%08x, fw version: 0x%08=
x\n",
> +                  adev->psp.hdcp_context.context.bin_desc.feature_versio=
n,
> +                  adev->psp.hdcp_context.context.bin_desc.fw_version);
> +       drm_printf(p, "TA DTM feature version: 0x%08x, fw version: 0x%08x=
\n",
> +                  adev->psp.dtm_context.context.bin_desc.feature_version=
,
> +                  adev->psp.dtm_context.context.bin_desc.fw_version);
> +       drm_printf(p, "TA RAP feature version: 0x%08x, fw version: 0x%08x=
\n",
> +                  adev->psp.rap_context.context.bin_desc.feature_version=
,
> +                  adev->psp.rap_context.context.bin_desc.fw_version);
> +       drm_printf(
> +               p,
> +               "TA SECURE DISPLAY feature version: 0x%08x, fw version: 0=
x%08x\n",
> +               adev->psp.securedisplay_context.context.bin_desc.feature_=
version,
> +               adev->psp.securedisplay_context.context.bin_desc.fw_versi=
on);
> +
> +       /* SMC firmware */
> +       version =3D adev->pm.fw_version;
> +
> +       smu_program =3D (version >> 24) & 0xff;
> +       smu_major =3D (version >> 16) & 0xff;
> +       smu_minor =3D (version >> 8) & 0xff;
> +       smu_debug =3D (version >> 0) & 0xff;
> +       drm_printf(p,
> +                  "SMC feature version: %u, program: %d, fw version: 0x%=
08x (%d.%d.%d)\n",
> +                  0, smu_program, version, smu_major, smu_minor, smu_deb=
ug);
> +
> +       /* SDMA firmware */
> +       for (int i =3D 0; i < adev->sdma.num_instances; i++) {
> +               drm_printf(p,
> +                          "SDMA%d feature version: %u, firmware version:=
 0x%08x\n",
> +                          i, adev->sdma.instance[i].feature_version,
> +                          adev->sdma.instance[i].fw_version);
> +       }
> +
> +       drm_printf(p, "VCN feature version: %u, fw version: 0x%08x\n", 0,
> +                  adev->vcn.fw_version);
> +       drm_printf(p, "DMCU feature version: %u, fw version: 0x%08x\n", 0=
,
> +                  adev->dm.dmcu_fw_version);
> +       drm_printf(p, "DMCUB feature version: %u, fw version: 0x%08x\n", =
0,
> +                  adev->dm.dmcub_fw_version);
> +       drm_printf(p, "PSP TOC feature version: %u, fw version: 0x%08x\n"=
,
> +                  adev->psp.toc.feature_version, adev->psp.toc.fw_versio=
n);
> +
> +       version =3D adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK;
> +       feature =3D (adev->mes.kiq_version & AMDGPU_MES_FEAT_VERSION_MASK=
) >>
> +                 AMDGPU_MES_FEAT_VERSION_SHIFT;
> +       drm_printf(p, "MES_KIQ feature version: %u, fw version: 0x%08x\n"=
,
> +                  feature, version);
> +
> +       version =3D adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
> +       feature =3D (adev->mes.sched_version & AMDGPU_MES_FEAT_VERSION_MA=
SK) >>
> +                 AMDGPU_MES_FEAT_VERSION_SHIFT;
> +       drm_printf(p, "MES feature version: %u, fw version: 0x%08x\n", fe=
ature,
> +                  version);
> +
> +       drm_printf(p, "VPE feature version: %u, fw version: 0x%08x\n",
> +                  adev->vpe.feature_version, adev->vpe.fw_version);
> +}
> +
>  static ssize_t
>  amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
>                         void *data, size_t datalen)
> @@ -118,6 +236,10 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset,=
 size_t count,
>                 }
>         }
>
> +       /* IP firmware information */
> +       drm_printf(&p, "\nIP Firmwares\n");
> +       amdgpu_devcoredump_fw_info(coredump->adev, &p);
> +
>         if (coredump->ring) {
>                 drm_printf(&p, "\nRing timed out details\n");
>                 drm_printf(&p, "IP Type: %d Ring Name: %s\n",
> --
> 2.34.1
>

