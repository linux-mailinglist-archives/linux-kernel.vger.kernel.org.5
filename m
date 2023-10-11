Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DE47C601F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376452AbjJKWDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjJKWD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:03:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FFC9E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:03:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEF4C433C8;
        Wed, 11 Oct 2023 22:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697061807;
        bh=/hznBHvaUailZGyU5wtIgOtLweBQ29rbC2f5ZoiDKTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FqampMHbpQ33BAMOzYpBW51gp/PIUf5Gcc7ngYMkIs52rwn5Rc0PKpDzoMqa8QOlt
         dfkJ8HdBB34eItFhMC49ZoRmOSQg4OzNNyFjFpes1AF6VqDS9Nr0KsQ21Ub47YRjIA
         Uvtd/j+DybifZp8YnJ/eLO2lHX0PhqPtjJnz3R5Zj5zBCUrWQi2stzz5og+yBXPrkx
         AZfkUElJyt59z4NTj6+ZRTsLwCZdWefiBhOtJJK7JdpljTMj0PrAwiuQr4R9RytKQX
         xW06ok/tg3uJcCsTziucB1/cPwAOzvKG2IBkPuHWVcp+wFCJo/i4S8NBVjwQV+779a
         11mmgCOmEfHDQ==
Date:   Wed, 11 Oct 2023 15:03:25 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Breno Leitao <leitao@debian.org>, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/bugs: Add a separate config for each mitigation
Message-ID: <20231011220325.5uje4xnfxuccumm7@treble>
References: <20231010103028.4192223-1-leitao@debian.org>
 <20231011044252.42bplzjsam3qsasz@treble>
 <20231011190317.GDZSbxdd5TuCIp5+JN@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231011190317.GDZSbxdd5TuCIp5+JN@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 09:03:17PM +0200, Borislav Petkov wrote:
> On Tue, Oct 10, 2023 at 09:42:52PM -0700, Josh Poimboeuf wrote:
> >   MITIGATION_PAGE_TABLE_ISOLATION
> >   MITIGATION_RETPOLINE
> >   MITIGATION_UNRET_ENTRY
> >   MITIGATION_CALL_DEPTH_TRACKING
> >   MITIGATION_IBPB_ENTRY
> >   MITIGATION_IBRS_ENTRY
> >   MITIGATION_SRSO
> >   MITIGATION_SLS
> 
> The train has already left the station on those. The other mitigations
> don't have "MITIGAT*" at all in front of the name. I.e.:
> 
> config RETHUNK
> config CALL_DEPTH_TRACKING
> ...
> 
> and prepending them all with MITIGATION_ is going to cause too much
> senseless churn for a reason which I don't think is worth the effort.

I wouldn't call it senseless churn.  There are concrete benefits -- for
both users and developers -- of having all the mitigation config options
living in the same config namespace.

Sure, the change might cause pain for users who disable these options,
but do those users actually exist?

-- 
Josh
