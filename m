Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF81D7F4934
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjKVOpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjKVOo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:44:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B54419D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:44:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAC0C433C7;
        Wed, 22 Nov 2023 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700664295;
        bh=h5w3izkPOTDID1ezFWef52/xpayVyQG+sKxK2opBXic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tQN/ApdwId0YZXaPIOrYdYglm5uofDpV92WPDX9Oea02vjC+1xvKsc0ECsUP2pSb/
         q7ugkyRzFQ8Hij4vHm/bfs6SZ/og9LQjuGE6TFB2rHqbR4eCv4p49bbrwEr5RJjsPl
         TEzrcBuanxqqk4aZPZ/FHbiAwDl87d2tZMcc0XtU=
Date:   Wed, 22 Nov 2023 14:44:53 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org, lenb@kernel.org, lpieralisi@kernel.org,
        andre.draszik@linaro.org, quic_zhenhuah@quicinc.com
Subject: Re: [PATCH] iommu: Avoid more races around device probe
Message-ID: <2023112238-sierra-chewable-86fc@gregkh>
References: <16f433658661d7cadfea51e7c65da95826112a2b.1700071477.git.robin.murphy@arm.com>
 <ZVZL9kZuVsb9VPnM@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVZL9kZuVsb9VPnM@nvidia.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 01:05:58PM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 15, 2023 at 06:25:44PM +0000, Robin Murphy wrote:
> > It turns out there are more subtle races beyond just the main part of
> > __iommu_probe_device() itself running in parallel - the dev_iommu_free()
> > on the way out of an unsuccessful probe can still manage to trip up
> > concurrent accesses to a device's fwspec. Thus, extend the scope of
> > iommu_probe_device_lock() to also serialise fwspec creation and initial
> > retrieval.
> > 
> > Reported-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> > Link: https://lore.kernel.org/linux-iommu/e2e20e1c-6450-4ac5-9804-b0000acdf7de@quicinc.com/
> > Fixes: 01657bc14a39 ("iommu: Avoid races around device probe")
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> > 
> > This is my idea of a viable fix, since it does not need a 700-line
> > diffstat to make the code do what it was already *trying* to do anyway.
> > This stuff should fundamentally not be hanging off driver probe in the
> > first place, so I'd rather get on with removing the underlying
> > brokenness than waste time and effort polishing it any further.
> 
> I'm fine with this as some hacky backport, but I don't want to see
> this cross-layer leakage left in the next merge window.
> 
> ie we should still do my other series on top of and reverting this.
> 
> I've poked at moving parts of it under probe and I think we can do
> substantial amounts in about two more series and a tidy a bunch of
> other stuff too.

I agree, it's messy and acpi should not need this, BUT at the moment, I
can't see any other way to resolve this simply.

So here's a begrudged ack:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

and hopefully the larger series should resolve this correctly?  Can that
be rebased on top of this?

Also, cc: stable on this for whomever applies it?

thanks,

greg k-h
