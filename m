Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC7D8090F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443745AbjLGTCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443267AbjLGTCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:02:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F00E10F9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 11:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701975743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kCUoIlarJIWNj7C91XvyEHV0oZwcTpS62oecRoOTzH0=;
        b=KKPsivmdqhZCTUOAkegovQGTAbg1bk1iSrZUXFO1UDp5FBQpB5cYg4OiCC1jxgRoUnbSuf
        ZMSo5cGfHMaY6/Pm5pvHOs8VkvoRelxX20M1Dk13C3NfATfi4Sfgza8vax+zfvNFuxATeL
        e14yIBj2Bd6wwnI6TpUpRljrVoQ+bQU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-tdhLc6TJP8KIg1xIgk53pg-1; Thu, 07 Dec 2023 14:02:22 -0500
X-MC-Unique: tdhLc6TJP8KIg1xIgk53pg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-54dbe033977so662263a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 11:02:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701975741; x=1702580541;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kCUoIlarJIWNj7C91XvyEHV0oZwcTpS62oecRoOTzH0=;
        b=wAB0UaGaB2tGOpjzDu5iJlE17tK+o7Pc5//du/y0VpZfkzR9C8C5t9Na+biwmmpP01
         J8QGJGAB7jrUk3jHKDSta0m5xEPAHMsnR4kmswc10MQWKeAoc7Gr7N97oPiuf9KIAMMR
         p94g6kedkkPRnd8JoydV4oRSlb+xO1QO6ui31sCdEbTAqJYh82+aAIwIcyZp8YfW3nm8
         oQ3vK7i8Oiogw1Cg3+bKjodJyfnOAfz1g28QkUXpsFLfIqpb8KXNgPOna06pWveAb5at
         80xdyAjUuCiyW92X+7nHKWR8GPrnEBJTL1vD0hBIw5iTVJgsHJMrvABOGGysdUJAsj/+
         +NHQ==
X-Gm-Message-State: AOJu0YzzKDVzsfht4cZPnAx1Teh5sE1UMLoPb65QAcZCFGoGyDNsLx3Q
        XaMNnQ6DN4iambaoloG21sRoVV7sMRvyGjChuEs9HWPhUUCmizPKiNBLCZGHGRnTSTi9OjSpKfK
        GdpDdjqBuDM+hYtw02Rct9Ntc
X-Received: by 2002:a17:906:33d1:b0:a16:88e8:2de7 with SMTP id w17-20020a17090633d100b00a1688e82de7mr915885eja.23.1701975740974;
        Thu, 07 Dec 2023 11:02:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRf9+cG0UTwBgE+QzAStnofCGxlNiNqtn7a72kKm4KP1uWA3P6q36LkZ9274l24NaRhYvriQ==
X-Received: by 2002:a17:906:33d1:b0:a16:88e8:2de7 with SMTP id w17-20020a17090633d100b00a1688e82de7mr915879eja.23.1701975740654;
        Thu, 07 Dec 2023 11:02:20 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id tf7-20020a1709078d8700b00a1db8b08613sm84683ejc.181.2023.12.07.11.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 11:02:19 -0800 (PST)
Message-ID: <585eee5b-06ee-4b0a-a5e3-50e5c471fcff@redhat.com>
Date:   Thu, 7 Dec 2023 20:02:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/intel/pmc: Remove GBE LTR ignore
Content-Language: en-US, nl
To:     "David E. Box" <david.e.box@linux.intel.com>,
        jahutchinson99@googlemail.com, ilpo.jarvinen@linux.intel.com,
        xi.pardee@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajvi.jingar@linux.intel.com
References: <20231207182311.2080972-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231207182311.2080972-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 12/7/23 19:23, David E. Box wrote:
> Commit 804951203aa5 ("platform/x86:intel/pmc: Combine core_init() and
> core_configure()") moved the GBE LTR ignore workaround from core.c to PCH
> code and added it new for Cannon Lake PCH in cnp.c. This introduced a
> network performance regression on a CNP PCH system [1] which has been
> observed on other PCH architectures during testing. Remove the probe-time
> GBE LTR ignore for all platforms. While this will prevent performance
> degradation, it will also limit the deepest SoC Package C state that can be
> entered at runtime while a LAN cable is attached.
> 
> Reported-by: James Hutchinson <jahutchinson99@googlemail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218143 [1]
> Fixes: 804951203aa5 ("platform/x86:intel/pmc: Combine core_init() and core_configure()")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Tested-by: James Hutchinson <jahutchinson99@googlemail.com>

So it seems to me that to fix 804951203aa5 the only thing
which needs to be done is remove the pmc_core_send_ltr_ignore()
call from cnp_core_init(), the other changes here are NOT
related to fixing the regression.

So IMHO it seems better to split this into 2 patches?

Also if this block the system from reaching PC10 should
this then not at least be done at suspend time and
undone at resume ?  I'm not seeing anything in the current
code which does an equivalent on suspend/resume, so it
seems to me like this will cause a significant increase
on suspended power-usage if an ethernet cable is attached ?

Regards,

Hans



> ---
>  drivers/platform/x86/intel/pmc/adl.c  | 6 ------
>  drivers/platform/x86/intel/pmc/cnp.c  | 6 ------
>  drivers/platform/x86/intel/pmc/core.c | 2 +-
>  drivers/platform/x86/intel/pmc/core.h | 1 -
>  drivers/platform/x86/intel/pmc/mtl.c  | 6 ------
>  drivers/platform/x86/intel/pmc/tgl.c  | 5 -----
>  6 files changed, 1 insertion(+), 25 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
> index 64c492391ede..e4a421ca64be 100644
> --- a/drivers/platform/x86/intel/pmc/adl.c
> +++ b/drivers/platform/x86/intel/pmc/adl.c
> @@ -321,11 +321,5 @@ int adl_core_init(struct pmc_dev *pmcdev)
>  
>  	pmc_core_get_low_power_modes(pmcdev);
>  
> -	/* Due to a hardware limitation, the GBE LTR blocks PC10
> -	 * when a cable is attached. Tell the PMC to ignore it.
> -	 */
> -	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
> -	pmc_core_send_ltr_ignore(pmcdev, 3);
> -
>  	return 0;
>  }
> diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
> index 59298f184d0e..416d3a0c3615 100644
> --- a/drivers/platform/x86/intel/pmc/cnp.c
> +++ b/drivers/platform/x86/intel/pmc/cnp.c
> @@ -216,11 +216,5 @@ int cnp_core_init(struct pmc_dev *pmcdev)
>  
>  	pmc_core_get_low_power_modes(pmcdev);
>  
> -	/* Due to a hardware limitation, the GBE LTR blocks PC10
> -	 * when a cable is attached. Tell the PMC to ignore it.
> -	 */
> -	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
> -	pmc_core_send_ltr_ignore(pmcdev, 3);
> -
>  	return 0;
>  }
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 983e3a8f4910..7c6a74957d57 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -462,7 +462,7 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
>  
> -int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
> +static int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
>  {
>  	struct pmc *pmc;
>  	const struct pmc_reg_map *map;
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index 6d7673145f90..3bbdb41a754f 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -493,7 +493,6 @@ extern const struct pmc_reg_map mtl_ioem_reg_map;
>  
>  extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
>  extern int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev);
> -extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
>  
>  int pmc_core_resume_common(struct pmc_dev *pmcdev);
>  int get_primary_reg_base(struct pmc *pmc);
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
> index 38c2f946ec23..33d32a76c43a 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -1065,11 +1065,5 @@ int mtl_core_init(struct pmc_dev *pmcdev)
>  	pmc_core_get_low_power_modes(pmcdev);
>  	mtl_punit_pmt_init(pmcdev);
>  
> -	/* Due to a hardware limitation, the GBE LTR blocks PC10
> -	 * when a cable is attached. Tell the PMC to ignore it.
> -	 */
> -	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
> -	pmc_core_send_ltr_ignore(pmcdev, 3);
> -
>  	return pmc_core_ssram_get_lpm_reqs(pmcdev);
>  }
> diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
> index d5f1d2223c5a..7e6f5739a197 100644
> --- a/drivers/platform/x86/intel/pmc/tgl.c
> +++ b/drivers/platform/x86/intel/pmc/tgl.c
> @@ -265,11 +265,6 @@ int tgl_core_init(struct pmc_dev *pmcdev)
>  
>  	pmc_core_get_low_power_modes(pmcdev);
>  	pmc_core_get_tgl_lpm_reqs(pmcdev->pdev);
> -	/* Due to a hardware limitation, the GBE LTR blocks PC10
> -	 * when a cable is attached. Tell the PMC to ignore it.
> -	 */
> -	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
> -	pmc_core_send_ltr_ignore(pmcdev, 3);
>  
>  	return 0;
>  }
> 
> base-commit: 35ddd61cf023b5deb2b7e9f1627abef053281c0a

