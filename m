Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF45779F93
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 13:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjHLLYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 07:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjHLLYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 07:24:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A2D110
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 04:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uRy5b2NDQ5YKh+tB78UZj7bxdV6CalOnVkbxdfzY2JU=; b=AiCIrL48rafub7NnMeQYmStmqP
        7aZf4f3ww+/XVQX6zSmeA+ujCLf+RlMHkLwJcW+LqOOT05naYe5oTxl6V4zpTj0hRcHWnTXAgNheN
        ECyug4DUXb8pWV4cQ3WNKQFryBjLXuSKCXx5DM9cEOwOF/WEOiRrDGpZ7f883bCVWKEBnrJ4neINO
        dvDqHkCMWXRP5Sv7tdpYKHqkvdzAyB0c083j3gyfLsnz5TlEpQMR8pg6aIsEH0mlHqYPz/iwqvdrj
        tg/U7C+Homybpsj5Ou4hVnrBdf2gLNgbDmiYH4FZHdifDha8fDDFs0/fSNIQ07jOcYWBcTPQeoIgh
        HVxlv6UA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUmiz-0078qN-MU; Sat, 12 Aug 2023 11:24:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D4BA730057E;
        Sat, 12 Aug 2023 13:24:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B791820410DA2; Sat, 12 Aug 2023 13:24:04 +0200 (CEST)
Date:   Sat, 12 Aug 2023 13:24:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 06/17] x86/cpu: Add SRSO untrain to retbleed=
Message-ID: <20230812112404.GB749618@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.850338672@infradead.org>
 <20230810154404.GOZNUFxHxLIMth6j9s@fat_crate.local>
 <20230810161003.i65d37ozlt3d5xse@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810161003.i65d37ozlt3d5xse@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:10:03PM -0400, Josh Poimboeuf wrote:
> On Thu, Aug 10, 2023 at 05:44:04PM +0200, Borislav Petkov wrote:
> > On Wed, Aug 09, 2023 at 09:12:24AM +0200, Peter Zijlstra wrote:
> > > Since it is now readily apparent that the two SRSO
> > > untrain_ret+return_thunk variants are exactly the same mechanism as
> > > the existing (retbleed) zen untrain_ret+return_thunk, add them to the
> > > existing retbleed options.
> > 
> > Except that Zen3/4 are not affected by retbleed, according to my current
> > state of information.
> > 
> > I don't like this lumping together of the issues even if their
> > mitigations are more or less similar.
> 
> I tend to agree that SRSO is a new issue and should have its own sysfs
> and cmdline options (though a separate CONFIG option is overkill IMO).
> 
> The mitigations are unfortunately intertwined, but we've been in that
> situation several times before (e.g., spectre_v2 + intel retbleed).

That very experience wants me to avoid doing it again :-/ But you all
really want to keep the parameter, can we at least rename it something
you can remember how to type, like 'srso=' instead of this horrific
'spec_rstack_overflow=' thing?
