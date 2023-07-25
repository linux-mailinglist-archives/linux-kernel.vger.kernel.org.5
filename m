Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F70761D08
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjGYPMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjGYPMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:12:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A24D1BD8;
        Tue, 25 Jul 2023 08:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09A5861796;
        Tue, 25 Jul 2023 15:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190B3C433C8;
        Tue, 25 Jul 2023 15:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690297923;
        bh=8THp3K8VuswJyA6ZQXnYnjyJbhS9jvJpXnNYRT9oTbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2kT7TXzWg5z4DsF7ST/eGZz62RXegu3XcV33Ukca4bw/tzemlkmbWOpjHfRnKfHry
         oUmqfPBF2pZdibId+QxwSoVpWcN35WI/0szz66+xFMsS9VDRd3zjdmvplOR7Vsls5z
         MtbVij7rryRX4PV1vtlQT2y1VzCF164N+fD0KrOY=
Date:   Tue, 25 Jul 2023 17:12:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dingyan Li <18500469033@163.com>
Cc:     Oliver Neukum <oneukum@suse.com>, stern@rowland.harvard.edu,
        sebastian.reichel@collabora.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] USB: add usbfs ioctl to get specific superspeedplus
 rates
Message-ID: <2023072526-reissue-uplifting-5674@gregkh>
References: <20230721084039.9728-1-18500469033@163.com>
 <2023072105-lethargic-saddling-ad97@gregkh>
 <130b453c.5c8f.1897872ce54.Coremail.18500469033@163.com>
 <2023072159-carol-underfeed-43eb@gregkh>
 <781b3f95-96e7-af83-e089-887ec7f2d255@suse.com>
 <2023072546-denture-half-5ceb@gregkh>
 <4edabcb3.7e65.1898d54679e.Coremail.18500469033@163.com>
 <ca4ad735-5605-3fd4-c903-fe5b039cf6a8@suse.com>
 <3018cd33.7ee4.1898d7e4798.Coremail.18500469033@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3018cd33.7ee4.1898d7e4798.Coremail.18500469033@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 10:40:10PM +0800, Dingyan Li wrote:
> 
> At 2023-07-25 22:08:44, "Oliver Neukum" <oneukum@suse.com> wrote:
> >On 25.07.23 15:54, Dingyan Li wrote:
> >
> >> If we can't "deprecate" ioctls, can we change the returned contents of existing ones?
> >
> >No. Absolutely not. That is totally unacceptable. It would be much
> >worse than just removing the support.
> >
> >	Regards
> >		Oliver
> 
> Got it, I guess this is for backward-compatibility.
> 
> I also have another thought. USBDEVFS_CONNINFO_EX is kind of special and
> used to retrieve contents of variable length. If you check proc_conninfo_ex(),
> I think maybe we can append a new member to "struct usbdevfs_conninfo_ex"
> without breaking backward-compatibility.

How exactly would that work?  Remember, new kernels still need to work
with old userspace code.

> By this way, we can avoid adding a new ioctl. Or even more aggressively,
> drop USBDEVFS_GET_SPEED and force everyone to use USBDEVFS_CONNINFO_EX
> since it can also return device speed.

We can not "force" anyone to change, that's not how the kernel works,
sorry.

greg k-h
