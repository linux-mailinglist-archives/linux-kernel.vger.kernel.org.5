Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B7377B727
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjHNK5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjHNK5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:57:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F23195
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hQX5RifFZ0HXPMgoLU2kmdpF1Nywn2pwg80ZuekRJEs=; b=B4yYf7xyDUdIVTPhZ+VtdS2h0t
        JA3ICpL1OhGiU0ruWTrWHY584Cq0dWNGcBkmP0Nv23MxNy8N7xZHASvp7zKNUx6IaO962udaAVjcp
        YP+OdfAXqKphlp4bjDjRbkdgrgIz6GAyuHeExnDu+T/2412dZrBKPVhbAcwBXU3Dk4SPgz2AC8Vbw
        wtc804WvmTlcPcTgVRERK0GgP9RaPdy7hf66BrVVXdnZAkwUWOlnrXwKyoY69hdlIW4GR+4kzNkPF
        htOIkYwYWkDG9LofuuZCTs67yh8h3k2X2oSXGMiVDzdHZ3KzcozEmgSQeVylxD8Naizs0Gl1AX56v
        qWxnaVkg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qVVFV-00AX2Y-1s;
        Mon, 14 Aug 2023 10:56:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 35CBF30020B;
        Mon, 14 Aug 2023 12:56:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 115ED21C0E9DF; Mon, 14 Aug 2023 12:56:37 +0200 (CEST)
Date:   Mon, 14 Aug 2023 12:56:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 06/17] x86/cpu: Add SRSO untrain to retbleed=
Message-ID: <20230814105636.GE776869@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.850338672@infradead.org>
 <20230810154404.GOZNUFxHxLIMth6j9s@fat_crate.local>
 <20230810161003.i65d37ozlt3d5xse@treble>
 <20230812112404.GB749618@hirez.programming.kicks-ass.net>
 <20230812121034.GDZNd2umHEqcQNaFbJ@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812121034.GDZNd2umHEqcQNaFbJ@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 02:10:34PM +0200, Borislav Petkov wrote:
> On Sat, Aug 12, 2023 at 01:24:04PM +0200, Peter Zijlstra wrote:
> > That very experience wants me to avoid doing it again :-/ But you all
> > really want to keep the parameter, can we at least rename it something
> > you can remember how to type, like 'srso=' instead of this horrific
> > 'spec_rstack_overflow=' thing?
> 
> I'm all for short'n'sweet but last time I did that, Linus said we should
> have option names which aren't abbreviations which don't mean anything.

So:

 1) do you guys really want to keep this extra argument?

 2) if so, can we *PLEASE* rename it, because the current naming *SUCKS*.


I really don't see the need for an extra feature, we can trivially fold
the whole thing into retbleed, that's already 2 issues, might as well
make it 3 :-)


If we're going to rename, how about we simply call it 'inception' then
we haz both 'retbleed=' and 'inception=' and we're consistent here. Then
I'll make a compromise and do:

 's/zen_\(untrain_ret\|return_thunk\)/btc_\1/g'

so that the actual mitigations have the official amd name on them --
however much I disagree with calling this branch-type-confusion.
