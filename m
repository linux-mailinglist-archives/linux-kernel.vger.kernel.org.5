Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3347EE8B2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 22:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjKPVOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 16:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjKPVN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 16:13:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CF1D4D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 13:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700169233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l6B51kHuwLmyHLtffoopCcRE0yAJ1jVAzbx5f+dxL4g=;
        b=NFmz7UeZUxymrksOuyPlUzW9a/iUHpvRvpNgJUgs/ohp5bWFRxAR7fJmQBWPeKR8yeRkjF
        wO8WAw64BC03Q6HVDW6ce/i74QiQ87tmpdga1GM+lYHl01LFNN6XszBy74u5CcqYwENoYk
        7vhx+V2fZzFM6vyipA1KExTt9NiYSO4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-_lRLhBGzMz2xswfXPOP2ag-1; Thu,
 16 Nov 2023 16:10:49 -0500
X-MC-Unique: _lRLhBGzMz2xswfXPOP2ag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36F5C2823817;
        Thu, 16 Nov 2023 21:09:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3BB01C060AE;
        Thu, 16 Nov 2023 21:09:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wi7gdgFM4tnLXfE4cj2XiKNARbGY-N2aF5h9CMaN6JUbA@mail.gmail.com>
References: <CAHk-=wi7gdgFM4tnLXfE4cj2XiKNARbGY-N2aF5h9CMaN6JUbA@mail.gmail.com> <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk> <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com> <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com> <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com> <4097023.1700084620@warthog.procyon.org.uk> <CAHk-=wgR3Mw2-8k2O3S10T-f4oz8FNfg7aziLU_6pbx0qowxew@mail.gmail.com> <42895.1700089191@warthog.procyon.org.uk>
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
Content-ID: <282730.1700168945.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 16 Nov 2023 21:09:05 +0000
Message-ID: <282731.1700168945@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

> You could try building the kernel without mitigations (or booting with t=
hem
> off, which isn't quite as good) to verify.

Okay, I disabled RETPOLINE, which seems like it should be the important on=
e.
With inlined memcpy:

 iov_kunit_benchmark_bvec: avg 3160 uS, stddev 17 uS
 iov_kunit_benchmark_bvec_split: avg 3380 uS, stddev 29 uS
 iov_kunit_benchmark_kvec: avg 2940 uS, stddev 978 uS
 iov_kunit_benchmark_xarray: avg 3599 uS, stddev 8 uS
 iov_kunit_benchmark_xarray_to_bvec: avg 3964 uS, stddev 16 uS

Directly calling __memcpy():

 iov_kunit_benchmark_bvec: avg 9947 uS, stddev 61 uS
 iov_kunit_benchmark_bvec_split: avg 9790 uS, stddev 13 uS
 iov_kunit_benchmark_kvec: avg 9565 uS, stddev 758 uS
 iov_kunit_benchmark_xarray: avg 10498 uS, stddev 24 uS
 iov_kunit_benchmark_xarray_to_bvec: avg 10459 uS, stddev 188 uS

I created a duplicate of __memcpy() (called __movsb_memcpy) without the
"alternative" statement and made it call that:

 iov_kunit_benchmark_bvec: avg 3177 uS, stddev 7 uS
 iov_kunit_benchmark_bvec_split: avg 3393 uS, stddev 10 uS
 iov_kunit_benchmark_kvec: avg 2813 uS, stddev 385 uS
 iov_kunit_benchmark_xarray: avg 3651 uS, stddev 7 uS
 iov_kunit_benchmark_xarray_to_bvec: avg 3946 uS, stddev 8 uS

And then I made it call memcpy_orig() directly:

 iov_kunit_benchmark_bvec: avg 9942 uS, stddev 17 uS
 iov_kunit_benchmark_bvec_split: avg 9802 uS, stddev 29 uS
 iov_kunit_benchmark_kvec: avg 9547 uS, stddev 598 uS
 iov_kunit_benchmark_xarray: avg 10486 uS, stddev 13 uS
 iov_kunit_benchmark_xarray_to_bvec: avg 10438 uS, stddev 12 uS

(See attached patch)

David
---
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 0ae2e1712e2e..df1ebbe345e2 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -43,7 +43,7 @@ EXPORT_SYMBOL(__memcpy)
 SYM_FUNC_ALIAS_MEMFUNC(memcpy, __memcpy)
 EXPORT_SYMBOL(memcpy)
 =

-SYM_FUNC_START_LOCAL(memcpy_orig)
+SYM_TYPED_FUNC_START(memcpy_orig)
 	movq %rdi, %rax
 =

 	cmpq $0x20, %rdx
@@ -169,4 +169,12 @@ SYM_FUNC_START_LOCAL(memcpy_orig)
 .Lend:
 	RET
 SYM_FUNC_END(memcpy_orig)
+EXPORT_SYMBOL(memcpy_orig)
 =

+SYM_TYPED_FUNC_START(__movsb_memcpy)
+	movq %rdi, %rax
+	movq %rdx, %rcx
+	rep movsb
+	RET
+SYM_FUNC_END(__movsb_memcpy)
+EXPORT_SYMBOL(__movsb_memcpy)
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index de7d11cf4c63..620cd6356a5b 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -58,11 +58,18 @@ size_t copy_from_user_iter(void __user *iter_from, siz=
e_t progress,
 	return res;
 }
 =

+extern void *__movsb_memcpy(void *, const void *, size_t);
+extern void *memcpy_orig(void *, const void *, size_t);
+
 static __always_inline
 size_t memcpy_to_iter(void *iter_to, size_t progress,
 		      size_t len, void *from, void *priv2)
 {
-	memcpy(iter_to, from + progress, len);
+#if 0
+	__movsb_memcpy(iter_to, from + progress, len);
+#else
+	memcpy_orig(iter_to, from + progress, len);
+#endif	=

 	return 0;
 }
 =

@@ -70,7 +77,11 @@ static __always_inline
 size_t memcpy_from_iter(void *iter_from, size_t progress,
 			size_t len, void *to, void *priv2)
 {
-	memcpy(to + progress, iter_from, len);
+#if 0
+	__movsb_memcpy(to + progress, iter_from, len);
+#else
+	memcpy_orig(to + progress, iter_from, len);
+#endif
 	return 0;
 }
 =

