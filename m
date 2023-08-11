Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B728E7787F9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjHKHQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjHKHQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:16:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1484359F;
        Fri, 11 Aug 2023 00:15:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A1AC6332E;
        Fri, 11 Aug 2023 07:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C85CC433C8;
        Fri, 11 Aug 2023 07:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691738153;
        bh=XANmocGoF5MvmXVwlaZrC+0leVQYZlMfoH2RyQXKu94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z0nc9A7bcksg22MKCjzDkiOdsVEOWIi0JJY01kJ6UlCULXi6/3sk1ok2afyewUied
         RJuuh+vJzVOhRHHDnEzvzN1p40QG6VAiiqCfOjvD6u2dL2BH4g35eV+gYBjFk6JtSl
         SWdeNEPdt70XZizIomcMFmeINxK+grfjPJn+qy7c=
Date:   Fri, 11 Aug 2023 09:15:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kurt Garloff <kurt@garloff.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: Drop 0fc6fea41c71 ("drm/i915: Disable DC states for all
 commits") from the 6.0.y series?
Message-ID: <2023081117-darling-ruined-33b1@gregkh>
References: <f0870e8f-0c66-57fd-f95d-18d014a11939@leemhuis.info>
 <2023080930-overturn-duo-17de@gregkh>
 <a10b911c-dc39-2924-26be-64c7964456ae@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a10b911c-dc39-2924-26be-64c7964456ae@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 01:31:00PM +0200, Thorsten Leemhuis wrote:
> On 09.08.23 11:15, Greg KH wrote:
> > On Mon, Aug 07, 2023 at 12:52:03PM +0200, Thorsten Leemhuis wrote:
> >> Hi Greg! Months ago you picked up mainline commit a2b6e99d8a6
> >> ("drm/i915: Disable DC states for all commits") for the 6.1.23 release
> >> as commit 0fc6fea41c71. It causes issues vor a few people (at least
> >> three, two of which are CCed) -- apparently because it depends on some
> >> change that wasn't picked up for 6.1.y.
> 
> Fun fact: here I had an off-by-one error I noticed and fixed, but...
> 
> >> This is known for a while now,
> >> but nobody has yet found which change that is (Al found something that
> >> worked for him, but that didn't work for others). For the whole story
> >> skim this ticket:
> >>
> >> https://gitlab.freedesktop.org/drm/intel/-/issues/8419
> >>
> >> I wonder if it might be better if you revert that commit for 6.0.y; I
> >> asked already in the ticket if this is likely to cause regressions for
> >> users of 6.0.y,
> 
> ...here I did not. :-/ Sorry.
> 
> >> but got no answer from the i915 devs (or did I miss
> >> something?). :-/
> > 
> > Now reverted (note, 6.0.y is long dead, I reverted this for 6.1.y)
> 
> Thx, but FWIW, seems my timing was bad. I had waited weeks before
> escalating this to you (which looking back now is something I maybe
> should have done earlier -- but first it looked like it was just one
> person/machine affected by this problem). But it seems soon after I
> brought this to your attention a solution came up, as a fix was posted
> and confirmed working by one of the reporters -- and the developer wants
> to post a backport for stable. For details see
> https://gitlab.freedesktop.org/drm/intel/-/issues/8419#note_2035731
> 
> Not sure what's the right thing to do at this point for 6.1.y --
> dropping the revert maybe before you do the release? You will know best
> anyway.

Let me keep the revert, that will fix the issue now.  If upstream wants
to solve this in a different/better way, we can add both patches at once
to prevent any systems from being broken.

thanks,

greg k-h
