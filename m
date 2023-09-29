Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D802E7B3A8C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjI2TTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbjI2TTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B518CE6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696015130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WTJNNZR7NVys6FKsRAOqshhBEp+IfsNfsjikkXSkrQI=;
        b=MahaUCUQRGkASb5sOVmxVBT5pv2Zw/8N+AAkOxHsnEQ4ikjU6Woa+GxIYC+yXdMELUXKRY
        7SUQFJmNVi7HlhLXOli0tSjG4BIJi2o8MoShdo1GqBgC15bMvHc5c6Hwjka3EqztTTqCGW
        73Jf3+jnt0Iq2xbs2VSPA40BLJcGSHc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-vzDhT1VqNtOrvGHRCHhdoA-1; Fri, 29 Sep 2023 15:18:48 -0400
X-MC-Unique: vzDhT1VqNtOrvGHRCHhdoA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7740c3506b9so2911874685a.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015128; x=1696619928;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTJNNZR7NVys6FKsRAOqshhBEp+IfsNfsjikkXSkrQI=;
        b=cp21UtX+vDUlADlrqSCkhLVPyZYH2mSylq4jgGREB0RoOZUMMkX4fBW6zYx/dhgegE
         h8VmsfGRNIB5LxxgvyFfwmL1w+6g8GaaVwLoklilCHjj3SwDrwd/dIYS1dV+Y8SWAL9T
         y/Yhiz1cKooqRKEzlbeA0RrXkbaRZxKCXVE/QqSgUOsGA3X8/mRKgpXBqzqrG2kXmWXV
         /J2tx4T6NvLlQswfAwh/YST+olayFdd+/qw/bTlJ9I9PrY3LS3/t+0RrRWYQAGzq1q4A
         AQX3y29irqTXo+YV3f6jMm98N0bl1OwY/bZbgbE9GmZ6+6PBzeMEAZeRJQlEn6UYpp3v
         f7rw==
X-Gm-Message-State: AOJu0Yzyete4pFYp+drsWVC6MDcXn0dEZ09IAOBFLtV0DHAYbHsiyn5P
        S+FqbqKhGJzIJ1RrGpYZ5SOeKn7Cjub7gBRk6ydtIqD3EGHTo7zVqVkvhaBuTR1d9cW0aHb543L
        88XsFdM+GYtLFm1KETdXPOuUw
X-Received: by 2002:a05:620a:2847:b0:768:1572:e9af with SMTP id h7-20020a05620a284700b007681572e9afmr5312122qkp.8.1696015128004;
        Fri, 29 Sep 2023 12:18:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDstTs7WAlmA4zsm/5Nhaeb/9hAZkIH2HGZ0P0FFFRqMhid3SaXQpOmfPyQwHi/sd9C7yOAg==
X-Received: by 2002:a05:620a:2847:b0:768:1572:e9af with SMTP id h7-20020a05620a284700b007681572e9afmr5312115qkp.8.1696015127723;
        Fri, 29 Sep 2023 12:18:47 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id d24-20020a05620a159800b0076ef0fb5050sm695265qkk.31.2023.09.29.12.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:18:47 -0700 (PDT)
Date:   Fri, 29 Sep 2023 14:18:45 -0500
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
Message-ID: <qlu7wposvlgakk6an22asogu65ehjiuutarcatrd5tnqux3jmd@ddkex4fxbqbz>
References: <20230928092040.9420-1-brgl@bgdev.pl>
 <rb3xf7pumyegck2reyj73sfnpgeyr3sufgcycteozpquah5py4@jpjvcwy5k2kz>
 <CAMRc=Md1upfk8FAWDMYi-+Z4qwVyiFV=PT6-uCrwAMb00NhvvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md1upfk8FAWDMYi-+Z4qwVyiFV=PT6-uCrwAMb00NhvvA@mail.gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 08:56:57PM +0200, Bartosz Golaszewski wrote:
> On Fri, Sep 29, 2023 at 5:29 PM Andrew Halaney <ahalaney@redhat.com> wrote:
> >
> > On Thu, Sep 28, 2023 at 11:20:29AM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > This is technically the second iteration of the SHM Bridge enablement on
> > > QCom platforms but in practice it's a complete rewrite.
> > >
> > > During the internal discussion with QCom the requirement has been established
> > > as an SHM Bridge pool manager with the assumption that there will be multiple
> > > users, each with their own pool. The problem with this is that we don't have
> > > many potential users of SHM pools upstream at the moment which was rightfully
> > > pointed out in the reviews under v1 (which even had some unused symbols etc.).
> > >
> > > Moreover: after some investigating, it turns out that there simply isn't any
> > > need for multiple pools as the core SCM only allocates a buffer if given call
> > > requires more than 4 arguments and there are only a handful of SCM calls that
> > > need to pass a physical address to a buffer as argument to the trustzone.
> > >
> > > Additionally all but one SCM call allocate buffers passed to the TZ only for
> > > the duration of the call and then free it right aftr it returns. The one
> > > exception is called once and the buffer it uses can remain in memory until
> > > released by the user.
> > >
> > > This all makes using multiple pools wasteful as most of that memory will be
> > > reserved but remain unused 99% of the time. What we need is a single pool of
> > > SCM memory that deals out chunks of suitable format (coherent and
> > > page-aligned) that fulfills the requirements of all calls.
> > >
> > > As not all architectures support SHM bridge, it makes sense to first unify the
> > > memory operations in SCM calls. All users do some kind of DMA mapping to obtain
> > > buffers, most using dma_alloc_coherent() which impacts performance.
> > >
> > > Genalloc pools are very fast so let's use them instead. Create a custom
> > > allocator that also deals with the mapping and use it across all SCM calls.
> > >
> > > Then once this is done, let's extend the allocator to use the SHM bridge
> > > functionality if available on the given platform.
> > >
> > > While at it: let's create a qcom specific directory in drivers/firmware/ and
> > > move relevant code in there.
> > >
> > > I couldn't test all SCM calls but tested with the inline crypto engine on
> > > sm8550 and sa8775p that runs most of new code paths (with and without SHM
> > > bridge). At least qseecom would need some Tested-by.
> >
> > I have been playing around with this on my x13s (sc8280xp). It seems
> > that efivars works ok (and therefore the qseecom stuff I believe), but
> > with these patches applied I'm getting -22 when loading any firmware.
> >
> > I'll try to dig a little more, but thought I'd report that before I
> > context switch for a little bit.
> >
> >     dmesg | grep "firmware\|-22"
> >     [    0.000000] psci: PSCIv1.1 detected in firmware.
> >     [    2.351999] qcom_scm firmware:scm: SHM Bridge enabled
> >     [    2.353002] qcom_scm firmware:scm: qseecom: found qseecom with version 0x1402000
> >     [    6.727604] systemd[1]: systemd-pcrmachine.service - TPM2 PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/StubPcrKernelImage-4a67b082-0a4c-41cf-b6c7-440b29bb8c4f).
> >     [    8.198381] qcom_q6v5_pas 1b300000.remoteproc: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qccdsp8280.mbn
> >     [    8.198418] remoteproc remoteproc1: can't start rproc 1b300000.remoteproc: -22
> >     [    8.407641] qcom_q6v5_pas 3000000.remoteproc: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcadsp8280.mbn
> >     [    8.407742] remoteproc remoteproc0: can't start rproc 3000000.remoteproc: -22
> >     [    8.588496] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
> >     [    8.588509] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
> >     [    9.392185] ath11k_pci 0006:01:00.0: fw_version 0x110b196e fw_build_timestamp 2022-12-22 12:54 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> >     [   10.229367] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
> >     [   10.229383] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
> >     [   11.041385] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
> >     [   11.041399] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
> >     [   11.070144] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
> >     [   11.070160] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
> >     [   11.321999] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
> >     [   11.322015] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
> >     [   11.340989] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
> >     [   11.341002] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
> >     [   11.576180] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
> >     [   11.576198] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
> >     [   11.593647] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
> >     [   11.593661] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
> >     [   11.854212] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
> >     [   11.854226] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
> >     [   11.879925] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
> >     [   11.879937] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
> >     [   12.157090] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
> >     [   12.157106] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
> >     [   12.183074] adreno 3d00000.gpu: error -22 initializing firmware qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn
> >     [   12.183088] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
> >
> > Thanks,
> > Andrew
> 
> Huh remoteproc seems to work fine on sm8550. Can you post the full
> kernel log? Do you know which SCM calls fails?
> 
> Bart

See my response on patch 6, and please let me know if you I messed up
the logic there and need to dig a little more. The log didn't have
anything useful outside what is shown here unfortunately, but I can
gather more if you refute that comment on patch 6.

Thanks,
Andrew

