Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD8C777980
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbjHJNWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbjHJNWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:22:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3281703
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 06:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i4FMwsUvfDztI8LkwgS4Ts6Gdm2vgRD/SJxoeyURwJQ=; b=gvSdnVL9S/KRitPL6WAqsMUqla
        POmvwMHORn4Z9Faj4DLE80sMIAv2pthZ9T31Ve6OiDgmpxrTH2+9dVj5bXl+oAO9OMWpx6/HBcJTg
        1PgzjTApnrniF07pAWLfS4MQXZtghdKk2GoiDsOVd//IqF22NDjvM3ZH+Dlu+K12W/SYmLnlLgqkT
        q8cqwWKB+rgdx9LiCPIbFKLZI730HLA4gDQcEFE4f2xYOwZ/RdWRUy9lxxbaFRtMdzgyON6xV/f0L
        WDjqKyqcRcDTr3b9j3heGNAmScx1JPU+3373Wjm/aSMFSANCV/aTKjjyeQGZo+pOrVwJt997EQ8p/
        oyWqWeHQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qU5cM-00Cizu-74; Thu, 10 Aug 2023 13:22:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CE03430003A;
        Thu, 10 Aug 2023 15:22:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B057F2023CC2D; Thu, 10 Aug 2023 15:22:21 +0200 (CEST)
Date:   Thu, 10 Aug 2023 15:22:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 02/17] x86/cpu: Clean up SRSO return thunk mess
Message-ID: <20230810132221.GB212435@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.543939260@infradead.org>
 <20230810115148.GEZNTPVLBmPL6uz4Af@fat_crate.local>
 <20230810123756.GY212435@hirez.programming.kicks-ass.net>
 <20230810125631.GJZNTef8zQWjoA9KYB@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810125631.GJZNTef8zQWjoA9KYB@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 02:56:31PM +0200, Borislav Petkov wrote:

> > Then both srso options use RSB/RAP stuffing to force a mispredict there.
> 
> They cause the RETs to mispredict - no stuffing. That's the add $8,
> %rsp in the zen3/4 case which causes the RET to mispredict. There's no
> doing a bunch of CALLs to stuff something.

This is what is called RSB stuffing, we've been doing it for ages on the
Intel side, and code in nospec-branch.h has a number of variants of
this.

	CALL	srso_safe_ret	// push addr of UD2 into RSB -- aka 'stuff'
	UD2
srso_safe_ret:
	ADD $8, %RSP		// skip over the return to UD2
	RET			// pop RSB, speculate into UD2, miss like a beast


Now compare to __FILL_ONE_RETURN, which has the comment 'Stuff a single
RSB slot.' That expands to:

	call	772f
	int3
772:	add	$8, %rsp
	lfence

Which is the same sequence and causes the next RET to speculate into
that int3.


So RSB stuffing is sticking addresses to traps in the RSB so that
subsequent predictions go into said traps instead of potentially user
controlled targets.

