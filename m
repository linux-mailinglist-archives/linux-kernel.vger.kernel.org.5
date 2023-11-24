Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A047F6CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjKXHRI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Nov 2023 02:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKXHRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:17:06 -0500
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2258BD5E;
        Thu, 23 Nov 2023 23:16:52 -0800 (PST)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id 6CC5C409CB;
        Fri, 24 Nov 2023 07:16:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 8CAE160009;
        Fri, 24 Nov 2023 07:16:47 +0000 (UTC)
Message-ID: <971ed2ceaeeba882d2b4c39015ee5ae5db3f5e82.camel@perches.com>
Subject: Re: [PATCH v2 2/7] kexec_file: print out debugging message if
 required
From:   Joe Perches <joe@perches.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, akpm@linux-foundation.org,
        nathan@kernel.org, yujie.liu@intel.com
Date:   Thu, 23 Nov 2023 23:16:46 -0800
In-Reply-To: <20231124033642.520686-3-bhe@redhat.com>
References: <20231124033642.520686-1-bhe@redhat.com>
         <20231124033642.520686-3-bhe@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8CAE160009
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: r4oqtahenar8h64oxpqpoeo1n6zbhmda
X-Rspamd-Server: rspamout08
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19c0OHTlDrKhb/Xt6M9rvhAh1ufC3tVTnk=
X-HE-Tag: 1700810207-170549
X-HE-Meta: U2FsdGVkX1+zlhNkZ9x3SOlShl6+X96epMaKjfHehHKyBsMtcvgR7F6Ii1tgURKZMXTJ4v77gzWxOCKJjrZ32dyx27aEd7KJtn+JaKan9d1JoOg5vx5spjNriOlsrJsAsKTNWoXgbsaaF0Aw9htJa6iNVZZnaP/omO8ddnk/a1hUgTJ/UY7dIv6hTgWYnyt0dTxqhxdXpQIY0i9zYhv989Np0jXyZefmSBvNLtvm6dtRPbiigZYQ2nQLsoXdSGX2/vxVXndB66Niab3Fp1e04lrREsrM7se2cR96ydP7F6f9OXdC0ttkSA5n1SXD5cD7
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-24 at 11:36 +0800, Baoquan He wrote:
> Replace pr_debug() with the newly added kexec_dprintk() in kexec_file
> loading related codes.

trivia for pr_debug -> kexec_dprintk conversions for
the entire patch set:

> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
[]
> @@ -551,9 +551,12 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>  		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
>  		phdr->p_align = 0;
>  		ehdr->e_phnum++;
> -		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
> +#ifdef CONFIG_KEXEC_FILE
> +		kexec_dprintk("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, "
> +			"sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
>  			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
>  			ehdr->e_phnum, phdr->p_offset);

It's good form to rewrap continuation lines to the open parenthesis

> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
[]
> @@ -389,11 +391,12 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  	if (ret)
>  		goto out;
>  
> +	kexec_dprintk("nr_segments = %lu\n", image->nr_segments);
>  	for (i = 0; i < image->nr_segments; i++) {
>  		struct kexec_segment *ksegment;
>  
>  		ksegment = &image->segment[i];
> -		pr_debug("Loading segment %d: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
> +		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
>  			 i, ksegment->buf, ksegment->bufsz, ksegment->mem,
>  			 ksegment->memsz);

here too etc...

