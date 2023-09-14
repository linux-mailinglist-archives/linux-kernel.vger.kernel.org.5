Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA427A07E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbjINOu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240387AbjINOuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:50:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D72C7212C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694702952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JJNWd5PCe2BYCxEP8rDUQkK/YgAeIPdVdWnp3Lyzy3o=;
        b=K1oM7fY99l9Xx2kzfLM6hcnwPk8R6pnqZmQvd4E18GQduyznP+ejlmPqAwGhGOjVFWDMZI
        A6/yHGmzp2I8SxHxyXHni5kn79U0hviwrHvEnlk2do00vWk677XVPEJn6BbZztFMAmoBZS
        s5u1yyXdDCzw3VNrN1iwsiT/2W+bQTw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-fWYBj35hOEmxTcbsa6YIpg-1; Thu, 14 Sep 2023 10:49:11 -0400
X-MC-Unique: fWYBj35hOEmxTcbsa6YIpg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5301927ab91so502860a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694702950; x=1695307750;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJNWd5PCe2BYCxEP8rDUQkK/YgAeIPdVdWnp3Lyzy3o=;
        b=c9uZtb+BzwnxndybdoIABApRAmxDDVNVfnSq4PAcmVlAB+kOkhQ0eDbMZk6qO03DED
         rp0aby1J2kwr/uB7Nza8jzo2gU7Q04LFsHuCLtuseJcYYA4/QMJNUX3pqm7dmLMmvPWB
         SV+8Xs8wYDWuiKUpTGX/h599dX+wGF6A/8HpuOLTMZ/jMcNpSljKZ5UfYkxGSv1MgEnf
         bjNZJ7dJ3RGtHEnd8z83q20i/bR5ycLPRh/hk+jOyisL3QrItBabIgs4PgqI8Va3mnj6
         rwK8i03f7jcjg5aKwewEYOPNoa7TReb1AjDtZCSkuD9SixYPBxSXywD9foR+ExD8iDZ5
         KPsA==
X-Gm-Message-State: AOJu0YxzDh11oYT0vad4UJx2R/NzGwtEvL/hwiHMw1vvyeUyFNchh8Lu
        V9sOfBLJTABWHo6YVz5X2MNCLc3ZxZvVpW3LMSHUG7XUY3HbcRN9bUwmMOi7J5vffHencStwtWF
        3FwESZCAAJvu+SxHWzhTLAvLL
X-Received: by 2002:a17:906:55:b0:9a1:fbfb:4d11 with SMTP id 21-20020a170906005500b009a1fbfb4d11mr5271987ejg.73.1694702950363;
        Thu, 14 Sep 2023 07:49:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuUh+o4qBa2QpPTqZcV/CAgpJXUP4q4YCRFbbhogb7vavGnViV5ntjLQB4fVRFpDMI4D+1TQ==
X-Received: by 2002:a17:906:55:b0:9a1:fbfb:4d11 with SMTP id 21-20020a170906005500b009a1fbfb4d11mr5271965ejg.73.1694702950001;
        Thu, 14 Sep 2023 07:49:10 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id rn5-20020a170906d92500b009a1e0349c4csm1119680ejb.23.2023.09.14.07.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 07:49:09 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     ssengar@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH] x86/hyperv: Restrict get_vtl to only VTL platforms
In-Reply-To: <1694604531-17128-1-git-send-email-ssengar@linux.microsoft.com>
References: <1694604531-17128-1-git-send-email-ssengar@linux.microsoft.com>
Date:   Thu, 14 Sep 2023 16:49:08 +0200
Message-ID: <874jjwq07v.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Saurabh Sengar <ssengar@linux.microsoft.com> writes:

> For non VTL platforms vtl is always 0, and there is no need of
> get_vtl function. For VTL platforms get_vtl should always succeed
> and should return the correct VTL.
>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 783ed339f341..e589c240565a 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -416,8 +416,8 @@ static u8 __init get_vtl(void)
>  	if (hv_result_success(ret)) {
>  		ret = output->as64.low & HV_X64_VTL_MASK;
>  	} else {
> -		pr_err("Failed to get VTL(%lld) and set VTL to zero by default.\n", ret);
> -		ret = 0;
> +		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);

Nitpick: arch/x86/hyperv/hv_init.c lacks pr_fmt so the message won't get
prefixed with "Hyper-V". I'm not sure 'VTL' abbreviation has the only,
Hyper-V specific meaning. I'd suggest we add 

#define pr_fmt(fmt)  "Hyper-V: " fmt

to the beginning of the file.

> +		BUG();
>  	}
>  
>  	local_irq_restore(flags);
> @@ -604,8 +604,10 @@ void __init hyperv_init(void)
>  	hv_query_ext_cap(0);
>  
>  	/* Find the VTL */
> -	if (!ms_hyperv.paravisor_present && hv_isolation_type_snp())
> +	if (IS_ENABLED(CONFIG_HYPERV_VTL_MODE))
>  		ms_hyperv.vtl = get_vtl();
> +	else
> +		ms_hyperv.vtl = 0;

Is 'else' branch really needed? 'ms_hyperv' seems to be a statically
allocated global. But instead of doing this, what about putting the
whole get_vtl() funtion under '#if (IS_ENABLED(CONFIG_HYPERV_VTL_MODE))', i.e.:

#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
static u8 __init get_vtl(void)
{
        u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
...
}
#else
static inline get_vtl(void) { return 0; }
#endif

and then we can always do

      ms_hyperv.vtl = get_vtl();

unconditionally?

>  
>  	return;

-- 
Vitaly

