Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6137D8F96
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345396AbjJ0HUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345388AbjJ0HU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:20:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF15B1BC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:20:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE88C433C9;
        Fri, 27 Oct 2023 07:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698391224;
        bh=+1VcG188vscil3yQawn71OQ65c/A723bocS9yrrCz1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HCApt18BTSaq+UwJSvDE24O/zRl5BhFSYV0hp0DhWFPuqQ+ggNkAdm0r9ao8RZ0HU
         FdLC4+6X7IPteXjFX3146q0lzJ4xqwtYYA+d4j6udg1MLmH1uHW/7689vysLP0O9cN
         v9qN9YBoOIsCcpSliyHq8ME5KesQgjDc2Zv+m70s=
Date:   Fri, 27 Oct 2023 09:20:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     andrey.konovalov@linux.dev
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: raw-gadget: properly handle interrupted
 requests
Message-ID: <2023102712-overhung-strum-e113@gregkh>
References: <0db45b1d7cc466e3d4d1ab353f61d63c977fbbc5.1698350424.git.andreyknvl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0db45b1d7cc466e3d4d1ab353f61d63c977fbbc5.1698350424.git.andreyknvl@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:01:12PM +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@gmail.com>
> 
> Currently, if a USB request that was queued by Raw Gadget is interrupted
> (via a signal), wait_for_completion_interruptible returns -ERESTARTSYS.
> Raw Gadget then attempts to propagate this value to userspace as a return
> value from its ioctls. However, when -ERESTARTSYS is returned by a syscall
> handler, the kernel internally restarts the syscall.
> 
> This doesn't allow userspace applications to interrupt requests queued by
> Raw Gadget (which is required when the emulated device is asked to switch
> altsettings). It also violates the implied interface of Raw Gadget that a
> single ioctl must only queue a single USB request.
> 
> Instead, make Raw Gadget do what GadgetFS does: check whether the request
> was interrupted (dequeued with status == -ECONNRESET) and report -EINTR to
> userspace.
> 
> Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
> ---

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
