Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17DD779FBC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 13:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjHLLdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 07:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjHLLdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 07:33:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E9B9F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 04:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C3xuPJd5iuQ7ovj1aFr1TvDUg+phyDvi/hQsqH6lPYg=; b=SZfx9WR20FGehK89oS0NGK+UP6
        sHgoWYNMgIKZllhICsrsHRbk2PleuPaOUx4+aBx5SKQnzpqeqElGEgYqbvZvvUTOZobljYIq3Rmoc
        oEN973LFR0RaM+TWMIWT53xHQO07VfwSFHmrc+yEF/C77NwgjYYUZvCNy3rOTjE/8m0EdNmeWUj/y
        2/U+uN53gD4bYFzQd7+7v1VcZhLyItE+jWRN+F/i70fRySRP7jM4getvIoTqKHlPVtq4NtonXDw2F
        2UPCqQpD6QHjEE+M78NhoDSKBU+1n6WxFwCXcHuJCfgrtHqfhRTlY/4MktukgJ8Wv+0bShcK0FyKs
        joDTRZHg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUmrZ-008f5q-0D;
        Sat, 12 Aug 2023 11:32:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9E26130057E;
        Sat, 12 Aug 2023 13:32:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 843F420410DA2; Sat, 12 Aug 2023 13:32:56 +0200 (CEST)
Date:   Sat, 12 Aug 2023 13:32:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 06/17] x86/cpu: Add SRSO untrain to retbleed=
Message-ID: <20230812113256.GC749618@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.850338672@infradead.org>
 <20230810154404.GOZNUFxHxLIMth6j9s@fat_crate.local>
 <20230810161003.i65d37ozlt3d5xse@treble>
 <20230811102748.GEZNYNJEeDxTqcOLvj@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811102748.GEZNYNJEeDxTqcOLvj@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:27:48PM +0200, Borislav Petkov wrote:
> On Thu, Aug 10, 2023 at 12:10:03PM -0400, Josh Poimboeuf wrote:
> > I tend to agree that SRSO is a new issue and should have its own sysfs
> > and cmdline options (though a separate CONFIG option is overkill IMO).
> 
> Yeah, there's a patch floating around adding a config option for every
> mitigation. Apparently people want to build-time disable them all.

So I really hate that .Kconfig explosion, that's the very last thing we
need :-( More random options that can cause build time trouble.

I might see value in one knob that kills all speculation nonsense at
build time, but not one per mitigation, that's maddness.
