Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7288D775E48
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjHIL6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHIL6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:58:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982301705
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 04:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=eC5yEoncpeJzLB6mZHh/IwgDr8tRdWlT0gUX8xRHqHs=; b=UOIiGz0o1XWWbd7Mqcqn0MSvo4
        Vag/LTPsznQWOfEy974XvovjDjjlY9KrpFkKEBFSebzjl7SsU0BZ0hm3rVgIdTPhKJQ71aALpqHDY
        vRUmG8AqeQGSsjkpbUBuq14BOtg3mLQR25ToDAOUUE/WHbsX9LxTJx1YosW3XEz61qV5Nmzn3gVyg
        Pb12fd0k48k3uWhqsQe6om3dzY1qscHkmaC29/ZU0/eaJZwDCFOOYB2fe5hzVmRxUcq7znyidxl68
        wqknBMrchaYFHMkp4guJTb5WsCZDIWPg7P7L82enz+Bhyw8suAhF0Q+BJb6DwGRZgNiYcbEsYVRRu
        VusNgpeQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qThpe-005cXm-1p;
        Wed, 09 Aug 2023 11:58:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7F2D300235;
        Wed,  9 Aug 2023 13:58:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B7194206DF88B; Wed,  9 Aug 2023 13:58:29 +0200 (CEST)
Date:   Wed, 9 Aug 2023 13:58:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew.Cooper3@citrix.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 00/17] Fix up the recent SRSO patches
Message-ID: <20230809115829.GJ212435@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <341a47de-2c12-43a3-2d5d-d9727a1e7420@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <341a47de-2c12-43a3-2d5d-d9727a1e7420@citrix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 11:04:15AM +0100, Andrew.Cooper3@citrix.com wrote:
> On 09/08/2023 8:12 am, Peter Zijlstra wrote:
> > Since I wasn't invited to the party (even though I did retbleed), I get to
> > clean things up afterwards :/
> >
> > Anyway, this here overhauls the SRSO patches in a big way.
> >
> > I claim that AMD retbleed (also called Speculative-Type-Confusion
> 
> Branch Type Confusion.

Durr, I shoud've double checked, and yes, too damn many different things
and not enough sleep.

> >  -- not to be
> > confused with Intel retbleed, which is an entirely different bug) is
> > fundamentally the same as this SRSO -- which is also caused by STC. And the
> > mitigations are so similar they should all be controlled from a single spot and
> > not conflated like they are now.
> 
> BTC and SRSO are certainly related, but they're not the same.
> 
> With BTC, an attacker poisons a branch type prediction to say "that
> thing (which isn't actually a ret) is a ret".
> 
> With SRSO, an attacker leaves a poisoned infinite-call-loop prediction. 
> Later, a real function (that is architecturally correct execution and
> will retire) trips over the predicted infinite loop, which overflows the
> RSB/RAS/RAP replacing the correct prediction on the top with the
> attackers choice of value.
> 
> So while branch type confusion is used to poison the top-of-RSB value,
> the ret that actually goes wrong needs a correct type=ret prediction for
> the SRSO attack to succeed.

Yes, this is what I meant, and I clearly failed to express myself
better. The point was that branch-type-confusion is involved with both,
just in different ways.
