Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018A77BF9A3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjJJLYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjJJLYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:24:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD4E94;
        Tue, 10 Oct 2023 04:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RHIty1r8jlpg4mbxrTX99MguDdmyNDYNfk7Z509OtEw=; b=AK/yhtwqX3jRAdiHHdyk4fqwYm
        4LtzZ1cDNS8zXq+n2DDkrXyrY1swTguaEC1XcnfP3Xo7lqcvYvpsYay9lVCPGct8rJfX2bIt9QxS3
        9eyjtchnrilqJ2j1VmM/XYgVJ04vaNaRaOLUpz6EWadnqkeEz1alsuYxGnioBz+i65//wBOp1Jukf
        /JOyO36Tgak878AK8KiYQOQmP1FyyYaP7sM8z9ixJaRuS/a9rqnuoaM6uwpPGrI1U3Caz4llcugJc
        UlyVh8gop7AUFH3aCD64gvwZcMN5j/cENwAPLfUnoAK7BZOApLF9XJgkTraYp5l0bEfoItnprootj
        sFDJ0krA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqAqf-004JVi-Mh; Tue, 10 Oct 2023 11:24:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F185300392; Tue, 10 Oct 2023 13:24:25 +0200 (CEST)
Date:   Tue, 10 Oct 2023 13:24:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Fei Yang <fei.yang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/alternatives: Disable KASAN on text_poke_early() in
 apply_alternatives()
Message-ID: <20231010112425.GJ377@noisy.programming.kicks-ass.net>
References: <20231010053716.2481-1-kirill.shutemov@linux.intel.com>
 <20231010081938.GBZSUJGlSvEkFIDnES@fat_crate.local>
 <20231010101056.GF377@noisy.programming.kicks-ass.net>
 <20231010102537.qkrfcna2fwfkzgir@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010102537.qkrfcna2fwfkzgir@box.shutemov.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 01:25:37PM +0300, Kirill A. Shutemov wrote:

> > That said, I don't particularly like the patch, I think it should, at
> > the veyr least, cover all of apply_alternatives, not just
> > text_poke_early().
> 
> I can do this, if it is the only stopper.
> 
> Do you want it disabled on caller side or inside apply_alternatives()?

Inside probably, covering the whole for()-loop thingy. Ideally with a
comment explaining how KASAN doesn't like partial LA57 patching.
