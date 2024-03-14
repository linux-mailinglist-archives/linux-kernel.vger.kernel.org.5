Return-Path: <linux-kernel+bounces-103298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A51087BDAF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8956B1F2347E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2E45C5F3;
	Thu, 14 Mar 2024 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRDQiOI3"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5F85BACF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422869; cv=none; b=dQ+y7jjkX4nEpT1cMsz82DB818f3fc4N93WqvZMOuMmloVCUlKts4woDSjyinjfFdYhpknqgmxCYflaHsAObtStC6aF+n6uI2fgqIIcBTHkg/E5yyHOFs0HlNkGk7MtAyZZNixZ19LhN71FJMUcce3lTjlZtP9KTFvms0kCP17k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422869; c=relaxed/simple;
	bh=jzVTV6di7eRlcOh8j3TgUpHYaVdzByAdOCL8YNC5w00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3sYtRrSbv1RgkW3wd5ZHp+ncgFkaDHQMsQUEJwiu3RgMWFqwVmdNsQcD7ESTC45jI8roXlquGfirACsWkf9fNCP1isyt4iRBiN76Tf59rr6Kzf0Io2MylDo8kgQVBhs0yMVRdCsraQLPOxue/ClDo/F6IBK6jam5y6NkvVu22k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRDQiOI3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dd9066b7c3so6843575ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710422867; x=1711027667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2yg1661moNiZAX3iAHBWmn64EJAcdHlAdwOsZY2kac=;
        b=PRDQiOI3mkJ14LtOuwU1n5O/6FybauXRytyDftpj44BM2FZiW3rC/sxXkX2ESDgHNl
         lb7aq97K7oMNnufnNlm1cGpd8zcMayeGIeeYNDIlNLTeX5AqH2HmJ4iCQKWuSNQq3lFz
         VF1FtJbcRAUDviMOH48yxEGjscbM8HHg4mrrE/c9oVQSLn13BvY6louAsQ4tVVRVHASz
         5S2LQypENsf7JlClcHOjyK2Va3xRnaDpsQ89ESIOr5AG9M2lYj89/AePTUpCXuCLj6/Z
         6enRfZw9QEBq2QFq7DAvoVMR2GtdRu/I3BNnjfjAnqngZZdWF06hmqIkLZIQJjqw7rWi
         Exnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710422867; x=1711027667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2yg1661moNiZAX3iAHBWmn64EJAcdHlAdwOsZY2kac=;
        b=ouCZjEQfzNxJyRC35hVlHXXUGmetaB5KEJLdj59VE46h4KMP4JuJqww1n+Xnu/tOyT
         n4L4gGXLSkvHd3R8GWMz/Y2+M+y0h1fiypjGzEhZgec7bVxARVPREIef5cjNyHmbq/yk
         acywxN/mS+J4TkKqtTR2vkVnOPgL02y9yuHjydSHNXYBE1YXE5Kvjlgv1ADKPkB6xY/l
         1GckPTeMvneJJgDPaqP5d920tyul3ALtwrLjbabreaEkAjisQLS8JCjaN6e9J0JIL/oF
         0UXjO8er3hTmuawSYfwY1MwzkojYtJdyYp0tuiKy7/ran5pCJA6xqeQf/qb+Xys/1mU8
         VsOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnA/sGvHQ7Zic0zNcyFH67SgSl+9GcI9s5SqaKYbHRDJTfLMGGplBB/ijqleOIpWH/Hp9lIlb0V419G+RKNIaJBjs6iMGggsYP9+DN
X-Gm-Message-State: AOJu0YxUrGnP9TXjLxDNQ1GKpaIIs/eVPgfhtXKVo5O5TW31H3iLX4Qt
	cyBQfbeLAF+9C7MhAsWAOsNCyPkODJorPGZyDY78MRkBSoqcF53b1hGJ2ESJs024DioXmUNjhQz
	aG/QyK20befWOP6VXfN7PHcKqb+8=
X-Google-Smtp-Source: AGHT+IGp4g1q2p2tX2Sg+2gMda75WGf0sHyJApwNets2saxCzKetZdsNeI7wYsoIWADxDks2FEegJj82DeVPiFree7Q=
X-Received: by 2002:a17:902:e5d1:b0:1dd:d412:2c8a with SMTP id
 u17-20020a170902e5d100b001ddd4122c8amr1914849plf.10.1710422867147; Thu, 14
 Mar 2024 06:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312124148.257067-1-sunil.khatri@amd.com> <20240312124148.257067-2-sunil.khatri@amd.com>
 <CADnq5_ON0NfcpmnHKjNYWgxfvfz-J3tgjX92DaaN63iKb+FOZg@mail.gmail.com>
 <498b87fb-727c-4ea2-9633-6ecbff436eba@amd.com> <0ee30d3b-0dbc-3eb6-a19c-abeb85cbc883@amd.com>
In-Reply-To: <0ee30d3b-0dbc-3eb6-a19c-abeb85cbc883@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Mar 2024 09:27:35 -0400
Message-ID: <CADnq5_OBsCtmzzB7yC85OjHfALCjUUPTDgw7C9UsghNfx7hPnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm:amdgpu: add firmware information of all IP's
To: "Sharma, Shashank" <shashank.sharma@amd.com>
Cc: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 2:10=E2=80=AFAM Sharma, Shashank
<shashank.sharma@amd.com> wrote:
>
>
> On 14/03/2024 06:58, Khatri, Sunil wrote:
> >
> > On 3/14/2024 2:06 AM, Alex Deucher wrote:
> >> On Tue, Mar 12, 2024 at 8:42=E2=80=AFAM Sunil Khatri <sunil.khatri@amd=
com>
> >> wrote:
> >>> Add firmware version information of each
> >>> IP and each instance where applicable.
> >>>
> >> Is there a way we can share some common code with devcoredump,
> >> debugfs, and the info IOCTL?  All three places need to query this
> >> information and the same logic is repeated in each case.
> >
> > Hello Alex,
> >
> > Yes you re absolutely right the same information is being retrieved
> > again as done in debugfs. I can reorganize the code so same function
> > could be used by debugfs and devcoredump but this is exactly what i
> > tried to avoid here. I did try to use minimum functionality in
> > devcoredump without shuffling a lot of code here and there.
> >
> > Also our devcoredump is implemented in amdgpu_reset.c and not all the
> > information is available here and there we might have to include lot
> > of header and cross functions in amdgpu_reset until we want a
> > dedicated file for devcoredump.
>
>
> I think Alex is suggesting to have one common backend to generate all
> the core debug info, and then different wrapper functions which can pack
> this raw info into the packets aligned with respective infra like
> devcore/debugfs/info IOCTL, which seems like a good idea to me.

Right, something like this.  I'm trying to avoid having to touch
several places every time we add a new firmware type or TA, etc.
Maybe something like an array of valid firmwares for each device and
then we can just walk the array and call a helper function to fetch
the firmware versions and name strings for the requested type.  Then
each use case can just call the helpers to get what it needs.

Alex

>
> If you think you need a new file for this backend it should be fine.
>
>
> something like:
>
> amdgpu_debug_core.c::
>
> struct amdgpu_core_debug_info {
>
> /* Superset of all the info you are collecting from HW */
>
> };
>
> - amdgpu_debug_generate_core_info
>
> {
>
> /* This function collects the core debug info from HW and saves in
> amdgpu_core_debug_info,
>
>    we can update this periodically regardless of a request */
>
> }
>
> and then:
>
> devcore_info *amdgpu_debug_pack_for_devcore(core_debug_info)
>
> {
>
> /* convert core debug info into devcore aligned format/data */
>
> }
>
> ioctl_info *amdgpu_debug_pack_for_info_ioctl(core_debug_info)
>
> {
>
> /* convert core debug info into info IOCTL aligned format/data */
>
> }
>
> debugfs_info *amdgpu_debug_pack_for_debugfs(core_debug_info)
>
> {
>
> /* convert core debug info into debugfs aligned format/data */
>
> }
>
> - Shashank
>
> >
> >
> >
> > Info IOCTL does have a lot of information which also is in pipeline to
> > be dumped but this if we want to reuse the functionality of IOCTL we
> > need to reorganize a lot of code.
> >
> > If that is the need of the hour i could work on that. Please let me kno=
w.
> >
> > This is my suggestion if it makes sense:
> >
> > 1. If we want to reuse a lot of functionality then we need to
> > modularize some of the functions further so they could be consumed
> > directly by devcoredump.
> > 2. We should also have a dedicated file for devcoredump.c/.h so its
> > easy to include headers of needed functionality cleanly and easy to
> > expand devcoredump.
> > 3. based on the priority and importance of this task we can add
> > information else some repetition is a real possibility.
> >
> >>
> >> Alex
> >>
> >>
> >>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 122
> >>> ++++++++++++++++++++++
> >>>   1 file changed, 122 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> >>> index 611fdb90a1fc..78ddc58aef67 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> >>> @@ -168,6 +168,123 @@ void amdgpu_coredump(struct amdgpu_device
> >>> *adev, bool vram_lost,
> >>>   {
> >>>   }
> >>>   #else
> >>> +static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev,
> >>> struct drm_printer *p)
> >>> +{
> >>> +       uint32_t version;
> >>> +       uint32_t feature;
> >>> +       uint8_t smu_program, smu_major, smu_minor, smu_debug;
> >>> +
> >>> +       drm_printf(p, "VCE feature version: %u, fw version: 0x%08x\n"=
,
> >>> +                  adev->vce.fb_version, adev->vce.fw_version);
> >>> +       drm_printf(p, "UVD feature version: %u, fw version: 0x%08x\n"=
,
> >>> +                  0, adev->uvd.fw_version);
> >>> +       drm_printf(p, "GMC feature version: %u, fw version: 0x%08x\n"=
,
> >>> +                  0, adev->gmc.fw_version);
> >>> +       drm_printf(p, "ME feature version: %u, fw version: 0x%08x\n",
> >>> +                  adev->gfx.me_feature_version,
> >>> adev->gfx.me_fw_version);
> >>> +       drm_printf(p, "PFP feature version: %u, fw version: 0x%08x\n"=
,
> >>> +                  adev->gfx.pfp_feature_version,
> >>> adev->gfx.pfp_fw_version);
> >>> +       drm_printf(p, "CE feature version: %u, fw version: 0x%08x\n",
> >>> +                  adev->gfx.ce_feature_version,
> >>> adev->gfx.ce_fw_version);
> >>> +       drm_printf(p, "RLC feature version: %u, fw version: 0x%08x\n"=
,
> >>> +                  adev->gfx.rlc_feature_version,
> >>> adev->gfx.rlc_fw_version);
> >>> +
> >>> +       drm_printf(p, "RLC SRLC feature version: %u, fw version:
> >>> 0x%08x\n",
> >>> +                  adev->gfx.rlc_srlc_feature_version,
> >>> +                  adev->gfx.rlc_srlc_fw_version);
> >>> +       drm_printf(p, "RLC SRLG feature version: %u, fw version:
> >>> 0x%08x\n",
> >>> +                  adev->gfx.rlc_srlg_feature_version,
> >>> +                  adev->gfx.rlc_srlg_fw_version);
> >>> +       drm_printf(p, "RLC SRLS feature version: %u, fw version:
> >>> 0x%08x\n",
> >>> +                  adev->gfx.rlc_srls_feature_version,
> >>> +                  adev->gfx.rlc_srls_fw_version);
> >>> +       drm_printf(p, "RLCP feature version: %u, fw version: 0x%08x\n=
",
> >>> +                  adev->gfx.rlcp_ucode_feature_version,
> >>> +                  adev->gfx.rlcp_ucode_version);
> >>> +       drm_printf(p, "RLCV feature version: %u, fw version: 0x%08x\n=
",
> >>> +                  adev->gfx.rlcv_ucode_feature_version,
> >>> +                  adev->gfx.rlcv_ucode_version);
> >>> +       drm_printf(p, "MEC feature version: %u, fw version: 0x%08x\n"=
,
> >>> +                  adev->gfx.mec_feature_version,
> >>> +                  adev->gfx.mec_fw_version);
> >>> +
> >>> +       if (adev->gfx.mec2_fw)
> >>> +               drm_printf(p,
> >>> +                          "MEC2 feature version: %u, fw version:
> >>> 0x%08x\n",
> >>> +                          adev->gfx.mec2_feature_version,
> >>> +                          adev->gfx.mec2_fw_version);
> >>> +
> >>> +       drm_printf(p, "IMU feature version: %u, fw version: 0x%08x\n"=
,
> >>> +                  0, adev->gfx.imu_fw_version);
> >>> +       drm_printf(p, "PSP SOS feature version: %u, fw version:
> >>> 0x%08x\n",
> >>> +                  adev->psp.sos.feature_version,
> >>> +                  adev->psp.sos.fw_version);
> >>> +       drm_printf(p, "PSP ASD feature version: %u, fw version:
> >>> 0x%08x\n",
> >>> + adev->psp.asd_context.bin_desc.feature_version,
> >>> + adev->psp.asd_context.bin_desc.fw_version);
> >>> +
> >>> +       drm_printf(p, "TA XGMI feature version: 0x%08x, fw version:
> >>> 0x%08x\n",
> >>> + adev->psp.xgmi_context.context.bin_desc.feature_version,
> >>> + adev->psp.xgmi_context.context.bin_desc.fw_version);
> >>> +       drm_printf(p, "TA RAS feature version: 0x%08x, fw version:
> >>> 0x%08x\n",
> >>> + adev->psp.ras_context.context.bin_desc.feature_version,
> >>> + adev->psp.ras_context.context.bin_desc.fw_version);
> >>> +       drm_printf(p, "TA HDCP feature version: 0x%08x, fw version:
> >>> 0x%08x\n",
> >>> + adev->psp.hdcp_context.context.bin_desc.feature_version,
> >>> + adev->psp.hdcp_context.context.bin_desc.fw_version);
> >>> +       drm_printf(p, "TA DTM feature version: 0x%08x, fw version:
> >>> 0x%08x\n",
> >>> + adev->psp.dtm_context.context.bin_desc.feature_version,
> >>> + adev->psp.dtm_context.context.bin_desc.fw_version);
> >>> +       drm_printf(p, "TA RAP feature version: 0x%08x, fw version:
> >>> 0x%08x\n",
> >>> + adev->psp.rap_context.context.bin_desc.feature_version,
> >>> + adev->psp.rap_context.context.bin_desc.fw_version);
> >>> +       drm_printf(p, "TA SECURE DISPLAY feature version: 0x%08x, fw
> >>> version: 0x%08x\n",
> >>> + adev->psp.securedisplay_context.context.bin_desc.feature_version,
> >>> + adev->psp.securedisplay_context.context.bin_desc.fw_version);
> >>> +
> >>> +       /* SMC firmware */
> >>> +       version =3D adev->pm.fw_version;
> >>> +
> >>> +       smu_program =3D (version >> 24) & 0xff;
> >>> +       smu_major =3D (version >> 16) & 0xff;
> >>> +       smu_minor =3D (version >> 8) & 0xff;
> >>> +       smu_debug =3D (version >> 0) & 0xff;
> >>> +       drm_printf(p, "SMC feature version: %u, program: %d, fw
> >>> version: 0x%08x (%d.%d.%d)\n",
> >>> +                  0, smu_program, version, smu_major, smu_minor,
> >>> smu_debug);
> >>> +
> >>> +       /* SDMA firmware */
> >>> +       for (int i =3D 0; i < adev->sdma.num_instances; i++) {
> >>> +               drm_printf(p, "SDMA%d feature version: %u, firmware
> >>> version: 0x%08x\n",
> >>> +                          i, adev->sdma.instance[i].feature_version,
> >>> + adev->sdma.instance[i].fw_version);
> >>> +       }
> >>> +
> >>> +       drm_printf(p, "VCN feature version: %u, fw version: 0x%08x\n"=
,
> >>> +                  0, adev->vcn.fw_version);
> >>> +       drm_printf(p, "DMCU feature version: %u, fw version: 0x%08x\n=
",
> >>> +                  0, adev->dm.dmcu_fw_version);
> >>> +       drm_printf(p, "DMCUB feature version: %u, fw version:
> >>> 0x%08x\n",
> >>> +                  0, adev->dm.dmcub_fw_version);
> >>> +       drm_printf(p, "PSP TOC feature version: %u, fw version:
> >>> 0x%08x\n",
> >>> +                  adev->psp.toc.feature_version,
> >>> adev->psp.toc.fw_version);
> >>> +
> >>> +       version =3D adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK;
> >>> +       feature =3D (adev->mes.kiq_version &
> >>> AMDGPU_MES_FEAT_VERSION_MASK)
> >>> +                                       >>
> >>> AMDGPU_MES_FEAT_VERSION_SHIFT;
> >>> +       drm_printf(p, "MES_KIQ feature version: %u, fw version:
> >>> 0x%08x\n",
> >>> +                  feature, version);
> >>> +
> >>> +       version =3D adev->mes.sched_version & AMDGPU_MES_VERSION_MASK=
;
> >>> +       feature =3D (adev->mes.sched_version &
> >>> AMDGPU_MES_FEAT_VERSION_MASK)
> >>> +                                       >>
> >>> AMDGPU_MES_FEAT_VERSION_SHIFT;
> >>> +       drm_printf(p, "MES feature version: %u, fw version: 0x%08x\n"=
,
> >>> +                  feature, version);
> >>> +
> >>> +       drm_printf(p, "VPE feature version: %u, fw version: 0x%08x\n"=
,
> >>> +                  adev->vpe.feature_version, adev->vpe.fw_version);
> >>> +
> >>> +}
> >>> +
> >>>   static ssize_t
> >>>   amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
> >>>                          void *data, size_t datalen)
> >>> @@ -215,6 +332,11 @@ amdgpu_devcoredump_read(char *buffer, loff_t
> >>> offset, size_t count,
> >>>                  }
> >>>          }
> >>>
> >>> +       if (coredump->adev) {
> >>> +               drm_printf(&p, "IP Firmwares\n");
> >>> +               amdgpu_devcoredump_fw_info(coredump->adev, &p);
> >>> +       }
> >>> +
> >>>          if (coredump->ring) {
> >>>                  drm_printf(&p, "\nRing timed out details\n");
> >>>                  drm_printf(&p, "IP Type: %d Ring Name: %s\n",
> >>> --
> >>> 2.34.1
> >>>

