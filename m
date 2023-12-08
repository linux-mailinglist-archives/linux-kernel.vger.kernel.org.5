Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D81809BB0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjLHF1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjLHF1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:27:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4F91708
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 21:27:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5144EC433C7;
        Fri,  8 Dec 2023 05:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702013237;
        bh=MWgjljHfQqo8VDu9iHxYxZNeRzofKjBIkHCOEehD1jE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NNPwQFPWpNf5CEaajJe3E3xnFBUxXAK4T22t5sZbl2dY6hzThvMj/dEgXYbPv83Me
         oPIGL8lg3qnL41higu605jVpykpJT55Iv8KDwQqPeJo+UfV+B1zw3cJBc7dkx7KLr7
         0uQmJQwQxo7cxRcBXZ+h+nq1EhVHpHItkpvHaDwQ=
Date:   Fri, 8 Dec 2023 06:27:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aron Silverton <aron.silverton@oracle.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Saeed Mahameed <saeed@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <2023120857-calculus-concerned-cef0@gregkh>
References: <20231128103304.25c2c642@kernel.org>
 <ZWZJGF7moDM_k6TU@x130>
 <2023112922-lyricist-unclip-8e78@gregkh>
 <oxtcvxwbj2hzv4lxnxubo3hoxn7diyzhm2oj3tsw2toxbc3og4@ddglhm6r3oa5>
 <20231204185210.030a72ca@kernel.org>
 <fgalnohzpiox7rvsf3wsurkf2x3rdtyhwqq5tk43gesvjlw6yl@i7colkh2sx5h>
 <20231205204855.52fa5cc1@kernel.org>
 <kakenvblxlgrkjvcrwfflnkm6n5fpxgr4qifwkdttjascth3te@57us7mblobjz>
 <20231207092329.3ec04dca@kernel.org>
 <uedlocmp2guvvhgxe2cjrjog3qf6pd7puj7idpygxxpjrnnj2p@nqmg66juf6xm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uedlocmp2guvvhgxe2cjrjog3qf6pd7puj7idpygxxpjrnnj2p@nqmg66juf6xm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 12:06:28PM -0600, Aron Silverton wrote:
> On Thu, Dec 07, 2023 at 09:23:29AM -0800, Jakub Kicinski wrote:
> > On Thu, 7 Dec 2023 10:41:25 -0600 Aron Silverton wrote:
> > > > I understand that having everything packaged and shipped together makes
> > > > life easier.  
> > > 
> > > I think it is a requirement. We operate with Secure Boot. The kernel is
> > > locked down. We don't have debugfs access, even if it were sufficient,
> > > and we cannot compile and load modules. Even without Secure Boot, there
> > > may not be a build environment available.
> > 
> > This 'no debugfs' requirement is a kernel lockdown thing, I presume?
> > Are we expected to throw debugfs out the window and for all vendors
> > to reimplement their debug functionality via a misc driver taking
> > arbitrary ioctls? Not only does that sound like a complete waste of
> > time and going backward in terms of quality of the interfaces, needing
> > custom vendor tools etc. etc., but also you go from (hopefully somewhat)
> > upstream reviewed debugfs interface to an interface where the only
> > security assurance is vendor telling you "trust me, it's all good".
> 
> IIRC, with lockdown, we can read from debugfs IFF the entries'
> permissions are 0400. We cannot write. It's not suitable for
> implementing an interactive debug interface.

This is a policy decision that a distro decides to do, and I have seen
it happen many times.  The problem with this is then, as you have found
out, vendors try to work around the removal of access to debugfs by
creating new interfaces like misc drivers and sysfs files to emulate
what they were previously exporting with debugfs.

When they do that, they break the reason why the distro/vendor decided
to prevent access to debugfs in the first place, making the whole system
insecure again!

I see this happen all the time in Android devices as Android restricted
access to debugfs many years ago to try to solve the problem of drivers
doing insecure things there.  Those drivers then just moved those
insecure operations to a different interface, making the system insecure
again.

To stop this cat-and-mouse game, work with the vendors that are
implementing these requirements to shut down access to these interfaces.
That is a policy decision made by them, and does NOT mean that the
kernel community needs to then start taking code to circumvent those
decisions as that makes the whole thing pointless.

So in short, use debugfs, that is what it was designed for.  If a vendor
does not wish to enable access to debugfs, then that is their decision
(probably a good one), don't circumvent it by making a new interface, as
odds are, the vendor will eventually realize it and work to cut off that
new interface as well, as they rightfully should.

thanks,

greg k-h
