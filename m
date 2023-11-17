Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3BD7EF1EA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 12:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345794AbjKQLgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 06:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjKQLgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 06:36:20 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D89B95
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 03:36:15 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 20A0840E0030;
        Fri, 17 Nov 2023 11:36:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ADBKEGOCI3P9; Fri, 17 Nov 2023 11:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700220970; bh=EceXs6Omee9hCMZqQHMGAQnAY4haaKDYNChLoTkdrus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XcWsAKJovvkbVR0LLVsiCRMtAx2P90vfgWpPFAuN7WK307G4vidfphuP7GZjvf4tl
         22az1tPKLNPvOUTxes5Xa/BkaU636EtL64+25vJEMwHP5l5CPiEebJcR9CKWQIwjZC
         6jBFSGqEwuP8bJ1bOw1UwI+zAurOkTyP9N5XyYPXEO9JFQQZjHc6fKMbizdmMqMR2A
         5qq3j0b0XPtCSWW4NsS5UeeT+MxqKFDzVtVLTwJY693NAX2Nv7IwdJ/e4h9Lu0eI9O
         aelREGGoz0GchzeH3vF8vfTSe+Dvu4CON9MZ0LRTQJf1tcA6eQNhmMuPTStg7ccvD4
         X7FbUoeqyJU5UIbG+nUwZDVHh3GgF3rPhWbLjztYrZMeI2EgfOMTGSGmudmKwDjLQr
         xMZHu5A5jZO2/HKU3Q7EXW0tPH36u+8qVEcZ1D2ixGv/1yFmZh4U0eywMSmnijAjRJ
         bbN4iS1aik49rKC035wfwD+V8ih0l8yesnrwv3mE5HmPHVWUdIVLg/6NgA79JhXTgj
         +AJqeT1qCWg1rUMfdGuwQpkG343Kayvbo/4bJCnexIqc+henqqWyO6SwkCgrBZXse0
         odkvkAMVrTzN7HpyxqqtosUwJngVaiYV/6o8yDVpa/EtdRPivg/1Ce0RuSEjVfZO7C
         WnXPjTHz9RvzigOobczH2PDg=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 98B7840E0032;
        Fri, 17 Nov 2023 11:35:54 +0000 (UTC)
Date:   Fri, 17 Nov 2023 12:35:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
Message-ID: <20231117113549.GBZVdQFQ7VrfsPd9mV@fat_crate.local>
References: <20231116154406.GDZVY4xmFvRQt0wGGE@fat_crate.local>
 <202311061616.cd495695-oliver.sang@intel.com>
 <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local>
 <CAHk-=wh0TcXyGmKHfs+Xe=5Sd5bNn=NNV9CEtOy_tbyHAAmk9g@mail.gmail.com>
 <232440.1700153046@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <232440.1700153046@warthog.procyon.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 04:44:06PM +0000, David Howells wrote:
> If you wanted this patch trying, I get the following numbers:
> 
>  iov_kunit_benchmark_bvec: avg 9950 uS, stddev 40 uS
>  iov_kunit_benchmark_bvec: avg 9950 uS, stddev 53 uS
>  iov_kunit_benchmark_bvec: avg 9973 uS, stddev 69 uS
>  iov_kunit_benchmark_bvec_split: avg 9793 uS, stddev 28 uS
>  iov_kunit_benchmark_bvec_split: avg 9800 uS, stddev 41 uS
>  iov_kunit_benchmark_bvec_split: avg 9804 uS, stddev 16 uS
>  iov_kunit_benchmark_kvec: avg 10122 uS, stddev 4403 uS
>  iov_kunit_benchmark_kvec: avg 9757 uS, stddev 1516 uS
>  iov_kunit_benchmark_kvec: avg 9909 uS, stddev 2694 uS
>  iov_kunit_benchmark_xarray: avg 10526 uS, stddev 52 uS
>  iov_kunit_benchmark_xarray: avg 10529 uS, stddev 48 uS
>  iov_kunit_benchmark_xarray: avg 10532 uS, stddev 63 uS
>  iov_kunit_benchmark_xarray_to_bvec: avg 10468 uS, stddev 23 uS
>  iov_kunit_benchmark_xarray_to_bvec: avg 10469 uS, stddev 157 uS
>  iov_kunit_benchmark_xarray_to_bvec: avg 10471 uS, stddev 163 uS

Hmm, stupid question: are those results better than without that
oneliner?

I don't see those same numbers done without this patch - maybe I can't
find them in the thread or so...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
