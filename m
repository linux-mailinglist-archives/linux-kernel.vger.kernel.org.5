Return-Path: <linux-kernel+bounces-126979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578FC894559
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9131C21517
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F38553364;
	Mon,  1 Apr 2024 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GEQjp8BQ"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A6C4EB38
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998822; cv=none; b=QnI0l/fIbgRzVH/n/gUFYPdYvOJLkNFza9D7wH7oTcaC2djU6wnVRmzZyCiLQ5xewz0nva1FzCkBoZbR8KrOblUIPk0A7msi7THFH/AIM84z5vqt9dSyJjbugfcrzcrxiQBkgPw8x1Ozx4iY+Y9xpPia30FfgSA7Nth6L8HJEgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998822; c=relaxed/simple;
	bh=xRA2kVWdLsLw32UwgsjnRYu7M6yDHMhVPmZxCGwEJAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZESUjDr2Atfc4NS/kCsf//9IFQ7YbPURAT9xjM0UOspdn8C+Jz+kk/YnfXdmnk/lM57YK5FrdTJpYuocZBVXa1Oec6TLhWGkL9Dqc+nCHAfMuh4lB2ek6HtZlfQFjtqI3HKtHGqcwNldsAK2gNZFDHwWj3Q0WdkJuU3rcNnFMEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GEQjp8BQ; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbed179f0faso3458889276.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 12:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711998819; x=1712603619; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Prq1QJJnQQU7u1iRcjMVZrhCj4xAy2Si6lydnwZRhuc=;
        b=GEQjp8BQBHTGx4Qk+SOSFx59tIEZtTXojY3K60hTjWTtjeal0ufWWkq8d11UUYpTWI
         2VpJ+Nv6l/7atUUN4KfB5UXjf3jz8ZvhVadbnqsbFpS7ItA3eeMi7pOeFGsEOFyYDwfx
         S6GU0rhJDKVHiTslt0bTykbKbsYVWNxz5wqlwJcXpOlg5iarMgSijaSlRfIHSv9USLpx
         MlYHPCNgBADoIje+h9ODRnirUS0GauxgWtYhnyHc+XfEDNWfxRtZOWvOW+ysdvvQZ28J
         FqPLFjklrUGBVU1YQxiYMXEP3RkCb1NYKtM/Z72qV5sN37AeORdpu2opsIx6uRRovjD8
         d00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711998819; x=1712603619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Prq1QJJnQQU7u1iRcjMVZrhCj4xAy2Si6lydnwZRhuc=;
        b=DZ+0tXYG8+xaRbwESW+TnbH7Ue6JMaCpd4ZXgoxlzsrg7xYKbl7alnPS4m10v5Lh+w
         poWxVQbd7l4xF375DVjJQmJdsbE6ZfbpuffOYpvSfHdDTyaW9xiilT5HKEkOI2Xk3z6G
         7tqlf+BP1Q0LWwiahvSOJ4sKh33sExLEcM2eVinfvGrd3DM/TcM1vfFlS1ETDBlMtoy4
         CmSR01ydoWNzKcxm/2dJtNsjv5mGi7scKz7c91X1WC01fbx+KQ7xxGCU52StrQj7G6GC
         yQgHhFSwNCYbD0hUl+dWHadvqP4ale/HzFVAI3XXamz8iJije9sHD7ucev7oK0U160Cr
         w4MA==
X-Forwarded-Encrypted: i=1; AJvYcCXYGa+0TNIHtihCjCNZG1aot4NDCZDBbCaW7sWtUoCXGC+d/5zSUkx/6CrzYr6SfA3qF1iWsm2gDRqvJj6SfZMYkmO75VzJ9OxMRJ5K
X-Gm-Message-State: AOJu0Yya7Vm7D6msuGs4xe4TUx/RUsuMVv76pA1Dq78L2qci2cCPx2s1
	z/FzqU3f4iPlIWWSKfQbZklLj/fXsv8Wqmij8k1KF958XGtwmRD57dPuNImTlEd0HuO0yboVH+j
	eM+a45faqpi+2jYOpeyGZRh8dhvUw8C6ws6wzB3zkxijAH7fi
X-Google-Smtp-Source: AGHT+IH0/B1ZK59cE+3njkExu1/oK/oKfgca8fZUN4erCCFS3DlhCeWUIs/BPU37DZOaYWWikalNTl6N1DBcONTXIVM=
X-Received: by 2002:a25:820d:0:b0:dcb:df38:1c20 with SMTP id
 q13-20020a25820d000000b00dcbdf381c20mr7122644ybk.24.1711998819458; Mon, 01
 Apr 2024 12:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401093843.2591147-1-quic_tengfan@quicinc.com> <20240401093843.2591147-3-quic_tengfan@quicinc.com>
In-Reply-To: <20240401093843.2591147-3-quic_tengfan@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 1 Apr 2024 22:13:28 +0300
Message-ID: <CAA8EJpqddAsgVGMfVi8A+cqCq9w5fDBfNuhiLK2t-q=6gBpy+Q@mail.gmail.com>
Subject: Re: [PATCH v6 RESEND 2/4] arm64: dts: qcom: qcs8550: introduce
 qcs8550 dtsi
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, keescook@chromium.org, 
	tony.luck@intel.com, gpiccoli@igalia.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Apr 2024 at 12:40, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>
> QCS8550 is derived from SM8550. The differnece between SM8550 and
> QCS8550 is QCS8550 doesn't have modem RF system. QCS8550 is mainly used
> in IoT scenarios.
> QCS8550 firmware has different memory map with SM8550 firmware. The
> memory map will be runtime added through bootloader.
> There are 3 types of reserved memory regions here:
> 1. Firmware related regions which aren't shared with kernel.
>     The device tree source in kernel doesn't need to have node to indicate
> the firmware related reserved information. OS bootloader conveys the
> information by update device tree in runtime.
>     This will be described as: UEFI saves the physical address of the
> UEFI System Table to dts file's chosen node. Kernel read this table and
> add reserved memory regions to efi config table. Current reserved memory
> region may have reserved region which was not yet used, release note of
> the firmware have such kind of information.
> 2. Firmware related memory regions which are shared with Kernel
>     Each region has a specific node with specific label name for later
> phandle reference from other driver dt node.
> 3. PIL regions.
>     PIL regions will be reserved and then assigned to subsystem firmware
> later.
> Here is a reserved memory map for this platform:
> 0x100000000 +------------------+
>             |                  |
>             | Firmware Related |
>             |                  |
>  0xd4d00000 +------------------+
>             |                  |
>             | Kernel Available |
>             |                  |
>  0xa7000000 +------------------+
>             |                  |
>             |    PIL Region    |
>             |                  |
>  0x8a800000 +------------------+
>             |                  |
>             | Firmware Related |
>             |                  |
>  0x80000000 +------------------+
> Note that:
> 0xa7000000..0xA8000000 is used by bootloader, when kernel boot up,
> it is available for kernel usage. This region is not suggested to be
> used by kernel features like ramoops, suspend resume etc.
>
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8550.dtsi | 169 ++++++++++++++++++++++++++
>  1 file changed, 169 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qcs8550.dtsi

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Minor nit below.

>
> diff --git a/arch/arm64/boot/dts/qcom/qcs8550.dtsi b/arch/arm64/boot/dts/qcom/qcs8550.dtsi
> new file mode 100644
> index 000000000000..a3ebf3d4e16d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs8550.dtsi
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include "sm8550.dtsi"
> +
> +/delete-node/ &reserved_memory;
> +
> +/ {
> +       reserved_memory: reserved-memory {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +
> +               /* These are 3 types of reserved memory regions here:
> +                * 1. Firmware related regions which aren't shared with kernel.
> +                *     The device tree source in kernel doesn't need to have node to
> +                * indicate the firmware related reserved information. OS bootloader
> +                * conveys the information by update device tree in runtime.
> +                *     This will be described as: UEFI saves the physical address of
> +                * the UEFI System Table to dts file's chosen node. Kernel read this
> +                * table and add reserved memory regions to efi config table. Current
> +                * reserved memory region may have reserved region which was not yet
> +                * used, release note of the firmware have such kind of information.
> +                * 2. Firmware related memory regions which are shared with Kernel.
> +                *     Each region has a specific node with specific label name for
> +                * later phandle reference from other driver dt node.
> +                * 3. PIL regions.
> +                *     PIL regions will be reserved and then assigned to subsystem
> +                * firmware later.
> +                * Here is a reserved memory map for this platform:
> +                * 0x100000000 +------------------+
> +                *             |                  |
> +                *             | Firmware Related |
> +                *             |                  |
> +                *  0xd4d00000 +------------------+
> +                *             |                  |
> +                *             | Kernel Available |
> +                *             |                  |
> +                *  0xa7000000 +------------------+
> +                *             |                  |
> +                *             |    PIL Region    |
> +                *             |                  |
> +                *  0x8a800000 +------------------+
> +                *             |                  |
> +                *             | Firmware Related |
> +                *             |                  |
> +                *  0x80000000 +------------------+
> +                * Note that:
> +                * 0xa7000000..0xA8000000 is used by bootloader, when kernel boot up,
> +                * it is available for kernel usage. This region is not suggested to
> +                * be used by kernel features like ramoops, suspend resume etc.
> +                */
> +
> +               /*
> +                * Firmware related regions, bootlader will possible reserve parts of
> +                * region from 0x80000000..0x8a800000.
> +                */
> +               aop_image_mem: aop-image-region@81c00000 {
> +                       reg = <0x0 0x81c00000 0x0 0x60000>;
> +                       no-map;
> +               };
> +
> +               aop_cmd_db_mem: aop-cmd-db-region@81c60000 {
> +                       compatible = "qcom,cmd-db";
> +                       reg = <0x0 0x81c60000 0x0 0x20000>;
> +                       no-map;
> +               };
> +
> +               aop_config_mem: aop-config-region@81c80000 {
> +                       no-map;
> +                       reg = <0x0 0x81c80000 0x0 0x20000>;
> +               };
> +
> +               smem_mem: smem-region@81d00000 {
> +                       compatible = "qcom,smem";
> +                       reg = <0x0 0x81d00000 0x0 0x200000>;
> +                       hwlocks = <&tcsr_mutex 3>;
> +                       no-map;
> +               };
> +
> +               adsp_mhi_mem: adsp-mhi-region@81f00000 {
> +                       reg = <0x0 0x81f00000 0x0 0x20000>;
> +                       no-map;
> +               };
> +
> +               /* PIL region */
> +               mpss_mem: mpss-region@8a800000 {
> +                       reg = <0x0 0x8a800000 0x0 0x10800000>;
> +                       no-map;
> +               };
> +
> +               q6_mpss_dtb_mem: q6-mpss-dtb-region@9b000000 {
> +                       reg = <0x0 0x9b000000 0x0 0x80000>;
> +                       no-map;
> +               };
> +
> +               ipa_fw_mem: ipa-fw-region@9b080000 {
> +                       reg = <0x0 0x9b080000 0x0 0x10000>;
> +                       no-map;
> +               };
> +
> +               ipa_gsi_mem: ipa-gsi-region@9b090000 {
> +                       reg = <0x0 0x9b090000 0x0 0xa000>;
> +                       no-map;
> +               };
> +
> +               gpu_micro_code_mem: gpu-micro-code-region@9b09a000 {
> +                       reg = <0x0 0x9b09a000 0x0 0x2000>;
> +                       no-map;
> +               };
> +
> +               spss_region_mem: spss-region@9b100000 {
> +                       reg = <0x0 0x9b100000 0x0 0x180000>;
> +                       no-map;
> +               };
> +
> +               spu_secure_shared_memory_mem: spu-secure-shared-memory-region@9b280000 {
> +                       reg = <0x0 0x9b280000 0x0 0x80000>;
> +                       no-map;
> +               };
> +
> +               camera_mem: camera-region@9b300000 {
> +                       reg = <0x0 0x9b300000 0x0 0x800000>;
> +                       no-map;
> +               };
> +
> +               video_mem: video-region@9bb00000 {
> +                       reg = <0x0 0x9bb00000 0x0 0x700000>;
> +                       no-map;
> +               };
> +
> +               cvp_mem: cvp-region@9c200000 {
> +                       reg = <0x0 0x9c200000 0x0 0x700000>;
> +                       no-map;
> +               };
> +
> +               cdsp_mem: cdsp-region@9c900000 {
> +                       reg = <0x0 0x9c900000 0x0 0x2000000>;
> +                       no-map;
> +               };
> +
> +               q6_cdsp_dtb_mem: q6-cdsp-dtb-region@9e900000 {
> +                       reg = <0x0 0x9e900000 0x0 0x80000>;
> +                       no-map;
> +               };
> +
> +               q6_adsp_dtb_mem: q6-adsp-dtb-region@9e980000 {
> +                       reg = <0x0 0x9e980000 0x0 0x80000>;
> +                       no-map;
> +               };
> +
> +               adspslpi_mem: adspslpi-region@9ea00000 {
> +                       reg = <0x0 0x9ea00000 0x0 0x4080000>;
> +                       no-map;
> +               };
> +
> +               /*
> +                * Firmware related regions, bootlader will possible reserve parts of

Nit: bootloader will possibly...

> +                * region from 0xd8000000..0x100000000.
> +                */
> +               mpss_dsm_mem: mpss_dsm_region@d4d00000 {
> +                       reg = <0x0 0xd4d00000 0x0 0x3300000>;
> +                       no-map;
> +               };
> +       };
> +};
> --
> 2.25.1
>
>


-- 
With best wishes
Dmitry

