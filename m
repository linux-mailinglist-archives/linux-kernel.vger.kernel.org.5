Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782BB7ED7C1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 00:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjKOXAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 18:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjKOXAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 18:00:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E7EDD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700089198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+C1sO2KbXUPPoDvevbfDwJOTot7T4u4Rq+CojvDXXG0=;
        b=ELbfCgUhjPLjUhAoibp7HPc2FiQjnWSLEBZUr0616Zgy59Penpc7zEYuyxhXf4X3SnJOo8
        s8PDW/iocenc+Ad6ZDegzQ9m2BbD/vxDGRqjPYfkiJqnubqTBBcLFuefaALUf3SQxy4o/p
        CDLsLNuxJxc7NTOmaArrJvOFJpBVgio=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-DD-kVh3aNDuL8WTb28IVNw-1; Wed,
 15 Nov 2023 17:59:55 -0500
X-MC-Unique: DD-kVh3aNDuL8WTb28IVNw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D18953C14913;
        Wed, 15 Nov 2023 22:59:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9543E1121306;
        Wed, 15 Nov 2023 22:59:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wgR3Mw2-8k2O3S10T-f4oz8FNfg7aziLU_6pbx0qowxew@mail.gmail.com>
References: <CAHk-=wgR3Mw2-8k2O3S10T-f4oz8FNfg7aziLU_6pbx0qowxew@mail.gmail.com> <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk> <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com> <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com> <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com> <4097023.1700084620@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Borislav Petkov <bp@alien8.de>,
        kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput -16.9% regression
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <42894.1700089191.1@warthog.procyon.org.uk>
Date:   Wed, 15 Nov 2023 22:59:51 +0000
Message-ID: <42895.1700089191@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> The purgatory code isn't exactly boot-time code, but it's very similar
> - it's kind of a limited environment that runs at crash time to load a
> new kernel.

Yeah - I can get rid of that by disabling KEXEC/CRASH handling, but then I see
errors in the compressed boot wrapper.

Instead, I tried replacing the call to memcpy() in memcpy_to_iter() and
memcpy_from_iter() with calls to __memcpy() to force the out-of-line memcpy.
Using my benchmarking patch, with what's upstream upstream I see:

 iov_kunit_benchmark_bvec: avg 3185 uS, stddev 19 uS
 iov_kunit_benchmark_bvec: avg 3186 uS, stddev 9 uS
 iov_kunit_benchmark_bvec: avg 3244 uS, stddev 153 uS
 iov_kunit_benchmark_bvec_split: avg 3397 uS, stddev 16 uS
 iov_kunit_benchmark_bvec_split: avg 3400 uS, stddev 16 uS
 iov_kunit_benchmark_bvec_split: avg 3402 uS, stddev 34 uS
 iov_kunit_benchmark_kvec: avg 2818 uS, stddev 550 uS
 iov_kunit_benchmark_kvec: avg 2906 uS, stddev 21 uS
 iov_kunit_benchmark_kvec: avg 2923 uS, stddev 1496 uS
 iov_kunit_benchmark_xarray: avg 3564 uS, stddev 6 uS
 iov_kunit_benchmark_xarray: avg 3573 uS, stddev 17 uS
 iov_kunit_benchmark_xarray: avg 3575 uS, stddev 58 uS
 iov_kunit_benchmark_xarray_to_bvec: avg 3929 uS, stddev 9 uS
 iov_kunit_benchmark_xarray_to_bvec: avg 3930 uS, stddev 6 uS
 iov_kunit_benchmark_xarray_to_bvec: avg 3930 uS, stddev 7 uS

And using __memcpy() rather than memcpy():

 iov_kunit_benchmark_bvec: avg 9977 uS, stddev 26 uS
 iov_kunit_benchmark_bvec: avg 9979 uS, stddev 12 uS
 iov_kunit_benchmark_bvec: avg 9980 uS, stddev 10 uS
 iov_kunit_benchmark_bvec_split: avg 9834 uS, stddev 31 uS
 iov_kunit_benchmark_bvec_split: avg 9840 uS, stddev 22 uS
 iov_kunit_benchmark_bvec_split: avg 9848 uS, stddev 55 uS
 iov_kunit_benchmark_kvec: avg 10010 uS, stddev 3253 uS
 iov_kunit_benchmark_kvec: avg 10017 uS, stddev 4400 uS
 iov_kunit_benchmark_kvec: avg 10095 uS, stddev 4282 uS
 iov_kunit_benchmark_xarray: avg 10611 uS, stddev 7 uS
 iov_kunit_benchmark_xarray: avg 10611 uS, stddev 9 uS
 iov_kunit_benchmark_xarray: avg 10616 uS, stddev 13 uS
 iov_kunit_benchmark_xarray_to_bvec: avg 10523 uS, stddev 143 uS
 iov_kunit_benchmark_xarray_to_bvec: avg 10524 uS, stddev 197 uS
 iov_kunit_benchmark_xarray_to_bvec: avg 10527 uS, stddev 186 uS

A disassembly of _copy_from_iter() for the latter is attached.  Note that the
UBUF/IOVEC still uses "rep movsb" and that you can see calls to memcpy() as
__memcpy() has the same address.

Switching to CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE instead of FOR_SIZE
out-of-lines calls to memcpy giving numbers like the second set, with or
without the patch.

I wonder how much of the performance reduction there is due to the mitigations
for spectre or suchlike.

David
---
    <+0>:	push   %r15
    <+2>:	push   %r14
    <+4>:	push   %r13
    <+6>:	push   %r12
    <+8>:	push   %rbp
    <+9>:	push   %rbx
    <+10>:	sub    $0x58,%rsp
    <+14>:	mov    %rdi,0x8(%rsp)
    <+19>:	mov    %gs:0x28,%rax
    <+28>:	mov    %rax,0x50(%rsp)
    <+33>:	xor    %eax,%eax
    <+35>:	cmpb   $0x0,0x3(%rdx)
    <+39>:	je     0xffffffff8176b766 <_copy_from_iter+52>
    <+41>:	cmpb   $0x0,0x1(%rdx)
    <+45>:	mov    %rdx,%r15
    <+48>:	je     0xffffffff8176b79b <_copy_from_iter+105>
    <+50>:	jmp    0xffffffff8176b76f <_copy_from_iter+61>
    <+52>:	ud2
    <+54>:	xor    %ebx,%ebx
    <+56>:	jmp    0xffffffff8176baf9 <_copy_from_iter+967>
    <+61>:	mov    0x50(%rsp),%rax
    <+66>:	sub    %gs:0x28,%rax
    <+75>:	jne    0xffffffff8176bb09 <_copy_from_iter+983>
    <+81>:	mov    0x8(%rsp),%rdi
    <+86>:	add    $0x58,%rsp
    <+90>:	pop    %rbx
    <+91>:	pop    %rbp
    <+92>:	pop    %r12
    <+94>:	pop    %r13
    <+96>:	pop    %r14
    <+98>:	pop    %r15
    <+100>:	jmp    0xffffffff8176a1f3 <__copy_from_iter_mc>
    <+105>:	mov    0x18(%rdx),%rax
    <+109>:	cmp    %rax,%rsi
    <+112>:	cmova  %rax,%rsi
    <+116>:	test   %rsi,%rsi
    <+119>:	mov    %rsi,%rbx
    <+122>:	je     0xffffffff8176baf9 <_copy_from_iter+967>

    <+128>:	mov    (%rdx),%dl
    <+130>:	test   %dl,%dl		# ITER_UBUF
    <+132>:	jne    0xffffffff8176b805 <_copy_from_iter+211>
    <+134>:	mov    0x8(%r15),%rsi
    <+138>:	mov    %rbx,%rcx
    <+141>:	add    0x10(%r15),%rsi
    <+145>:	mov    %rsi,%rdx
    <+148>:	mov    %rbx,%rsi
    <+151>:	mov    %rdx,%rdi
    <+154>:	call   0xffffffff8176a052 <__access_ok>
    <+159>:	test   %al,%al
    <+161>:	je     0xffffffff8176b7e8 <_copy_from_iter+182>
    <+163>:	nop
    <+164>:	nop
    <+165>:	nop
    <+166>:	mov    0x8(%rsp),%rdi
    <+171>:	mov    %rdx,%rsi
    <+174>:	rep movsb %ds:(%rsi),%es:(%rdi)
    <+176>:	nop
    <+177>:	nop
    <+178>:	nop
    <+179>:	nop
    <+180>:	nop
    <+181>:	nop
    <+182>:	mov    %rbx,%rax
    <+185>:	sub    %rcx,%rax
    <+188>:	add    0x18(%r15),%rcx
    <+192>:	add    %rax,0x8(%r15)
    <+196>:	sub    %rbx,%rcx
    <+199>:	mov    %rax,%rbx
    <+202>:	mov    %rcx,0x18(%r15)
    <+206>:	jmp    0xffffffff8176baf9 <_copy_from_iter+967>

    <+211>:	cmp    $0x1,%dl		# ITER_IOVEC
    <+214>:	jne    0xffffffff8176b8a3 <_copy_from_iter+369>
    <+220>:	mov    0x10(%r15),%rbp
    <+224>:	mov    %rsi,%r10
    <+227>:	xor    %ebx,%ebx
    <+229>:	mov    0x8(%r15),%r12
    <+233>:	mov    0x8(%rbp),%rdx
    <+237>:	sub    %r12,%rdx
    <+240>:	cmp    %r10,%rdx
    <+243>:	cmova  %r10,%rdx
    <+247>:	test   %rdx,%rdx
    <+250>:	je     0xffffffff8176b876 <_copy_from_iter+324>
    <+252>:	mov    0x0(%rbp),%r11
    <+256>:	mov    %rdx,%rsi
    <+259>:	mov    %rdx,%rcx
    <+262>:	add    %r12,%r11
    <+265>:	mov    %r11,%rdi
    <+268>:	call   0xffffffff8176a052 <__access_ok>
    <+273>:	test   %al,%al
    <+275>:	je     0xffffffff8176b85e <_copy_from_iter+300>
    <+277>:	nop
    <+278>:	nop
    <+279>:	nop
    <+280>:	mov    0x8(%rsp),%rax
    <+285>:	mov    %r11,%rsi
    <+288>:	lea    (%rax,%rbx,1),%rdi
    <+292>:	rep movsb %ds:(%rsi),%es:(%rdi)
    <+294>:	nop
    <+295>:	nop
    <+296>:	nop
    <+297>:	nop
    <+298>:	nop
    <+299>:	nop
    <+300>:	mov    %rdx,%rax
    <+303>:	sub    %rdx,%r10
    <+306>:	sub    %rcx,%rax
    <+309>:	add    %rcx,%r10
    <+312>:	add    %rax,%rbx
    <+315>:	add    %rax,%r12
    <+318>:	cmp    0x8(%rbp),%r12
    <+322>:	jb     0xffffffff8176b884 <_copy_from_iter+338>
    <+324>:	add    $0x10,%rbp
    <+328>:	xor    %r12d,%r12d
    <+331>:	test   %r10,%r10
    <+334>:	jne    0xffffffff8176b81b <_copy_from_iter+233>
    <+336>:	jmp    0xffffffff8176b887 <_copy_from_iter+341>
    <+338>:	mov    %r12,%r10
    <+341>:	mov    %rbp,%rax
    <+344>:	sub    0x10(%r15),%rax
    <+348>:	mov    %r10,0x8(%r15)
    <+352>:	mov    %rbp,0x10(%r15)
    <+356>:	sar    $0x4,%rax
    <+360>:	sub    %rax,0x20(%r15)
    <+364>:	jmp    0xffffffff8176baec <_copy_from_iter+954>

    <+369>:	cmp    $0x2,%dl		# ITER_BVEC
    <+372>:	jne    0xffffffff8176b946 <_copy_from_iter+532>
    <+378>:	mov    0x10(%r15),%r13
    <+382>:	mov    %rsi,%r12
    <+385>:	xor    %ebx,%ebx
    <+387>:	mov    0x8(%r15),%r14
    <+391>:	mov    0xc(%r13),%ecx
    <+395>:	add    %r14,%rcx
    <+398>:	mov    %rcx,%rdi
    <+401>:	and    $0xfff,%ecx
    <+407>:	shr    $0xc,%rdi
    <+411>:	shl    $0x6,%rdi
    <+415>:	add    0x0(%r13),%rdi
    <+419>:	call   0xffffffff81769ae2 <kmap_local_page>
    <+424>:	mov    0x8(%r13),%ebp
    <+428>:	mov    $0x1000,%edx
    <+433>:	lea    (%rax,%rcx,1),%rsi
    <+437>:	mov    0x8(%rsp),%rax
    <+442>:	sub    %r14,%rbp
    <+445>:	lea    (%rax,%rbx,1),%rdi
    <+449>:	cmp    %r12,%rbp
    <+452>:	cmova  %r12,%rbp
    <+456>:	sub    %rcx,%rdx
    <+459>:	cmp    %rdx,%rbp
    <+462>:	cmova  %rdx,%rbp
    <+466>:	mov    %rbp,%rdx
    <+469>:	add    %rbp,%r14
    <+472>:	sub    %rbp,%r12
    <+475>:	call   0xffffffff81d63980 <memcpy>
    <+480>:	mov    0x8(%r13),%eax
    <+484>:	add    %rbp,%rbx
    <+487>:	cmp    %rax,%r14
    <+490>:	jb     0xffffffff8176b925 <_copy_from_iter+499>
    <+492>:	add    $0x10,%r13
    <+496>:	xor    %r14d,%r14d
    <+499>:	test   %r12,%r12
    <+502>:	jne    0xffffffff8176b8b9 <_copy_from_iter+391>
    <+504>:	mov    %r13,%rax
    <+507>:	sub    0x10(%r15),%rax
    <+511>:	mov    %r14,0x8(%r15)
    <+515>:	mov    %r13,0x10(%r15)
    <+519>:	sar    $0x4,%rax
    <+523>:	sub    %rax,0x20(%r15)
    <+527>:	jmp    0xffffffff8176baec <_copy_from_iter+954>

    <+532>:	cmp    $0x3,%dl		# ITER_KVEC
    <+535>:	jne    0xffffffff8176b9bf <_copy_from_iter+653>
    <+537>:	mov    0x10(%r15),%r13
    <+541>:	mov    %rsi,%r12
    <+544>:	xor    %ebx,%ebx
    <+546>:	mov    0x8(%r15),%r14
    <+550>:	mov    0x8(%r13),%rbp
    <+554>:	sub    %r14,%rbp
    <+557>:	cmp    %r12,%rbp
    <+560>:	cmova  %r12,%rbp
    <+564>:	test   %rbp,%rbp
    <+567>:	je     0xffffffff8176b992 <_copy_from_iter+608>
    <+569>:	mov    0x0(%r13),%rsi
    <+573>:	mov    %rbp,%rdx
    <+576>:	sub    %rbp,%r12
    <+579>:	mov    0x8(%rsp),%rax
    <+584>:	add    %r14,%rsi
    <+587>:	add    %rbp,%r14
    <+590>:	lea    (%rax,%rbx,1),%rdi
    <+594>:	add    %rbp,%rbx
    <+597>:	call   0xffffffff81d63980 <memcpy>
    <+602>:	cmp    0x8(%r13),%r14
    <+606>:	jb     0xffffffff8176b9a0 <_copy_from_iter+622>
    <+608>:	add    $0x10,%r13
    <+612>:	xor    %r14d,%r14d
    <+615>:	test   %r12,%r12
    <+618>:	jne    0xffffffff8176b958 <_copy_from_iter+550>
    <+620>:	jmp    0xffffffff8176b9a3 <_copy_from_iter+625>
    <+622>:	mov    %r14,%r12
    <+625>:	mov    %r13,%rax
    <+628>:	sub    0x10(%r15),%rax
    <+632>:	mov    %r12,0x8(%r15)
    <+636>:	mov    %r13,0x10(%r15)
    <+640>:	sar    $0x4,%rax
    <+644>:	sub    %rax,0x20(%r15)
    <+648>:	jmp    0xffffffff8176baec <_copy_from_iter+954>

    <+653>:	cmp    $0x4,%dl		# ITER_XARRAY
    <+656>:	jne    0xffffffff8176baf2 <_copy_from_iter+960>
    <+662>:	movq   $0x3,0x30(%rsp)
    <+671>:	mov    0x10(%r15),%rax
    <+675>:	xor    %edx,%edx
    <+677>:	mov    0x8(%r15),%r14
    <+681>:	mov    %rdx,0x38(%rsp)
    <+686>:	add    0x20(%r15),%r14
    <+690>:	mov    %rdx,0x40(%rsp)
    <+695>:	mov    %rdx,0x48(%rsp)
    <+700>:	mov    %rax,0x18(%rsp)
    <+705>:	mov    %r14,%rax
    <+708>:	shr    $0xc,%rax
    <+712>:	mov    %rax,0x20(%rsp)
    <+717>:	xor    %eax,%eax
    <+719>:	mov    %eax,0x28(%rsp)
    <+723>:	lea    0x18(%rsp),%rdi
    <+728>:	or     $0xffffffffffffffff,%rsi
    <+732>:	mov    %rbx,%r13
    <+735>:	call   0xffffffff81d5ca1d <xas_find>
    <+740>:	xor    %ebx,%ebx
    <+742>:	mov    %rax,(%rsp)
    <+746>:	cmpq   $0x0,(%rsp)
    <+751>:	je     0xffffffff8176bae8 <_copy_from_iter+950>
    <+757>:	mov    (%rsp),%rsi
    <+761>:	lea    0x18(%rsp),%rdi
    <+766>:	call   0xffffffff81769b5c <xas_retry>
    <+771>:	test   %al,%al
    <+773>:	jne    0xffffffff8176bad5 <_copy_from_iter+931>
    <+779>:	testb  $0x1,(%rsp)
    <+783>:	jne    0xffffffff8176ba7c <_copy_from_iter+842>
    <+785>:	mov    (%rsp),%rdi
    <+789>:	call   0xffffffff81769a58 <folio_test_hugetlb>
    <+794>:	test   %al,%al
    <+796>:	jne    0xffffffff8176ba80 <_copy_from_iter+846>
    <+798>:	mov    (%rsp),%rdi
    <+802>:	lea    (%r14,%rbx,1),%rdx
    <+806>:	call   0xffffffff81769ac8 <folio_size>
    <+811>:	mov    (%rsp),%rdi
    <+815>:	lea    -0x1(%rax),%r12
    <+819>:	and    %rdx,%r12
    <+822>:	call   0xffffffff81769ac8 <folio_size>
    <+827>:	sub    %r12,%rax
    <+830>:	cmp    %r13,%rax
    <+833>:	cmova  %r13,%rax
    <+837>:	mov    %rax,%rbp
    <+840>:	jmp    0xffffffff8176bad0 <_copy_from_iter+926>
    <+842>:	ud2
    <+844>:	jmp    0xffffffff8176bae8 <_copy_from_iter+950>
    <+846>:	ud2
    <+848>:	jmp    0xffffffff8176bae8 <_copy_from_iter+950>
    <+850>:	mov    (%rsp),%rdi
    <+854>:	mov    %r12,%rsi
    <+857>:	call   0xffffffff81769b07 <kmap_local_folio>
    <+862>:	mov    $0x1000,%edx
    <+867>:	mov    %rax,%rsi
    <+870>:	mov    %r12,%rax
    <+873>:	and    $0xfff,%eax
    <+878>:	sub    %rax,%rdx
    <+881>:	mov    0x8(%rsp),%rax
    <+886>:	cmp    %rbp,%rdx
    <+889>:	cmova  %rbp,%rdx
    <+893>:	lea    (%rax,%rbx,1),%rdi
    <+897>:	mov    %rdx,0x10(%rsp)
    <+902>:	call   0xffffffff81d63980 <memcpy>
    <+907>:	mov    0x10(%rsp),%rdx
    <+912>:	add    %rdx,%rbx
    <+915>:	sub    %rdx,%r13
    <+918>:	je     0xffffffff8176bae8 <_copy_from_iter+950>
    <+920>:	sub    %rdx,%rbp
    <+923>:	add    %rdx,%r12
    <+926>:	test   %rbp,%rbp
    <+929>:	jne    0xffffffff8176ba84 <_copy_from_iter+850>
    <+931>:	lea    0x18(%rsp),%rdi
    <+936>:	call   0xffffffff8176a6bb <xas_next_entry>
    <+941>:	mov    %rax,(%rsp)
    <+945>:	jmp    0xffffffff8176ba1c <_copy_from_iter+746>
    <+950>:	add    %rbx,0x8(%r15)
    <+954>:	sub    %rbx,0x18(%r15)
    <+958>:	jmp    0xffffffff8176baf9 <_copy_from_iter+967>

    # ITER_DISCARD
    <+960>:	sub    %rsi,%rax
    <+963>:	mov    %rax,0x18(%r15)
    <+967>:	mov    0x50(%rsp),%rax
    <+972>:	sub    %gs:0x28,%rax
    <+981>:	je     0xffffffff8176bb0e <_copy_from_iter+988>
    <+983>:	call   0xffffffff81d62fcd <__stack_chk_fail>
    <+988>:	add    $0x58,%rsp
    <+992>:	mov    %rbx,%rax
    <+995>:	pop    %rbx
    <+996>:	pop    %rbp
    <+997>:	pop    %r12
    <+999>:	pop    %r13
    <+1001>:	pop    %r14
    <+1003>:	pop    %r15
    <+1005>:	jmp    0xffffffff81d6f7e0 <__x86_return_thunk>

