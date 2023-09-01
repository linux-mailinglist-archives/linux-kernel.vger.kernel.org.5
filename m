Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39CC78FB69
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjIAJuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjIAJuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:50:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69C3E8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 02:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693561756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bcExDhghP5q2uMrkxwwq4cXddfl7pnt3QkGDEdgHPBI=;
        b=epMbUR7v9AAO39BMn6kizGwtrpXmscoLVuyEW88zgxbuNyZUDj9heC0F6zYDqlDeB8YoLj
        sr0iFD4Q4y2FXpecHHGX1LzcW8B9G2Xnsba8LSfceIwf1hWqzzRNZBcf69w/03vNe+NLDY
        NBgkNH4QVL0juC08hmLBpkgRdFrfUlg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-dqSyZhw4NUq7agicu0a-mg-1; Fri, 01 Sep 2023 05:49:12 -0400
X-MC-Unique: dqSyZhw4NUq7agicu0a-mg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 518D23C17126;
        Fri,  1 Sep 2023 09:49:12 +0000 (UTC)
Received: from localhost (unknown [10.72.113.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70A1540C6F4C;
        Fri,  1 Sep 2023 09:49:11 +0000 (UTC)
Date:   Fri, 1 Sep 2023 17:49:08 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, thunder.leizhen@huawei.com,
        dyoung@redhat.com, prudo@redhat.com, samuel.holland@sifive.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v2 3/8] crash_core: change parse_crashkernel() to support
 crashkernel=,high|low parsing
Message-ID: <ZPGzlIkXqVThTwjg@MiWiFi-R3L-srv>
References: <20230829121610.138107-1-bhe@redhat.com>
 <20230829121610.138107-4-bhe@redhat.com>
 <c4a1f96e-2c8d-a496-61f3-0299d77c5c84@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4a1f96e-2c8d-a496-61f3-0299d77c5c84@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/23 at 10:56am, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/8/29 20:16, Baoquan He wrote:
> > Now parse_crashkernel() is a real entry point for all kinds of
> > crahskernel parsing on any architecture.
> > 
> > And wrap the crahskernel=,high|low handling inside
> > CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION ifdeffery scope.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  include/linux/crash_core.h |  6 ++++++
> >  kernel/crash_core.c        | 28 +++++++++++++++++++++++++++-
> >  2 files changed, 33 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> > index 2e76289699ff..85260bf4a734 100644
> > --- a/include/linux/crash_core.h
> > +++ b/include/linux/crash_core.h
> > @@ -77,6 +77,12 @@ Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
> >  			  void *data, size_t data_len);
> >  void final_note(Elf_Word *buf);
> >  
> > +#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> > +#ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
> > +#define DEFAULT_CRASH_KERNEL_LOW_SIZE  (128UL << 20)
> > +#endif
> > +#endif
> > +
> >  int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
> >  		unsigned long long *crash_size, unsigned long long *crash_base,
> >  		unsigned long long *low_size, bool *high);
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index f6a5c219e2e1..355b0ab5189c 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -276,6 +276,9 @@ static int __init __parse_crashkernel(char *cmdline,
> >  /*
> >   * That function is the entry point for command line parsing and should be
> >   * called from the arch-specific code.
> > + *
> > + * If crashkernel=,high|low is supported on architecture, non-NULL values
> > + * should be passed to parameters 'low_size' and 'high'.
> >   */
> >  int __init parse_crashkernel(char *cmdline,
> >  			     unsigned long long system_ram,
> > @@ -291,7 +294,30 @@ int __init parse_crashkernel(char *cmdline,
> >  				crash_base, NULL);
> >  	if (!high)
> >  		return ret;
> > -
> > +#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> > +	else if (ret == -ENOENT) {
> > +		ret = __parse_crashkernel(cmdline, 0, crash_size,
> > +				crash_base, suffix_tbl[SUFFIX_HIGH]);
> > +		if (ret || !*crash_size)
> > +			return -1;
> 
> Change -1 to -EINVAL?

Thanks a lot for careful reviewing, Zhen Lei.

Here, it's fine to me, parse_crashkernel() returns 0 on success, other value
on failure. '-1' or '-EINVAL' is not different to me in this case. I can
update if you think '-EINVAL' is better.

> 
> > +
> > +		/*
> > +		 * crashkernel=Y,low can be specified or not, but invalid value
> > +		 * is not allowed.
> > +		 */
> > +		ret = __parse_crashkernel(cmdline, 0, low_size,
> > +				crash_base, suffix_tbl[SUFFIX_LOW]);
> > +		if (ret == -ENOENT)
> > +			*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> > +		else if (ret)
> > +			return -1;
> 
> return ret;

Ditto.

> 
> > +
> > +		*high = true;
> > +	} else if (ret || !*crash_size) {
> 
> This check can be moved outside of #ifdef. Because even '!high', it's completely
> applicable. The overall adjustment is as follows:

Hmm, the current logic is much easier to understand. However, I may not
100% get your suggestion. Can you paste the complete code in your
suggested way? Do not need 100% correct code, just the skeleton of code logic
so that I can better understand it and add inline comment.

> 
> -  	if (!high)
> -  		return ret;
> 
> #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> 	if (high && ret == -ENOENT) {
> 		... ...
> 		if (ret || !*crash_size)	//parse HIGH
> 		... ...
> 	}
> 
> 	//At this point, *crash_size is not 0 and ret is 0.
> 	//We can also delete if (!*crash_size) above because it will be checked later.
> #endif
> 
> 	if (!*crash_size)
> 		ret = -EINVAL;
> 
> 	return ret;

When crashkernel=,high is specified while crashkernel=,low is omitted,
the ret==-ENOENT, but we can't return ret directly. That is still an
acceptable way.

> 
> -  	return 0;
> 
> > +		/* The specified value is invalid */
> > +		return -1;
> > +	}
> > +#endif
> >  	return 0;
> >  }
> >  
> > 
> 
> -- 
> Regards,
>   Zhen Lei
> 

