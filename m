Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4B27C0304
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjJJRwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjJJRwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:52:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA0A94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CDFnZc21Ozvf7XO4JeN+a4VGrAwW58tlsLbHLVG80K0=; b=VupZYlx2yVrvQieDO2CGUkUpWw
        IZFTPEzjZkVZiRWtl4V+gLlfAMAnU9oard2MPfFOQ9wRbqLHbvt0eDQVIzBX05THcy+DmBeoOgMBT
        X3VRNWDfbHact6Meorvsj0CXSpoNO5XaX8pgd8gKkZbcF6AdEF+HQ+zhkn6xckPQZz7JjRlQtEwjd
        d+ZQe8ppLuVxoYayAyOXOMQNGUv5JgD4doypWy28Bz/XAXoGUq9ExHE7BFJOVBBEFTAX3Qz/D2V80
        OrqImwp5yvqexxjmP6iB0MhqGnBnKjmNSY5XoSKB4OJDEOvb5U9dOLsr4dOXN7FXbxtCWlPTgEhNE
        ATiyo3Kw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqGtr-005zJx-Ql; Tue, 10 Oct 2023 17:52:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7FC20300392; Tue, 10 Oct 2023 19:52:07 +0200 (CEST)
Date:   Tue, 10 Oct 2023 19:52:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Kaplan <david.kaplan@amd.com>
Cc:     x86@kernel.org, luto@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Ensure default return thunk isn't used at runtime
Message-ID: <20231010175207.GH14330@noisy.programming.kicks-ass.net>
References: <20231010171020.462211-1-david.kaplan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010171020.462211-1-david.kaplan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 12:10:17PM -0500, David Kaplan wrote:

> David Kaplan (3):
>   Revert "x86/retpoline: Remove .text..__x86.return_thunk section"
>   x86/vdso: Run objtool on vdso32-setup
>   x86/retpoline: Ensure default return thunk isn't used at runtime
> 
>  arch/x86/entry/vdso/Makefile  |  3 ++-
>  arch/x86/kernel/vmlinux.lds.S |  3 +++
>  arch/x86/lib/retpoline.S      | 10 +++++++---
>  3 files changed, 12 insertions(+), 4 deletions(-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

That said, I'm afraid we might have broken rethunk for i386 somewhere
along the SRSO series.

I suspect the easiest fix is to make CONFIG_RETHUNK hard depend on
x86_64 or something.
