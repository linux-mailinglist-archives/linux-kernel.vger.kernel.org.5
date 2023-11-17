Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCA57EF5D6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjKQQKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjKQQKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:10:12 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C6A189
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:10:07 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0495840E01A4;
        Fri, 17 Nov 2023 16:10:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4U9P1q4_ffaT; Fri, 17 Nov 2023 16:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700237402; bh=4l/AX34Xk8xNnGdKcFWHaYBWUllvSpSZLfrnRLTllOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Twxv6dHpy3SzM+aq6d+bZRAuIvY8zd0jPmeGIpMB8JZwTXx8FseOGkRpkvEeP5v9u
         qLVqb4iNC8xgAuuaP02DvCC3DxRc4qRHa2RGl6yrHc1YagK6U9I11O56BMaKsQMy4P
         IFofW/vrpzFYNLpSBFJUmENf0yEV0uyHUE7N70cIzEtLetNOfKCd9p5L5VXBWy1Iun
         T3oHYe/H92iHuAojhjkOpgG1nozLYkHH9SLNV4FF0ERqwUrkvmZbT4xBOUdkXgBOBN
         i1/E/QPiP/kqoOWASQsM6KfiAYxpQgABjnjCwPk5RhnX4HFfJwM9XMdLWvYpoxgjhy
         be5TLHvpNdFAOZi5JM8KpqEgy4fDPAP9xuCP/I6SGu+5jH2umR0ZQVVMqUmx2dyzBk
         //dyMSM2UwjbkX1xm5+XhAg2NT+IB6F6OwKDZp+K7eXU/UFVY9MIgkkIU0ZPQTfnuU
         SXP5wD0diKRcwAfUZaEs9SzoLlEnCJsjSgLBtsrhagXkOTjEOX8mHPMLPsArX+6egX
         BduvBN0P7hpsF1Piy9g+SOvIohYxQsq5SpN33TNeRfF9M4pao8bhDmSdCoqCn0IiZ5
         x1IyK8+Va+pygzzY00CwAK1+De4zV1MPEfhEWxtlfjC8ZiOuD8GLl1ItD/5U3isBRp
         b4yP1TnGLTroUffTbtSJrgIk=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E19E640E0030;
        Fri, 17 Nov 2023 16:09:45 +0000 (UTC)
Date:   Fri, 17 Nov 2023 17:09:40 +0100
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
Message-ID: <20231117160940.GGZVeQRLgLjJZXBLE1@fat_crate.local>
References: <20231116154406.GDZVY4xmFvRQt0wGGE@fat_crate.local>
 <202311061616.cd495695-oliver.sang@intel.com>
 <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local>
 <CAHk-=wh0TcXyGmKHfs+Xe=5Sd5bNn=NNV9CEtOy_tbyHAAmk9g@mail.gmail.com>
 <232440.1700153046@warthog.procyon.org.uk>
 <864270.1700230337@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <864270.1700230337@warthog.procyon.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 02:12:17PM +0000, David Howells wrote:
> Borislav Petkov <bp@alien8.de> wrote:
> 
> > Hmm, stupid question: are those results better than without that
> > oneliner?
> 
> Without any changes, I see something like:
> 
>  iov_kunit_benchmark_bvec: avg 3185 uS, stddev 19 uS
>  iov_kunit_benchmark_bvec: avg 3186 uS, stddev 9 uS
>  iov_kunit_benchmark_bvec: avg 3244 uS, stddev 153 uS
>  iov_kunit_benchmark_bvec_split: avg 3397 uS, stddev 16 uS
>  iov_kunit_benchmark_bvec_split: avg 3400 uS, stddev 16 uS
>  iov_kunit_benchmark_bvec_split: avg 3402 uS, stddev 34 uS
>  iov_kunit_benchmark_kvec: avg 2818 uS, stddev 550 uS
>  iov_kunit_benchmark_kvec: avg 2906 uS, stddev 21 uS
>  iov_kunit_benchmark_kvec: avg 2923 uS, stddev 1496 uS
>  iov_kunit_benchmark_xarray: avg 3564 uS, stddev 6 uS
>  iov_kunit_benchmark_xarray: avg 3573 uS, stddev 17 uS
>  iov_kunit_benchmark_xarray: avg 3575 uS, stddev 58 uS
>  iov_kunit_benchmark_xarray_to_bvec: avg 3929 uS, stddev 9 uS
>  iov_kunit_benchmark_xarray_to_bvec: avg 3930 uS, stddev 6 uS
>  iov_kunit_benchmark_xarray_to_bvec: avg 3930 uS, stddev 7 uS

Which looks like those added memcpy calls add a lot of overhead due to
the mitigations crap.

You could verify that if you boot a kernel with the oneliner but add
"mitigations=off" on the cmdline.

Or profile the workload and check whether the return thunks appear
higher in the profile... I'd say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
