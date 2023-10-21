Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC867D1FA6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 22:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjJUUvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 16:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJUUvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 16:51:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F591A3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 13:51:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5B1C433C7;
        Sat, 21 Oct 2023 20:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697921495;
        bh=5F/XdsLWNfNKEFZZYUr1FEKIom3JRNW9VYy1S/BrlwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xWAomL2hR5EeELcfXYC3lnTiT/AP3CU8Vfi4b+2wy6gh5nRvI9ssW/wwjudfoIcrJ
         D+9iFJklEOk4Bk9fmdTbA1DFUMjLdCF9r0MYLmqrr5wq1TzIvXlc1aRqyRKZk5rdcs
         BnX+okgL2mfR0/fpPb3NC9UQWmw9FVDBORpY/3yU=
Date:   Sat, 21 Oct 2023 22:51:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 4/6] Revert "nvmem: add new config option"
Message-ID: <2023102113-posted-pronounce-97fb@gregkh>
References: <20231020105545.216052-1-srinivas.kandagatla@linaro.org>
 <20231020105545.216052-5-srinivas.kandagatla@linaro.org>
 <2023102100-tile-spinning-fa1b@gregkh>
 <ef93205165ac15b4d6ea14a5e9f22cd9@milecki.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef93205165ac15b4d6ea14a5e9f22cd9@milecki.pl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 10:31:55PM +0200, Rafał Miłecki wrote:
> On 2023-10-21 19:18, Greg KH wrote:
> > On Fri, Oct 20, 2023 at 11:55:43AM +0100, srinivas.kandagatla@linaro.org
> > wrote:
> > > From: Rafał Miłecki <rafal@milecki.pl>
> > > 
> > > This reverts commit 517f14d9cf3533d5ab4fded195ab6f80a92e378f.
> > > 
> > > It seems that "no_of_node" config option was added to help mtd's case.
> > > 
> > > DT nodes of MTD partitions (that are also NVMEM devices) may contain
> > > subnodes that SHOULD NOT be treated as NVMEM fixed cells. To prevent
> > > NVMEM core code from parsing them "no_of_node" was set to true and
> > > that
> > > made for_each_child_of_node() in NVMEM a no-op.
> > > 
> > > With the introduction of "add_legacy_fixed_of_cells" config option
> > > things got more explicit. MTD subsystem simply tells NVMEM when to
> > > look
> > > for fixed cells and there is no need to hack "of_node" pointer
> > > anymore.
> > > 
> > > Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> > > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > 
> > Why isn't this also marked for stable trees?
> 
> I think it's explained in commit message but maybe it's not clear
> enough?

It's not, I just read it again and can't figure it out, sorry.

> This revert (PATCH 4/6) is possible only with the previous PATCH 2/6
> applied first. In other words "no_of_node" config option can be dropped
> only after adding "add_legacy_fixed_of_cells" config option.

Ah, ok, that's not obvious :)

> Since adding "add_legacy_fixed_of_cells" is not a bug/regression fix I
> didn't mark it for stable and so I couldn't mark revert for stable.

That's fine, but can you please resend this with a better changelog that
makes it obvious why now we can revert the old patch, otherwise the
autobot will come along and attempt to backport it to stable as well.

thanks,

greg k-h
