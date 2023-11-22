Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B937F3EB9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjKVHPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjKVHPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:15:34 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A653A1;
        Tue, 21 Nov 2023 23:15:29 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SZsq30tX6zRhS4;
        Wed, 22 Nov 2023 15:11:11 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 22 Nov 2023 15:15:26 +0800
Message-ID: <158e642b-7c42-d7a6-e0eb-813d947a1e32@huawei.com>
Date:   Wed, 22 Nov 2023 15:15:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [patch 105/118] fs/binfmt_elf.c: don't copy ELF header around
Content-Language: en-US
To:     <linux-kernel@vger.kernel.org>, <adobriyan@gmail.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <mm-commits@vger.kernel.org>, <torvalds@linux-foundation.org>
References: <20200130221021.5f0211c56346d5485af07923@linux-foundation.org>
 <20200131061655.5PTo3WfTa%akpm@linux-foundation.org>
CC:     <chris.zjh@huawei.com>
From:   Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20200131061655.5PTo3WfTa%akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/1/31 14:16, Andrew Morton wrote:
> From: Alexey Dobriyan <adobriyan@gmail.com>
> Subject: fs/binfmt_elf.c: don't copy ELF header around
> 
> ELF header is read into bprm->buf[] by generic execve code.
> 
> Save a memcpy and allocate just one header for the interpreter instead of
> two headers (64 bytes instead of 128 on 64-bit).
> 
> Link: http://lkml.kernel.org/r/20191208171242.GA19716@avx2
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  fs/binfmt_elf.c |   55 ++++++++++++++++++++++------------------------
>  1 file changed, 27 insertions(+), 28 deletions(-)
> 
> --- a/fs/binfmt_elf.c~elf-dont-copy-elf-header-around
> +++ a/fs/binfmt_elf.c
> @@ -161,8 +161,9 @@ static int padzero(unsigned long elf_bss
>  #endif
>  
>  static int
> -create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
> -		unsigned long load_addr, unsigned long interp_load_addr)
> +create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
> +		unsigned long load_addr, unsigned long interp_load_addr,
> +		unsigned long e_entry)
>  {
>  	unsigned long p = bprm->p;
>  	int argc = bprm->argc;
> @@ -251,7 +252,7 @@ create_elf_tables(struct linux_binprm *b
>  	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
>  	NEW_AUX_ENT(AT_BASE, interp_load_addr);
>  	NEW_AUX_ENT(AT_FLAGS, 0);
> -	NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
> +	NEW_AUX_ENT(AT_ENTRY, e_entry);
>  	NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
>  	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
>  	NEW_AUX_ENT(AT_GID, from_kgid_munged(cred->user_ns, cred->gid));
> @@ -690,12 +691,13 @@ static int load_elf_binary(struct linux_
>  	int bss_prot = 0;
>  	int retval, i;
>  	unsigned long elf_entry;
> +	unsigned long e_entry;
>  	unsigned long interp_load_addr = 0;
>  	unsigned long start_code, end_code, start_data, end_data;
>  	unsigned long reloc_func_desc __maybe_unused = 0;
>  	int executable_stack = EXSTACK_DEFAULT;
> +	struct elfhdr *elf_ex = (struct elfhdr *)bprm->buf;
>  	struct {
> -		struct elfhdr elf_ex;
>  		struct elfhdr interp_elf_ex;
>  	} *loc;
>  	struct arch_elf_state arch_state = INIT_ARCH_ELF_STATE;
> @@ -706,30 +708,27 @@ static int load_elf_binary(struct linux_
>  		retval = -ENOMEM;
>  		goto out_ret;
>  	}
> -	
> -	/* Get the exec-header */
> -	loc->elf_ex = *((struct elfhdr *)bprm->buf);
>  
>  	retval = -ENOEXEC;
>  	/* First of all, some simple consistency checks */
> -	if (memcmp(loc->elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
> +	if (memcmp(elf_ex->e_ident, ELFMAG, SELFMAG) != 0)
>  		goto out;
>  
> -	if (loc->elf_ex.e_type != ET_EXEC && loc->elf_ex.e_type != ET_DYN)
> +	if (elf_ex->e_type != ET_EXEC && elf_ex->e_type != ET_DYN)
>  		goto out;
> -	if (!elf_check_arch(&loc->elf_ex))
> +	if (!elf_check_arch(elf_ex))
>  		goto out;
> -	if (elf_check_fdpic(&loc->elf_ex))
> +	if (elf_check_fdpic(elf_ex))
>  		goto out;
>  	if (!bprm->file->f_op->mmap)
>  		goto out;
>  
> -	elf_phdata = load_elf_phdrs(&loc->elf_ex, bprm->file);
> +	elf_phdata = load_elf_phdrs(elf_ex, bprm->file);
>  	if (!elf_phdata)
>  		goto out;
>  
>  	elf_ppnt = elf_phdata;
> -	for (i = 0; i < loc->elf_ex.e_phnum; i++, elf_ppnt++) {
> +	for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++) {
>  		char *elf_interpreter;
>  
>  		if (elf_ppnt->p_type != PT_INTERP)
> @@ -783,7 +782,7 @@ out_free_interp:
>  	}
>  
>  	elf_ppnt = elf_phdata;
> -	for (i = 0; i < loc->elf_ex.e_phnum; i++, elf_ppnt++)
> +	for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++)
>  		switch (elf_ppnt->p_type) {
>  		case PT_GNU_STACK:
>  			if (elf_ppnt->p_flags & PF_X)
> @@ -793,7 +792,7 @@ out_free_interp:
>  			break;
>  
>  		case PT_LOPROC ... PT_HIPROC:
> -			retval = arch_elf_pt_proc(&loc->elf_ex, elf_ppnt,
> +			retval = arch_elf_pt_proc(elf_ex, elf_ppnt,
>  						  bprm->file, false,
>  						  &arch_state);
>  			if (retval)
> @@ -837,7 +836,7 @@ out_free_interp:
>  	 * still possible to return an error to the code that invoked
>  	 * the exec syscall.
>  	 */
> -	retval = arch_check_elf(&loc->elf_ex,
> +	retval = arch_check_elf(elf_ex,
>  				!!interpreter, &loc->interp_elf_ex,
>  				&arch_state);
>  	if (retval)
> @@ -850,8 +849,8 @@ out_free_interp:
>  
>  	/* Do this immediately, since STACK_TOP as used in setup_arg_pages
>  	   may depend on the personality.  */
> -	SET_PERSONALITY2(loc->elf_ex, &arch_state);
> -	if (elf_read_implies_exec(loc->elf_ex, executable_stack))
> +	SET_PERSONALITY2(*elf_ex, &arch_state);

It seems that the "SET_PERSONALITY2()" is a little late.

When a 32-bit compatible user-mode program forks out a 64-bit program,
when the 64-bit program is run in execve() the 32-bit STACK_TOP_MAX is
used to set vm_end and vm_start of the vma in __bprm_mm_init() in
alloc_bprm() because the 32-bit compatible flag has not been cleared,
but the setup_arg_pages() function later uses 64-bit STACK_TOP after
calling this SET_PERSONALITY2() to clear the 32-bit compatible flag,
which doesn't seem reasonable.

> +	if (elf_read_implies_exec(*elf_ex, executable_stack))
>  		current->personality |= READ_IMPLIES_EXEC;
>  
>  	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
> @@ -878,7 +877,7 @@ out_free_interp:
>  	/* Now we do a little grungy work by mmapping the ELF image into
>  	   the correct location in memory. */
>  	for(i = 0, elf_ppnt = elf_phdata;
> -	    i < loc->elf_ex.e_phnum; i++, elf_ppnt++) {
> +	    i < elf_ex->e_phnum; i++, elf_ppnt++) {
>  		int elf_prot, elf_flags;
>  		unsigned long k, vaddr;
>  		unsigned long total_size = 0;
> @@ -922,9 +921,9 @@ out_free_interp:
>  		 * If we are loading ET_EXEC or we have already performed
>  		 * the ET_DYN load_addr calculations, proceed normally.
>  		 */
> -		if (loc->elf_ex.e_type == ET_EXEC || load_addr_set) {
> +		if (elf_ex->e_type == ET_EXEC || load_addr_set) {
>  			elf_flags |= MAP_FIXED;
> -		} else if (loc->elf_ex.e_type == ET_DYN) {
> +		} else if (elf_ex->e_type == ET_DYN) {
>  			/*
>  			 * This logic is run once for the first LOAD Program
>  			 * Header for ET_DYN binaries to calculate the
> @@ -973,7 +972,7 @@ out_free_interp:
>  			load_bias = ELF_PAGESTART(load_bias - vaddr);
>  
>  			total_size = total_mapping_size(elf_phdata,
> -							loc->elf_ex.e_phnum);
> +							elf_ex->e_phnum);
>  			if (!total_size) {
>  				retval = -EINVAL;
>  				goto out_free_dentry;
> @@ -991,7 +990,7 @@ out_free_interp:
>  		if (!load_addr_set) {
>  			load_addr_set = 1;
>  			load_addr = (elf_ppnt->p_vaddr - elf_ppnt->p_offset);
> -			if (loc->elf_ex.e_type == ET_DYN) {
> +			if (elf_ex->e_type == ET_DYN) {
>  				load_bias += error -
>  				             ELF_PAGESTART(load_bias + vaddr);
>  				load_addr += load_bias;
> @@ -1032,7 +1031,7 @@ out_free_interp:
>  		}
>  	}
>  
> -	loc->elf_ex.e_entry += load_bias;
> +	e_entry = elf_ex->e_entry + load_bias;
>  	elf_bss += load_bias;
>  	elf_brk += load_bias;
>  	start_code += load_bias;
> @@ -1075,7 +1074,7 @@ out_free_interp:
>  		allow_write_access(interpreter);
>  		fput(interpreter);
>  	} else {
> -		elf_entry = loc->elf_ex.e_entry;
> +		elf_entry = e_entry;
>  		if (BAD_ADDR(elf_entry)) {
>  			retval = -EINVAL;
>  			goto out_free_dentry;
> @@ -1093,8 +1092,8 @@ out_free_interp:
>  		goto out;
>  #endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
>  
> -	retval = create_elf_tables(bprm, &loc->elf_ex,
> -			  load_addr, interp_load_addr);
> +	retval = create_elf_tables(bprm, elf_ex,
> +			  load_addr, interp_load_addr, e_entry);
>  	if (retval < 0)
>  		goto out;
>  	current->mm->end_code = end_code;
> @@ -1112,7 +1111,7 @@ out_free_interp:
>  		 * growing down), and into the unused ELF_ET_DYN_BASE region.
>  		 */
>  		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
> -		    loc->elf_ex.e_type == ET_DYN && !interpreter)
> +		    elf_ex->e_type == ET_DYN && !interpreter)
>  			current->mm->brk = current->mm->start_brk =
>  				ELF_ET_DYN_BASE;
>  
> _
