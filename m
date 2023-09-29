Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B3A7B36D4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjI2Pan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjI2Pak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77056B4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696001389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0EyE7lybU2xa4kGO2RQmyaL1xqyI0FDlxwF98uNTc4I=;
        b=DNTmpwb7aRyD0GKlnr/TNTvgp0SogWwiBJHWmnT5C/XBHysyPOTVTPmgEXFbcDjkq7VO7R
        sTYKuYCYWQ3og0Y9ZdJEFFQpzRKUFowmzNIaVlXiCqiCEH0UXT9+Ml/aDRHM2x6XoGQ+jY
        AdtlbJbuP/y7exPVHGJgFIuMgO88lRA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-IFDSIFPfObizeU0HQ8Yk6Q-1; Fri, 29 Sep 2023 11:29:48 -0400
X-MC-Unique: IFDSIFPfObizeU0HQ8Yk6Q-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4180c303ef1so190796281cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696001387; x=1696606187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EyE7lybU2xa4kGO2RQmyaL1xqyI0FDlxwF98uNTc4I=;
        b=rpfd0AOBf6p30xJygG1o29v7WulS4N9VnsfC7ja9lyTxICzm/Ii3gmyXwnuHSwtkOn
         npQ9ewXxdtYRkuAZ2gbpL4xrblUGMPXoFyNZwyaIsrg/oMLHhvvhMLA6hxtBuY6SQYK4
         hYOW7ZWUMB8DlZMPRCgDpVGJzbRviIw6yEQoojtiXPduzOxzPexqc7pHTPh2GevkxMR8
         OiZRlPxbJ9u2+e1xy+zkcy2vjjxpw5xHTgSL76jUcMskol0PhawxViobUy+vIXIt+m61
         onPDrmfsl90aUWLId/N4BUyUPAZ5YN12obCQMIfpd1E8kqFlDA3WI3er2PKgBjzdXcd8
         NT5w==
X-Gm-Message-State: AOJu0YyMecZBI2pBSpLwwQxW7OBfzwBKRmFvW7HSPQZxEUg9JdowD2T5
        XbPkBx85o8LHiBK/eUkjTwv7jsBfPGC8g3eRE3fmL42+qB6h5rQxFX6LDXmDyQ3JNctdLrdAtAz
        3Sbpgpmx6upzZuQDseq5oke61
X-Received: by 2002:ac8:5e4c:0:b0:417:9541:31ba with SMTP id i12-20020ac85e4c000000b00417954131bamr4217847qtx.59.1696001387598;
        Fri, 29 Sep 2023 08:29:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXqso90MPUK89c4G64yiJOv+YfvkntgvIDyz4UgRl7o5mBfeqUnByF1b3C4iKBHPkDqQpUJg==
X-Received: by 2002:ac8:5e4c:0:b0:417:9541:31ba with SMTP id i12-20020ac85e4c000000b00417954131bamr4217827qtx.59.1696001387275;
        Fri, 29 Sep 2023 08:29:47 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id fp6-20020a05622a508600b004181aa90b46sm3729548qtb.89.2023.09.29.08.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 08:29:46 -0700 (PDT)
Date:   Fri, 29 Sep 2023 10:29:44 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 00/11] arm64: qcom: add and enable SHM Bridge support
Message-ID: <rb3xf7pumyegck2reyj73sfnpgeyr3sufgcycteozpquah5py4@jpjvcwy5k2kz>
References: <20230928092040.9420-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928092040.9420-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 11:20:29AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This is technically the second iteration of the SHM Bridge enablement on
> QCom platforms but in practice it's a complete rewrite.
>
> During the internal discussion with QCom the requirement has been established
> as an SHM Bridge pool manager with the assumption that there will be multiple
> users, each with their own pool. The problem with this is that we don't have
> many potential users of SHM pools upstream at the moment which was rightfully
> pointed out in the reviews under v1 (which even had some unused symbols etc.).
>
> Moreover: after some investigating, it turns out that there simply isn't any
> need for multiple pools as the core SCM only allocates a buffer if given call
> requires more than 4 arguments and there are only a handful of SCM calls that
> need to pass a physical address to a buffer as argument to the trustzone.
>
> Additionally all but one SCM call allocate buffers passed to the TZ only for
> the duration of the call and then free it right aftr it returns. The one
> exception is called once and the buffer it uses can remain in memory until
> released by the user.
>
> This all makes using multiple pools wasteful as most of that memory will be
> reserved but remain unused 99% of the time. What we need is a single pool of
> SCM memory that deals out chunks of suitable format (coherent and
> page-aligned) that fulfills the requirements of all calls.
>
> As not all architectures support SHM bridge, it makes sense to first unify the
> memory operations in SCM calls. All users do some kind of DMA mapping to obtain
> buffers, most using dma_alloc_coherent() which impacts performance.
>
> Genalloc pools are very fast so let's use them instead. Create a custom
> allocator that also deals with the mapping and use it across all SCM calls.
>
> Then once this is done, let's extend the allocator to use the SHM bridge
> functionality if available on the given platform.
>
> While at it: let's create a qcom specific directory in drivers/firmware/ and
> move relevant code in there.
>
> I couldn't test all SCM calls but tested with the inline crypto engine on
> sm8550 and sa8775p that runs most of new code paths (with and without SHM
> bridge). At least qseecom would need some Tested-by.

I have been playing around with this on my x13s (sc8280xp). It seems
that efivars works ok (and therefore the qseecom stuff I believe), but
with these patches applied I'm getting -22 when loading any firmware.

I'll try to dig a little more, but thought I'd report that before I
context switch for a little bit.

    dmesg | grep "firmware\|-22"
    [    0.000000] psci: PSCIv1.1 detected in firmware.
    [    2.351999] qcom_scm firmware:scm: SHM Bridge enabled
    [    2.353002] qcom_scm firmware:scm: qseecom: found qseecom with version 0x1402000
    [    6.727604] systemd[1]: systemd-pcrmachine.service - TPM2 PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/StubPcrKernelImage-4a67b082-0a4c-41cf-b6c7-440b29bb8c4f).
    [    8.198381] qcom_q6v5_pas 1b300000.remoteproc: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qccdsp8280.mbn
    [    8.198418] remoteproc remoteproc1: can't start rproc 1b300000.remoteproc: -22
    [    8.407641] qcom_q6v5_pas 3000000.remoteproc: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcadsp8280.mbn
    [    8.407742] remoteproc remoteproc0: can't start rproc 3000000.remoteproc: -22
    [    8.588496] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
    [    8.588509] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
    [    9.392185] ath11k_pci 0006:01:00.0: fw_version 0x110b196e fw_build_timestamp 2022-12-22 12:54 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
    [   10.229367] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
    [   10.229383] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
    [   11.041385] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
    [   11.041399] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
    [   11.070144] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
    [   11.070160] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
    [   11.321999] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
    [   11.322015] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
    [   11.340989] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
    [   11.341002] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
    [   11.576180] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
    [   11.576198] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
    [   11.593647] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
    [   11.593661] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
    [   11.854212] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
    [   11.854226] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
    [   11.879925] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
    [   11.879937] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
    [   12.157090] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
    [   12.157106] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
    [   12.183074] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
    [   12.183088] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22

Thanks,
Andrew
>
> v1 -> v2:
> - too many changes to list, it's a complete rewrite as explained above
>
> Bartosz Golaszewski (11):
>   firmware: qcom: move Qualcomm code into its own directory
>   firmware: qcom: scm: add a dedicated SCM memory allocator
>   firmware: qcom: scm: switch to using the SCM allocator
>   firmware: qcom: scm: make qcom_scm_assign_mem() use the SCM allocator
>   firmware: qcom: scm: make qcom_scm_ice_set_key() use the SCM allocator
>   firmware: qcom: scm: make qcom_scm_pas_init_image() use the SCM
>     allocator
>   firmware: qcom: scm: make qcom_scm_lmh_dcvsh() use the SCM allocator
>   firmware: qcom: scm: make qcom_scm_qseecom_app_get_id() use the SCM
>     allocator
>   firmware: qcom: qseecom: convert to using the SCM allocator
>   firmware: qcom-scm: add support for SHM bridge operations
>   firmware: qcom: scm: enable SHM bridge
>
>  MAINTAINERS                                   |   4 +-
>  drivers/firmware/Kconfig                      |  48 +---
>  drivers/firmware/Makefile                     |   5 +-
>  drivers/firmware/qcom/Kconfig                 |  56 ++++
>  drivers/firmware/qcom/Makefile                |   9 +
>  drivers/firmware/{ => qcom}/qcom_qseecom.c    |   0
>  .../{ => qcom}/qcom_qseecom_uefisecapp.c      | 251 ++++++------------
>  drivers/firmware/{ => qcom}/qcom_scm-legacy.c |   0
>  drivers/firmware/qcom/qcom_scm-mem.c          | 170 ++++++++++++
>  drivers/firmware/{ => qcom}/qcom_scm-smc.c    |  21 +-
>  drivers/firmware/{ => qcom}/qcom_scm.c        | 149 ++++++-----
>  drivers/firmware/{ => qcom}/qcom_scm.h        |   9 +
>  include/linux/firmware/qcom/qcom_qseecom.h    |   4 +-
>  include/linux/firmware/qcom/qcom_scm.h        |  13 +
>  14 files changed, 427 insertions(+), 312 deletions(-)
>  create mode 100644 drivers/firmware/qcom/Kconfig
>  create mode 100644 drivers/firmware/qcom/Makefile
>  rename drivers/firmware/{ => qcom}/qcom_qseecom.c (100%)
>  rename drivers/firmware/{ => qcom}/qcom_qseecom_uefisecapp.c (84%)
>  rename drivers/firmware/{ => qcom}/qcom_scm-legacy.c (100%)
>  create mode 100644 drivers/firmware/qcom/qcom_scm-mem.c
>  rename drivers/firmware/{ => qcom}/qcom_scm-smc.c (92%)
>  rename drivers/firmware/{ => qcom}/qcom_scm.c (94%)
>  rename drivers/firmware/{ => qcom}/qcom_scm.h (95%)
>
> --
> 2.39.2
>

