Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665427DE5A7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjKARyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjKARyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:54:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00553109;
        Wed,  1 Nov 2023 10:54:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C845C433C9;
        Wed,  1 Nov 2023 17:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698861250;
        bh=JAumfjAMArYws76N389UqFy89DYhXF68dhxExokMXXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gp/1JaVgjaX0aErHXARToRP3jqVB4mU1rKyb6acTpxhiky76TB9Au9YxcUcD2wkVf
         oQ0d2jabJM17qBhkJCxYSHCiUyVLvQm4o4onpY/I4xrc7/ku06ZJRZkOp/RPqQxAiu
         1jzYI9CoeyudoOCLekiRugVrhVBBv6+BxDVgLgrM=
Date:   Wed, 1 Nov 2023 18:54:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Jos=E9?= Pekkarinen <jose.pekkarinen@foxhound.fi>
Cc:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        skhan@linuxfoundation.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+95f2e2439b97575ec3c0@syzkaller.appspotmail.com
Subject: Re: [PATCH] drivers core: lookup sysfs power group before removal
Message-ID: <2023110139-dupe-snipping-5700@gregkh>
References: <20231101173627.2658-1-jose.pekkarinen@foxhound.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231101173627.2658-1-jose.pekkarinen@foxhound.fi>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 07:36:27PM +0200, José Pekkarinen wrote:
> Hinted by syzboot, there is a few cases where the sysfs power group may
> not be there, like the failure while adding it, or adding its runtime
> group, or when the sysfs firmware loader fallback fail to populate. In
> the last case, the device_del function will be called leading to attempt
> to remove the sysfs group. This patch will lookup for it in advance to
> grant that it is effectively there before cleaning it up.
> 
> Reported-by: syzbot+95f2e2439b97575ec3c0@syzkaller.appspotmail.com
> 
> Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
> ---
>  drivers/base/power/sysfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index a1474fb67db9..6601729c4698 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -834,5 +834,7 @@ void dpm_sysfs_remove(struct device *dev)
>  	dev_pm_qos_constraints_destroy(dev);
>  	rpm_sysfs_remove(dev);
>  	sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
> -	sysfs_remove_group(&dev->kobj, &pm_attr_group);
> +
> +	if (kernfs_find_and_get((&dev->kobj)->sd, pm_attr_group.name))
> +		sysfs_remove_group(&dev->kobj, &pm_attr_group);

What's to keep it from going away right after finding it?

In other words, what is wrong with removing a group that is not there?
What error happens?  It should be fine, or are you seeing real code
failures somewhere?

Also, I think you just leaked a reference count here, how was this
tested?

thanks,

greg k-h
