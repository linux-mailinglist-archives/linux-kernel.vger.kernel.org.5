Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E9279BCCD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359613AbjIKWSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbjIKKch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A6F3120
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694428306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=scL+PN7rvFW0rRtuvyrop8LP1MAlxFU5fgMf6KSanRA=;
        b=BYgJ8S/7aluC2EL4MIos0W/eh+Tdcm+5FgV2saBF1+/y1Uh+t4+mliikjaRdoPky2Xmoo1
        RL+5AA0Rp6U583CXYqtZsm1hCbvqeHWwPXw9rHOO5i+lJBlKru2bRyVXX3U0TaOLtOmsKx
        QMIBijMKBhv9d21YbrLm7rKh/Wvnc0E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-bOa0vEtiPUa0zpz8zjb7vQ-1; Mon, 11 Sep 2023 06:31:44 -0400
X-MC-Unique: bOa0vEtiPUa0zpz8zjb7vQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 662A5382254A;
        Mon, 11 Sep 2023 10:31:44 +0000 (UTC)
Received: from localhost (unknown [10.72.112.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FB1F40C200A;
        Mon, 11 Sep 2023 10:31:42 +0000 (UTC)
Date:   Mon, 11 Sep 2023 18:31:39 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Hari Bathini <hbathini@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>,
        Dave Young <dyoung@redhat.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] vmcore: allow fadump to export vmcore even if
 is_kdump_kernel() is false
Message-ID: <ZP7si3UMVpPfYV+w@MiWiFi-R3L-srv>
References: <20230905183604.568996-1-hbathini@linux.ibm.com>
 <20230905183604.568996-2-hbathini@linux.ibm.com>
 <8734zltc6z.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734zltc6z.fsf@mail.lhotse>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/23 at 05:13pm, Michael Ellerman wrote:
> Hari Bathini <hbathini@linux.ibm.com> writes:
> > Currently, is_kdump_kernel() returns true when elfcorehdr_addr is set.
> > While elfcorehdr_addr is set for kexec based kernel dump mechanism,
> > alternate dump capturing methods like fadump [1] also set it to export
> > the vmcore. Since, is_kdump_kernel() is used to restrict resources in
> > crash dump capture kernel and such restrictions are not desirable for
> > fadump, allow is_kdump_kernel() to be defined differently for fadump
> > case. With that change, include is_fadump_active() check in functions
> > is_vmcore_usable() & vmcore_unusable() to be able to export vmcore for
> > fadump case too.
> ...
> > diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> > index 0f3a656293b0..de8a9fabfb6f 100644
> > --- a/include/linux/crash_dump.h
> > +++ b/include/linux/crash_dump.h
> > @@ -50,6 +50,7 @@ void vmcore_cleanup(void);
> >  #define vmcore_elf64_check_arch(x) (elf_check_arch(x) || vmcore_elf_check_arch_cross(x))
> >  #endif
> >  
> > +#ifndef is_kdump_kernel
> >  /*
> >   * is_kdump_kernel() checks whether this kernel is booting after a panic of
> >   * previous kernel or not. This is determined by checking if previous kernel
> > @@ -64,6 +65,19 @@ static inline bool is_kdump_kernel(void)
> >  {
> >  	return elfcorehdr_addr != ELFCORE_ADDR_MAX;
> >  }
> > +#endif
> > +
> > +#ifndef is_fadump_active
> > +/*
> > + * If f/w assisted dump capturing mechanism (fadump), instead of kexec based
> > + * dump capturing mechanism (kdump) is exporting the vmcore, then this function
> > + * will be defined in arch specific code to return true, when appropriate.
> > + */
> > +static inline bool is_fadump_active(void)
> > +{
> > +	return false;
> > +}
> > +#endif
> >  
> >  /* is_vmcore_usable() checks if the kernel is booting after a panic and
> >   * the vmcore region is usable.
> > @@ -75,7 +89,8 @@ static inline bool is_kdump_kernel(void)
> >  
> >  static inline int is_vmcore_usable(void)
> >  {
> > -	return is_kdump_kernel() && elfcorehdr_addr != ELFCORE_ADDR_ERR ? 1 : 0;
> > +	return (is_kdump_kernel() || is_fadump_active())
> > +		&& elfcorehdr_addr != ELFCORE_ADDR_ERR ? 1 : 0;
> >  }
> >  
> >  /* vmcore_unusable() marks the vmcore as unusable,
> > @@ -84,7 +99,7 @@ static inline int is_vmcore_usable(void)
> >  
> >  static inline void vmcore_unusable(void)
> >  {
> > -	if (is_kdump_kernel())
> > +	if (is_kdump_kernel() || is_fadump_active())
> >  		elfcorehdr_addr = ELFCORE_ADDR_ERR;
> >  }
> 
> I think it would be cleaner to decouple is_vmcore_usable() and
> vmcore_usable() from is_kdump_kernel().
> 
> ie, make them operate solely based on the value of elforehdr_addr:
> 
> static inline int is_vmcore_usable(void)
> {
> 	elfcorehdr_addr != ELFCORE_ADDR_ERR && \
> 		elfcorehdr_addr != ELFCORE_ADDR_MAX;

Agree. I fell into the blind corner of thinking earlier. Above change
is better.

> }
> 
> static inline void vmcore_unusable(void)
> {
> 	elfcorehdr_addr = ELFCORE_ADDR_ERR;
> }
> 
> 
> Then all we need on powerpc is a way to override is_kdump_kernel().
> 
> cheers
> 

