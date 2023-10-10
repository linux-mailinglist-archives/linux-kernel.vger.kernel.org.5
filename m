Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FEC7C0042
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjJJPTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjJJPTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:19:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3BDC6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:19:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC52C433C8;
        Tue, 10 Oct 2023 15:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696951148;
        bh=q5zpB8Ae5EwUX+krsgcAEDQQxTiFxoZyHrCg5TuPpm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fRSgeZicmUkwBUqTTVEkR2oFBRPB7uH2+ITFqHwgtoTc5q2FbaeEAe1Ce5BXEPqpP
         QwzT13xhObh+q5M3efgctZ+RKZPnui+bEzR9pVMCjIJI+fy6e8dvQrCTsYdkZtsrXM
         MZfJhckFbDfe1gQSXHliI1dzbbxkp1XE0snIMFE7zE55B+UFoU2Zkwcsqiu36cQ4qI
         GdL4B7hPIFvnln7FyvPe5grLN81/OFmxPBIi5oSkG9EF7L5pJF2t3VoCEjrQ3zsz2d
         e8jQuXPWmP773MoBiOuy+0imw335Mp2djDq5NITji7sn8iRkVz40DBV1AcjjX4JVD2
         D+8vbhSx3+Pvg==
Date:   Tue, 10 Oct 2023 17:19:03 +0200
From:   Simon Horman <horms@kernel.org>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        thomas.petazzoni@bootlin.com, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v3 1/1] ethtool: Fix mod state of verbose no_mask
 bitset
Message-ID: <ZSVrZ9fIP62RLQpY@kernel.org>
References: <20231009133645.44503-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009133645.44503-1-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 03:36:45PM +0200, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> A bitset without mask in a _SET request means we want exactly the bits in
> the bitset to be set. This works correctly for compact format but when
> verbose format is parsed, ethnl_update_bitset32_verbose() only sets the
> bits present in the request bitset but does not clear the rest. The commit
> 6699170376ab fixes this issue by clearing the whole target bitmap before we
> start iterating. The solution proposed brought an issue with the behavior
> of the mod variable. As the bitset is always cleared the old val will
> always differ to the new val.
> 
> Fix it by adding a new temporary variable which save the state of the old
> bitmap.
> 
> Fixes: 6699170376ab ("ethtool: fix application of verbose no_mask bitset")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v2:
> - Fix the allocated size.
> 
> Changes in v3:
> - Add comment.
> - Updated variable naming.
> - Add orig_bitmap variable to avoid n_mask condition in the
>   nla_for_each_nested() loop.

Hi Köry,

thanks for the updates. This one looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
