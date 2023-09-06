Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CCD793787
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbjIFI5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjIFI5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:57:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0224D184;
        Wed,  6 Sep 2023 01:57:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB7FC433C7;
        Wed,  6 Sep 2023 08:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693990630;
        bh=JZGUePwl6/0DjGndwCMmh1J3++0RqMmIei8uSU9hbD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=itF05d9VXRjSiPj62d0CqBBiUTScgKvirVgpg8Uz9kUxNHH6/XJaZ/2hupha+ktyb
         DzPAB4/0JWmQrr3Ar3n9p/xt+IXHg3Kbf5CFFHdyOERoLIpUStvsEk3fVd15COCIS3
         vrVMsu7jxb8pv/JSp4BSyHvn5NOxImM3jopFtDVI=
Date:   Wed, 6 Sep 2023 09:57:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Saranya Gopal <saranya.gopal@intel.com>,
        Rajaram Regupathy <rajaram.regupathy@intel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Wayne Chang <waynec@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Fix NULL pointer dereference
Message-ID: <2023090638-overexert-endearing-3726@gregkh>
References: <20230906084842.1922052-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906084842.1922052-1-heikki.krogerus@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 11:48:42AM +0300, Heikki Krogerus wrote:
> Making sure the UCSI debugfs entry actually exists before
> attempting to remove it.
> 
> Fixes: df0383ffad64 ("usb: typec: ucsi: Add debugfs for ucsi commands")
> Reported-by: Dave Hansen <dave.hansen@intel.com>
> Closes: https://lore.kernel.org/linux-usb/700df3c4-2f6c-85f9-6c61-065bc5b2db3a@intel.com/
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Saranya Gopal <saranya.gopal@intel.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/typec/ucsi/debugfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/debugfs.c b/drivers/usb/typec/ucsi/debugfs.c
> index 0c7bf88d4a7f..f67733cecfdf 100644
> --- a/drivers/usb/typec/ucsi/debugfs.c
> +++ b/drivers/usb/typec/ucsi/debugfs.c
> @@ -84,6 +84,9 @@ void ucsi_debugfs_register(struct ucsi *ucsi)
>  
>  void ucsi_debugfs_unregister(struct ucsi *ucsi)
>  {
> +	if (IS_ERR_OR_NULL(ucsi) || !ucsi->debugfs)
> +		return;
> +
>  	debugfs_remove_recursive(ucsi->debugfs->dentry);

Why are you saving the dentry at all?  Why not just have debugfs look it
up when you want to remove it based on the filename?

Anyway, not a big deal here, just a comment.  I'll queue this up after
-rc1 is out.

thanks,

greg k-h
