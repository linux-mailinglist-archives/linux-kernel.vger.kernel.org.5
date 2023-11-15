Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8B57ECA90
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 19:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjKOSfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 13:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjKOSfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:35:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1487319D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700073342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9TcRagWPCoG2DdsGqLFhChJSsHvxmy5XsheDLk2JaLs=;
        b=bwRUGmDgIgtppr0kZA+FTnWI8KVROGKq9yKLsuIvNNFYelLRnVzoIm+diiAHXKvhc2idmz
        m8TVpn3nxkRKJh9hCRL3c2nGAObGuh4vcUMqNBFr5aHbGc2krfCTpJS+jJCndCF7wNZhJ7
        V+NVCak7/m+IUFHw0olA6t00rMCNE+k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-1AAlrEALOjGVLAOSAQdB6A-1; Wed, 15 Nov 2023 13:35:38 -0500
X-MC-Unique: 1AAlrEALOjGVLAOSAQdB6A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C4FB185A780;
        Wed, 15 Nov 2023 18:35:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58B3B36EE;
        Wed, 15 Nov 2023 18:35:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
References: <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com> <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk> <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, kernel test robot <oliver.sang@intel.com>,
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
Content-ID: <4007889.1700073334.1@warthog.procyon.org.uk>
Date:   Wed, 15 Nov 2023 18:35:34 +0000
Message-ID: <4007890.1700073334@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> which makes *zero* sense. It first checks that the the length is at
> least 8 bytes, then it moves *one* word by hand, then it aligns the
> code to 8 bytes remaining, and does the remaining (possibly
> overlapping at the beginning) words as one "rep movsq",

That's not what I see.  See attached for a dump of _copy_from_iter from my
kernel.  It's just using REP MOVSB.

For reference, the compiler is gcc-13.2.1-3.fc39.x86_64 with
binutils-2.40-13.fc39.x86_64.

David
---

(gdb) disas _copy_from_iter
Dump of assembler code for function _copy_from_iter:
    <+0>:	push   %r15
    <+2>:	push   %r14
    <+4>:	push   %r13
    <+6>:	push   %r12
    <+8>:	push   %rbp
    <+9>:	push   %rbx
    <+10>:	sub    $0x40,%rsp
    <+14>:	mov    %gs:0x28,%rax
    <+23>:	mov    %rax,0x38(%rsp)
    <+28>:	xor    %eax,%eax
    <+30>:	cmpb   $0x0,0x3(%rdx)
    <+34>:	je     0xffffffff81770334 <_copy_from_iter+50>
    <+36>:	cmpb   $0x0,0x1(%rdx)
    <+40>:	mov    %rdi,%r12
    <+43>:	mov    %rdx,%rbx
    <+46>:	je     0xffffffff81770364 <_copy_from_iter+98>
    <+48>:	jmp    0xffffffff8177033d <_copy_from_iter+59>
    <+50>:	ud2
    <+52>:	xor    %ebp,%ebp
    <+54>:	jmp    0xffffffff8177067e <_copy_from_iter+892>

    <+59>:	mov    0x38(%rsp),%rax
    <+64>:	sub    %gs:0x28,%rax
    <+73>:	jne    0xffffffff8177068e <_copy_from_iter+908>
    <+79>:	add    $0x40,%rsp
    <+83>:	pop    %rbx
    <+84>:	pop    %rbp
    <+85>:	pop    %r12
    <+87>:	pop    %r13
    <+89>:	pop    %r14
    <+91>:	pop    %r15
    <+93>:	jmp    0xffffffff8176ee3f <__copy_from_iter_mc>

    <+98>:	mov    0x18(%rdx),%rax
    <+102>:	cmp    %rax,%rsi
    <+105>:	cmova  %rax,%rsi
    <+109>:	test   %rsi,%rsi
    <+112>:	mov    %rsi,%rbp
    <+115>:	je     0xffffffff8177067e <_copy_from_iter+892>

    <+121>:	mov    (%rdx),%dl
    <+123>:	test   %dl,%dl		# ITER_UBUF
    <+125>:	jne    0xffffffff817703cc <_copy_from_iter+202>
    <+127>:	mov    0x8(%rbx),%rsi
    <+131>:	mov    %rbp,%rcx
    <+134>:	add    0x10(%rbx),%rsi
    <+138>:	mov    %rsi,%rdx
    <+141>:	mov    %rbp,%rsi
    <+144>:	mov    %rdx,%rdi
    <+147>:	call   0xffffffff8176ec9e <__access_ok>
    <+152>:	test   %al,%al
    <+154>:	je     0xffffffff817703af <_copy_from_iter+173>
    <+156>:	nop
    <+157>:	nop
    <+158>:	nop
    <+159>:	mov    %r12,%rdi
    <+162>:	mov    %rdx,%rsi
    <+165>:	rep movsb %ds:(%rsi),%es:(%rdi)
    <+167>:	nop
    <+168>:	nop
    <+169>:	nop
    <+170>:	nop
    <+171>:	nop
    <+172>:	nop
    <+173>:	mov    %rbp,%rax
    <+176>:	sub    %rcx,%rax
    <+179>:	add    0x18(%rbx),%rcx
    <+183>:	add    %rax,0x8(%rbx)
    <+187>:	sub    %rbp,%rcx
    <+190>:	mov    %rax,%rbp
    <+193>:	mov    %rcx,0x18(%rbx)
    <+197>:	jmp    0xffffffff8177067e <_copy_from_iter+892>

    <+202>:	cmp    $0x1,%dl		# ITER_IOVEC
    <+205>:	jne    0xffffffff8177044c <_copy_from_iter+330>
    <+207>:	mov    0x10(%rbx),%r9
    <+211>:	mov    %rsi,%r8
    <+214>:	xor    %ebp,%ebp
    <+216>:	mov    0x8(%rbx),%r10
    <+220>:	mov    0x8(%r9),%rdx
    <+224>:	sub    %r10,%rdx
    <+227>:	cmp    %r8,%rdx
    <+230>:	cmova  %r8,%rdx
    <+234>:	test   %rdx,%rdx
    <+237>:	je     0xffffffff81770433 <_copy_from_iter+305>
    <+239>:	mov    (%r9),%r11
    <+242>:	mov    %rdx,%rsi
    <+245>:	mov    %rdx,%rcx
    <+248>:	add    %r10,%r11
    <+251>:	mov    %r11,%rdi
    <+254>:	call   0xffffffff8176ec9e <__access_ok>
    <+259>:	test   %al,%al
    <+261>:	je     0xffffffff8177041b <_copy_from_iter+281>
    <+263>:	nop
    <+264>:	nop
    <+265>:	nop
    <+266>:	lea    (%r12,%rbp,1),%rdi
    <+270>:	mov    %r11,%rsi
    <+273>:	rep movsb %ds:(%rsi),%es:(%rdi)
    <+275>:	nop
    <+276>:	nop
    <+277>:	nop
    <+278>:	nop
    <+279>:	nop
    <+280>:	nop
    <+281>:	mov    %rdx,%rax
    <+284>:	sub    %rdx,%r8
    <+287>:	sub    %rcx,%rax
    <+290>:	add    %rcx,%r8
    <+293>:	add    %rax,%rbp
    <+296>:	add    %rax,%r10
    <+299>:	cmp    0x8(%r9),%r10
    <+303>:	jb     0xffffffff81770444 <_copy_from_iter+322>
    <+305>:	add    $0x10,%r9
    <+309>:	xor    %r10d,%r10d
    <+312>:	test   %r8,%r8
    <+315>:	jne    0xffffffff817703de <_copy_from_iter+220>
    <+317>:	jmp    0xffffffff81770544 <_copy_from_iter+578>
    <+322>:	mov    %r10,%r8
    <+325>:	jmp    0xffffffff81770544 <_copy_from_iter+578>

    <+330>:	cmp    $0x2,%dl		# ITER_BVEC
    <+333>:	jne    0xffffffff817704ee <_copy_from_iter+492>
    <+339>:	mov    0x10(%rbx),%r8
    <+343>:	mov    %rsi,%r11
    <+346>:	xor    %ebp,%ebp
    <+348>:	mov    $0x1000,%r10d
    <+354>:	mov    0x8(%rbx),%r9
    <+358>:	mov    0xc(%r8),%ecx
    <+362>:	add    %r9,%rcx
    <+365>:	mov    %rcx,%rdi
    <+368>:	and    $0xfff,%ecx
    <+374>:	shr    $0xc,%rdi
    <+378>:	shl    $0x6,%rdi
    <+382>:	add    (%r8),%rdi
    <+385>:	call   0xffffffff8176e72e <kmap_local_page>
    <+390>:	mov    %r10,%rdx
    <+393>:	mov    %rax,%rsi
    <+396>:	mov    0x8(%r8),%eax
    <+400>:	sub    %r9,%rax
    <+403>:	cmp    %r11,%rax
    <+406>:	cmova  %r11,%rax
    <+410>:	sub    %rcx,%rdx
    <+413>:	cmp    %rdx,%rax
    <+416>:	cmova  %rdx,%rax
    <+420>:	add    %rcx,%rsi
    <+423>:	lea    (%r12,%rbp,1),%rdx
    <+427>:	mov    %eax,%ecx
    <+429>:	sub    %rax,%r11
    <+432>:	mov    %rdx,%rdi
    <+435>:	add    %rax,%rbp
    <+438>:	add    %rax,%r9
    <+441>:	rep movsb %ds:(%rsi),%es:(%rdi)
    <+443>:	mov    0x8(%r8),%eax
    <+447>:	cmp    %rax,%r9
    <+450>:	jb     0xffffffff817704cd <_copy_from_iter+459>
    <+452>:	add    $0x10,%r8
    <+456>:	xor    %r9d,%r9d
    <+459>:	test   %r11,%r11
    <+462>:	jne    0xffffffff81770468 <_copy_from_iter+358>
    <+464>:	mov    %r8,%rax
    <+467>:	sub    0x10(%rbx),%rax
    <+471>:	mov    %r9,0x8(%rbx)
    <+475>:	mov    %r8,0x10(%rbx)
    <+479>:	sar    $0x4,%rax
    <+483>:	sub    %rax,0x20(%rbx)
    <+487>:	jmp    0xffffffff81770671 <_copy_from_iter+879>

    <+492>:	cmp    $0x3,%dl		# ITER_KVEC
    <+495>:	jne    0xffffffff81770560 <_copy_from_iter+606>
    <+497>:	mov    0x10(%rbx),%r9
    <+501>:	mov    %rsi,%r8
    <+504>:	xor    %ebp,%ebp
    <+506>:	mov    0x8(%rbx),%rdx
    <+510>:	mov    0x8(%r9),%rax
    <+514>:	sub    %rdx,%rax
    <+517>:	cmp    %r8,%rax
    <+520>:	cmova  %r8,%rax
    <+524>:	test   %rax,%rax
    <+527>:	je     0xffffffff81770534 <_copy_from_iter+562>
    <+529>:	mov    (%r9),%rsi
    <+532>:	lea    (%r12,%rbp,1),%r10
    <+536>:	mov    %rax,%rcx
    <+539>:	add    %rax,%rbp
    <+542>:	mov    %r10,%rdi
    <+545>:	sub    %rax,%r8
    <+548>:	add    %rdx,%rsi
    <+551>:	add    %rax,%rdx
    <+554>:	rep movsb %ds:(%rsi),%es:(%rdi)
    <+556>:	cmp    0x8(%r9),%rdx
    <+560>:	jb     0xffffffff81770541 <_copy_from_iter+575>
    <+562>:	add    $0x10,%r9
    <+566>:	xor    %edx,%edx
    <+568>:	test   %r8,%r8
    <+571>:	jne    0xffffffff81770500 <_copy_from_iter+510>
    <+573>:	jmp    0xffffffff81770544 <_copy_from_iter+578>
    <+575>:	mov    %rdx,%r8
    <+578>:	mov    %r9,%rax
    <+581>:	sub    0x10(%rbx),%rax
    <+585>:	mov    %r8,0x8(%rbx)
    <+589>:	mov    %r9,0x10(%rbx)
    <+593>:	sar    $0x4,%rax
    <+597>:	sub    %rax,0x20(%rbx)
    <+601>:	jmp    0xffffffff81770671 <_copy_from_iter+879>

    <+606>:	cmp    $0x4,%dl		# ITER_XARRAY
    <+609>:	jne    0xffffffff81770677 <_copy_from_iter+885>
    <+615>:	movq   $0x3,0x18(%rsp)
    <+624>:	mov    0x10(%rbx),%rax
    <+628>:	xor    %edx,%edx
    <+630>:	mov    0x8(%rbx),%r14
    <+634>:	mov    %rdx,0x20(%rsp)
    <+639>:	add    0x20(%rbx),%r14
    <+643>:	mov    %rdx,0x28(%rsp)
    <+648>:	mov    %rdx,0x30(%rsp)
    <+653>:	mov    %rax,(%rsp)
    <+657>:	mov    %r14,%rax
    <+660>:	shr    $0xc,%rax
    <+664>:	mov    %rax,0x8(%rsp)
    <+669>:	xor    %eax,%eax
    <+671>:	mov    %eax,0x10(%rsp)
    <+675>:	or     $0xffffffffffffffff,%rsi
    <+679>:	mov    %rsp,%rdi
    <+682>:	mov    %rbp,%r13
    <+685>:	call   0xffffffff81d617d1 <xas_find>
    <+690>:	xor    %ebp,%ebp
    <+692>:	mov    $0x1000,%r15d
    <+698>:	mov    %rax,%r8
    <+701>:	test   %r8,%r8
    <+704>:	je     0xffffffff8177066d <_copy_from_iter+875>
    <+710>:	mov    %r8,%rsi
    <+713>:	mov    %rsp,%rdi
    <+716>:	call   0xffffffff8176e7a8 <xas_retry>
    <+721>:	test   %al,%al
    <+723>:	jne    0xffffffff8177065d <_copy_from_iter+859>
    <+729>:	test   $0x1,%r8d
    <+736>:	jne    0xffffffff81770614 <_copy_from_iter+786>
    <+738>:	mov    %r8,%rdi
    <+741>:	call   0xffffffff8176e6a4 <folio_test_hugetlb>
    <+746>:	test   %al,%al
    <+748>:	jne    0xffffffff81770618 <_copy_from_iter+790>
    <+750>:	call   0xffffffff8176e714 <folio_size>
    <+755>:	lea    (%r14,%rbp,1),%rdx
    <+759>:	lea    -0x1(%rax),%r10
    <+763>:	call   0xffffffff8176e714 <folio_size>
    <+768>:	and    %rdx,%r10
    <+771>:	sub    %r10,%rax
    <+774>:	cmp    %r13,%rax
    <+777>:	cmova  %r13,%rax
    <+781>:	mov    %rax,%r9
    <+784>:	jmp    0xffffffff81770658 <_copy_from_iter+854>
    <+786>:	ud2
    <+788>:	jmp    0xffffffff8177066d <_copy_from_iter+875>
    <+790>:	ud2
    <+792>:	jmp    0xffffffff8177066d <_copy_from_iter+875>
    <+794>:	lea    (%r12,%rbp,1),%r11
    <+798>:	mov    %r10,%rsi
    <+801>:	mov    %r8,%rdi
    <+804>:	call   0xffffffff8176e753 <kmap_local_folio>
    <+809>:	mov    %r15,%rdx
    <+812>:	mov    %r11,%rdi
    <+815>:	mov    %rax,%rsi
    <+818>:	mov    %r10,%rax
    <+821>:	and    $0xfff,%eax
    <+826>:	sub    %rax,%rdx
    <+829>:	cmp    %r9,%rdx
    <+832>:	cmova  %r9,%rdx
    <+836>:	add    %rdx,%rbp
    <+839>:	sub    %rdx,%r13
    <+842>:	mov    %edx,%ecx
    <+844>:	rep movsb %ds:(%rsi),%es:(%rdi)
    <+846>:	je     0xffffffff8177066d <_copy_from_iter+875>
    <+848>:	sub    %rdx,%r9
    <+851>:	add    %rdx,%r10
    <+854>:	test   %r9,%r9
    <+857>:	jne    0xffffffff8177061c <_copy_from_iter+794>
    <+859>:	mov    %rsp,%rdi
    <+862>:	call   0xffffffff8176f307 <xas_next_entry>
    <+867>:	mov    %rax,%r8
    <+870>:	jmp    0xffffffff817705bf <_copy_from_iter+701>
    <+875>:	add    %rbp,0x8(%rbx)
    <+879>:	sub    %rbp,0x18(%rbx)
    <+883>:	jmp    0xffffffff8177067e <_copy_from_iter+892>

    # ITER_DISCARD / default
    <+885>:	sub    %rsi,%rax
    <+888>:	mov    %rax,0x18(%rbx)
    <+892>:	mov    0x38(%rsp),%rax
    <+897>:	sub    %gs:0x28,%rax
    <+906>:	je     0xffffffff81770693 <_copy_from_iter+913>
    <+908>:	call   0xffffffff81d67d8d <__stack_chk_fail>
    <+913>:	add    $0x40,%rsp
    <+917>:	mov    %rbp,%rax
    <+920>:	pop    %rbx
    <+921>:	pop    %rbp
    <+922>:	pop    %r12
    <+924>:	pop    %r13
    <+926>:	pop    %r14
    <+928>:	pop    %r15
    <+930>:	jmp    0xffffffff81d745a0 <__x86_return_thunk>

