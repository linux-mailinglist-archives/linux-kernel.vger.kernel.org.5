Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D069F7A17CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjIOHv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjIOHv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:51:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA96A1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZFwnsbKYl3NmgETwTRCgjJWOjPQCpSyxYv0AKkY25Tk=; b=q+v0MKGUeyvJ1iwyEqUMcYPhLs
        y5gpW9PY2dfP/8A3YxeYtmWMT7gw+l4dbPHeKdjQNqFVazezDONr4stQa/P0piFd15wXRdf5w9qV7
        Cj8LymEyhiX6isnlTnCYuBh/5fX4RRG6fyNkIk6C5N6XFVXJ4mS4oxENLz+aNjjZYhR5Qwret4t/6
        9IXqkmRk85zr2TpK1M6RiKuQ6OF7vew+N7dFtkvpNHxQIzX56ApyUq+ISV/rypixhBL25dAUAcx7G
        jN5CSX0YlWE/Yd+rn+YDL2hjouYP0uQgCvNGxd4OEKzMAWrNaeLbwcdty4YE0CegpWIyBgh6+UEA0
        LaqO3bQw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qh3bV-008p5A-18;
        Fri, 15 Sep 2023 07:51:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 738B93003F2; Fri, 15 Sep 2023 09:51:06 +0200 (CEST)
Date:   Fri, 15 Sep 2023 09:51:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 10/11] x86/alternatives: Simplify ALTERNATIVE_n()
Message-ID: <20230915075106.GA6787@noisy.programming.kicks-ass.net>
References: <20230907153036.GBZPnsnNreLCyGpJFn@fat_crate.local>
 <20230909075009.GAZPwjsYZ4sSALN/5+@fat_crate.local>
 <20230909092554.GC2771@noisy.programming.kicks-ass.net>
 <20230910144227.GAZP3V0/mQ73C2hx/l@fat_crate.local>
 <20230912092709.GE35261@noisy.programming.kicks-ass.net>
 <20230912094441.GA13926@noisy.programming.kicks-ass.net>
 <20230913043738.GCZQE8kuw8p3WsnCXd@fat_crate.local>
 <20230913084658.GA692@noisy.programming.kicks-ass.net>
 <20230913143847.GBZQHJd24PX0l0gLG+@fat_crate.local>
 <20230915074647.GA6721@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915074647.GA6721@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 09:46:47AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 13, 2023 at 04:38:47PM +0200, Borislav Petkov wrote:
> 
> >   [ bp: Make labels unique and thus all sizing use unambiguous labels.
> >     Add more info. ]
> 
> > +#define __ALTERNATIVE(oldinstr, newinstr, ft_flags, n)			\
> > +	OLDINSTR(oldinstr, n)						\
> > +	ALTINSTR_ENTRY(ft_flags)					\
> > +	ALTINSTR_REPLACEMENT(newinstr)
> 
> > +#define ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)	\
> > +	__ALTERNATIVE(ALTERNATIVE(oldinst, newinst1, flag1),		\
> > +		    newinst2, flag2, 1)
> 
> > +#define ALTERNATIVE_3(oldinst, newinst1, flag1, newinst2, flag2,	\
> > +		      newinst3, flag3)					\
> > +	__ALTERNATIVE(ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2), \
> > +		    newinst3, flag3, 2)
> 
> 
> So I see what you did with that @n argument, but urgh, do we really need
> this? I mean, it just makes things harder to use and it doesn't actually
> fix anything.. :/

That is, if we can magic this using __COUNTER__ without a user interface
penalty, then sure. But the last time I tried that I failed utterly and
ended up with labels like:

  .Lalt_old___COUNTER__:

no matter how many layers of CPP macro eval I stuck in it. So clearly I
wasn't having a good day ....
