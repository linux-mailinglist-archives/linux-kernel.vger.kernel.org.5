Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF817D02B5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbjJSTqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJSTqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:46:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA65114
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:46:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B56C433C7;
        Thu, 19 Oct 2023 19:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697744793;
        bh=2DBOZmybY+3Sory7Y9c4bwMDlQQGsBhqz4ybxHg0V9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCprSc35KjwFeSPxc0FeCG4WzN/N7I1lSv+jyLd+mK3jy8JGuiUbiqvfUZKm38aEJ
         c8F8aaMTLgAjI6touH0p5jHWRftlMlnxAYttdI7fAwqtJQPzpD/NZm5p9U41zMOjW7
         VaiAHi7aWbkOq1i9fb+tvoWZ4Zek5XxLKwzeKD6M=
Date:   Thu, 19 Oct 2023 21:46:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <2023101902-upturned-pledge-3a35@gregkh>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-3-saeed@kernel.org>
 <2023101835-trapdoor-unicycle-788a@gregkh>
 <20231018180128.GA719006@nvidia.com>
 <2023101808-quicksand-roman-0da7@gregkh>
 <20231018185629.GD3952@nvidia.com>
 <2023101913-owl-showman-5858@gregkh>
 <20231019190046.GV3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019190046.GV3952@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 04:00:46PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 19, 2023 at 07:21:57PM +0200, Greg Kroah-Hartman wrote:
> > > All of the Mellanox driver stack (over 400 files now!) is dual
> > > licensed because we have a large team of people working the Mellanox
> > > driver for many operating systems with many different licenses. We
> > > want the certainty of a permissive license for the driver code we
> > > supply to Linux as the team routinely references and/or re-uses
> > > Mellanox authored Linux driver code into other scenarios under the
> > > permissive side of the dual license.
> > > 
> > > For instance I could easily see the work Saeed has done here finding
> > > its way into FreeBSD. We significantly support FreeBSD employing
> > > maintainers and develop a sophisticated Mellanox driver over
> > > there. This would not be possible without the Linux driver being dual
> > > licensed.
> > 
> > Yes it would, you can take the work that you all do and license it under
> > the BSD license and put it into FreeBSD just fine.
> 
> Sure, you can do that at day 0, but mlx5 is now about 10 years old and
> has tens of thousands of commits. Many non-Mellanox commits. (mostly
> non-significant, IMHO, IANAL)

That's not the case for this specific chunk of code, so it's not a valid
point at all, sorry.

Let's stick to just this new file, please keep it one-license, not dual,
it makes everything simpler overall.

> Remember that Leon created auxiliary bus so these complex multi-system
> HWs could be split up cleanly into their respective subsystems? This
> is an aux device driver for the misc subsystem as part of the giant
> cross-subsystem mlx5 driver. Ie Saeed is adding 3 more files to that
> existing monster.

Yes, and as the auxiliary bus code is EXPORT_SYMBOL_GPL() attempting to
license code that is a driver for that bus (i.e. this new contribution)
under anything other than just GPL is crazy.  Go talk to your lawyers
about that please, it's obviously not ok.

thanks,

greg k-h
