Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B62B7CF037
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjJSGjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjJSGjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:39:31 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D5011B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cvEk/RfvEiDyndE/vC1vKef1YvAAxcWQ14qqGw1SuTA=; b=VzAEWHQCiZe/JTmVVmaoPZTdv/
        xzFsTER2NV9lNK7TOmsIJGPPaN5UxEmfEqGVs1RfvxU1YdkR4Ur43o9xSQn3JhUHLZpK4n/6sK3CE
        S3XOS5m/H4RUbhdN+mScBH4sKTWuKoZklJDhpGqmHWAE6Xb31ON8F5sZKjs0XJKYdd9/1hy2OFeXN
        /GtX++uSsI/O5f0T065vXgKCO6Ye6vkvgejoZ9AHXCNqc+JVKXgcFNH6/OnwF6su5heTPPN/nl8TP
        Yit3e0eP9ZpFb44Tu4EKIx5zjmFc10KIPikEknhKWIXKy+6qjCnGeRPWtqSET32JTFMAsqVNgtxGp
        f+fGo+JQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qtMgn-002fgg-1u;
        Thu, 19 Oct 2023 06:39:25 +0000
Date:   Thu, 19 Oct 2023 07:39:25 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     gus Gusenleitner Klaus <gus@keba.com>
Cc:     Al Viro <viro@ftp.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: AW: [PATCH] amd64: Fix csum_partial_copy_generic()
Message-ID: <20231019063925.GX800259@ZenIV>
References: <VI1PR0702MB3840EB26EF2A1A35BFEA53BFD9D5A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231018154205.GT800259@ZenIV>
 <VI1PR0702MB3840F2D594B9681BF2E0CD81D9D4A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231019050250.GV800259@ZenIV>
 <20231019061427.GW800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019061427.GW800259@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 07:14:27AM +0100, Al Viro wrote:
> On Thu, Oct 19, 2023 at 06:02:50AM +0100, Al Viro wrote:
> > On Thu, Oct 19, 2023 at 04:44:04AM +0000, gus Gusenleitner Klaus wrote:
> > > > On Wed, Oct 18, 2023 at 06:18:05AM +0000, gus Gusenleitner Klaus wrote:
> > > > > The checksum calculation is wrong in case of an source buffer
> > > > > containing zero bytes only. The expected return value is 0, the
> > > > > actual return value is 0xfffffff.
> > > > 
> > > > Expected where?  The actual checksum is defined modulo 0xffff, so
> > > > 0 and 0xffffffff represent the same final value.
> > > > 
> > > > The only twist is that in some situations we internally use 0 for
> > > > "not calculated yet".
> > > > 
> > > > > This problem occurs when a ICMP echo reply is sent that has set
> > > > > zero identifier, sequence number and data.
> > > > 
> > > > What problem?  Could you please either point to specific RFC or
> > > > show that packets are rejected by some existing system, or...?
> > > 
> > > Here's our situation:
> > > Our device gets pinged by a third party manufacturer robot controller.
> > > We have updated the kernel in our device to 5.15 from 4.9, the robot
> > > controller is kept unchanged. At 4.9, our device's ping reply is accepted
> > > by the robot controller, at 5.15 it's not.
> > > 
> > > Wireshark shows a bad checksum warning:
> > >  'Checksum: 0x0000 incorrect, should be 0xffff' 
> > > 
> > 
> > Lovely.  I think I see what's going on, give me a few to think about it...
> 
> The real source of trouble was switching csum_and_copy_{to,from}_user()
> to reporting faults as 0.  And yes, it's broken.  Bugger...

I really hate the idea of bringing back the old horrors and splitting
_nocheck and _user variants ;-/  Especially since we don't care (and
never had, really) where in the EFAULT case had the damn thing faulted
and what csum had it managed to accumulate prior to that point.

The only callers are csum_and_copy_..._iter() and they discard
the entire iovec segment if fault happens; all users of
csum_and_copy_from_iter() are actually discarding everything in
that case (reverting iterator to the point where it had been
prior to the call).

And they are all thread-synchronous.  Hell, it's tempting to steal
a thread flag, clear it before the call of those suckers, set it in
exception handlers in those and check in csum_and_copy_..._iter()
after the call...  Let me see how ugly something of that sort would
be...
