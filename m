Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C23779971D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 11:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344510AbjIIJmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 05:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344515AbjIIJmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 05:42:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7794CE7F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 02:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TvtlqBFK6HcBOTsw+bIuWcPT6nLKb6o3jkrG2eUxQhY=; b=PWsGMQVbuAZyfU+trIHHpGJj4k
        ZISvbVfJZt+sYGpTQGRcSuq4lyxJYFNdNvpLBvOYsJv6WTtxuaKamCLMkuC23Y6V/h4o1oyTW+bPI
        St9LFadVxJJ+HQeewMdVoaGeX24wT6idjwCVS1o8/lSWLmlv6ZYV39yyMVVg2GWlaST40J8BIRju7
        1zvUEgcxqZwrmIPcQOVehmj/KL+NIEHH+wIC0jNDW17p0/ODqsCB4y3XyATXrP7+I6V5+EvBAypCh
        nspMihTnZVhf4jSWfXNXtLDtjJBc8RdWX6WATN5Q4Omyi1OBrqJDw/wIRpItZ33qotv289MMvRr28
        oouN41GA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qeuTy-003Cw0-0h;
        Sat, 09 Sep 2023 09:42:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4CB65300348; Sat,  9 Sep 2023 11:42:27 +0200 (CEST)
Date:   Sat, 9 Sep 2023 11:42:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 10/11] x86/alternatives: Simplify ALTERNATIVE_n()
Message-ID: <20230909094227.GA16786@noisy.programming.kicks-ass.net>
References: <20230814114426.057251214@infradead.org>
 <20230814121149.176244760@infradead.org>
 <20230907083158.GBZPmKfjarnaQk1ofB@fat_crate.local>
 <20230907110917.GA10955@noisy.programming.kicks-ass.net>
 <20230907150632.GAZPnm+Ly+Vyt8VPYr@fat_crate.local>
 <20230907153036.GBZPnsnNreLCyGpJFn@fat_crate.local>
 <20230909075009.GAZPwjsYZ4sSALN/5+@fat_crate.local>
 <20230909092554.GC2771@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230909092554.GC2771@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 11:25:54AM +0200, Peter Zijlstra wrote:
> This becomes more of a problem with your example above where the
> respective lengths are 0, 5, 16. In that case, when you patch 5, you'll
> leave 11 single nops in there.
> 
> So what that code you deleted does is look for all alternatives that
> start at the same point and computes the max replacementlen, because
> that is the amount of bytes in the source text that has been reserved
> for this alternative.
> 
> That is not optional.

Note that the original alternatives did this with the alt_max_*() macro
at build time.
