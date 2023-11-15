Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2F37EBAB9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 01:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbjKOA6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 19:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjKOA6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 19:58:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F60D9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 16:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700009917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3zlBf98ARjkQaX/S5kQ5snEY5GoQGl3AvBs2Ts5bz28=;
        b=fRTMdK0jrgkt0yj13HTvVwia1jCxNJqS0MLEUkuCHHDV9APXhlxma870Vg9ItwmmswWzI3
        d88Mq9GeI09GPUsCjNAWqc5q7YuBhJSkRt7iiqQHe9mVMHmrivXLVtzqjyehW944GqgmEz
        ml4ormmCQLISgbSu8JE3UxzfelbZa8Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-MZ5tl1akPnSAAv4ds1nyfQ-1; Tue, 14 Nov 2023 19:58:35 -0500
X-MC-Unique: MZ5tl1akPnSAAv4ds1nyfQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8873B185A781;
        Wed, 15 Nov 2023 00:58:34 +0000 (UTC)
Received: from localhost (unknown [10.72.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1C892166B26;
        Wed, 15 Nov 2023 00:58:33 +0000 (UTC)
Date:   Wed, 15 Nov 2023 08:58:30 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH 1/7] kexec_file: add kexec_file flag to control debug
 printing
Message-ID: <ZVQXthHraBBVeNy2@MiWiFi-R3L-srv>
References: <20231114153253.241262-1-bhe@redhat.com>
 <20231114153253.241262-2-bhe@redhat.com>
 <1e7863ec4e4ab10b84fd0e64f30f8464d2e484a3.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e7863ec4e4ab10b84fd0e64f30f8464d2e484a3.camel@perches.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/23 at 08:03am, Joe Perches wrote:
> On Tue, 2023-11-14 at 23:32 +0800, Baoquan He wrote:
> > When specifying 'kexec -c -d', kexec_load interface will print loading
> > information, e.g the regions where kernel/initrd/purgatory/cmdline
> > are put, the memmap passed to 2nd kernel taken as system RAM ranges,
> > and printing all contents of struct kexec_segment, etc. These are
> > very helpful for analyzing or positioning what's happening when
> > kexec/kdump itself failed. The debugging printing for kexec_load
> > interface is made in user space utility kexec-tools.
> > 
> > Whereas, with kexec_file_load interface, 'kexec -s -d' print nothing.
> > Because kexec_file code is mostly implemented in kernel space, and the
> > debugging printing functionality is missed. It's not convenient when
> > debugging kexec/kdump loading and jumping with kexec_file_load
> > interface.
> > 
> > Now add KEXEC_FILE_DEBUG to kexec_file flag to control the debugging
> > message printing. And add global variable kexec_file_dbg_print and
> > macro kexec_dprintk() to facilitate the printing.
> > 
> > This is a preparation, later kexec_dprintk() will be used to replace the
> > existing pr_debug(). Once 'kexec -s -d' is specified, it will print out
> > kexec/kdump loading information. If '-d' is not specified, it regresses
> > to pr_debug().
> 
> Not quite as pr_debug is completely eliminated with
> zero object size when DEBUG is not #defined.
> 
> Now the object size will be larger and contain the
> formats in .text.

Ah, I didn't realize that. Thanks for telling. I didn't take pr_info()
and pr_debug because I want to avoid printing the pr_fmt() string in
each file.

> 
> []
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> []
> > @@ -264,6 +264,18 @@ arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
> >  	return -ENOEXEC;
> >  }
> >  #endif
> > +
> > +extern bool kexec_file_dbg_print;
> > +
> > +#define kexec_dprintk(fmt, args...)			\
> > +	do {						\
> > +		if (kexec_file_dbg_print)		\
> > +			printk(KERN_INFO fmt, ##args);	\
> > +		else					\
> > +			printk(KERN_DEBUG fmt, ##args);	\
> > +	} while (0)
> > +
> > +
> 
> I don't know how many of these printks exist and if
> overall object size matters but using

Not too much because they are spread in different arch.
> 
> #define kexec_dprintkfmt, ...)					\
> 	printk("%s" fmt,					\
> 	       kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,	\
> 	       ##__VA_ARGS__)
> 
> should reduce overall object size by eliminating the
> mostly duplicated format in .text which differs only
> by the KERN_<PREFIX>

Sure, the new one looks great to me, I will update code to take it.
Thanks a lot for your great suggestion.

Thanks
Baoquan

