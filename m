Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D5D7FAEDA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbjK1AHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjK1AHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:07:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243C1101
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:07:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F4BC433C8;
        Tue, 28 Nov 2023 00:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701130040;
        bh=yjF7KLT1rCV9GqA6p3repObpFG5GNsH7iCXAw5Ejt+w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TIx0v/y0C5+w2KWs22IsZSWGFIu8KquE9PewQZQ7aJoduXSqUjRHXKj/vdJQ+Drd7
         +vIBy62enzQiDwtit6SVh+sCk4t0IQ4ZFsDHeHWbygLj28T11DkUjdkGHuSpyhRxvN
         RppPZLEq8dxiX0PeoR1t6EJZ6Gzc1BDyFzrzdiOzIKMjlpL0Zwc+2YQ7yPvSSg2gbh
         GHou9O/h9Wq6n+8RVvFquyjr1mwbPmehF4f4GjXCXStB59RRwsTi5QBVlfnjMNBwW1
         i40GhvZV4brc+u6E0m+53zolTLSUUENq3e7bgiwI0QfaYGkj2V59EpWQPzAriBqLNW
         0L2iW8sLw1lcA==
Date:   Mon, 27 Nov 2023 16:07:19 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231127160719.4a8b2ad1@kernel.org>
In-Reply-To: <ZWTtTjgBrNxpd9IO@x130>
References: <20231121070619.9836-1-saeed@kernel.org>
        <20231121070619.9836-3-saeed@kernel.org>
        <2023112702-postal-rumbling-003f@gregkh>
        <20231127144017.GK436702@nvidia.com>
        <2023112752-pastel-unholy-c63d@gregkh>
        <20231127161732.GL436702@nvidia.com>
        <2023112707-feline-unselect-692f@gregkh>
        <ZWTtTjgBrNxpd9IO@x130>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 11:26:06 -0800 Saeed Mahameed wrote:
> This driver is different as it doesn't replace existing mlx5 drivers,
> mlx5 functionality drivers are still there to expose the device features
> through the standard stacks, this is just a companion driver to access
> debug information, by driver and FW design mlx5ctl is not meant to
> manage or pilot the device like other device specific char drivers.

You keep saying "debug information" which is really underselling this
driver. Are you not going to support mstreg?

The common development flow as far as netdev is concerned is:
 - some customer is interested in a new feature of a chip
 - vendor hacks the support out of tree, using oot module and/or
   user space tooling
 - customer does a PoC with that hacked up, non-upstream solution
   - if it works, vendor has to find out a proper upstream API,
     hopefully agreed on with other vendors
   - if it doesn't match customer needs the whole thing lands in the bin

If the vendor specific PoC can be achieved with fully upstream software
we lose leverage to force vendors to agree on common APIs.

This should all be self-evident for people familiar with netdev, but
I thought I'd spell it out.

I understand that the device has other uses, but every modern NIC has
other uses. I don't see how netdev can agree to this driver as long as
there is potential for configuring random networking things thru it.
All major netdev vendors have a set of out of tree tools / "expose
everything misc drivers", "for debug". They will soon follow your
example if we let this in.
