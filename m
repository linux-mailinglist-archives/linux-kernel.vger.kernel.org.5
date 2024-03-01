Return-Path: <linux-kernel+bounces-89051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3B886E9FB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD79C1C22CEB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8BD3BB25;
	Fri,  1 Mar 2024 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FAMzqZeh"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EB28F65;
	Fri,  1 Mar 2024 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709323104; cv=none; b=jRR8wB49jCyah1UUDvLJQXQJqxZbhVYoHuVRJdjYNAzYJMmlzF15HfV4Aj03Gh7qGE0PbXLDf07fnUoyp8t0gZpSB8yo7h89cJqvcDHRTcBRIu+1VomvGx6luZXc5nGUDaCLl54cQypSJIyHK0odceOjhtuRlvAqN328i7/FHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709323104; c=relaxed/simple;
	bh=Zn3bxT0o9PrrHIxUnVjgiDif2+oM8O0MliHZoyS6LXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHI3iOBJgnq3J5ubYglfVGo2ZRlkkPA3OqXgGJcjBwqWbaqWVW+QI8mbHib5mgCYN+UIJFhubmTCg/R6QGKD8dyg41BqIdPMt0zCqm/IGKO0i2+Qgv6OxtPRU+raByZepCAioZAOrbAgRVqVTpQ55s4Y8iznhI9s8ErRAGPWjW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=FAMzqZeh; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d275e63590so33452191fa.2;
        Fri, 01 Mar 2024 11:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1709323099; x=1709927899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CrGUAjJrWXnHQtTV9E2N6B/Iz+3SqPZvgpY6neIlgjA=;
        b=FAMzqZeh0I3yf129nLdOaljFCaDin9TeuMJrMd3tZzgJtpumiB3GqfNWz6mago85TV
         z2zIBJRpE0zxKWJdUiUHm1HyOdQqw6p20SW0aN64THNTikKOrmTJgDy/d7WIQfUGZM4t
         hesLhPrk0hEs3Y15Pz+G4kePxgPOIBx3Je20t4vz/Drfu6tebjhpk30sIaqeXbye9YlZ
         C/cN5DtShRpq4Bo2bCB+fxjiDIIM0E08Ej5MKxowkVg78WOZ9t4uw4s6A1O+E2FHla2n
         cOVsZxuc2Y/1GXW+fEgYiba8/sAnF9s9wR35SUUYvumscb+uOi4Yof8wkfcsqgmdXu4L
         j2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709323099; x=1709927899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrGUAjJrWXnHQtTV9E2N6B/Iz+3SqPZvgpY6neIlgjA=;
        b=AcNn8Y0ly6rwbMQWRmS4aqTh7dLdlUGo8enylGa0v0gVdI2NUj1icZ6il2y0kisATE
         neR9Knv73qJX/KpCV3RTSk5ncIYZiiUjjTdLxzb1QUb4ZLLOZ5RpOGdUKMP4jDWd6T2+
         n154bBQzUkBu+jyDH/bs9FVidex3+IMyYFWAWJadRccC5rCmIbLRFbGfaErfVyALwtPU
         TUFutWCtPuuFZEfMDnGPk+yc4M5o7NvW1rdqCy8EO0nG/ft3He/CKL6uTkoBZhN0ecwi
         byYrajH8G9RlSHus5t6CnJJiwaJ6EVCyYFh3+oilqjNKYlFOAMyHdIdDlbopL5Ei5fxg
         a/vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXw9kDeD07v45eKMso+iJ17/OmwL7vMhM6oCyJxopr2oQ0spEt+UJJMPbnCcpKY2fUXa6OWgMOpG3r8MoVvxmq30d0Kb04lDx+AVYh79L1Ei71I0ueBbwBfNwUw2vZ/29XDAMA
X-Gm-Message-State: AOJu0Yz4Fok308hmDrJBiIRKWVU9c74ARJ6MWcAG2oQ1mjPakm4wJ2TL
	a8Bw9XFVjPrVb/M+uRPS8sthCahvsS8Fb5hb9DHvvs4qMt8dERAR
X-Google-Smtp-Source: AGHT+IGDylYd6fVtVJ2o8u3+lHLgNJ2Q1Cqq7pOXwxVuvRZFsVJcrhZ2y9ZkaGNrLCLmNUy4q4tG+A==
X-Received: by 2002:a2e:a30d:0:b0:2d2:3758:8c2a with SMTP id l13-20020a2ea30d000000b002d237588c2amr1894648lje.9.1709323098091;
        Fri, 01 Mar 2024 11:58:18 -0800 (PST)
Received: from [192.168.1.10] ([94.9.209.181])
        by smtp.googlemail.com with ESMTPSA id bj19-20020a0560001e1300b0033e0302d892sm5570050wrb.66.2024.03.01.11.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 11:58:17 -0800 (PST)
Message-ID: <7c704581-6b16-46c3-9ca3-77ae97644d2e@googlemail.com>
Date: Fri, 1 Mar 2024 19:58:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: Linux 6.7.7
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, jslaby@suse.cz
References: <2024030109-thievish-tapered-7da6@gregkh>
Content-Language: en-GB
From: Chris Clayton <chris2553@googlemail.com>
In-Reply-To: <2024030109-thievish-tapered-7da6@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi

On 01/03/2024 13:16, Greg Kroah-Hartman wrote:
> I'm announcing the release of the 6.7.7 kernel.
> 
> All users of the 6.7 kernel series must upgrade.
> 
> The updated 6.7.y git tree can be found at:
>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.7.y
> and can be browsed at the normal kernel.org git web browser:
>     https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> 
> thanks,
> 
> greg k-h
> 
> ------------

linux-6.7.7 fails to build when CONFIG_NTFS3_LZX_XPRESS is not defined. The same build failure occured in the 6.8  and
is fixed by c8e314624a1666ed2eec28549713021a8ec801e9

Chris Clayton
> 
>  Documentation/conf.py                                           |    6 
>  Documentation/dev-tools/kunit/usage.rst                         |   10 
>  Makefile                                                        |    2 
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts      |    4 
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts       |    4 
>  arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts              |    2 
>  arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi    |    4 
>  arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi             |    2 
>  arch/arm/boot/dts/nxp/imx/imx7d-flex-concentrator.dts           |    2 
>  arch/arm/boot/dts/ti/omap/am335x-moxa-uc-2100-common.dtsi       |    2 
>  arch/arm/mach-ep93xx/core.c                                     |    1 
>  arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts     |    2 
>  arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts     |    9 
>  arch/arm64/boot/dts/rockchip/px30.dtsi                          |    2 
>  arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts        |   10 
>  arch/arm64/include/asm/fpsimd.h                                 |    2 
>  arch/arm64/kernel/fpsimd.c                                      |   16 
>  arch/arm64/kernel/suspend.c                                     |    3 
>  arch/arm64/kvm/vgic/vgic-its.c                                  |    5 
>  arch/loongarch/Kconfig                                          |   23 
>  arch/loongarch/include/asm/acpi.h                               |    4 
>  arch/loongarch/kernel/acpi.c                                    |    4 
>  arch/loongarch/kernel/setup.c                                   |    4 
>  arch/loongarch/kernel/smp.c                                     |  122 ++---
>  arch/loongarch/vdso/Makefile                                    |    1 
>  arch/mips/kernel/traps.c                                        |    8 
>  arch/parisc/kernel/processor.c                                  |    8 
>  arch/parisc/kernel/unwind.c                                     |   14 
>  arch/powerpc/include/asm/ppc-pci.h                              |   10 
>  arch/powerpc/kernel/iommu.c                                     |   23 
>  arch/powerpc/kvm/book3s_hv.c                                    |   26 +
>  arch/powerpc/kvm/book3s_hv_nestedv2.c                           |   20 
>  arch/powerpc/platforms/pseries/pci_dlpar.c                      |    4 
>  arch/s390/pci/pci.c                                             |    2 
>  arch/sparc/Makefile                                             |    2 
>  arch/sparc/video/Makefile                                       |    2 
>  arch/x86/entry/entry.S                                          |   23 
>  arch/x86/include/asm/cpufeatures.h                              |    2 
>  arch/x86/include/asm/nospec-branch.h                            |   13 
>  arch/x86/kernel/traps.c                                         |    2 
>  arch/x86/mm/numa.c                                              |   21 
>  block/blk-map.c                                                 |   13 
>  drivers/accel/ivpu/ivpu_drv.c                                   |    5 
>  drivers/accel/ivpu/ivpu_hw_37xx.c                               |    2 
>  drivers/accel/ivpu/ivpu_hw_40xx.c                               |    9 
>  drivers/accel/ivpu/ivpu_mmu.c                                   |    3 
>  drivers/ata/ahci.c                                              |   44 +
>  drivers/ata/ahci.h                                              |    1 
>  drivers/ata/ahci_ceva.c                                         |  125 +++--
>  drivers/ata/libata-core.c                                       |   59 +-
>  drivers/block/aoe/aoeblk.c                                      |    5 
>  drivers/block/virtio_blk.c                                      |    7 
>  drivers/bus/imx-weim.c                                          |    2 
>  drivers/cache/ax45mp_cache.c                                    |    4 
>  drivers/crypto/virtio/virtio_crypto_akcipher_algs.c             |    5 
>  drivers/cxl/acpi.c                                              |   46 +
>  drivers/cxl/core/pci.c                                          |   49 +-
>  drivers/dma/apple-admac.c                                       |    5 
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c                        |    4 
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c                        |    4 
>  drivers/dma/fsl-qdma.c                                          |    2 
>  drivers/dma/sh/shdma.h                                          |    2 
>  drivers/dma/ti/edma.c                                           |   10 
>  drivers/firewire/core-card.c                                    |   18 
>  drivers/firmware/efi/arm-runtime.c                              |    2 
>  drivers/firmware/efi/efi-init.c                                 |   19 
>  drivers/firmware/efi/riscv-runtime.c                            |    2 
>  drivers/gpio/gpiolib.c                                          |    5 
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                             |    4 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                        |   18 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                      |   11 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                         |    2 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c                      |    2 
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                           |    8 
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c                          |    6 
>  drivers/gpu/drm/amd/amdgpu/soc15.c                              |   22 
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h                           |    9 
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c               |   57 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c           |    5 
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c              |   16 
>  drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c           |    2 
>  drivers/gpu/drm/amd/display/dc/dc.h                             |    4 
>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                    |    7 
>  drivers/gpu/drm/amd/display/dc/dc_dp_types.h                    |    6 
>  drivers/gpu/drm/amd/display/dc/dc_types.h                       |   14 
>  drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c             |    1 
>  drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c       |    1 
>  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c         |   18 
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c   |    4 
>  drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c   |    4 
>  drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c       |    2 
>  drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c         |   11 
>  drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h              |    2 
>  drivers/gpu/drm/amd/display/dc/link/link_dpms.c                 |   42 +
>  drivers/gpu/drm/amd/display/dc/link/link_factory.c              |   26 -
>  drivers/gpu/drm/amd/display/dc/link/link_validation.c           |   62 ++
>  drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c |  182 +++++--
>  drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h |    9 
>  drivers/gpu/drm/drm_buddy.c                                     |    4 
>  drivers/gpu/drm/drm_syncobj.c                                   |   19 
>  drivers/gpu/drm/i915/display/intel_sdvo.c                       |   10 
>  drivers/gpu/drm/i915/display/intel_tv.c                         |   10 
>  drivers/gpu/drm/meson/meson_encoder_cvbs.c                      |    1 
>  drivers/gpu/drm/meson/meson_encoder_dsi.c                       |    1 
>  drivers/gpu/drm/meson/meson_encoder_hdmi.c                      |    1 
>  drivers/gpu/drm/nouveau/nvkm/subdev/bar/r535.c                  |    5 
>  drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c               |    8 
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c                  |   18 
>  drivers/gpu/drm/ttm/ttm_pool.c                                  |    2 
>  drivers/hid/hid-logitech-hidpp.c                                |    2 
>  drivers/hid/hid-nvidia-shield.c                                 |    4 
>  drivers/hwmon/coretemp.c                                        |    2 
>  drivers/hwmon/nct6775-core.c                                    |   14 
>  drivers/i2c/busses/i2c-imx.c                                    |    5 
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c                        |    5 
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c                        |    3 
>  drivers/infiniband/hw/hfi1/pio.c                                |    6 
>  drivers/infiniband/hw/hfi1/sdma.c                               |    2 
>  drivers/infiniband/hw/irdma/defs.h                              |    1 
>  drivers/infiniband/hw/irdma/hw.c                                |    8 
>  drivers/infiniband/hw/irdma/verbs.c                             |    9 
>  drivers/infiniband/hw/mlx5/cong.c                               |    6 
>  drivers/infiniband/hw/qedr/verbs.c                              |   11 
>  drivers/infiniband/ulp/srpt/ib_srpt.c                           |   17 
>  drivers/input/joystick/xpad.c                                   |    2 
>  drivers/input/serio/i8042-acpipnpio.h                           |    8 
>  drivers/input/touchscreen/goodix.c                              |    3 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c                 |   45 -
>  drivers/iommu/intel/iommu.c                                     |   87 +++
>  drivers/iommu/intel/iommu.h                                     |    7 
>  drivers/iommu/intel/nested.c                                    |   14 
>  drivers/iommu/intel/pasid.c                                     |    5 
>  drivers/iommu/intel/pasid.h                                     |    1 
>  drivers/iommu/iommu-sva.c                                       |    2 
>  drivers/iommu/iommufd/hw_pagetable.c                            |    3 
>  drivers/iommu/iommufd/iova_bitmap.c                             |   68 ++
>  drivers/irqchip/irq-gic-v3-its.c                                |    2 
>  drivers/irqchip/irq-mbigen.c                                    |    8 
>  drivers/irqchip/irq-sifive-plic.c                               |    8 
>  drivers/md/dm-crypt.c                                           |   95 +++-
>  drivers/md/dm-integrity.c                                       |   91 +++
>  drivers/md/dm-verity-target.c                                   |   86 +++
>  drivers/md/dm-verity.h                                          |    6 
>  drivers/md/md.c                                                 |   70 +--
>  drivers/md/raid10.c                                             |   16 
>  drivers/md/raid5.c                                              |   29 -
>  drivers/misc/open-dice.c                                        |    2 
>  drivers/net/ethernet/broadcom/asp2/bcmasp.c                     |    6 
>  drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c                |    3 
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c             |    4 
>  drivers/net/ethernet/microchip/sparx5/sparx5_main.c             |    1 
>  drivers/net/ethernet/microchip/sparx5/sparx5_main.h             |    1 
>  drivers/net/ethernet/microchip/sparx5/sparx5_packet.c           |    2 
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c               |   20 
>  drivers/net/gtp.c                                               |   10 
>  drivers/net/ipa/ipa_interrupt.c                                 |    2 
>  drivers/net/phy/realtek.c                                       |    4 
>  drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c              |    5 
>  drivers/nvme/host/fc.c                                          |   47 --
>  drivers/nvme/target/fc.c                                        |  137 +++--
>  drivers/nvme/target/fcloop.c                                    |    6 
>  drivers/nvme/target/tcp.c                                       |    1 
>  drivers/pci/msi/irqdomain.c                                     |    2 
>  drivers/platform/mellanox/mlxbf-tmfifo.c                        |   67 ++
>  drivers/platform/x86/intel/vbtn.c                               |    3 
>  drivers/platform/x86/think-lmi.c                                |   20 
>  drivers/platform/x86/thinkpad_acpi.c                            |    5 
>  drivers/platform/x86/touchscreen_dmi.c                          |   39 +
>  drivers/platform/x86/x86-android-tablets/core.c                 |    3 
>  drivers/platform/x86/x86-android-tablets/lenovo.c               |    1 
>  drivers/platform/x86/x86-android-tablets/x86-android-tablets.h  |    1 
>  drivers/regulator/max5970-regulator.c                           |    2 
>  drivers/regulator/pwm-regulator.c                               |    3 
>  drivers/s390/cio/device_ops.c                                   |    6 
>  drivers/scsi/Kconfig                                            |    2 
>  drivers/scsi/lpfc/lpfc_scsi.c                                   |   12 
>  drivers/scsi/scsi.c                                             |   22 
>  drivers/scsi/sd.c                                               |   26 +
>  drivers/scsi/smartpqi/smartpqi.h                                |    1 
>  drivers/scsi/smartpqi/smartpqi_init.c                           |   88 +++
>  drivers/spi/spi-cs42l43.c                                       |    5 
>  drivers/spi/spi-hisi-sfc-v3xx.c                                 |    5 
>  drivers/spi/spi-intel-pci.c                                     |    1 
>  drivers/spi/spi-sh-msiof.c                                      |   16 
>  drivers/target/target_core_device.c                             |    5 
>  drivers/target/target_core_pscsi.c                              |    9 
>  drivers/target/target_core_transport.c                          |    4 
>  drivers/tty/serial/amba-pl011.c                                 |   60 +-
>  drivers/tty/serial/stm32-usart.c                                |    4 
>  drivers/ufs/core/ufshcd.c                                       |    7 
>  drivers/usb/cdns3/cdns3-gadget.c                                |    8 
>  drivers/usb/cdns3/core.c                                        |    1 
>  drivers/usb/cdns3/drd.c                                         |   13 
>  drivers/usb/cdns3/drd.h                                         |    6 
>  drivers/usb/cdns3/host.c                                        |   16 
>  drivers/usb/dwc3/gadget.c                                       |    5 
>  drivers/usb/gadget/function/f_ncm.c                             |   10 
>  drivers/usb/gadget/udc/omap_udc.c                               |    3 
>  drivers/usb/roles/class.c                                       |   29 -
>  drivers/usb/storage/scsiglue.c                                  |    7 
>  drivers/usb/storage/uas.c                                       |    7 
>  drivers/usb/typec/tcpm/tcpm.c                                   |    3 
>  drivers/usb/typec/ucsi/ucsi_acpi.c                              |   71 ++-
>  drivers/video/fbdev/savage/savagefb_driver.c                    |    3 
>  drivers/video/fbdev/sis/sis_main.c                              |    2 
>  fs/afs/volume.c                                                 |    4 
>  fs/aio.c                                                        |    9 
>  fs/btrfs/defrag.c                                               |    2 
>  fs/cachefiles/cache.c                                           |    2 
>  fs/cachefiles/daemon.c                                          |    1 
>  fs/ceph/caps.c                                                  |    6 
>  fs/ceph/mds_client.c                                            |    9 
>  fs/ceph/mds_client.h                                            |    2 
>  fs/ceph/super.h                                                 |    2 
>  fs/erofs/namei.c                                                |   28 -
>  fs/ext4/extents.c                                               |  111 +++-
>  fs/ext4/mballoc.c                                               |   15 
>  fs/ntfs3/attrib.c                                               |   45 +
>  fs/ntfs3/attrlist.c                                             |   12 
>  fs/ntfs3/bitmap.c                                               |    4 
>  fs/ntfs3/dir.c                                                  |   44 +
>  fs/ntfs3/file.c                                                 |   72 ++-
>  fs/ntfs3/frecord.c                                              |   19 
>  fs/ntfs3/fslog.c                                                |  232 ++++------
>  fs/ntfs3/fsntfs.c                                               |   29 +
>  fs/ntfs3/index.c                                                |    8 
>  fs/ntfs3/inode.c                                                |   32 +
>  fs/ntfs3/namei.c                                                |   12 
>  fs/ntfs3/ntfs.h                                                 |    4 
>  fs/ntfs3/ntfs_fs.h                                              |   25 -
>  fs/ntfs3/record.c                                               |   18 
>  fs/ntfs3/super.c                                                |   49 +-
>  fs/ntfs3/xattr.c                                                |    6 
>  fs/smb/client/cached_dir.c                                      |    3 
>  fs/smb/client/cifsencrypt.c                                     |    2 
>  fs/smb/client/cifsglob.h                                        |   12 
>  fs/smb/client/connect.c                                         |   11 
>  fs/smb/client/dfs.c                                             |    7 
>  fs/smb/client/file.c                                            |    3 
>  fs/smb/client/fs_context.c                                      |    2 
>  fs/smb/client/readdir.c                                         |   15 
>  fs/smb/client/sess.c                                            |    5 
>  fs/smb/client/smb2pdu.c                                         |   26 +
>  fs/smb/client/transport.c                                       |   18 
>  include/kunit/resource.h                                        |   21 
>  include/linux/ceph/osd_client.h                                 |    3 
>  include/linux/fs.h                                              |    2 
>  include/linux/iommu.h                                           |   12 
>  include/linux/memblock.h                                        |    2 
>  include/linux/mlx5/mlx5_ifc.h                                   |    2 
>  include/linux/swap.h                                            |    5 
>  include/net/netfilter/nf_flow_table.h                           |    2 
>  include/net/switchdev.h                                         |    3 
>  include/net/tcp.h                                               |    2 
>  include/scsi/scsi_device.h                                      |    5 
>  kernel/bpf/helpers.c                                            |    5 
>  lib/Kconfig.debug                                               |    1 
>  lib/kunit/kunit-test.c                                          |    5 
>  lib/kunit/test.c                                                |    6 
>  mm/damon/core.c                                                 |   15 
>  mm/damon/lru_sort.c                                             |   43 +
>  mm/damon/reclaim.c                                              |   18 
>  mm/memblock.c                                                   |    6 
>  mm/memcontrol.c                                                 |   10 
>  mm/memory.c                                                     |   20 
>  mm/swap.h                                                       |    5 
>  mm/swapfile.c                                                   |   13 
>  mm/zswap.c                                                      |    7 
>  net/bridge/br_switchdev.c                                       |   84 ++-
>  net/ceph/osd_client.c                                           |   18 
>  net/core/skmsg.c                                                |    7 
>  net/core/sock.c                                                 |   23 
>  net/devlink/core.c                                              |   12 
>  net/devlink/port.c                                              |    2 
>  net/ipv4/arp.c                                                  |    3 
>  net/ipv4/devinet.c                                              |   21 
>  net/ipv4/inet_hashtables.c                                      |   25 +
>  net/ipv4/udp.c                                                  |    7 
>  net/ipv6/addrconf.c                                             |   21 
>  net/ipv6/exthdrs.c                                              |   10 
>  net/ipv6/seg6.c                                                 |   20 
>  net/l2tp/l2tp_ip6.c                                             |    2 
>  net/mac80211/cfg.c                                              |    2 
>  net/mac80211/debugfs_netdev.c                                   |    4 
>  net/mac80211/debugfs_netdev.h                                   |    5 
>  net/mac80211/iface.c                                            |    2 
>  net/mac80211/mlme.c                                             |    8 
>  net/mac80211/scan.c                                             |   30 -
>  net/mac80211/sta_info.c                                         |    2 
>  net/mac80211/tx.c                                               |    2 
>  net/mctp/route.c                                                |    2 
>  net/mptcp/diag.c                                                |    8 
>  net/mptcp/fastopen.c                                            |    6 
>  net/mptcp/mib.c                                                 |    1 
>  net/mptcp/mib.h                                                 |    8 
>  net/mptcp/options.c                                             |    9 
>  net/mptcp/pm_netlink.c                                          |   74 ++-
>  net/mptcp/pm_userspace.c                                        |   15 
>  net/mptcp/protocol.c                                            |   69 +-
>  net/mptcp/protocol.h                                            |   25 -
>  net/mptcp/subflow.c                                             |   86 ++-
>  net/netfilter/nf_conntrack_proto_sctp.c                         |    2 
>  net/netfilter/nf_flow_table_core.c                              |   17 
>  net/netfilter/nf_tables_api.c                                   |   81 +--
>  net/phonet/datagram.c                                           |    4 
>  net/phonet/pep.c                                                |   41 +
>  net/sched/act_mirred.c                                          |  147 +++---
>  net/sched/cls_flower.c                                          |    5 
>  net/switchdev/switchdev.c                                       |   73 +++
>  net/tls/tls_main.c                                              |    2 
>  net/tls/tls_sw.c                                                |   24 -
>  net/unix/af_unix.c                                              |   19 
>  net/wireless/nl80211.c                                          |    1 
>  net/xdp/xsk.c                                                   |    3 
>  scripts/bpf_doc.py                                              |    2 
>  sound/pci/hda/cs35l41_hda_property.c                            |    4 
>  sound/pci/hda/hda_intel.c                                       |    6 
>  sound/soc/amd/acp/acp-mach-common.c                             |    9 
>  sound/soc/codecs/wm_adsp.c                                      |   29 -
>  sound/soc/sunxi/sun4i-spdif.c                                   |    5 
>  sound/usb/clock.c                                               |   10 
>  sound/usb/format.c                                              |   20 
>  tools/net/ynl/lib/ynl.c                                         |   19 
>  tools/testing/selftests/drivers/net/bonding/bond_options.sh     |    2 
>  tools/testing/selftests/iommu/config                            |    5 
>  tools/testing/selftests/mm/uffd-unit-tests.c                    |    6 
>  tools/testing/selftests/net/forwarding/tc_actions.sh            |    3 
>  tools/testing/selftests/net/mptcp/diag.sh                       |   46 +
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh              |   41 -
>  tools/testing/selftests/net/mptcp/mptcp_join.sh                 |  109 +---
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh                  |   16 
>  tools/testing/selftests/net/mptcp/pm_netlink.sh                 |    8 
>  tools/testing/selftests/net/mptcp/simult_flows.sh               |    3 
>  tools/testing/selftests/net/mptcp/userspace_pm.sh               |   18 
>  tools/testing/selftests/riscv/hwprobe/cbo.c                     |    6 
>  tools/testing/selftests/riscv/hwprobe/hwprobe.c                 |    4 
>  tools/testing/selftests/riscv/mm/mmap_test.h                    |    3 
>  tools/testing/selftests/riscv/vector/v_initval_nolibc.c         |    2 
>  tools/testing/selftests/riscv/vector/vstate_prctl.c             |    4 
>  339 files changed, 3835 insertions(+), 1815 deletions(-)
> 
> Aaro Koskinen (1):
>       usb: gadget: omap_udc: fix USB gadget regression on Palm TE
> 
> Alex Elder (1):
>       net: ipa: don't overrun IPA suspend interrupt registers
> 
> Alexander Stein (1):
>       arm64: dts: tqma8mpql: fix audio codec iov-supply
> 
> Alexander Tsoy (2):
>       ALSA: usb-audio: Check presence of valid altsetting control
>       ALSA: usb-audio: Ignore clock selector errors for single connection
> 
> Alice Chao (1):
>       scsi: ufs: core: Fix shift issue in ufshcd_clear_cmd()
> 
> Alison Schofield (2):
>       x86/numa: Fix the address overlap check in numa_fill_memblks()
>       x86/numa: Fix the sort compare func used in numa_fill_memblks()
> 
> Amit Machhiwal (1):
>       KVM: PPC: Book3S HV: Fix L2 guest reboot failure due to empty 'arch_compat'
> 
> Andrew Bresticker (2):
>       efi: runtime: Fix potential overflow of soft-reserved region size
>       efi: Don't add memblocks for soft-reserved memory
> 
> Andrzej Kacprowski (1):
>       accel/ivpu: Don't enable any tiles by default on VPU40xx
> 
> Anshuman Khandual (1):
>       mm/memblock: add MEMBLOCK_RSRV_NOINIT into flagname[] array
> 
> Armin Wolf (1):
>       drm/amd/display: Fix memory leak in dm_sw_fini()
> 
> Arnd Bergmann (3):
>       dm-integrity, dm-verity: reduce stack usage for recheck
>       RDMA/srpt: fix function pointer cast warnings
>       nouveau: fix function cast warnings
> 
> Arunpravin Paneer Selvam (1):
>       drm/buddy: Modify duplicate list_splice_tail call
> 
> Baokun Li (4):
>       ext4: avoid dividing by 0 in mb_update_avg_fragment_size() when block bitmap corrupt
>       ext4: avoid allocating blocks from corrupted group in ext4_mb_try_best_found()
>       ext4: avoid allocating blocks from corrupted group in ext4_mb_find_by_goal()
>       cachefiles: fix memory leak in cachefiles_add_cache()
> 
> Bart Van Assche (2):
>       fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio
>       RDMA/srpt: Support specifying the srpt_service_guid parameter
> 
> Benjamin Berg (1):
>       wifi: iwlwifi: do not announce EPCS support
> 
> Brenton Simpson (1):
>       Input: xpad - add Lenovo Legion Go controllers
> 
> Charlene Liu (1):
>       drm/amd/display: fix USB-C flag update after enc10 feature init
> 
> Charles Keepax (1):
>       spi: cs42l43: Handle error from devm_pm_runtime_enable
> 
> Chen Jun (1):
>       irqchip/mbigen: Don't use bus_get_dev_root() to find the parent
> 
> Chen-Yu Tsai (1):
>       ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616
> 
> Chengming Zhou (1):
>       mm/zswap: invalidate duplicate entry when !zswap_enabled
> 
> Chhayly Leang (1):
>       ALSA: hda: cs35l41: Support ASUS Zenbook UM3402YAR
> 
> Chris Morgan (1):
>       arm64: dts: rockchip: Correct Indiedroid Nova GPIO Names
> 
> Christian A. Ehrhardt (2):
>       block: Fix WARNING in _copy_from_iter
>       usb: ucsi_acpi: Quirk to ack a connector change ack cmd
> 
> Christoph Müllner (4):
>       tools: selftests: riscv: Fix compile warnings in hwprobe
>       tools: selftests: riscv: Fix compile warnings in cbo
>       tools: selftests: riscv: Fix compile warnings in vector tests
>       tools: selftests: riscv: Fix compile warnings in mm tests
> 
> Conrad Kostecki (1):
>       ahci: asm1166: correct count of reported ports
> 
> Corey Minyard (1):
>       i2c: imx: when being a target, mark the last read as processed
> 
> Damien Le Moal (2):
>       ata: libata-core: Do not try to set sleeping devices to standby
>       ata: libata-core: Do not call ata_dev_power_set_standby() twice
> 
> Dan Carpenter (2):
>       scsi: ufs: Uninitialized variable in ufshcd_devfreq_target()
>       drm/nouveau/mmu/r535: uninitialized variable in r535_bar_new_()
> 
> Dan Williams (1):
>       cxl/acpi: Fix load failures due to single window creation failure
> 
> Daniel Vacek (1):
>       IB/hfi1: Fix sdma.h tx->num_descs off-by-one error
> 
> Daniel Wagner (9):
>       nvme-fc: do not wait in vain when unloading module
>       nvmet-fcloop: swap the list_add_tail arguments
>       nvmet-fc: release reference on target port
>       nvmet-fc: defer cleanup using RCU properly
>       nvmet-fc: free queue and assoc directly
>       nvmet-fc: hold reference on hostport match
>       nvmet-fc: abort command when there is no binding
>       nvmet-fc: avoid deadlock on delete association path
>       nvmet-fc: take ref count on tgtport before delete assoc
> 
> Daniil Dulov (1):
>       afs: Increase buffer size in afs_update_volume_status()
> 
> David Gow (1):
>       kunit: Add a macro to wrap a deferred action function
> 
> David Strahan (1):
>       scsi: smartpqi: Add new controller PCI IDs
> 
> Devyn Liu (1):
>       spi: hisi-sfc-v3xx: Return IRQ_NONE if no interrupts were detected
> 
> Dmitry Bogdanov (1):
>       scsi: target: core: Add TMF to tmr_list handling
> 
> Dmytro Laktyushkin (1):
>       drm/amd/display: Fix DPSTREAM CLK on and off sequence
> 
> Don Brace (1):
>       scsi: smartpqi: Fix disable_managed_interrupts
> 
> Edward Adam Davis (1):
>       fs/ntfs3: Fix oob in ntfs_listxattr
> 
> Emil Renner Berthing (1):
>       gpiolib: Handle no pin_ranges in gpiochip_generic_config()
> 
> Eric Dumazet (3):
>       ipv4: properly combine dev_base_seq and ipv4.dev_addr_genid
>       ipv6: properly combine dev_base_seq and ipv6.dev_addr_genid
>       net: implement lockless setsockopt(SO_PEEK_OFF)
> 
> Erik Kurzinger (2):
>       drm/syncobj: call drm_syncobj_fence_add_wait when WAIT_AVAILABLE flag is set
>       drm/syncobj: handle NULL fence in syncobj_eventfd_entry_func
> 
> Felix Fietkau (1):
>       wifi: mac80211: fix race condition on enabling fast-xmit
> 
> Florian Fainelli (1):
>       net: bcmasp: Indicate MAC is in charge of PHY PM
> 
> Florian Westphal (2):
>       netfilter: nf_tables: set dormant flag on hook register failure
>       netfilter: nf_tables: use kzalloc for hook allocation
> 
> Frank Li (2):
>       usb: cdns3: fixed memory use after free at cdns3_gadget_ep_disable()
>       usb: cdns3: fix memory double free when handle zero packet
> 
> Fullway Wang (2):
>       fbdev: savage: Error out if pixclock equals zero
>       fbdev: sis: Error out if pixclock equals zero
> 
> Gaurav Batra (1):
>       powerpc/pseries/iommu: DLPAR add doesn't completely initialize pci_controller
> 
> Geliang Tang (6):
>       mptcp: add CurrEstab MIB counter support
>       mptcp: use mptcp_set_state
>       mptcp: add needs_id for userspace appending addr
>       mptcp: add needs_id for netlink appending addr
>       selftests: mptcp: diag: check CURRESTAB counters
>       selftests: mptcp: add mptcp_lib_get_counter
> 
> Gianmarco Lusvardi (1):
>       bpf, scripts: Correct GPL license name
> 
> Greg Kroah-Hartman (1):
>       Linux 6.7.7
> 
> Guenter Roeck (3):
>       lib/Kconfig.debug: TEST_IOV_ITER depends on MMU
>       parisc: Fix stack unwinder
>       hwmon: (nct6775) Fix access to temperature configuration registers
> 
> Guixin Liu (1):
>       nvmet-tcp: fix nvme tcp ida memory leak
> 
> Hangbin Liu (1):
>       selftests: bonding: set active slave to primary eth1 specifically
> 
> Hannes Reinecke (1):
>       scsi: lpfc: Use unsigned type for num_sge
> 
> Hans de Goede (4):
>       Input: goodix - accept ACPI resources with gpio_count == 3 && gpio_int_idx == 0
>       platform/x86: x86-android-tablets: Fix keyboard touchscreen on Lenovo Yogabook1 X90
>       platform/x86: intel-vbtn: Stop calling "VBDL" from notify_handler
>       platform/x86: touchscreen_dmi: Allow partial (prefix) matches for ACPI names
> 
> Hector Martin (1):
>       dmaengine: apple-admac: Keep upper bits of REG_BUS_WIDTH
> 
> Heiko Stuebner (1):
>       arm64: dts: rockchip: set num-cs property for spi on px30
> 
> Helge Deller (1):
>       Revert "parisc: Only list existing CPUs in cpu_possible_mask"
> 
> Horatiu Vultur (1):
>       net: sparx5: Add spinlock for frame transmission from CPU
> 
> Huacai Chen (4):
>       LoongArch: Change acpi_core_pic[NR_CPUS] to acpi_core_pic[MAX_CORE_PIC]
>       LoongArch: Call early_init_fdt_scan_reserved_mem() earlier
>       LoongArch: Disable IRQ before init_fn() for nonboot CPUs
>       LoongArch: Update cpu_sibling_map when disabling nonboot CPUs
> 
> Huang Pei (1):
>       MIPS: reserve exception vector space ONLY ONCE
> 
> Ism Hong (1):
>       fs/ntfs3: use non-movable memory for ntfs3 MFT buffer cache
> 
> Jacek Lawrynowicz (1):
>       accel/ivpu: Disable d3hot_delay on all NPU generations
> 
> Jakub Kicinski (4):
>       net/sched: act_mirred: use the backlog for mirred ingress
>       net/sched: act_mirred: don't override retval if we already lost the skb
>       tools: ynl: make sure we always pass yarg to mnl_cb_run
>       tools: ynl: don't leak mcast_groups on init error
> 
> Jason Gunthorpe (3):
>       iommufd: Reject non-zero data_type if no data_len is provided
>       s390: use the correct count for __iowrite64_copy()
>       iommu/arm-smmu-v3: Do not use GFP_KERNEL under as spinlock
> 
> Javier Martinez Canillas (1):
>       sparc: Fix undefined reference to fb_is_primary_device
> 
> Jeremy Kerr (1):
>       net: mctp: put sock on tag allocation failure
> 
> Jianbo Liu (1):
>       net/sched: flower: Add lock protection when remove filter handle
> 
> Jiri Kosina (1):
>       HID: logitech-hidpp: add support for Logitech G Pro X Superlight 2
> 
> Jiri Pirko (1):
>       devlink: fix port dump cmd type
> 
> Joao Martins (4):
>       iommufd/iova_bitmap: Bounds check mapped::pages access
>       iommufd/iova_bitmap: Switch iova_bitmap::bitmap to an u8 array
>       iommufd/iova_bitmap: Handle recording beyond the mapped pages
>       iommufd/iova_bitmap: Consider page offset for the pages to be pinned
> 
> Johannes Berg (5):
>       wifi: mac80211: set station RX-NSS on reconfig
>       wifi: mac80211: fix driver debugfs for vif type change
>       wifi: mac80211: initialize SMPS mode correctly
>       wifi: mac80211: adding missing drv_mgd_complete_tx() call
>       wifi: mac80211: accept broadcast probe responses on 6 GHz
> 
> Johannes Weiner (1):
>       mm: memcontrol: clarify swapaccount=0 deprecation warning
> 
> Jonathan Corbet (1):
>       docs: Instruct LaTeX to cope with deeper nesting
> 
> Justin Chen (1):
>       net: bcmasp: Sanity check is off by one
> 
> Justin Iurman (1):
>       Fix write to cloned skb in ipv6_hop_ioam()
> 
> Kairui Song (1):
>       mm/swap: fix race when skipping swapcache
> 
> Kalesh AP (2):
>       RDMA/bnxt_re: Return error for SRQ resize
>       RDMA/bnxt_re: Add a missing check in bnxt_qplib_query_srq
> 
> Kamal Heib (1):
>       RDMA/qedr: Fix qedr_create_user_qp error flow
> 
> Kees Cook (2):
>       smb: Work around Clang __bdos() type confusion
>       LoongArch: vDSO: Disable UBSAN instrumentation
> 
> Kenzo Gomez (1):
>       ALSA: hda: cs35l41: Support additional ASUS Zenbook UX3402VA
> 
> Konstantin Komarov (23):
>       fs/ntfs3: Improve alternative boot processing
>       fs/ntfs3: Modified fix directory element type detection
>       fs/ntfs3: Improve ntfs_dir_count
>       fs/ntfs3: Correct hard links updating when dealing with DOS names
>       fs/ntfs3: Print warning while fixing hard links count
>       fs/ntfs3: Reduce stack usage
>       fs/ntfs3: Fix multithreaded stress test
>       fs/ntfs3: Fix detected field-spanning write (size 8) of single field "le->name"
>       fs/ntfs3: Correct use bh_read
>       fs/ntfs3: Add file_modified
>       fs/ntfs3: Drop suid and sgid bits as a part of fpunch
>       fs/ntfs3: Implement super_operations::shutdown
>       fs/ntfs3: ntfs3_forced_shutdown use int instead of bool
>       fs/ntfs3: Add and fix comments
>       fs/ntfs3: Add NULL ptr dereference checking at the end of attr_allocate_frame()
>       fs/ntfs3: Fix c/mtime typo
>       fs/ntfs3: Disable ATTR_LIST_ENTRY size check
>       fs/ntfs3: Use kvfree to free memory allocated by kvmalloc
>       fs/ntfs3: Prevent generic message "attempt to access beyond end of device"
>       fs/ntfs3: Use i_size_read and i_size_write
>       fs/ntfs3: Correct function is_rst_area_valid
>       fs/ntfs3: Fixed overflow check in mi_enum_attr()
>       fs/ntfs3: Update inode->i_size after success write into compressed file
> 
> Krishna Kurapati (1):
>       usb: gadget: ncm: Avoid dropping datagrams of properly parsed NTBs
> 
> Krystian Pradzynski (1):
>       accel/ivpu/40xx: Stop passing SKU boot parameters to FW
> 
> Kuniyuki Iwashima (2):
>       dccp/tcp: Unhash sk from ehash for tb2 alloc failure after check_estalblished().
>       arp: Prevent overflow in arp_req_get().
> 
> Kunwu Chan (2):
>       dmaengine: ti: edma: Add some null pointer checks to the edma_probe
>       HID: nvidia-shield: Add missing null pointer checks to LED initialization
> 
> Lad Prabhakar (1):
>       cache: ax45mp_cache: Align end size to cache boundary in ax45mp_dma_cache_wback()
> 
> Lennert Buytenhek (2):
>       ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers
>       ahci: Extend ASM1061 43-bit DMA address quirk to other ASM106x parts
> 
> Lewis Huang (1):
>       drm/amd/display: Only allow dig mapping to pwrseq in new asic
> 
> Li Ming (1):
>       cxl/pci: Skip to handle RAS errors if CXL.mem device is detached
> 
> Lijo Lazar (1):
>       drm/amdgpu: Fix HDP flush for VFs on nbio v7.9
> 
> Liming Sun (1):
>       platform/mellanox: mlxbf-tmfifo: Drop Tx network packet when Tx TmFIFO is full
> 
> Lino Sanfilippo (2):
>       serial: stm32: do not always set SER_RS485_RX_DURING_TX if RS485 is enabled
>       serial: amba-pl011: Fix DMA transmission in RS485 mode
> 
> Lucas Stach (1):
>       bus: imx-weim: fix valid range check
> 
> Lukas Wunner (1):
>       ARM: dts: Fix TPM schema violations
> 
> Ma Jun (1):
>       drm/amdgpu: Fix the runtime resume failure issue
> 
> Mahesh Rajashekhara (1):
>       scsi: smartpqi: Fix logical volume rescan race condition
> 
> Maksim Kiselev (1):
>       aoe: avoid potential deadlock at set_capacity
> 
> Marek Vasut (1):
>       arm64: dts: imx8mp: Disable UART4 by default on Data Modul i.MX8M Plus eDM SBC
> 
> Mario Limonciello (2):
>       drm/amd: Stop evicting resources on APUs in suspend
>       platform/x86: thinkpad_acpi: Only update profile if successfully converted
> 
> Mark Brown (2):
>       arm64/sme: Restore SME registers on exit from suspend
>       arm64/sme: Restore SMCR_EL1.EZT0 on exit from suspend
> 
> Mark Pearson (1):
>       platform/x86: think-lmi: Fix password opcode ordering for workstations
> 
> Mark Zhang (1):
>       IB/mlx5: Don't expose debugfs entries for RRoCE general parameters if not supported
> 
> Martin Blumenstingl (2):
>       regulator: pwm-regulator: Add validity checks in continuous .get_voltage
>       drm/meson: Don't remove bridges which are created by other drivers
> 
> Martin K. Petersen (2):
>       scsi: sd: usb_storage: uas: Access media prior to querying device properties
>       scsi: core: Consult supported VPD page list prior to fetching page
> 
> Martin KaFai Lau (1):
>       bpf: Fix racing between bpf_timer_cancel_and_free and bpf_timer_cancel
> 
> Masahiro Yamada (2):
>       LoongArch: Select ARCH_ENABLE_THP_MIGRATION instead of redefining it
>       LoongArch: Select HAVE_ARCH_SECCOMP to use the common SECCOMP menu
> 
> Matthieu Baerts (NGI0) (9):
>       selftests: mptcp: userspace_pm: unique subtest names
>       selftests: mptcp: simult flows: fix some subtest names
>       selftests: mptcp: pm nl: also list skipped tests
>       selftests: mptcp: pm nl: avoid error msg on older kernels
>       selftests: mptcp: diag: fix bash warnings on older kernels
>       selftests: mptcp: diag: unique 'in use' subtest names
>       selftests: mptcp: diag: unique 'cestab' subtest names
>       selftests: mptcp: join: stop transfer when check is done (part 1)
>       selftests: mptcp: join: stop transfer when check is done (part 2)
> 
> Maxime Ripard (1):
>       drm/i915/tv: Fix TV mode
> 
> Meenakshikumar Somasundaram (1):
>       drm/amd/display: Add dpia display mode validation logic
> 
> Melissa Wen (1):
>       drm/amd/display: fix null-pointer dereference on edid reading
> 
> Michal Kazior (1):
>       wifi: cfg80211: fix missing interfaces when dumping
> 
> Mika Westerberg (1):
>       spi: intel-pci: Add support for Arrow Lake SPI serial flash
> 
> Mike Marciniszyn (1):
>       RDMA/irdma: Fix KASAN issue with tasklet
> 
> Mikulas Patocka (4):
>       dm-crypt: recheck the integrity tag after a failure
>       dm-integrity: recheck the integrity tag after a failure
>       dm-crypt: don't modify the data when using authenticated encryption
>       dm-verity: recheck the hash after a failure
> 
> Muhammad Usama Anjum (1):
>       selftests/iommu: fix the config fragment
> 
> Mukul Joshi (1):
>       drm/amdkfd: Use correct drm device for cgroup permission check
> 
> Mustafa Ismail (2):
>       RDMA/irdma: Set the CQ read threshold for GEN 1
>       RDMA/irdma: Add AE for too many RNRS
> 
> Nam Cao (1):
>       irqchip/sifive-plic: Enable interrupt if needed before EOI
> 
> Naohiro Aota (1):
>       scsi: target: pscsi: Fix bio_put() for error case
> 
> Nathan Chancellor (1):
>       drm/amd/display: Avoid enum conversion warning
> 
> Nikita Shubin (1):
>       ARM: ep93xx: Add terminator to gpiod_lookup_table
> 
> Oliver Upton (3):
>       KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler
>       KVM: arm64: vgic-its: Test for valid IRQ in its_sync_lpi_pending_table()
>       irqchip/gic-v3-its: Do not assume vPE tables are preallocated
> 
> Ondrej Jirman (1):
>       Revert "usb: typec: tcpm: reset counter when enter into unattached state after try role"
> 
> Pablo Neira Ayuso (3):
>       netfilter: nft_flow_offload: reset dst in route object after setting up flow
>       netfilter: nft_flow_offload: release dst in case direct xmit path is used
>       netfilter: nf_tables: register hooks last when adding new chain/flowtable
> 
> Paolo Abeni (6):
>       mptcp: fix more tx path fields initialization
>       mptcp: corner case locking for rx path fields initialization
>       mptcp: fix lockless access in subflow ULP diag
>       mptcp: fix data races on local_id
>       mptcp: fix data races on remote_id
>       mptcp: fix duplicate subflow creation
> 
> Patrick Rudolph (1):
>       regulator (max5970): Fix IRQ handler
> 
> Paulo Alcantara (2):
>       smb: client: increase number of PDUs allowed in a compound request
>       smb: client: set correct d_type for reparse points under DFS mounts
> 
> Pavel Sakharov (1):
>       net: stmmac: Fix incorrect dereference in interrupt handlers
> 
> Pawan Gupta (1):
>       x86/bugs: Add asm helpers for executing VERW
> 
> Pawel Laszczak (2):
>       usb: cdnsp: blocked some cdns3 specific code
>       usb: cdnsp: fixed issue with incorrect detecting CDNSP family controllers
> 
> Peichen Huang (1):
>       drm/amd/display: Request usb4 bw for mst streams
> 
> Peter Oberparleiter (1):
>       s390/cio: fix invalid -EBUSY on ccw_device_start
> 
> Phoenix Chen (1):
>       platform/x86: touchscreen_dmi: Add info for the TECLAST X16 Plus tablet
> 
> Prike Liang (2):
>       drm/amdgpu: skip to program GFXDEC registers for suspend abort
>       drm/amdgpu: reset gpu for s3 suspend abort case
> 
> Qu Wenruo (1):
>       btrfs: defrag: avoid unnecessary defrag caused by incorrect extent size
> 
> Radhey Shyam Pandey (1):
>       ata: ahci_ceva: fix error handling for Xilinx GT PHY support
> 
> Randy Dunlap (1):
>       scsi: jazz_esp: Only build if SCSI core is builtin
> 
> Richard Fitzgerald (1):
>       ASoC: wm_adsp: Don't overwrite fwf_name with the default
> 
> Robert Richter (1):
>       cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS window
> 
> Roman Li (1):
>       drm/amd/display: Disable ips before dc interrupt setting
> 
> Rui Salvaterra (2):
>       ALSA: hda: Replace numeric device IDs with constant values
>       ALSA: hda: Increase default bdl_pos_adj for Apollo Lake
> 
> Rémi Denis-Courmont (2):
>       phonet: take correct lock to peek at the RX queue
>       phonet/pep: fix racy skb_queue_empty() use
> 
> SEO HOYOUNG (1):
>       scsi: ufs: core: Remove the ufshcd_release() in ufshcd_err_handling_prepare()
> 
> Sabrina Dubroca (3):
>       tls: break out of main loop when PEEK gets a non-data record
>       tls: stop recv() if initial process_rx_list gave us non-DATA
>       tls: don't skip over different type records from the rx_list
> 
> Sandeep Dhavale (1):
>       erofs: fix refcount on the metabuf used for inode lookup
> 
> Sebastian Andrzej Siewior (1):
>       xsk: Add truesize to skb_add_rx_frag().
> 
> SeongJae Park (3):
>       mm/damon/lru_sort: fix quota status loss due to online tunings
>       mm/damon/core: check apply interval in damon_do_apply_schemes()
>       mm/damon/reclaim: fix quota stauts loss due to online tunings
> 
> Shigeru Yoshida (1):
>       bpf, sockmap: Fix NULL pointer dereference in sk_psock_verdict_data_ready()
> 
> Shiraz Saleem (1):
>       RDMA/irdma: Validate max_send_wr and max_recv_wr
> 
> Shyam Prasad N (8):
>       cifs: open_cached_dir should not rely on primary channel
>       cifs: cifs_pick_channel should try selecting active channels
>       cifs: translate network errors on send to -ECONNABORTED
>       cifs: helper function to check replayable error codes
>       cifs: make sure that channel scaling is done only once
>       cifs: do not search for channel if server is terminating
>       cifs: change tcon status when need_reconnect is set on it
>       cifs: handle cases where multiple sessions share connection
> 
> Siddharth Vadapalli (1):
>       net: phy: realtek: Fix rtl8211f_config_init() for RTL8211F(D)(I)-VD-CG PHY
> 
> Sohaib Nadeem (3):
>       drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz
>       drm/amd/display: fixed integer types and null check locations
>       Revert "drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz"
> 
> Srinivasan Shanmugam (2):
>       drm/amd/display: Fix buffer overflow in 'get_host_router_total_dp_tunnel_bw()'
>       drm/amd/display: Fix potential null pointer dereference in dc_dmub_srv
> 
> Stanley.Yang (1):
>       drm/amdgpu: Fix shared buff copy to user
> 
> Steve French (2):
>       smb3: clarify mount warning
>       smb3: add missing null server pointer check
> 
> Subbaraya Sundeep (1):
>       octeontx2-af: Consider the action set by PF
> 
> Szilard Fabian (1):
>       Input: i8042 - add Fujitsu Lifebook U728 to i8042 quirk table
> 
> Takashi Sakamoto (1):
>       firewire: core: send bus reset promptly on gap count error
> 
> Terry Tritton (1):
>       selftests/mm: uffd-unit-test check if huge page size is 0
> 
> Thinh Nguyen (1):
>       usb: dwc3: gadget: Don't disconnect if not started
> 
> Thomas Hellström (1):
>       drm/ttm: Fix an invalid freeing on already freed page in error path
> 
> Timur Tabi (1):
>       drm/nouveau: nvkm_gsp_radix3_sg() should use nvkm_gsp_mem_ctor()
> 
> Tina Zhang (1):
>       iommu: Add mm_get_enqcmd_pasid() helper function
> 
> Tobias Waldekranz (2):
>       net: bridge: switchdev: Skip MDB replays of deferred events on offload
>       net: bridge: switchdev: Ensure deferred event delivery on unoffload
> 
> Tom Parkin (1):
>       l2tp: pass correct message length to ip6_append_data
> 
> Vasiliy Kovalev (3):
>       gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()
>       ipv6: sr: fix possible use-after-free and null-ptr-deref
>       devlink: fix possible use-after-free and memory leaks in devlink_init()
> 
> Venkata Prasad Potturu (1):
>       ASoC: amd: acp: Add check for cpu dai link initialization
> 
> Victor Nogueira (1):
>       net/sched: act_mirred: Create function tcf_mirred_to_dev and improve readability
> 
> Vidya Sagar (1):
>       PCI/MSI: Prevent MSI hardware interrupt number truncation
> 
> Vinod Koul (3):
>       dmaengine: shdma: increase size of 'dev_id'
>       dmaengine: fsl-qdma: increase size of 'irq_name'
>       dmaengine: dw-edma: increase size of 'name' in debugfs code
> 
> Wachowski, Karol (1):
>       accel/ivpu: Force snooping for MMU writes
> 
> Wayne Lin (1):
>       drm/amd/display: adjust few initialization order in dm
> 
> Will Deacon (1):
>       misc: open-dice: Fix spurious lockdep warning
> 
> Wolfram Sang (1):
>       spi: sh-msiof: avoid integer overflow in constants
> 
> Xin Long (1):
>       netfilter: conntrack: check SCTP_CID_SHUTDOWN_ACK for vtag setting in sctp_new
> 
> Xiubo Li (2):
>       libceph: fail sparse-read if the data length doesn't match
>       ceph: always check dir caps asynchronously
> 
> Xu Yang (2):
>       usb: roles: fix NULL pointer issue when put module's reference
>       usb: roles: don't get/set_role() when usb_role_switch is unregistered
> 
> Yi Liu (6):
>       iommu/vt-d: Update iotlb in nested domain attach
>       iommu/vt-d: Track nested domains in parent
>       iommu/vt-d: Remove domain parameter for intel_pasid_setup_dirty_tracking()
>       iommu/vt-d: Wrap the dirty tracking loop to be a helper
>       iommu/vt-d: Add missing dirty tracking set for parent domain
>       iommu/vt-d: Set SSADE when attaching to a parent with dirty tracking
> 
> Yi Sun (1):
>       virtio-blk: Ensure no requests in virtqueues before deleting vqs.
> 
> Yosry Ahmed (1):
>       mm: zswap: fix missing folio cleanup in writeback race path
> 
> Yu Kuai (6):
>       md: Don't ignore suspended array in md_check_recovery()
>       md: Don't ignore read-only array in md_check_recovery()
>       md: Make sure md_do_sync() will set MD_RECOVERY_DONE
>       md: Don't register sync_thread for reshape directly
>       md: Don't suspend the array for interrupted reshape
>       md: Fix missing release of 'active_io' for flush
> 
> Zhang Rui (1):
>       hwmon: (coretemp) Enlarge per package core count limit
> 
> Zhang Yi (1):
>       ext4: correct the hole length returned by ext4_map_blocks()
> 
> Zhipeng Lu (1):
>       IB/hfi1: Fix a memleak in init_credit_return
> 
> zhenwei pi (1):
>       crypto: virtio/akcipher - Fix stack overflow on memcpy
> 

