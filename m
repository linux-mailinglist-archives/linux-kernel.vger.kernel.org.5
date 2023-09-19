Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C3D7A60A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjISLFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjISLFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:05:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA30F7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695121489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wpbrdLK1aN164ZiqLi72UGFResb0onUWuvtwINnIXW4=;
        b=KNTkx4WuAQMIrdcdYO1Flgxg+u/oQF3OK6F1oPnO2Os7O2WDrWfSi76lClNxUiUK24dUVb
        AW0xfazdn9lX1ZtWwYFNyhssVgbp66NsGWmcVWoQObUss9RhKca62rWCJXb3JbFIIo6F7l
        NSlvvU8JUy75+uSGiD5fjyiP/gludQw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-RPgXSEg0MPeuQF79W_cuoQ-1; Tue, 19 Sep 2023 07:04:48 -0400
X-MC-Unique: RPgXSEg0MPeuQF79W_cuoQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99388334de6so402143766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695121487; x=1695726287;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wpbrdLK1aN164ZiqLi72UGFResb0onUWuvtwINnIXW4=;
        b=Jz0pLeNMXlcjtvQ7WYNfO4D5EKri4CiDK/80a3BnlL6QpzvBZDMMoSDG6yP8WinuOY
         ew1qAZtPzzDdlJu7whykpe5b1qj7hGspFpI0YncM5m3dfYoNjnjw7ktncWgsVfeSeo46
         kgGs+mT72KTcz4oOrTtl77Pcy/BixAp17VvZFIdPWSg01IKh23JorFC+j+Zd3vPPvTIU
         GoSqrLIVkb01sbjtfe7KjctTGx45/lZSrN7kn+ojzYfDXV3A4a1Bf0gFcJCmNBdS+gk+
         E6lLWSmTXLGAZDz1pk0I5G6kfKGyUrBwvg1Y4+c9GdrM7ecf672A5+Ni+JNXqLoKbqkN
         fvrQ==
X-Gm-Message-State: AOJu0Yy4XakDyte4iLaIQQpPWyoRkzPb2vbIY+JqSt+w+RYPAJS7YBlV
        CeSlRLMyiUYc/EbYSPqomAtrngv+XI5hmnG4GCKde1sO8Wxeq1IsGjQ75tXD8vEZmmwZP0lFA7H
        VWm1dDQJ/cLQUri0EbuqIoOOGpfsU07IJlRY=
X-Received: by 2002:a17:907:6087:b0:9a5:cf6f:3efc with SMTP id ht7-20020a170907608700b009a5cf6f3efcmr8673796ejc.77.1695121487492;
        Tue, 19 Sep 2023 04:04:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlLQeG7D6Ljt5+qx+wMv+B8dMsdKiuudDL3TU0i0qwDm8uDYU48ExXOxvwwMGAs3WNVXLeFQ==
X-Received: by 2002:a17:907:6087:b0:9a5:cf6f:3efc with SMTP id ht7-20020a170907608700b009a5cf6f3efcmr8673775ejc.77.1695121487204;
        Tue, 19 Sep 2023 04:04:47 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ck19-20020a170906c45300b0099297c99314sm7594521ejb.113.2023.09.19.04.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 04:04:46 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     ssengar@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH v2] x86/hyperv: Restrict get_vtl to only VTL platforms
In-Reply-To: <1695101408-22432-1-git-send-email-ssengar@linux.microsoft.com>
References: <1695101408-22432-1-git-send-email-ssengar@linux.microsoft.com>
Date:   Tue, 19 Sep 2023 13:04:45 +0200
Message-ID: <87jzsme84y.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Saurabh Sengar <ssengar@linux.microsoft.com> writes:

> For non VTL platforms vtl is always 0, and there is no need of
> get_vtl function. For VTL platforms get_vtl should always succeed
> and should return the correct VTL.

Nitpicking, an alternative summary:

"""
When Linux runs in a non-default VTL (CONFIG_HYPERV_VTL_MODE=y),
get_vtl() must never fail as the result it returns is used in
negotiations with the host. In the more generic case,
(CONFIG_HYPERV_VTL_MODE=n) the VTL is always zero so there's no need to
do the hypercall.

Make get_vtl() BUG() in case of failure and put the implementation under
"if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)" to avoid the call altogether in
the most generic use case.
"""

>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

> ---
> [V2]
>  - Put the if else at function definition rather then at the caller
>
>  arch/x86/hyperv/hv_init.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 783ed339f341..f0128fd4031d 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -394,6 +394,7 @@ static void __init hv_get_partition_id(void)
>  	local_irq_restore(flags);
>  }
>  
> +#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>  static u8 __init get_vtl(void)
>  {
>  	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
> @@ -416,13 +417,16 @@ static u8 __init get_vtl(void)
>  	if (hv_result_success(ret)) {
>  		ret = output->as64.low & HV_X64_VTL_MASK;
>  	} else {
> -		pr_err("Failed to get VTL(%lld) and set VTL to zero by default.\n", ret);
> -		ret = 0;
> +		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
> +		BUG();
>  	}
>  
>  	local_irq_restore(flags);
>  	return ret;
>  }
> +#else
> +static inline u8 get_vtl(void) { return 0; }
> +#endif
>  
>  /*
>   * This function is to be invoked early in the boot sequence after the
> @@ -604,8 +608,7 @@ void __init hyperv_init(void)
>  	hv_query_ext_cap(0);
>  
>  	/* Find the VTL */
> -	if (!ms_hyperv.paravisor_present && hv_isolation_type_snp())
> -		ms_hyperv.vtl = get_vtl();
> +	ms_hyperv.vtl = get_vtl();
>  
>  	return;

-- 
Vitaly

