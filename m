Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF7D7AE4B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbjIZEr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIZEr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:47:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2045FB8;
        Mon, 25 Sep 2023 21:47:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2282C433C8;
        Tue, 26 Sep 2023 04:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695703639;
        bh=AMClMXoW/SwY9XBZNSxgkg0YbclLYYx39/FwqmsD/P4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rkUPrDB0Sc8Aa13mYevbDJwYR3shwPRBPjo91IL8D7otbra6/ar4Agns76mXyoPXl
         eeLGRc3tuiE7WXxMCDYBWAQpvPaTcUqMM658ZkEJ/Mn3e0EzkKCRsBGeBPc1/c+lE0
         m3yODV1yBiXYk1aszHeoF3KWwDedd6Iw704oDQ8E=
Date:   Tue, 26 Sep 2023 06:47:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     Tony Nguyen <anthony.l.nguyen@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        jesse.brandeburg@intel.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] i40e: fix the wrong PTP frequency calculation
Message-ID: <2023092641-rind-seventh-c99b@gregkh>
References: <20230627022658.1876747-1-yajun.deng@linux.dev>
 <10269e86-ed8a-0b09-a39a-a5239a1ba744@intel.com>
 <72bfc00f-7c60-f027-61cb-03084021c218@linux.dev>
 <9e1b824f-04d3-4acb-66d3-a5f90afbad0e@intel.com>
 <ef08645e-9891-0d12-2c87-39ce0be52aee@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef08645e-9891-0d12-2c87-39ce0be52aee@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 09:54:29AM +0800, Yajun Deng wrote:
> 
> On 2023/9/26 07:59, Tony Nguyen wrote:
> > On 9/25/2023 12:55 AM, Yajun Deng wrote:
> > > 
> > > On 2023/6/28 04:20, Jacob Keller wrote:
> > > > 
> > > > On 6/26/2023 7:26 PM, Yajun Deng wrote:
> > > > > The new adjustment should be based on the base frequency, not the
> > > > > I40E_PTP_40GB_INCVAL in i40e_ptp_adjfine().
> > > > > 
> > > > > This issue was introduced in commit 3626a690b717 ("i40e: use
> > > > > mul_u64_u64_div_u64 for PTP frequency calculation"), and was fixed in
> > > > > commit 1060707e3809 ("ptp: introduce helpers to adjust by scaled
> > > > > parts per million"). However the latter is a new feature and
> > > > > hasn't been
> > > > > backported to the stable releases.
> > > > > 
> > > > > This issue affects both v6.0 and v6.1 versions, and the v6.1
> > > > > version is
> > > > > an LTS version.
> > > > > 
> > 
> > ...
> > 
> > > > 
> > > > Thanks for finding and fixing this mistake. I think its the
> > > > simplest fix
> > > > to get into the stable kernel that are broken, since taking the
> > > > adjust_by_scaled_ppm version would require additional patches.
> > > > 
> > > > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > > > 
> > > Kindly ping...
> > 
> > As this patch looks to be for stable, you need to follow the process for
> > that. I believe your situation would fall into option 3:
> > https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3
> > 
> > 
> Yes, it needs an upstream commit ID. But this patch didn't need to apply to
> the upstream.
> 
> As the commit of the patch, the issue was fixed in
> commit 1060707e3809 ("ptp: introduce helpers to adjust by scaled
> parts per million"). However the commit is a new feature and hasn't been
> backported to the stable releases.
> 
> Therefore, the patch does not have an upstream commit ID, and only needs to
> be applied to stable.

That wasn't very obvious to most of us, perhaps resend it and explicitly
ask for acks/reviews so it can be only applied to the 6.1.y tree?

thanks,

greg k-h
