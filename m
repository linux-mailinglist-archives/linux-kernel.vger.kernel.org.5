Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A2F79D9A6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbjILTgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjILTgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:36:52 -0400
Received: from out-221.mta1.migadu.com (out-221.mta1.migadu.com [IPv6:2001:41d0:203:375::dd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6731ACF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:36:48 -0700 (PDT)
Date:   Tue, 12 Sep 2023 15:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694547406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zNCblYMtY7zlJoqjRoQyxe09ubNPwpC6FeW7lybTK0g=;
        b=mO8fi2Va4OlZtR+qKA2rT/4aY4TZDjq2SLK3JtORAn6hMauL7cUy+9fsqraknGUMcpNA1m
        sWcdhz/fzQNLRaRovoW8Cx4KjmS2fqjpWHzxsPBlbsLuwKEXHmm8BqGevTm/Wr58IchTdy
        a41EuDjn7pHlwhmnLBMXahy4vZjWbho=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     bfoster@redhat.com, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH 0/7] bcachefs compiler warning fixes for 32-bit
Message-ID: <20230912193642.sdlwon4jta4ob5ac@moria.home.lan>
References: <20230912-bcachefs-warning-fixes-v1-0-a1cc83a38836@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912-bcachefs-warning-fixes-v1-0-a1cc83a38836@kernel.org>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:15:37PM -0700, Nathan Chancellor wrote:
> Hi all,
> 
> This is a series of fixes for warnings that I now see from bcachefs when
> building my test matrix with LLVM in -next, mostly from 32-bit
> architectures. Most of the patches should be uncontroversial; the
> min_t/max_t changes are probably the worst ones.

Those patches all look fine, thanks

> I still see several instances of -Wframe-larger-than when building for
> 32-bit ARM (I am sure they will show up on other 32-bit architectures as
> well), which I am not entirely sure how to tackle. It looks like the
> majority of the instances are just due to large structures on the stack
> in combination with some inlining resulting in some spills, so it seems
> like moving to a heap allocation for some of those would the right fix
> but I know some maintainers would rather fix them in their own way,
> hence just the report.

I just started seeing these again as well. The biggest single object
that most of them have on their stack is btree_trans, but initializing
that has to do a heap allocation for the btree_paths array - so we might
as well switch to heap allocating the entire thing.

That will help.
