Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A62180AB8E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574602AbjLHSDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574604AbjLHSDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:03:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0441985
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702058600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZUwBvIRAvhG9B+SuHsds4P0doNbLcysnUY/gEIcgCUI=;
        b=FYb3TKdZwjjaxbyFLYcyPrHbcF36mgPXh1ts2b9EcZIl3bqXTNau8bK1tNxfiMflcg/acB
        hz3FBjdDXIGvds0QXTJ7ZJQ/W4rYCbWpPtRVEWDmHplUgOsLF32LHEhgmyW9bAFBHvyJ+D
        zYQFq+sNy2LTwvQgZjnAnV2FPaVc084=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-oBRiHJwVOCGNy-Eog95cXQ-1; Fri, 08 Dec 2023 13:03:18 -0500
X-MC-Unique: oBRiHJwVOCGNy-Eog95cXQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4238180a464so25752661cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 10:03:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702058598; x=1702663398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUwBvIRAvhG9B+SuHsds4P0doNbLcysnUY/gEIcgCUI=;
        b=FheYmYr/k+h88bruNGd1maiLjHs8djNFhIThL0cC/RmmCroytc9Mp57kULiA6Bd+wB
         Xy7cH2XlcFCoDKx45Pjqzr+DoYzw8PmHNgO2jIl7ZcIv3T/Z8yPXCwQx71ePDkAndDf0
         NtRjcAO0iRyzE9p0Gj0u6r39SzhKpHQDDA6gKdFFgTp0go3hhKAwlhStOvx+aWrc4Uhs
         WUwB6euI9wefnwC1K6VRZ6zNtI7ZwRtwX8kv6Rg18mW4yE4/WvBfaWk8ZPsstQrCmG1p
         PqqjoMTrX4w9G+fqcjI57VePoEe2SIXI1rAx+Fa29R4STzI/GxMhurSIYNzDCHNaeyDA
         G6GQ==
X-Gm-Message-State: AOJu0Yw9BrsSGCzjPa4/wUEuGAIbtVNhN4yG/zowEmICD/0yqliNM4HW
        1SSpPJ2I4FB49ux92f9xjH1ReMfGNNtHwva4PeE55Ans6RVJ7t/tdlyQRxT6QhjlpoM9R4QNrKI
        ofvMfjLPRZdXD8w5LAIY6O7kK
X-Received: by 2002:a05:622a:15ce:b0:425:4043:764e with SMTP id d14-20020a05622a15ce00b004254043764emr495009qty.118.1702058598159;
        Fri, 08 Dec 2023 10:03:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzfhsAS69ChnjICSx4RU6A3rBLFhJWviTjp9kOqookZu1U2Q0y6hQzmQ7TI/PJppMBb58O4A==
X-Received: by 2002:a05:622a:15ce:b0:425:4043:764e with SMTP id d14-20020a05622a15ce00b004254043764emr495000qty.118.1702058597888;
        Fri, 08 Dec 2023 10:03:17 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id m18-20020ac86892000000b00419801b1094sm971536qtq.13.2023.12.08.10.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:03:17 -0800 (PST)
Date:   Fri, 8 Dec 2023 12:03:15 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com
Subject: Re: [PATCH v2 17/17] scsi: ufs: qcom: Remove unused definitions
Message-ID: <pocqtwanoyircdkrdipealburqnzmqvmgqklsii5plj4r6n6lh@htaxbhagxd2d>
References: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
 <20231208065902.11006-18-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208065902.11006-18-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 12:29:02PM +0530, Manivannan Sadhasivam wrote:
> Remove unused definitions.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/ufs/host/ufs-qcom.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 2ce63a1c7f2f..cdceeb795e70 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -10,22 +10,16 @@
>  #include <soc/qcom/ice.h>
>  #include <ufs/ufshcd.h>
>  
> -#define MAX_U32                 (~(u32)0)
>  #define MPHY_TX_FSM_STATE       0x41
>  #define TX_FSM_HIBERN8          0x1
>  #define HBRN8_POLL_TOUT_MS      100
>  #define DEFAULT_CLK_RATE_HZ     1000000
> -#define BUS_VECTOR_NAME_LEN     32
>  #define MAX_SUPP_MAC		64
>  
>  #define UFS_HW_VER_MAJOR_MASK	GENMASK(31, 28)
>  #define UFS_HW_VER_MINOR_MASK	GENMASK(27, 16)
>  #define UFS_HW_VER_STEP_MASK	GENMASK(15, 0)
>  
> -/* vendor specific pre-defined parameters */
> -#define SLOW 1
> -#define FAST 2
> -
>  #define UFS_QCOM_LIMIT_HS_RATE		PA_HS_MODE_B
>  
>  /* QCOM UFS host controller vendor specific registers */
> -- 
> 2.25.1
> 

