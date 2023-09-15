Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3357A16A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjIOG56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjIOG54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:57:56 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E1662711;
        Thu, 14 Sep 2023 23:57:21 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 0AF25212BE69; Thu, 14 Sep 2023 23:57:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0AF25212BE69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1694761041;
        bh=e+0ylquv9A5KtyzvdTC9+dYY+hP2ulWv/8F37NNvEiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UUTaIbYZydJCT4m0Ye8+WYheZ9GTeQP4lfeB+kgwXCIpMlZ1vVtpau0Q3SCfIVumq
         O1TMIQxgvNtn71c/c/oWa9A8hy9VFFqW/B/MLvhWdvjP6T7myCFyBI0kpHcxr6gr14
         Jf21fq740XtGrzMvVzSACRyjLvltZYijznB74fM4=
Date:   Thu, 14 Sep 2023 23:57:21 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     ssengar@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH] x86/hyperv: Restrict get_vtl to only VTL platforms
Message-ID: <20230915065720.GA19997@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1694604531-17128-1-git-send-email-ssengar@linux.microsoft.com>
 <874jjwq07v.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jjwq07v.fsf@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 04:49:08PM +0200, Vitaly Kuznetsov wrote:
> Saurabh Sengar <ssengar@linux.microsoft.com> writes:
> 
> > For non VTL platforms vtl is always 0, and there is no need of
> > get_vtl function. For VTL platforms get_vtl should always succeed
> > and should return the correct VTL.
> >
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_init.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 783ed339f341..e589c240565a 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -416,8 +416,8 @@ static u8 __init get_vtl(void)
> >  	if (hv_result_success(ret)) {
> >  		ret = output->as64.low & HV_X64_VTL_MASK;
> >  	} else {
> > -		pr_err("Failed to get VTL(%lld) and set VTL to zero by default.\n", ret);
> > -		ret = 0;
> > +		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
> 
> Nitpick: arch/x86/hyperv/hv_init.c lacks pr_fmt so the message won't get
> prefixed with "Hyper-V". I'm not sure 'VTL' abbreviation has the only,
> Hyper-V specific meaning. I'd suggest we add 
> 
> #define pr_fmt(fmt)  "Hyper-V: " fmt
> 
> to the beginning of the file.

Good suggestion, I can do this as a separate patch.

> 
> > +		BUG();
> >  	}
> >  
> >  	local_irq_restore(flags);
> > @@ -604,8 +604,10 @@ void __init hyperv_init(void)
> >  	hv_query_ext_cap(0);
> >  
> >  	/* Find the VTL */
> > -	if (!ms_hyperv.paravisor_present && hv_isolation_type_snp())
> > +	if (IS_ENABLED(CONFIG_HYPERV_VTL_MODE))
> >  		ms_hyperv.vtl = get_vtl();
> > +	else
> > +		ms_hyperv.vtl = 0;
> 
> Is 'else' branch really needed? 'ms_hyperv' seems to be a statically
> allocated global. But instead of doing this, what about putting the
> whole get_vtl() funtion under '#if (IS_ENABLED(CONFIG_HYPERV_VTL_MODE))', i.e.:
> 
> #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
> static u8 __init get_vtl(void)
> {
>         u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
> ...
> }
> #else
> static inline get_vtl(void) { return 0; }
> #endif
> 
> and then we can always do
> 
>       ms_hyperv.vtl = get_vtl();
> 
> unconditionally?


Fine with me, can update in v2.

- Saurabh

> 
> >  
> >  	return;
> 
> -- 
> Vitaly
> 
