Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94CA80AE12
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574714AbjLHUjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHUjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:39:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12833171E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 12:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702067995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BZ2jOncrEKw232jrvqkJsjD/GwaaXlY1Y1umyeZKqBI=;
        b=gEeD8FPsNnrR0QG/hwuQWxfEOa2yn5XOcuihrT4Wqh5461mqNbhBw7MsSAK/Di7O3di1I8
        /hIDIOaMzzem/pbEWm9A7mIKGh5YsEsB4SyFvhCfI3W4513i+YofKtDlnzHvRs4yvcC7rN
        To9m5FUc1K+Y5L359C9qkDteXaCJ5Bg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-giCgkY__ML2QaEo5-V3dLw-1; Fri, 08 Dec 2023 15:39:54 -0500
X-MC-Unique: giCgkY__ML2QaEo5-V3dLw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-77f5a5dde50so44345385a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 12:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702067993; x=1702672793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZ2jOncrEKw232jrvqkJsjD/GwaaXlY1Y1umyeZKqBI=;
        b=Z/q4alTl5uqoyu3mI/SyhNexXeBfLPHpz3ZQB1rPSi+m2gc1MKSi/V/Zsxx73r0RzA
         44jOq+XKRugN5qWQj9Ys6x2q6eLHQFQmApVOLbSFqHMj+ivc7fdLUrRndAUE0Hup9oT9
         klmnwNenij1GWHqDQDgROBgu1iS8m2nryb8i6Hrx6+ikXsnV/Q3SW23TeXlfUj2LOp1/
         PwKgPPD0MiAu2Gk7tiiwwzuMGIXX9dMwpoi7shbAjmg/sTxLDDBq6s+6hEmeWUoYOnVs
         vL7GIMlplPNRxSpgDgxZz9BWgWCOD/G6afjNGPNwU3AMOp7fkffks84ZGbQJknLTEI/i
         e9vQ==
X-Gm-Message-State: AOJu0YyOU3h3dO2Zrk7YfbsusTi3pdxZT98rMuy6+BBhEpMC/RaEgaWp
        LgR6yQeNaQwYoI2H/UO/g1ePOHkogtUOSP4EQp1yC0zvn/xJ9ooAJmXlnc3tS7/9akSR9DvWVXi
        vSTV6+h0WGFtJ/WalB1Ivy51h
X-Received: by 2002:a05:620a:4628:b0:77f:3b42:d9ce with SMTP id br40-20020a05620a462800b0077f3b42d9cemr760945qkb.85.1702067993659;
        Fri, 08 Dec 2023 12:39:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKxCtQsMQxp/KSOFjCeDbaxYduu4LWKBh1Y0Dagd3wlsrQ4MNeu6AtBDd9TCnEjArfrpOATw==
X-Received: by 2002:a05:620a:4628:b0:77f:3b42:d9ce with SMTP id br40-20020a05620a462800b0077f3b42d9cemr760936qkb.85.1702067993423;
        Fri, 08 Dec 2023 12:39:53 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id o1-20020a05620a228100b00775bb02893esm941499qkh.96.2023.12.08.12.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 12:39:52 -0800 (PST)
Date:   Fri, 8 Dec 2023 14:39:50 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com
Subject: Re: [PATCH v2 00/17] scsi: ufs: qcom: Code cleanups
Message-ID: <wimggq4gabqgjinxffx5dmaf6y34kf3q2r4wbcytd7s2pjabfu@hwlni6z7kpam>
References: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 12:28:45PM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series has code some cleanups to the Qcom UFS driver. No functional
> change. In this version, I've removed code supporting legacy controllers
> ver < 2.0, as the respective platforms were never supported in upstream.
> 
> Tested on: RB5 development board based on Qcom SM8250 SoC.
> 
> - Mani
> 
> Changes in v2:
> 
> * Collected review tags
> * Fixed the comments from Andrew
> * Added a few more patches, most notably one removing the code for old
>   controllers (ver < v2.0)
> 

I took this for a spin on sa8775p-ride when developing another patch
today with no issues. Certainly doesn't hit all the cases here, but:

Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8775p-ride

> Manivannan Sadhasivam (17):
>   scsi: ufs: qcom: Use clk_bulk APIs for managing lane clocks
>   scsi: ufs: qcom: Fix the return value of ufs_qcom_ice_program_key()
>   scsi: ufs: qcom: Fix the return value when
>     platform_get_resource_byname() fails
>   scsi: ufs: qcom: Remove superfluous variable assignments
>   scsi: ufs: qcom: Remove the warning message when core_reset is not
>     available
>   scsi: ufs: qcom: Export ufshcd_{enable/disable}_irq helpers and make
>     use of them
>   scsi: ufs: qcom: Fail ufs_qcom_power_up_sequence() when core_reset
>     fails
>   scsi: ufs: qcom: Check the return value of
>     ufs_qcom_power_up_sequence()
>   scsi: ufs: qcom: Remove redundant error print for devm_kzalloc()
>     failure
>   scsi: ufs: qcom: Use dev_err_probe() to simplify error handling of
>     devm_gpiod_get_optional()
>   scsi: ufs: qcom: Remove unused ufs_qcom_hosts struct array
>   scsi: ufs: qcom: Sort includes alphabetically
>   scsi: ufs: qcom: Initialize cycles_in_1us variable in
>     ufs_qcom_set_core_clk_ctrl()
>   scsi: ufs: qcom: Simplify ufs_qcom_{assert/deassert}_reset
>   scsi: ufs: qcom: Remove support for host controllers older than v2.0
>   scsi: ufs: qcom: Use ufshcd_rmwl() where applicable
>   scsi: ufs: qcom: Remove unused definitions
> 
>  drivers/ufs/core/ufshcd.c   |   6 +-
>  drivers/ufs/host/ufs-qcom.c | 377 +++++-------------------------------
>  drivers/ufs/host/ufs-qcom.h |  52 +----
>  include/ufs/ufshcd.h        |   2 +
>  4 files changed, 66 insertions(+), 371 deletions(-)
> 
> -- 
> 2.25.1
> 

