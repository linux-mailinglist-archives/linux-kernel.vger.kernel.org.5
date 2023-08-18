Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E834A780A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376468AbjHRK4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376478AbjHRKzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:55:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0DC30F5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 03:55:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED0E860E08
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15DDC433C9;
        Fri, 18 Aug 2023 10:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692356147;
        bh=XlqY4Yic3Gv96y4bEhrFTLtlSIDPkxSaGRYN+jEJlzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mdPXqSQjoLVu1gKJQtyECWmkj/FcL6oLBFvDMUqcuRmfHLw4WEgMjx35bbvbNniOx
         nIcaLRIZpqbpcr7WQQqMcN3DzfSDzqekEnNfuIIFpOxfHL1rGangI8pth8l9r4dxkn
         M+ik5UN0CjjTyG+tPEhqz3Wpf4apej9eMZXw5W/Wj5plLHmz1bxUZBPU9CfjGiasrT
         8EbFX7E9ci9sZg3GwxrALjrEE3o4twOgeH76bP73+pxkdCSMy3qBudOWstP98snlgT
         i4x2eCd2VZpFg8mu7C3G/jn5RVGEhCQpwuXbLIY01L8nfX9GvhBfPdyPouWn4TQKN7
         GRkP5Nfe7cXzw==
Date:   Fri, 18 Aug 2023 12:55:42 +0200
From:   Simon Horman <horms@kernel.org>
To:     Hariprasad Kelam <hkelam@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, sgoutham@marvell.com,
        gakula@marvell.com, jerinj@marvell.com, lcherian@marvell.com,
        sbhatta@marvell.com, naveenm@marvell.com, edumazet@google.com,
        pabeni@redhat.com
Subject: Re: [net-next Patch 0/5] octeontx2-af: misc MAC block changes
Message-ID: <ZN9OLltBUdKK+3tH@vergenet.net>
References: <20230817112357.25874-1-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817112357.25874-1-hkelam@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 04:53:52PM +0530, Hariprasad Kelam wrote:
> This series of patches adds recent changes added in MAC (CGX/RPM) block.
> 
> Patch1: Adds new LMAC mode supported by CN10KB silicon
> 
> Patch2: In a scenario where system boots with no cgx devices, currently
>         AF driver treats this as error as a result no interfaces will work.
>         This patch relaxes this check, such that non cgx mapped netdev
>         devices will work.
> 
> Patch3: This patch adds required lmac validation in MAC block APIs.
> 
> Patch4: This patch replaces generic error codes with driver specific error
>         codes for better debugging.
> 
> Patch5: Prints error message incase, no netdev is mapped with given
>         cgx,lmac pair.
> 
> 
> Hariprasad Kelam (4):
>   octeontx2-af: CN10KB: Add USGMII LMAC mode
>   octeontx2-af: Add validation of lmac
>   octeontx2-af: replace generic error codes
>   octeontx2-af: print error message incase of invalid pf mapping
> 
> Sunil Goutham (1):
>   octeontx2-af: Don't treat lack of CGX interfaces as error

For series,

Reviewed-by: Simon Horman <horms@kernel.org>

