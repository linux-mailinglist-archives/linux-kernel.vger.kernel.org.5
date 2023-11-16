Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3927EE55C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343972AbjKPQoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjKPQoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:44:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7603FB7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 08:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700153051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cgOZv+HSF5fpSXSIYpXcb5BN5q50Bv1mWBUvFipGc6w=;
        b=cJjWFlM21yePCqlryjRNFZkaGGdEv5EZd0QQ2g4Tbg8vE7vw8mIz4vYYejEz4NEIPE+nVM
        A5H+C7cBon62107q0CB4UnO+pKGBxiDK6c+08z/kn5M0MsJaNa47riOvbZsCRYqaBU20h4
        78Oc+jUZYsR/MuoyFlE8/loM9QAvoXs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-NjtpnwZ_OYiC2dtYogqGHg-1; Thu,
 16 Nov 2023 11:44:10 -0500
X-MC-Unique: NjtpnwZ_OYiC2dtYogqGHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 658D9381258D;
        Thu, 16 Nov 2023 16:44:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3814E10F47;
        Thu, 16 Nov 2023 16:44:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20231116154406.GDZVY4xmFvRQt0wGGE@fat_crate.local>
References: <20231116154406.GDZVY4xmFvRQt0wGGE@fat_crate.local> <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk> <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com> <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com> <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com> <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local> <CAHk-=wh0TcXyGmKHfs+Xe=5Sd5bNn=NNV9CEtOy_tbyHAAmk9g@mail.gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Content-ID: <232439.1700153046.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 16 Nov 2023 16:44:06 +0000
Message-ID: <232440.1700153046@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> wrote:

> diff --git a/Makefile b/Makefile
> index ede0bd241056..94d93070d54a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -996,6 +996,8 @@ endif
>  # change __FILE__ to the relative path from the srctree
>  KBUILD_CPPFLAGS +=3D $(call cc-option,-fmacro-prefix-map=3D$(srctree)/=3D=
)
>  =

> +KBUILD_CFLAGS	+=3D $(call cc-option,-mstringop-strategy=3Dlibcall)
> +
>  # include additional Makefiles when needed
>  include-y			:=3D scripts/Makefile.extrawarn
>  include-$(CONFIG_DEBUG_INFO)	+=3D scripts/Makefile.debug

If you wanted this patch trying, I get the following numbers:

 iov_kunit_benchmark_bvec: avg 9950 uS, stddev 40 uS
 iov_kunit_benchmark_bvec: avg 9950 uS, stddev 53 uS
 iov_kunit_benchmark_bvec: avg 9973 uS, stddev 69 uS
 iov_kunit_benchmark_bvec_split: avg 9793 uS, stddev 28 uS
 iov_kunit_benchmark_bvec_split: avg 9800 uS, stddev 41 uS
 iov_kunit_benchmark_bvec_split: avg 9804 uS, stddev 16 uS
 iov_kunit_benchmark_kvec: avg 10122 uS, stddev 4403 uS
 iov_kunit_benchmark_kvec: avg 9757 uS, stddev 1516 uS
 iov_kunit_benchmark_kvec: avg 9909 uS, stddev 2694 uS
 iov_kunit_benchmark_xarray: avg 10526 uS, stddev 52 uS
 iov_kunit_benchmark_xarray: avg 10529 uS, stddev 48 uS
 iov_kunit_benchmark_xarray: avg 10532 uS, stddev 63 uS
 iov_kunit_benchmark_xarray_to_bvec: avg 10468 uS, stddev 23 uS
 iov_kunit_benchmark_xarray_to_bvec: avg 10469 uS, stddev 157 uS
 iov_kunit_benchmark_xarray_to_bvec: avg 10471 uS, stddev 163 uS

I'm using the 6 patches here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Diov-kunit

Set CONFIG_TEST_IOV_ITER=3Dm and then load the kunit_iov_iter.ko module.  =
It'll
dump its benchmarks to dmesg.

David

