Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A3D7F147B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjKTNdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjKTNdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:33:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7ABD2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 05:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700487185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GKAjxb5L8GXcEiZp1p1xgiANkfwmq+6HRFgDC3/1RH8=;
        b=JHzQjg1RWJmHk0kdGCcnbuJXhX80SajqMv6Jd9Lp2q6APpw8QdcZEhAPMlB6a75qCuLHFM
        PBOgF1stxwyBPFS2sQDwAX6FBu0cgpDbUUIimbw9VDTpRgbBGzdZYQi4qjVnQLfeOaRbLR
        zxt8NPnWYHhjWEuqGrxSLu2fMkYM4wA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-WX_z4KetNXKpjlICiS3MVQ-1; Mon, 20 Nov 2023 08:33:02 -0500
X-MC-Unique: WX_z4KetNXKpjlICiS3MVQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD5308F15C7;
        Mon, 20 Nov 2023 13:33:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F889C1596F;
        Mon, 20 Nov 2023 13:32:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wiRQHD5xnB8H9Lwk9fJPDpfVNAwPS4KLnfrcrU3zbMAdQ@mail.gmail.com>
References: <CAHk-=wiRQHD5xnB8H9Lwk9fJPDpfVNAwPS4KLnfrcrU3zbMAdQ@mail.gmail.com> <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com> <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com> <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com> <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local> <CAHk-=wh0TcXyGmKHfs+Xe=5Sd5bNn=NNV9CEtOy_tbyHAAmk9g@mail.gmail.com> <232440.1700153046@warthog.procyon.org.uk> <864270.1700230337@warthog.procyon.org.uk> <20231117160940.GGZVeQRLgLjJZXBLE1@fat_crate.local> <CAHk-=wj33FoGBQ7HkqjLbyOBQogWpYAG7WUTXatcfBF5duijjQ@mail.gmail.com> <CAHk-=whLbJ7vvB1ACVC6t44zjihX8w7GMY2y584+Fm83rsmaKg@mail.gmail.com> <20231117191243.GHZVe7K4vN9n5M92gb@fat_crate.local>
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
Content-ID: <2284218.1700487177.1@warthog.procyon.org.uk>
Date:   Mon, 20 Nov 2023 13:32:57 +0000
Message-ID: <2284219.1700487177@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So I don't think we should use either of these benchmarks as a "we
> need to optimize for *this*", but it is another example of how much
> memcpy() does matter. Even if the end result is then "but different
> microarchitectrues react so differently that we can't please
> everybody".

So what, if anything, should I change?  Should I make it directly call
__memcpy?  Or should we just leave it to the compiler?  I would prefer to
leave memcpy_from_iter() and memcpy_to_iter() as __always_inline to eliminate
the function pointer call we otherwise end up with and to eliminate the return
value (which is always 0 in this case).

How about something along the attached lines?  (With the inline asm
appropriate pushed out to an arch header file).

On the other hand, it might be better to have memcpy_to/from_iter() just call
__memcpy() as it doesn't seem to make much difference to the time taken and
the inline func can still return a constant 0 return value that can be
optimised away.

David
---

diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 0ae2e1712e2e..7354982dc433 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -43,7 +43,7 @@ EXPORT_SYMBOL(__memcpy)
 SYM_FUNC_ALIAS_MEMFUNC(memcpy, __memcpy)
 EXPORT_SYMBOL(memcpy)
 
-SYM_FUNC_START_LOCAL(memcpy_orig)
+SYM_TYPED_FUNC_START(memcpy_orig)
 	movq %rdi, %rax
 
 	cmpq $0x20, %rdx
@@ -169,4 +169,4 @@ SYM_FUNC_START_LOCAL(memcpy_orig)
 .Lend:
 	RET
 SYM_FUNC_END(memcpy_orig)
-
+EXPORT_SYMBOL(memcpy_orig)
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index de7d11cf4c63..de73edb9ffcc 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -62,7 +62,17 @@ static __always_inline
 size_t memcpy_to_iter(void *iter_to, size_t progress,
 		      size_t len, void *from, void *priv2)
 {
-	memcpy(iter_to, from + progress, len);
+	size_t len2 = len;
+	from += progress;
+	/*
+	 * If CPU has FSRM feature, use 'rep movs'.
+	 * Otherwise, use rep_movs_alternative.
+	 */
+	asm volatile(
+		ALTERNATIVE("rep movsb",
+			    "call memcpy_orig", ALT_NOT(X86_FEATURE_FSRM))
+		:"+D" (iter_to), "+S" (from), "+d" (len), "+c"(len2), ASM_CALL_CONSTRAINT
+		:: "memory", "rax", "r8", "r9", "r10", "r11");
 	return 0;
 }
 
@@ -70,7 +80,18 @@ static __always_inline
 size_t memcpy_from_iter(void *iter_from, size_t progress,
 			size_t len, void *to, void *priv2)
 {
-	memcpy(to + progress, iter_from, len);
+	size_t len2 = len;
+	to += progress;
+	/*
+	 * If CPU has FSRM feature, use 'rep movs'.
+	 * Otherwise, use rep_movs_alternative.
+	 */
+	asm volatile(
+		ALTERNATIVE("rep movsb",
+			    "call memcpy_orig",
+			    ALT_NOT(X86_FEATURE_FSRM))
+		:"+D" (to), "+S" (iter_from), "+d" (len), "+c" (len2), ASM_CALL_CONSTRAINT
+		:: "memory", "rax", "r8", "r9", "r10", "r11");
 	return 0;
 }
 

