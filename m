Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727987CB1BB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjJPR6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjJPR6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:58:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2BE83
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:58:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B8DC433C7;
        Mon, 16 Oct 2023 17:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697479131;
        bh=AyK2SXcqdRnOrh1k76CSD8fTzBnhoJScCp2j+ldNjaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w98KksX3ig/2ARv3Elxv4giqqgt/EaFboKZhRg/4fbwkl+Sf3iqws6nUr4eZvlZG5
         JioaV3HQppmUtn/V7vxxETIxkjur9jSBYySvG6BdzgKPtB9QQ1ivyymKyl8VDUohV/
         RHOqVCuNC0NLcHksup7XHzjfZ9al2UoQ/7HorQgw=
Date:   Mon, 16 Oct 2023 19:42:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hongren Zheng <i@zenithal.me>
Cc:     Shuah Khan <shuah@kernel.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au
Subject: Re: [PATCH v2 -next] usb/usbip: fix wrong data added to platform
 device
Message-ID: <2023101623-amaretto-sevenfold-6b5e@gregkh>
References: <ZSpHPCaQ5DDA9Ysl@Sun>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSpHPCaQ5DDA9Ysl@Sun>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 03:46:04PM +0800, Hongren Zheng wrote:
> .data of platform_device_info will be copied into .platform_data of
> struct device via platform_device_add_data.

That is crazy.

> However, vhcis[i] contains a spinlock, is dynamically allocated and
> used by other code, so it is not meant to be copied. The workaround
> was to use void *vhci as an agent, but it was removed in the commit
> suggested below.

Again, crazy, I'm amazed it works at all.

> This patch adds back the workaround and changes the way of using
> platform_data accordingly.
> 
> Reported-by: syzbot+e0dbc33630a092ccf033@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/00000000000029242706077f3145@google.com/
> Reported-by: syzbot+6867a9777f4b8dc4e256@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/0000000000007634c1060793197c@google.com/
> Fixes: b8aaf639b403 ("usbip: Use platform_device_register_full()")
> Tested-by: syzbot+6867a9777f4b8dc4e256@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/0000000000007ac87d0607979b6b@google.com/
> Signed-off-by: Hongren Zheng <i@zenithal.me>
> ---
>  drivers/usb/usbip/vhci_hcd.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

I'll take this now, as it fixes a reported issue, but really, the root
problem should be fixed instead.  This is not how to treat platform data
at all.

thanks,

greg k-h
