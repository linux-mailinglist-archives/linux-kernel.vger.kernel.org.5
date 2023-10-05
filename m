Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E984C7BA0DD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240228AbjJEOsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbjJEOox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:44:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9CE6E91;
        Thu,  5 Oct 2023 07:22:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2146C43391;
        Thu,  5 Oct 2023 05:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696483656;
        bh=hXymtCmkQgS1mz4WN4LARQgIXsgfg8oCoZqTgfgSt/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BbpCpY2Q0zEwY41GucwBsBZTdMge6AGCY7bXU/clMyyCXKJTV0EDLKXZQhP6Gmvyb
         i7tzzZViGYUX1/BLXHrp9MgUNcssHkKZ+E07sMIo2XQd9Xhgj8wBFQLGyOjD2kEs17
         PxOhx0u+oKdQ8lrzOhlumXDQrrVIpZHitXF+j0a79GixClpVIz2eZl61qc1UDcG73I
         FDMmfOiG2H8IzEuKKw/M7PogaSgM8X2WZc5kjl+Dp1+hjjwCugO78vBqHSBJRgrtI8
         iiiR0aNTydrnms7VNPMV5M6X+tEx0k+2XJsejW9H5dww52kR9ESsW7JTvRKWQR81qv
         y9fkPnEwbon1w==
Date:   Thu, 5 Oct 2023 08:26:22 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "deller@gmx.de" <deller@gmx.de>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "bjorn@kernel.org" <bjorn@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
        "puranjay12@gmail.com" <puranjay12@gmail.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "will@kernel.org" <will@kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "song@kernel.org" <song@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 03/13] mm/execmem, arch: convert simple overrides of
 module_alloc to execmem
Message-ID: <20231005052622.GD3303@kernel.org>
References: <20230918072955.2507221-1-rppt@kernel.org>
 <20230918072955.2507221-4-rppt@kernel.org>
 <607927885bb8ca12d4cd5787f01207c256cc8798.camel@intel.com>
 <00277a3acb36d2309156264c7e8484071bc91614.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00277a3acb36d2309156264c7e8484071bc91614.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 03:39:26PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2023-10-03 at 17:29 -0700, Rick Edgecombe wrote:
> > It seems a bit weird to copy all of this. Is it trying to be faster
> > or
> > something?
> > 
> > Couldn't it just check r->start in execmem_text/data_alloc() path and
> > switch to EXECMEM_DEFAULT if needed then? The execmem_range_is_data()
> > part that comes later could be added to the logic there too. So this
> > seems like unnecessary complexity to me or I don't see the reason.
> 
> I guess this is a bad idea because if you have the full size array
> sitting around anyway you might as well use it and reduce the
> exec_mem_alloc() logic.

That's was the idea, indeed. :)

> Just looking at it from the x86 side (and
> similar) though, where there is actually only one execmem_range and it
> building this whole array with identical data and it seems weird.

Right, most architectures have only one range, but to support all variants
that we have, execmem has to maintain the whole array.

-- 
Sincerely yours,
Mike.
