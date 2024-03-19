Return-Path: <linux-kernel+bounces-107681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263A1880001
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D173B28485E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0068256776;
	Tue, 19 Mar 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEyOV+EW"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD3B62818
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860189; cv=none; b=RTPTpaFpkVpDcxLO9ua1N7BM3IRhMXMJh8U1CeTdUHvdyicT28ujsRbintCNDc9TsyDO9AMaumo/w6M3cmcXSue3zTuihPcbxzK/KzR/e/GxXUvDowLSeskACvIOWtBmfAvG2ZCr0cKXl/S6EpSxqUKEigJrCktiKOF/nhr1sSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860189; c=relaxed/simple;
	bh=dik/k5HK042p5OfCqw8HAAlio+gLneCdzRIGtqKSCag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/zjkuXDdb5a8igYfIJW3znkBSke374pUrMRItEOno2aeJ7wxl6g81LZkypEkAnrJI8YRHeB0hjWYF539vtwhOa6HYYayv3STxq08TcBUz+8gXEic2Kw66pq78NS44zkb3vAI0yM7YIvQiSZRx9T9iSM2OadnPlmhQYjQpuXLfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEyOV+EW; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3417a3151c4so1569026f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710860185; x=1711464985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BfQPKp8XTVeFxo8rve5lY4XSXvKrGENVM3TuHTEMm2k=;
        b=TEyOV+EWsSadfkRUl0S9c6boBTOP3eZvAL2sWQo38rYeH/hAZsmZm587HFjKLLGdGq
         u5seX/qlrFZESCDSQF5f0PEtA8BKP+PSKk35DaT32is712OyAr3dkD5zHxrCWsWakG8R
         Z6c23lfEOZLVh1FkByzIbWs6H93DTs3CpN+jjzKESxaBZK4D32efwxiYcx8rMTU1LPUZ
         ih/fsji9Hx6CZRN6XewkynoOFm8Hcc+1+buwkbpnONnBnnM+v5JWnvN7gbQPgq3hc7k4
         9bsdl2e5JsGoTgpNv2ZH0jCAVzvnJtzrI+6LbBBDMHLkSzHwmnkfHvwIvT4+BuUIsjWK
         MxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710860185; x=1711464985;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BfQPKp8XTVeFxo8rve5lY4XSXvKrGENVM3TuHTEMm2k=;
        b=DzBbenwYVyClwGaCldMlSjFPZ04ikhmPaCDRMlES3KPl261xl+mIgAfySj9xAivg4r
         Px3YbHGDl268chUUDjn9iOCjuZDA8+EViR2C/q31ScLKXSEHCnvaRC5+eZ1Quw2TA3Rj
         PgxpSGaawGDR5dtd3WurmjDpT27Q8Y5qmjtu0SiT3X35j6VuoftEqNz1zGAz/bI0mfKr
         AgFIMsU7dq2JHM45E1wbioODxt/H8dX2mHz8708TdTy+xGr8p/Ow7WK1lFq+MMeMVOUM
         X+g+96VDYrtn3FIsBSX6+q7JN8zUVWJDvLQeMIgbKY8yyQNZx/2tAbbPT1Hzu2xTgFRn
         vvLg==
X-Forwarded-Encrypted: i=1; AJvYcCVHCpm+pTOc7OqeAQDduWcCkk/acP8K0QnBjzjqQ1v4YtKSK3Ii6rcgq5TPReR7Bcagawc2SmTR/+03204jkB9rfYcJHqiGkRqrzl6p
X-Gm-Message-State: AOJu0Yx3JbVebVeBo1/IMdTBcwovtkae+C0dpUAOn85GeoHsWOFGBYAK
	zmk//sRiYOnbfHKr6xrteCSuzeBHZ8ySn14brrnPdJaY38PSFl6Y
X-Google-Smtp-Source: AGHT+IEG4zLGa88C6iT149OgULBa2BRcyhmQUiQ7/+MjO16LcGp41bhLMNetrgRRzAWR0cvkxuHnBQ==
X-Received: by 2002:adf:e259:0:b0:33e:3d2:1a97 with SMTP id bl25-20020adfe259000000b0033e03d21a97mr8016025wrb.27.1710860185418;
        Tue, 19 Mar 2024 07:56:25 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id k4-20020adfe3c4000000b0033e48db23bdsm12537689wrm.100.2024.03.19.07.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 07:56:24 -0700 (PDT)
Message-ID: <8e36fae9-6501-435e-a01c-93990bef57f7@gmail.com>
Date: Tue, 19 Mar 2024 15:56:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: refactor code to reuse system information
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
References: <20240319123208.851901-1-sunil.khatri@amd.com>
 <CADnq5_PW2ZQ8sP9NcX=f5QhHM-Ne=EQA7k9BKwwwZbgsRyV4-A@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_PW2ZQ8sP9NcX=f5QhHM-Ne=EQA7k9BKwwwZbgsRyV4-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 19.03.24 um 15:26 schrieb Alex Deucher:
> On Tue, Mar 19, 2024 at 8:32 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>> Refactor the code so debugfs and devcoredump can reuse
>> the common information and avoid unnecessary copy of it.
>>
>> created a new file which would be the right place to
>> hold functions which will be used between sysfs, debugfs
>> and devcoredump.
>>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_devinfo.c | 151 ++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     | 118 +--------------
>>   4 files changed, 157 insertions(+), 115 deletions(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_devinfo.c
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 4536c8ad0e11..05d34f4b18f5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -80,7 +80,7 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
>>          amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>>          amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>>          amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>> -       amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o
>> +       amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_devinfo.o
>>
>>   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 9c62552bec34..0267870aa9b1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1609,4 +1609,5 @@ extern const struct attribute_group amdgpu_vram_mgr_attr_group;
>>   extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
>>   extern const struct attribute_group amdgpu_flash_attr_group;
>>
>> +int amdgpu_device_info(struct amdgpu_device *adev, struct drm_amdgpu_info_device *dev_info);
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_devinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_devinfo.c
>> new file mode 100644
>> index 000000000000..d2c15a1dcb0d
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_devinfo.c
>> @@ -0,0 +1,151 @@
>> +// SPDX-License-Identifier: MIT
>> +/*
>> + * Copyright 2024 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include "amdgpu.h"
>> +#include "amd_pcie.h"
>> +
>> +#include <drm/amdgpu_drm.h>
>> +
>> +int amdgpu_device_info(struct amdgpu_device *adev, struct drm_amdgpu_info_device *dev_info)
> We can probably keep this in amdgpu_kms.c unless that file is getting
> too big.  I don't think it warrants a new file at this point.  If you
> do keep it in amdgpu_kms.c, I'd recommend renaming it to something
> like amdgpu_kms_device_info() to keep the naming conventions.

We should not be using this for anything new in the first place.

A whole bunch of the stuff inside the devinfo structure has been 
deprecated because we found that putting everything into one structure 
was a bad idea.

Regards,
Christian.

>
>> +{
>> +       int ret;
>> +       uint64_t vm_size;
>> +       uint32_t pcie_gen_mask;
>> +
>> +       if (dev_info == NULL)
>> +               return -EINVAL;
>> +
>> +       dev_info->device_id = adev->pdev->device;
>> +       dev_info->chip_rev = adev->rev_id;
>> +       dev_info->external_rev = adev->external_rev_id;
>> +       dev_info->pci_rev = adev->pdev->revision;
>> +       dev_info->family = adev->family;
>> +       dev_info->num_shader_engines = adev->gfx.config.max_shader_engines;
>> +       dev_info->num_shader_arrays_per_engine = adev->gfx.config.max_sh_per_se;
>> +       /* return all clocks in KHz */
>> +       dev_info->gpu_counter_freq = amdgpu_asic_get_xclk(adev) * 10;
>> +       if (adev->pm.dpm_enabled) {
>> +               dev_info->max_engine_clock = amdgpu_dpm_get_sclk(adev, false) * 10;
>> +               dev_info->max_memory_clock = amdgpu_dpm_get_mclk(adev, false) * 10;
>> +               dev_info->min_engine_clock = amdgpu_dpm_get_sclk(adev, true) * 10;
>> +               dev_info->min_memory_clock = amdgpu_dpm_get_mclk(adev, true) * 10;
>> +       } else {
>> +               dev_info->max_engine_clock =
>> +                       dev_info->min_engine_clock =
>> +                               adev->clock.default_sclk * 10;
>> +               dev_info->max_memory_clock =
>> +                       dev_info->min_memory_clock =
>> +                               adev->clock.default_mclk * 10;
>> +               }
>> +       dev_info->enabled_rb_pipes_mask = adev->gfx.config.backend_enable_mask;
>> +       dev_info->num_rb_pipes = adev->gfx.config.max_backends_per_se *
>> +               adev->gfx.config.max_shader_engines;
>> +       dev_info->num_hw_gfx_contexts = adev->gfx.config.max_hw_contexts;
>> +       dev_info->ids_flags = 0;
>> +       if (adev->flags & AMD_IS_APU)
>> +               dev_info->ids_flags |= AMDGPU_IDS_FLAGS_FUSION;
>> +       if (adev->gfx.mcbp)
>> +               dev_info->ids_flags |= AMDGPU_IDS_FLAGS_PREEMPTION;
>> +       if (amdgpu_is_tmz(adev))
>> +               dev_info->ids_flags |= AMDGPU_IDS_FLAGS_TMZ;
>> +       if (adev->gfx.config.ta_cntl2_truncate_coord_mode)
>> +               dev_info->ids_flags |= AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD;
>> +
>> +       vm_size = adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
>> +       vm_size -= AMDGPU_VA_RESERVED_TOP;
>> +
>> +       /* Older VCE FW versions are buggy and can handle only 40bits */
>> +       if (adev->vce.fw_version && adev->vce.fw_version < AMDGPU_VCE_FW_53_45)
>> +               vm_size = min(vm_size, 1ULL << 40);
>> +
>> +       dev_info->virtual_address_offset = AMDGPU_VA_RESERVED_BOTTOM;
>> +       dev_info->virtual_address_max = min(vm_size, AMDGPU_GMC_HOLE_START);
>> +
>> +       if (vm_size > AMDGPU_GMC_HOLE_START) {
>> +               dev_info->high_va_offset = AMDGPU_GMC_HOLE_END;
>> +               dev_info->high_va_max = AMDGPU_GMC_HOLE_END | vm_size;
>> +       }
>> +       dev_info->virtual_address_alignment = max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE);
>> +       dev_info->pte_fragment_size = (1 << adev->vm_manager.fragment_size) * AMDGPU_GPU_PAGE_SIZE;
>> +       dev_info->gart_page_size = max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE);
>> +       dev_info->cu_active_number = adev->gfx.cu_info.number;
>> +       dev_info->cu_ao_mask = adev->gfx.cu_info.ao_cu_mask;
>> +       dev_info->ce_ram_size = adev->gfx.ce_ram_size;
>> +       memcpy(&dev_info->cu_ao_bitmap[0], &adev->gfx.cu_info.ao_cu_bitmap[0],
>> +              sizeof(adev->gfx.cu_info.ao_cu_bitmap));
>> +       memcpy(&dev_info->cu_bitmap[0], &adev->gfx.cu_info.bitmap[0],
>> +              sizeof(dev_info->cu_bitmap));
>> +       dev_info->vram_type = adev->gmc.vram_type;
>> +       dev_info->vram_bit_width = adev->gmc.vram_width;
>> +       dev_info->vce_harvest_config = adev->vce.harvest_config;
>> +       dev_info->gc_double_offchip_lds_buf =
>> +               adev->gfx.config.double_offchip_lds_buf;
>> +       dev_info->wave_front_size = adev->gfx.cu_info.wave_front_size;
>> +       dev_info->num_shader_visible_vgprs = adev->gfx.config.max_gprs;
>> +       dev_info->num_cu_per_sh = adev->gfx.config.max_cu_per_sh;
>> +       dev_info->num_tcc_blocks = adev->gfx.config.max_texture_channel_caches;
>> +       dev_info->gs_vgt_table_depth = adev->gfx.config.gs_vgt_table_depth;
>> +       dev_info->gs_prim_buffer_depth = adev->gfx.config.gs_prim_buffer_depth;
>> +       dev_info->max_gs_waves_per_vgt = adev->gfx.config.max_gs_threads;
>> +
>> +       if (adev->family >= AMDGPU_FAMILY_NV)
>> +               dev_info->pa_sc_tile_steering_override =
>> +                       adev->gfx.config.pa_sc_tile_steering_override;
>> +
>> +       dev_info->tcc_disabled_mask = adev->gfx.config.tcc_disabled_mask;
>> +
>> +       /* Combine the chip gen mask with the platform (CPU/mobo) mask. */
>> +       pcie_gen_mask = adev->pm.pcie_gen_mask & (adev->pm.pcie_gen_mask >> 16);
>> +       dev_info->pcie_gen = fls(pcie_gen_mask);
>> +       dev_info->pcie_num_lanes =
>> +               adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X32 ? 32 :
>> +               adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X16 ? 16 :
>> +               adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X12 ? 12 :
>> +               adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X8 ? 8 :
>> +               adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X4 ? 4 :
>> +               adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X2 ? 2 : 1;
>> +
>> +       dev_info->tcp_cache_size = adev->gfx.config.gc_tcp_l1_size;
>> +       dev_info->num_sqc_per_wgp = adev->gfx.config.gc_num_sqc_per_wgp;
>> +       dev_info->sqc_data_cache_size = adev->gfx.config.gc_l1_data_cache_size_per_sqc;
>> +       dev_info->sqc_inst_cache_size = adev->gfx.config.gc_l1_instruction_cache_size_per_sqc;
>> +       dev_info->gl1c_cache_size = adev->gfx.config.gc_gl1c_size_per_instance *
>> +                                   adev->gfx.config.gc_gl1c_per_sa;
>> +       dev_info->gl2c_cache_size = adev->gfx.config.gc_gl2c_per_gpu;
>> +       dev_info->mall_size = adev->gmc.mall_size;
>> +
>> +
>> +       if (adev->gfx.funcs->get_gfx_shadow_info) {
>> +               struct amdgpu_gfx_shadow_info shadow_info;
>> +
>> +               ret = amdgpu_gfx_get_gfx_shadow_info(adev, &shadow_info);
>> +               if (!ret) {
>> +                       dev_info->shadow_size = shadow_info.shadow_size;
>> +                       dev_info->shadow_alignment = shadow_info.shadow_alignment;
>> +                       dev_info->csa_size = shadow_info.csa_size;
>> +                       dev_info->csa_alignment = shadow_info.csa_alignment;
>> +               }
>> +       }
>> +       return ret;
>> +}
> As noted by Lijo, this should probably be a void function since we
> want to populate as much information as we can and we can't break the
> IOCTL interface.
>
> Alex
>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index a66d47865e3b..24f775c68a51 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -850,125 +850,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>          }
>>          case AMDGPU_INFO_DEV_INFO: {
>>                  struct drm_amdgpu_info_device *dev_info;
>> -               uint64_t vm_size;
>> -               uint32_t pcie_gen_mask;
>>
>>                  dev_info = kzalloc(sizeof(*dev_info), GFP_KERNEL);
>>                  if (!dev_info)
>>                          return -ENOMEM;
>>
>> -               dev_info->device_id = adev->pdev->device;
>> -               dev_info->chip_rev = adev->rev_id;
>> -               dev_info->external_rev = adev->external_rev_id;
>> -               dev_info->pci_rev = adev->pdev->revision;
>> -               dev_info->family = adev->family;
>> -               dev_info->num_shader_engines = adev->gfx.config.max_shader_engines;
>> -               dev_info->num_shader_arrays_per_engine = adev->gfx.config.max_sh_per_se;
>> -               /* return all clocks in KHz */
>> -               dev_info->gpu_counter_freq = amdgpu_asic_get_xclk(adev) * 10;
>> -               if (adev->pm.dpm_enabled) {
>> -                       dev_info->max_engine_clock = amdgpu_dpm_get_sclk(adev, false) * 10;
>> -                       dev_info->max_memory_clock = amdgpu_dpm_get_mclk(adev, false) * 10;
>> -                       dev_info->min_engine_clock = amdgpu_dpm_get_sclk(adev, true) * 10;
>> -                       dev_info->min_memory_clock = amdgpu_dpm_get_mclk(adev, true) * 10;
>> -               } else {
>> -                       dev_info->max_engine_clock =
>> -                               dev_info->min_engine_clock =
>> -                                       adev->clock.default_sclk * 10;
>> -                       dev_info->max_memory_clock =
>> -                               dev_info->min_memory_clock =
>> -                                       adev->clock.default_mclk * 10;
>> -               }
>> -               dev_info->enabled_rb_pipes_mask = adev->gfx.config.backend_enable_mask;
>> -               dev_info->num_rb_pipes = adev->gfx.config.max_backends_per_se *
>> -                       adev->gfx.config.max_shader_engines;
>> -               dev_info->num_hw_gfx_contexts = adev->gfx.config.max_hw_contexts;
>> -               dev_info->ids_flags = 0;
>> -               if (adev->flags & AMD_IS_APU)
>> -                       dev_info->ids_flags |= AMDGPU_IDS_FLAGS_FUSION;
>> -               if (adev->gfx.mcbp)
>> -                       dev_info->ids_flags |= AMDGPU_IDS_FLAGS_PREEMPTION;
>> -               if (amdgpu_is_tmz(adev))
>> -                       dev_info->ids_flags |= AMDGPU_IDS_FLAGS_TMZ;
>> -               if (adev->gfx.config.ta_cntl2_truncate_coord_mode)
>> -                       dev_info->ids_flags |= AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD;
>> -
>> -               vm_size = adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
>> -               vm_size -= AMDGPU_VA_RESERVED_TOP;
>> -
>> -               /* Older VCE FW versions are buggy and can handle only 40bits */
>> -               if (adev->vce.fw_version &&
>> -                   adev->vce.fw_version < AMDGPU_VCE_FW_53_45)
>> -                       vm_size = min(vm_size, 1ULL << 40);
>> -
>> -               dev_info->virtual_address_offset = AMDGPU_VA_RESERVED_BOTTOM;
>> -               dev_info->virtual_address_max =
>> -                       min(vm_size, AMDGPU_GMC_HOLE_START);
>> -
>> -               if (vm_size > AMDGPU_GMC_HOLE_START) {
>> -                       dev_info->high_va_offset = AMDGPU_GMC_HOLE_END;
>> -                       dev_info->high_va_max = AMDGPU_GMC_HOLE_END | vm_size;
>> -               }
>> -               dev_info->virtual_address_alignment = max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE);
>> -               dev_info->pte_fragment_size = (1 << adev->vm_manager.fragment_size) * AMDGPU_GPU_PAGE_SIZE;
>> -               dev_info->gart_page_size = max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE);
>> -               dev_info->cu_active_number = adev->gfx.cu_info.number;
>> -               dev_info->cu_ao_mask = adev->gfx.cu_info.ao_cu_mask;
>> -               dev_info->ce_ram_size = adev->gfx.ce_ram_size;
>> -               memcpy(&dev_info->cu_ao_bitmap[0], &adev->gfx.cu_info.ao_cu_bitmap[0],
>> -                      sizeof(adev->gfx.cu_info.ao_cu_bitmap));
>> -               memcpy(&dev_info->cu_bitmap[0], &adev->gfx.cu_info.bitmap[0],
>> -                      sizeof(dev_info->cu_bitmap));
>> -               dev_info->vram_type = adev->gmc.vram_type;
>> -               dev_info->vram_bit_width = adev->gmc.vram_width;
>> -               dev_info->vce_harvest_config = adev->vce.harvest_config;
>> -               dev_info->gc_double_offchip_lds_buf =
>> -                       adev->gfx.config.double_offchip_lds_buf;
>> -               dev_info->wave_front_size = adev->gfx.cu_info.wave_front_size;
>> -               dev_info->num_shader_visible_vgprs = adev->gfx.config.max_gprs;
>> -               dev_info->num_cu_per_sh = adev->gfx.config.max_cu_per_sh;
>> -               dev_info->num_tcc_blocks = adev->gfx.config.max_texture_channel_caches;
>> -               dev_info->gs_vgt_table_depth = adev->gfx.config.gs_vgt_table_depth;
>> -               dev_info->gs_prim_buffer_depth = adev->gfx.config.gs_prim_buffer_depth;
>> -               dev_info->max_gs_waves_per_vgt = adev->gfx.config.max_gs_threads;
>> -
>> -               if (adev->family >= AMDGPU_FAMILY_NV)
>> -                       dev_info->pa_sc_tile_steering_override =
>> -                               adev->gfx.config.pa_sc_tile_steering_override;
>> -
>> -               dev_info->tcc_disabled_mask = adev->gfx.config.tcc_disabled_mask;
>> -
>> -               /* Combine the chip gen mask with the platform (CPU/mobo) mask. */
>> -               pcie_gen_mask = adev->pm.pcie_gen_mask & (adev->pm.pcie_gen_mask >> 16);
>> -               dev_info->pcie_gen = fls(pcie_gen_mask);
>> -               dev_info->pcie_num_lanes =
>> -                       adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X32 ? 32 :
>> -                       adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X16 ? 16 :
>> -                       adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X12 ? 12 :
>> -                       adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X8 ? 8 :
>> -                       adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X4 ? 4 :
>> -                       adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X2 ? 2 : 1;
>> -
>> -               dev_info->tcp_cache_size = adev->gfx.config.gc_tcp_l1_size;
>> -               dev_info->num_sqc_per_wgp = adev->gfx.config.gc_num_sqc_per_wgp;
>> -               dev_info->sqc_data_cache_size = adev->gfx.config.gc_l1_data_cache_size_per_sqc;
>> -               dev_info->sqc_inst_cache_size = adev->gfx.config.gc_l1_instruction_cache_size_per_sqc;
>> -               dev_info->gl1c_cache_size = adev->gfx.config.gc_gl1c_size_per_instance *
>> -                                           adev->gfx.config.gc_gl1c_per_sa;
>> -               dev_info->gl2c_cache_size = adev->gfx.config.gc_gl2c_per_gpu;
>> -               dev_info->mall_size = adev->gmc.mall_size;
>> -
>> -
>> -               if (adev->gfx.funcs->get_gfx_shadow_info) {
>> -                       struct amdgpu_gfx_shadow_info shadow_info;
>> -
>> -                       ret = amdgpu_gfx_get_gfx_shadow_info(adev, &shadow_info);
>> -                       if (!ret) {
>> -                               dev_info->shadow_size = shadow_info.shadow_size;
>> -                               dev_info->shadow_alignment = shadow_info.shadow_alignment;
>> -                               dev_info->csa_size = shadow_info.csa_size;
>> -                               dev_info->csa_alignment = shadow_info.csa_alignment;
>> -                       }
>> +               ret = amdgpu_device_info(adev, dev_info);
>> +               if (!ret) {
>> +                       kfree(dev_info);
>> +                       return ret;
>>                  }
>>
>>                  ret = copy_to_user(out, dev_info,
>> --
>> 2.34.1
>>


