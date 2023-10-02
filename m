Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC967B598B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjJBSBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjJBSBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:01:07 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10086AC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 11:01:05 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d81b42a3108so28187276.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 11:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696269664; x=1696874464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOYDr52agfsu91xM8m2iaWWGVv9lXmRJ4r8U24TP67A=;
        b=TBeNGCIcbZHJfViQR0KyBosia+sj+2WtfbBFvMHF/D9rLetrPqPiTyi3yBEFvywoUY
         46KAqMzA2jFHYyEoMdQHaCjIySFW8+y2jJ53ruLBZE1DdGaHbN4ImNjkLi+G9Tjppkqp
         Z+6aHB58WdKYcLmtuyCPEYw06PtMcAVirMc/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269664; x=1696874464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOYDr52agfsu91xM8m2iaWWGVv9lXmRJ4r8U24TP67A=;
        b=FH2oFktLIUQWVBltZPHZZ7ym7a2ajxBTyykHfLkftsQbb9WGeF6FDXJOmEtF3piPkl
         5cWXsqINYnnOSusVlgRCDGPls9PSt+3mI3XJ7krBbMm9OG6cvO8B/MsyAgDT4IjkeYEe
         IneNFxHT2t2dAVLfYauz+OpwTTPK4YWpY8qK+5DEEknVn8jP6gzde2iFLkhXRRuE4wEf
         EWMfYCjHdezFGfo0ZBqM+45JKYS+NZk4xNMOI7ERUbk61gKw86wHJTNb/oEInOjhR8Wp
         YsltO8QAmVKg4tVMPjJdyw0n8Mow9hbmegsuqZjpz3NK19lCOWrwEPg6PG0+Fyvt2VMx
         PFvQ==
X-Gm-Message-State: AOJu0YzpfVc1zR1TOse85DFcyndIJQWgq9dnMyKoQIpzMw+rgCrsf1/h
        Ym8cv6fP5IviJMr+DXH3NuaC1A==
X-Google-Smtp-Source: AGHT+IEnF3j+rJGNnZbSDKSflRdBe2uXAAfCiOzl86PRFfuwUAwjhutEhB6KHHHsfumjj4/ymsbDoQ==
X-Received: by 2002:a25:d6d2:0:b0:d80:4533:9556 with SMTP id n201-20020a25d6d2000000b00d8045339556mr12092359ybg.63.1696269664239;
        Mon, 02 Oct 2023 11:01:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f18-20020a637552000000b005777a50c14csm19617226pgn.0.2023.10.02.11.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 11:01:03 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:01:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ibmvmc: replace deprecated strncpy with strscpy
Message-ID: <202310021058.C9E46875@keescook>
References: <20230927-strncpy-drivers-misc-ibmvmc-c-v1-1-29f56cd3a269@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-strncpy-drivers-misc-ibmvmc-c-v1-1-29f56cd3a269@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 05:52:14AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.

This is weird -- I think hmc_id needs to be marked __nonstring, and the
commit log should talk about how it appears to be not %NUL terminated.

The bounce buffer is weird -- it seems like hmc_id could be made a
regular C string by being changed to MHC_ID_LEN + 1, and then everything
would work correctly without needing a bounce buffer, etc. (Well, it
would need explicit %NUL termination after the copy_from_user()).

But if that refactor doesn't sound right to maintainers, then I'd agree
that this patch is fine (though capturing the __nonstring bit might be
nice):

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/misc/ibmvmc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
> index 2101eb12bcba..6d9ed9325f9f 100644
> --- a/drivers/misc/ibmvmc.c
> +++ b/drivers/misc/ibmvmc.c
> @@ -1249,9 +1249,7 @@ static long ibmvmc_ioctl_sethmcid(struct ibmvmc_file_session *session,
>  		return -EIO;
>  	}
>  
> -	/* Make sure buffer is NULL terminated before trying to print it */
> -	memset(print_buffer, 0, HMC_ID_LEN + 1);
> -	strncpy(print_buffer, hmc->hmc_id, HMC_ID_LEN);
> +	strscpy(print_buffer, hmc->hmc_id, sizeof(print_buffer));
>  	pr_info("ibmvmc: sethmcid: Set HMC ID: \"%s\"\n", print_buffer);
>  
>  	memcpy(buffer->real_addr_local, hmc->hmc_id, HMC_ID_LEN);
> 
> ---
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> change-id: 20230927-strncpy-drivers-misc-ibmvmc-c-534349716fa4
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
