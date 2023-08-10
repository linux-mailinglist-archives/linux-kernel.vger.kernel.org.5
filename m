Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DE67779C3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjHJNlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbjHJNlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:41:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331B0211D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 06:40:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD05964BCE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7887C433C8;
        Thu, 10 Aug 2023 13:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691674858;
        bh=Boi2EmBcvRwZaghQ8cLIVs6Ifp4ejTuFCmJKUXfXouA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZnttkvoQLkZnzcPaHupkf4DN/nU0OmLYBjgnnmxk8MeRiUV4/QD1z94LgCez09dFh
         53hUjN0w7MctVFCyRvXBKDQTz027zFzM+8J7IWqSgv90AoZY9UhiwQPxOi9Glt+B6k
         97TgYPyeiD/X1/JifPyWf5dDDNNFpEHvNiSi+4MPLjOTPvHffbnGgrj5N6A/0kGrND
         Ef7Im1h/TdiYDEFa3AMPAfKdrOr6+ha1X9sTXhHroerHlpdPanU5pZBDpy0c8oubiL
         n3oeX+KoTYIb2Hgpt+o11o4qu+uWX8HA/fQ6JHZJorT9BU3ZZm5AkPS57JMZy3noCg
         0gtcFJ6Go/7AA==
Date:   Thu, 10 Aug 2023 06:40:56 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: Hang when booting guest kernels compiled with clang after SRSO
 mitigations
Message-ID: <20230810134056.GA130730@dev-arch.thelio-3990X>
References: <20230810013334.GA5354@dev-arch.thelio-3990X>
 <20230810081038.GAZNSbftb6DOgg/U7e@fat_crate.local>
 <20230810090835.GBZNSpE6tCw+Ci+9yh@fat_crate.local>
 <20230810101649.GA1795474@dev-arch.thelio-3990X>
 <20230810125122.GIZNTdSuFvA3Cjfexq@fat_crate.local>
 <20230810132706.GA3805855@dev-arch.thelio-3990X>
 <20230810133216.GKZNTm4KpohRR4gVsT@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810133216.GKZNTm4KpohRR4gVsT@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 03:32:16PM +0200, Borislav Petkov wrote:
> On Thu, Aug 10, 2023 at 06:27:06AM -0700, Nathan Chancellor wrote:
> > But my host kernel was compiled using GCC 13.2.0 from kernel.org for the
> > sake of testing to see if the compiler used to build the host kernel had
> > an impact on the problem and it did not.
> 
> Ok, now I'm confused.

Heh, so was I at first when I was doing my regular build and boot tests
of -next :P

> Lemme see if I understand it correctly:
> 
> host kernel:
>  - SRSO enabled
>  - built with gcc
> 
> guest kernel:
>  - built with clang
>  - SRSO not necessary
> 
> Is that the scenario?

Yes, that should be correct.

Host kernel string:

  6.5.0-rc5-00039-g138bcddb86d8 (nathan@dev-arch.thelio-3990X) (x86_64-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41) #1 SMP PREEMPT_DYNAMIC Wed Aug  9 17:34:43 MST 2023

Guest kernel string:

  6.5.0-rc5 (nathan@dev-arch.thelio-3990X) (ClangBuiltLinux clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6), GNU ld (GNU Binutils) 2.41.50.20230809) #1 SMP PREEMPT_DYNAMIC Wed Aug  9 16:54:33 MST 2023

> Anything else?

Shouldn't be. As I noted in the original email, it seems something
specific to the safe-ret mitigation as I don't see the problem with
ibpb, that would be a good canary for making sure that you see the same
behavior.

Cheers,
Nathan
