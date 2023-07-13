Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DFB752821
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjGMQQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjGMQQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:16:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9603126B2;
        Thu, 13 Jul 2023 09:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qWs5+UJLbSYIWkNYobDTB5epXB0C966aqZhqz7qxkuE=; b=Axf2mJyTVJ//LDU0s3MzUQeSgC
        XqBjZjmbF84lFbXZZnGPW2qs+rJCJ/RslMrc56Sjf+PZF4ohJANI2uSTXKC6LKrgacZjJ/DMaE/i5
        VDHiNVenE5V8ISge/X+1BwBIVxL91IgDendNMP14IiQVBr6e2xOjBeJzMVjVuzr28vyD2X+0fK173
        K1g33tS4S+reH260B9ZJTfHuzSMgSZOno0KJf1T10yUimbYrRGKAAC5T4/oFYb9QSb2LGJfTaOEC4
        lrFENt2Js4jJuKx4hlBI6+0wtcrh1VuxzU08aWo5SqHtyJMNU6/qo0d2Llcncsjg09QE13F3f8xiW
        oh83lHJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJyyL-000HxX-Pp; Thu, 13 Jul 2023 16:15:17 +0000
Date:   Thu, 13 Jul 2023 17:15:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        surenb@google.com, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH rfc -next 01/10] mm: add a generic VMA lock-based page
 fault handler
Message-ID: <ZLAjFQGgcjt4ykS7@casper.infradead.org>
References: <20230713095339.189715-1-wangkefeng.wang@huawei.com>
 <20230713095339.189715-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713095339.189715-2-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +int try_vma_locked_page_fault(struct vm_locked_fault *vmlf, vm_fault_t *ret)
> +{
> +	struct vm_area_struct *vma;
> +	vm_fault_t fault;


On Thu, Jul 13, 2023 at 05:53:29PM +0800, Kefeng Wang wrote:
> +#define VM_LOCKED_FAULT_INIT(_name, _mm, _address, _fault_flags, _vm_flags, _regs, _fault_code) \
> +	_name.mm		= _mm;			\
> +	_name.address		= _address;		\
> +	_name.fault_flags	= _fault_flags;		\
> +	_name.vm_flags		= _vm_flags;		\
> +	_name.regs		= _regs;		\
> +	_name.fault_code	= _fault_code

More consolidated code is a good idea; no question.  But I don't think
this is the right way to do it.

> +int __weak arch_vma_check_access(struct vm_area_struct *vma,
> +				 struct vm_locked_fault *vmlf);

This should be:

#ifndef vma_check_access
bool vma_check_access(struct vm_area_struct *vma, )
{
	return (vma->vm_flags & vm_flags) == 0;
}
#endif

and then arches which want to do something different can just define
vma_check_access.

> +int try_vma_locked_page_fault(struct vm_locked_fault *vmlf, vm_fault_t *ret)
> +{
> +	struct vm_area_struct *vma;
> +	vm_fault_t fault;

Declaring the vmf in this function and then copying it back is just wrong.
We need to declare vm_fault_t earlier (in the arch fault handler) and
pass it in.  I don't think that creating struct vm_locked_fault is the
right idea either.

> +	if (!(vmlf->fault_flags & FAULT_FLAG_USER))
> +		return -EINVAL;
> +
> +	vma = lock_vma_under_rcu(vmlf->mm, vmlf->address);
> +	if (!vma)
> +		return -EINVAL;
> +
> +	if (arch_vma_check_access(vma, vmlf)) {
> +		vma_end_read(vma);
> +		return -EINVAL;
> +	}
> +
> +	fault = handle_mm_fault(vma, vmlf->address,
> +				vmlf->fault_flags | FAULT_FLAG_VMA_LOCK,
> +				vmlf->regs);
> +	*ret = fault;
> +
> +	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
> +		vma_end_read(vma);
> +
> +	if ((fault & VM_FAULT_RETRY))
> +		count_vm_vma_lock_event(VMA_LOCK_RETRY);
> +	else
> +		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> +
> +	return 0;
> +}
> +
>  #endif /* CONFIG_PER_VMA_LOCK */
>  
>  #ifndef __PAGETABLE_P4D_FOLDED
> -- 
> 2.27.0
> 
> 
