Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3F37D45DF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 05:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjJXDWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 23:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJXDWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 23:22:07 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C479B8F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 20:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=atLd/XsfBtuODVrf8BwbGbwqfzpm/EVtiwnpkWQfSN8=; b=nGW0wjMbs/ltjp1PlmIBLFfbxd
        RPFVi8eufEe/bnRl3wMPlvXpa5ZHKERLC9pC8DoXBS0udHvMUS47WYdBWi7Xf9/hyuDuYAMnS0rrX
        nEYh2ma+NUwJsUw+bIuBLi85UlCaS8ODG6w4+Td1z8Fwry8vcoYIsClWOFoKLLLagYPBeWMsze9pi
        qMBVq+YNWchZlSnJ1HL6HMZa0QazcZ8W+u4T2uR7F7e2uZSP5oT6qEkEEFwD+QyehazW+rQ3UrCK5
        a1F5JE/lOZvVCruszSJV7iHTEoa8COXw8HBJ7Wz8JYhGg8815sUA5JsJOAQdQCXq3JAt0GA6WZjwq
        hgqnVqJA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qv7dg-004jND-2X;
        Tue, 24 Oct 2023 02:59:28 +0000
Date:   Tue, 24 Oct 2023 03:59:28 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Laight <David.Laight@aculab.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        gus Gusenleitner Klaus <gus@keba.com>,
        Al Viro <viro@ftp.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: AW: [PATCH] amd64: Fix csum_partial_copy_generic()
Message-ID: <20231024025928.GD800259@ZenIV>
References: <20231019050250.GV800259@ZenIV>
 <20231019061427.GW800259@ZenIV>
 <20231019063925.GX800259@ZenIV>
 <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
 <20231019080615.GY800259@ZenIV>
 <20231021071525.GA789610@ZenIV>
 <20231021222203.GA800259@ZenIV>
 <5487af5c8c184ac896af2d0b32b3ff42@AcuMS.aculab.com>
 <20231022111153.GB800259@ZenIV>
 <2a4555bf640e4bc4b76e1ae14e5cb5e1@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a4555bf640e4bc4b76e1ae14e5cb5e1@AcuMS.aculab.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 08:16:59AM +0000, David Laight wrote:
> From: Al Viro
> > Sent: 22 October 2023 12:12
> > 
> > On Sun, Oct 22, 2023 at 11:03:39AM +0000, David Laight wrote:
> > 
> > > > +			return -1;
> > >
> > > If you are going to return -1 the return type should be signed.
> > 
> > It's a perfectly valid C to have return -1 in a function that
> > returns unsigned long long (or any other unsigned type, really)...
> 
> It is also valid C to return a pointer :-)

No, it is not.  Conversions done for return are the same as for
assignments; in particular, conversion from any integer type to
any unsigned integer type is done by taking the value modulo
the range of target type.  Conversion from pointer to an integer,
OTOH, is a constraint violation.

> I also suspect that sparse will complain massively and
> require a lot of the horrid (__force) casts.
> (They should really be a function so that they are completely
> ignored by the compiler - unless the compiler needs a cast as well.)

Why would sparse "complain massively" about operations with u64?
I realize that you've slapped "I suspect" in front of that
particular load of fertilizer, but... seriously, your output is
very hard to distinguish from ChatGPT drivel ;-/
