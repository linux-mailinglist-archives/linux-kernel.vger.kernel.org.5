Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6974A777C0E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbjHJPXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjHJPXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:23:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4D42690
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1kq+kjwRymoymSvio1A+yye3+OK7RscR7eu3mLRzrww=; b=AxueBSIYHzl8ZSqTSxligp9jHn
        puhXNc2IdbtQb1CipAqJ0Xy+0ZW6MToARw9JycZKHwlUxyh2aUkZMPGLuXXTjjhf1lORPURhOBJjh
        VH4IYgWkexzz0MCzpHWWWAqRbKLL+BJFLE3gNfc5PEaXw/9Zg88m8aXzCjioA6zlxXj9tQDVgejul
        0hW6KYORAs543NJ4SNYCft8M0ry7yDBkEilEyQT6fd27Ks8UoJ8r0XiLO/cNwibPHM1qHV1G/sjTj
        ITqhqrksYemEd1gv6VL+87196s0dt0VqNGYKmZMnXpjKu4KV6+ZJWvYFJiwePTXuwaB4na4p2C2pS
        u7x2RoLg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qU7Um-006aC6-0m;
        Thu, 10 Aug 2023 15:22:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9EDBC30020B;
        Thu, 10 Aug 2023 17:22:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7AA3F202C01E2; Thu, 10 Aug 2023 17:22:39 +0200 (CEST)
Date:   Thu, 10 Aug 2023 17:22:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 04/17] objtool/x86: Fix SRSO mess
Message-ID: <20230810152239.GC212435@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.715361518@infradead.org>
 <20230810120615.GGZNTSt49g/2YCTGYI@fat_crate.local>
 <20230810124859.GZ212435@hirez.programming.kicks-ass.net>
 <20230810125005.GC220434@hirez.programming.kicks-ass.net>
 <20230810150201.GMZNT76W2EFGNsOV1R@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810150201.GMZNT76W2EFGNsOV1R@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 05:02:01PM +0200, Borislav Petkov wrote:
> On Thu, Aug 10, 2023 at 02:50:05PM +0200, Peter Zijlstra wrote:
> > Notably 'call RET' is not what this is about. I hope the below
> > clarifies.
> 
> Yah, it does, now that you've taken the time to explain it. Looking at
> the commit which added it:
> 
>   15e67227c49a ("x86: Undo return-thunk damage")
> 
> it doesn't even begin to explain it. Can you please put the gist of what
> you've explained here in a comment over patch_return() as it is not
> really obvious - at least to me it isn't - what the rules for the thunks
> are.
> 
> I mean, they're clear now but I think we should hold them down
> explicitly. Especially with all the crazy patching we're doing now.

Will update.
