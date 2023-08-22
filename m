Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE47784BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjHVV3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjHVV3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:29:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202BECF8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692739705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KJIRzp140S4A9gJM0yxefcyxkEewcwkrzrbp9iHGj4s=;
        b=PlvXz2qg4kBEiX0fyTR1kIcfI5icrVtmYN8Byl4dvDyx9IcGIDie4C3RMUnqtz8OenZQSg
        vWCUH8ODU/5t/X2l7lrhHKL99WwOLK6nVWyBgkug6ke9KRp2CG0d5DcQ0g3TMNgOeia/Q7
        E013233+jVdRF6pnl2Qf891PY9A+xzQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-b0g44_4JO1eLo-F13PLUrw-1; Tue, 22 Aug 2023 17:28:24 -0400
X-MC-Unique: b0g44_4JO1eLo-F13PLUrw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-40c10c73650so60681251cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692739703; x=1693344503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJIRzp140S4A9gJM0yxefcyxkEewcwkrzrbp9iHGj4s=;
        b=aEUvKC/w5tBKaCDBB6yg8yMUfSFO5/tqnbsBdkNSy0bFj3Gt2wLu55JwKtQU+tFYP9
         RScgySG5tjVcjx1CJV87DGQ89F+M/iZtsoAUG3dl1bYLGkCu8s5rLpaXPgdOj+scuCgt
         xDHfmDQp8ajp1zn9hsBokjy/01YAYOqsgJjwe5+tkyuapu980UuxpjINfCYRkOSui495
         Ue0qwzDN1+nsqgUrcFHafL3ETmpZ8yRFZ+5jKHQ+iRuxcF7dD7Udx7uTCJcx3vn6bI05
         0fiWn9vaY+MKejWASUEu7lqElqdR2qOkkr11d5wDuxXm2t77hSS2Q/43BAmLWjvc4DR3
         pGRQ==
X-Gm-Message-State: AOJu0YyxcWmuK1SbcYvK2Yb5UB9c8UGEPlgwBgXoXrl8AIEFbJ2Kz7cg
        pHDS+/Cn3iMHsp1YUSwt/ULOzuoGS2xBxaYEULKwoPwEH5h/vq75DW4yxj51Qh6QKE/+/SaenBU
        HG9QZAhVuvENxRtglIHWIy/QCKxf8CgZE
X-Received: by 2002:a05:622a:191:b0:410:443:221a with SMTP id s17-20020a05622a019100b004100443221amr13760005qtw.1.1692739703269;
        Tue, 22 Aug 2023 14:28:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE5pLXawKyyf/r7BStTu9VgH3N5jMnxDo3xdPUd6SDwQX9epXapbs9Md5/ogJTTsWK/tc7dw==
X-Received: by 2002:a05:622a:191:b0:410:443:221a with SMTP id s17-20020a05622a019100b004100443221amr13759993qtw.1.1692739703023;
        Tue, 22 Aug 2023 14:28:23 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id o10-20020ac872ca000000b004108fe9697asm2222555qtp.61.2023.08.22.14.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 14:28:22 -0700 (PDT)
Date:   Tue, 22 Aug 2023 14:28:21 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-sgx@vger.kernel.org, stable@vger.kernel.org,
        Todd Brandt <todd.e.brandt@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Enable hwrng only for Pluton on AMD CPUs
Message-ID: <ubwdpgalqja6c3ggp4rjapqhts7m3pxgrdvm7ytwxitaasbjhd@32tbbipd2vfn>
References: <20230822203912.2256229-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822203912.2256229-1-jarkko@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 11:39:12PM +0300, Jarkko Sakkinen wrote:
> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG for
> all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On the
> reported systems the TPM doesn't reply at bootup and returns back the
> command code. This makes the TPM fail probe.
> 
> Since only Microsoft Pluton is the only known combination of AMD CPU and
> fTPM from other vendor, disable hwrng otherwise. In order to make sysadmin
> aware of this, print also info message to the klog.
> 
> Cc: stable@vger.kernel.org
> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217804
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v2:
> * CONFIG_X86

Did you mean to wrap the crb_acpi_add chunk with CONFIG_X86?

> * Removed "Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>"
> * Removed "Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>"
> ---
>  drivers/char/tpm/tpm_crb.c | 31 ++++++-------------------------
>  1 file changed, 6 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 65ff4d2fbe8d..28448bfd4062 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -463,28 +463,6 @@ static bool crb_req_canceled(struct tpm_chip *chip, u8 status)
>  	return (cancel & CRB_CANCEL_INVOKE) == CRB_CANCEL_INVOKE;
>  }
>  
> -static int crb_check_flags(struct tpm_chip *chip)
> -{
> -	u32 val;
> -	int ret;
> -
> -	ret = crb_request_locality(chip, 0);
> -	if (ret)
> -		return ret;
> -
> -	ret = tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL);
> -	if (ret)
> -		goto release;
> -
> -	if (val == 0x414D4400U /* AMD */)
> -		chip->flags |= TPM_CHIP_FLAG_HWRNG_DISABLED;
> -
> -release:
> -	crb_relinquish_locality(chip, 0);
> -
> -	return ret;
> -}
> -
>  static const struct tpm_class_ops tpm_crb = {
>  	.flags = TPM_OPS_AUTO_STARTUP,
>  	.status = crb_status,
> @@ -827,9 +805,12 @@ static int crb_acpi_add(struct acpi_device *device)
>  	if (rc)
>  		goto out;
>  
> -	rc = crb_check_flags(chip);
> -	if (rc)
> -		goto out;
> +	/* A quirk for https://www.amd.com/en/support/kb/faq/pa-410 */
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
> +	    priv->sm != ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
> +		dev_info(dev, "Disabling hwrng\n");
> +		chip->flags |= TPM_CHIP_FLAG_HWRNG_DISABLED;
> +	}
>  
>  	rc = tpm_chip_register(chip);
>  
> -- 
> 2.39.2
> 

