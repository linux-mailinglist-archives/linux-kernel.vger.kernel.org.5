Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21127AA768
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 05:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjIVDpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 23:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVDpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 23:45:39 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E459FE8;
        Thu, 21 Sep 2023 20:45:33 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 23CD7212C5B4; Thu, 21 Sep 2023 20:45:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 23CD7212C5B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695354333;
        bh=NMNgZixFawrFHkja6vAm/CPSiWXDvRG8KizcyBOmbC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ezqh8fLYi0jq4DHGJLtyzms4myNKOcuxAWmfU94TUB1yZgq78Ao2AWJCSeQ/99DuQ
         p1cBmG7vwRJPML7h7sDa97QYD3tp2xObZoUWiK9WtMn6ehN6SH3E5YvvHQLB8gh5qN
         mFWL+qNnFrnIVnkuDEn2bV+Ulfe2l+hjbUurQRx4=
Date:   Thu, 21 Sep 2023 20:45:33 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: Re: [PATCH] x86/hyperv: Remove hv_vtl_early_init initcall
Message-ID: <20230922034533.GA17734@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1695185552-19910-1-git-send-email-ssengar@linux.microsoft.com>
 <49e81d87-baee-4ba5-873c-ba32615beab0@grsecurity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49e81d87-baee-4ba5-873c-ba32615beab0@grsecurity.net>
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

On Thu, Sep 21, 2023 at 08:27:09PM +0200, Mathias Krause wrote:
> Missed it in my review, but the kernel bot already noticed it, so....
> 
> On 20.09.23 06:52, Saurabh Sengar wrote:
> > [...]
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > index 033b53f993c6..83019c3aaae9 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -340,8 +340,10 @@ static inline u64 hv_get_non_nested_register(unsigned int reg) { return 0; }
> >  
> >  #ifdef CONFIG_HYPERV_VTL_MODE
> >  void __init hv_vtl_init_platform(void);
> > +int __init hv_vtl_early_init(void);
> >  #else
> >  static inline void __init hv_vtl_init_platform(void) {}
> > +static int __init hv_vtl_early_init(void) {}
> 
> static inline

Thanks, will send v2 fixing this and the other typo in commit

Regards,
Saurabh

> 
> >  #endif
> >  
> >  #include <asm-generic/mshyperv.h>
> 
> Thanks,
> Mathias
