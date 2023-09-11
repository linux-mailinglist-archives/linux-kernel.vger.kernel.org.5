Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5333F79AB59
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 22:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjIKUrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244053AbjIKS70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:59:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114781B6;
        Mon, 11 Sep 2023 11:59:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD79C433C8;
        Mon, 11 Sep 2023 18:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694458761;
        bh=BiU1W+RBB06NcMTa0T9geOWsmY6i5RpjwrAWcchH+0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P1Xq4jwua6sz95mhYk1kGatnq68WOYHUEev4ZBkG5PzKnCunqt2cv2kz0k8lE+PW3
         HpdFM+Z8A2sBg4zOqp+aXwpiZ7AHCUfc3Oqq4VUZ/L2fYvAKBhbkkCezeILT0AnsW2
         i+wnMk4PG1WVRSZJhFV3hO/N1xBuGt0Wu73heduE=
Date:   Mon, 11 Sep 2023 20:59:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Saranya Gopal <saranya.gopal@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Release debugfs only if it has been
 allocated
Message-ID: <2023091112-elevation-immature-8f9f@gregkh>
References: <20230911162706.2856910-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911162706.2856910-1-yu.c.chen@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:27:06AM +0800, Chen Yu wrote:
> The following NULL pointer exception was found during boot up:
> 
>  calling  ucsi_acpi_platform_driver_init+0x0/0xff0 [ucsi_acpi] @ 394
>  initcall mac_hid_init+0x0/0xff0 [mac_hid] returned 0 after 5 usecs
>  BUG: kernel NULL pointer dereference, address: 0000000000000020
>  Call Trace:
>   ? ucsi_debugfs_unregister+0x15/0x30 [typec_ucsi]
>   ucsi_destroy+0x17/0x30 [typec_ucsi]
>   ucsi_acpi_probe+0x1d5/0x230 [ucsi_acpi]
> 
> It is possible that ucsi_acpi_probe() fails to install the notifier,
> and calls ucsi_destroy() to release the resource. However at that
> moment the debugfs has not been registered yet, thus the NULL pointer
> exception is triggered. Add the check for debugfs pointer.
> 
> Fixes: Commit df0383ffad64 ("usb: typec: ucsi: Add debugfs for ucsi commands")

Incorrect format :(

> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/usb/typec/ucsi/debugfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/debugfs.c b/drivers/usb/typec/ucsi/debugfs.c
> index 0c7bf88d4a7f..55533dc3d539 100644
> --- a/drivers/usb/typec/ucsi/debugfs.c
> +++ b/drivers/usb/typec/ucsi/debugfs.c
> @@ -84,7 +84,8 @@ void ucsi_debugfs_register(struct ucsi *ucsi)
>  
>  void ucsi_debugfs_unregister(struct ucsi *ucsi)
>  {
> -	debugfs_remove_recursive(ucsi->debugfs->dentry);
> +	if (ucsi->debugfs)
> +		debugfs_remove_recursive(ucsi->debugfs->dentry);
>  	kfree(ucsi->debugfs);
>  }

What's wrong with this patch instead:
	https://lore.kernel.org/all/20230906084842.1922052-1-heikki.krogerus@linux.intel.com/

thanks,

greg k-h
