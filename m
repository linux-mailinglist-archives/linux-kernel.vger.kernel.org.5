Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55C375B6B5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjGTS0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjGTS0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:26:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB1A135;
        Thu, 20 Jul 2023 11:26:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2019E61BB6;
        Thu, 20 Jul 2023 18:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4062C433C7;
        Thu, 20 Jul 2023 18:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689877589;
        bh=xha2iXtDT4iIsye4s+aA5Kiqrk4hNe9ZAS+tEs71g+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=amNiniA08uTgnSyLnoLNygaQQ/+mDsLy+preW5cAxap2xGZmBUCdonM2RqhcQdO9H
         qVRpqzDErPrIgPS7jzjlZLI+NhH4TWbuDquIFXxAS6skFdpwyDGeWSGyJ5vvEPG4a2
         6H+/5Cjg1ssLt0nRNEPNvXHBRXaxFNWvBFNfc2iY=
Date:   Thu, 20 Jul 2023 20:26:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Edward Cree <ecree.xilinx@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, corbet@lwn.net,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux@leemhuis.info, kvalo@kernel.org,
        benjamin.poirier@gmail.com
Subject: Re: [PATCH docs v3] docs: maintainer: document expectations of small
 time maintainers
Message-ID: <2023072012-subzero-maturity-b6cd@gregkh>
References: <20230719183225.1827100-1-kuba@kernel.org>
 <50164116-9d12-698d-f552-96b52c718749@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50164116-9d12-698d-f552-96b52c718749@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 07:23:56PM +0100, Edward Cree wrote:
> On 19/07/2023 19:32, Jakub Kicinski wrote:
> > We appear to have a gap in our process docs. We go into detail
> > on how to contribute code to the kernel, and how to be a subsystem
> > maintainer. I can't find any docs directed towards the thousands
> > of small scale maintainers, like folks maintaining a single driver
> > or a single network protocol.
> > 
> > Document our expectations and best practices. I'm hoping this doc
> > will be particularly useful to set expectations with HW vendors.
> > 
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reviewed-by: Mark Brown <broonie@kernel.org>
> > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> 
> Thanks for writing this.  One question—
> 
> > +Reviews
> > +-------
> > +
> > +Maintainers must review *all* patches touching exclusively their drivers,
> > +no matter how trivial. If the patch is a tree wide change and modifies
> > +multiple drivers - whether to provide a review is left to the maintainer.
> 
> Does this apply even to "checkpatch cleanup patch spam", where other patches
>  sprayed from the same source (perhaps against other drivers) have already
>  been nacked as worthless churn?  I've generally been assuming I can ignore
>  those, do I need to make sure to explicitly respond with typically a repeat
>  of what's already been said elsewhere?

No, you can ignore them if you don't want to take them :)
