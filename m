Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698D27C0333
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjJJSOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjJJSOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:14:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2D89D;
        Tue, 10 Oct 2023 11:14:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92F7C433C8;
        Tue, 10 Oct 2023 18:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696961678;
        bh=KsMN/5hC8tiFKEbhh6siqHXAzPCxbvRDAXznjfMpuLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LshSLjQomnvT1Gw0v/OZ1rNAKVF5YNYOxewQLOwOBt81KIv0BXN6sDFR61hcwzvm2
         AseseFCYmvHw6KIcFxGwKuXW8nVN6lSAmfkLbBcZKb6bKFYRcaSrUl61dBtxdp3utG
         AOqTNC4VJorvcSZw8Bb8QhrNs5O7XHBpmxzyx9uKNCPrWNrErW0KqpPavNI/E/UWnV
         Ny/RqOitm3jyAefY7fzKfDGKVVKakbluXaOqnku38hW9r5pOD6lGkcnmNfAnNi+oAK
         3fmRFxZELsaEf5zC44oUK/z09ho/RGVKRxfsNFcaTFpnbZvIm5lkYOCBLv1Sp3iEX8
         KuLvW5K9JpEDg==
Date:   Tue, 10 Oct 2023 19:14:34 +0100
From:   Will Deacon <will@kernel.org>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the arm-perf tree
Message-ID: <20231010181434.GA10072@willie-the-truck>
References: <20231010095601.1443903c@canb.auug.org.au>
 <98ffbcf6-a646-ac2-5785-f78644f7cbe@os.amperecomputing.com>
 <20231010175013.GA10036@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010175013.GA10036@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 06:50:13PM +0100, Will Deacon wrote:
> On Mon, Oct 09, 2023 at 10:45:18PM -0700, Ilkka Koskinen wrote:
> > On Mon, 9 Oct 2023, Stephen Rothwell wrote:
> > > After merging the arm-perf tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > > 
> > > drivers/perf/arm_cspmu/ampere_cspmu.c: In function 'ampere_cspmu_set_ev_filter':
> > > drivers/perf/arm_cspmu/ampere_cspmu.c:164:9: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]
> > >  164 |         writel(threshold, cspmu->base0 + PMAUXR0);
> > >      |         ^~~~~~
> > > cc1: all warnings being treated as errors
> > > 
> > > Caused by commit
> > > 
> > >  290a9c0e55f8 ("perf: arm_cspmu: ampere_cspmu: Add support for Ampere SoC PMU")
> > > 
> > > I have used the arm-perf tree from next-20231009 for today.
> > 
> > Thanks for catching the bug! It doesn't seem to happen on arm64 build but I
> > can reproduce it on x86_64 build indeed.
> > 
> > 
> > Will, it seems that "#include <linux/io.h>" is missing from ampere_cspmu.c.
> > After that also x86_64 build goes through. How would you like to get the bug
> > fixed? Shall I submit a new version of the patch, and you would replace the
> > old patch with the new one or is it better to
> > create a completely new patch that only adds the missing include line?
> 
> If it's just a missing include, I can chuck a patch on top to fix it myself.
> I'll double-check it resolves the problem and then update the branch.

In the end I just fixed up your commit, as it was still on the HEAD of the
branch. Update now pushed out!

Cheers,

Will
