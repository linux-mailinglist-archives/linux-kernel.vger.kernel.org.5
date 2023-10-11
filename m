Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F4A7C47A3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 04:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344767AbjJKCKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 22:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344750AbjJKCKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 22:10:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A26AA7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 19:10:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D5DC433C8;
        Wed, 11 Oct 2023 02:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696990221;
        bh=SCN+YvrTAvn/rzETs6OSh7GFIZOLCdOcc5xTG+BWl0g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A0n2bizFMpZqqKeGhyfo1ozKH4zwv1E5WO/KuO+JorM7wXzRM6u21i+SvPPYJPSgL
         8IqhnLJh5EdIJKh+kVXpg8RCAGy8fiWXmjx6wag+lF9y2PDpt33HpFV6iz8JSsWBIM
         QFyLHie+TUizdXcW9qnZcCeEwjxw3/2lrXoEwz9cZ1ctYvcWrhSBPQmqeaysAwknlh
         BUkjjBOydhkCOQvKK2JxDXFKCCFNMJ5XcTXWPK8kz/gRCkT8fW47b9auOrDVAGrzGQ
         vzgylqoG1XQ39ay/nXMofyJqIkddLIywkojM3gpXsJy4O0dYN98IQuVdgltPbH1/Ag
         0z1PUB0veiV3A==
Date:   Tue, 10 Oct 2023 19:10:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     takeru hayasaka <hayatake396@gmail.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ethtool: ice: Support for RSS settings to GTP
 from ethtool
Message-ID: <20231010191019.12fb7071@kernel.org>
In-Reply-To: <CADFiAcKF08osdvd4EiXSR1YJ22TXrMu3b7ujkMTwAsEE8jzgOw@mail.gmail.com>
References: <20231008075221.61863-1-hayatake396@gmail.com>
        <20231010123235.4a6498da@kernel.org>
        <CADFiAcKF08osdvd4EiXSR1YJ22TXrMu3b7ujkMTwAsEE8jzgOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 10:56:17 +0900 takeru hayasaka wrote:
> GTP generates a flow that includes an ID called TEID to identify the
> tunnel. This tunnel is created for each UE (User Equipment).
> By performing RSS based on this flow, it is possible to apply RSS for
> each communication unit from the UE.
> Without this, RSS would only be effective within the range of IP addresses.
> For instance, the PGW can only perform RSS within the IP range of the SGW.
> What I'm trying to say is that RSS based solely on IP addresses can be
> problematic from a load distribution perspective, especially if
> there's a bias in the terminals connected to a particular base
> station.
> As a reference that discusses a similar topic, please see the link
> below(is not RSS, is TEID Flow):
> https://docs.nvidia.com/networking-ethernet-software/cumulus-linux-56/Layer-3/Routing/Equal-Cost-Multipath-Load-Sharing/#gtp-hashing

Makes sense, thanks for the extra information. I think it would be
worth adding all of this to the commit message!

Regarding the patch - you are only adding flow types, not a new field 
(which are defined as RXH_*). If we want to hash on an extra field, 
I think we need to specify that field as well?

> Thank you for your understanding.
> ---
> Sorry! My email was blocked because it wasn't sent in plain text mode.
> I've made the necessary changes and will resend it.

No worries! Additional request - in the future please prefer the
bottom-posting or interleaved style of replies:
https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
