Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E890D80D079
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344236AbjLKQE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344281AbjLKQEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:04:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854F2478A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:01:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F15C433C7;
        Mon, 11 Dec 2023 16:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702310472;
        bh=oCcOVEKBX3Ypniv+YoVvEtMDlri449mXUOt1s3iGDX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PkSKqzir2ETv2HS6iDh7GlFFPvOzjSUxC7WmcZ5wv7+bh+UNiEU4gxePAO2iKiaJb
         p7F4j/O8mlvUwn2XbuVrqUl4OxyD52lQmEttIyx3i1gFZUKmW4xL5BwzptMyYNms3g
         xAbwKo3KzljaoZc1xfVbryb6HcehO2Yv8wmtnQq4=
Date:   Mon, 11 Dec 2023 17:01:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Piro Yang <piroyangg@gmail.com>
Cc:     linux-staging@lists.linux.dev,
        Linux Outreachy <outreachy@lists.linux.dev>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging:vme_user:fix the issue of using the wrong error
 code
Message-ID: <2023121133-mandatory-idealness-d454@gregkh>
References: <20231211155453.105409-1-piroyangg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211155453.105409-1-piroyangg@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 11:54:53PM +0800, Piro Yang wrote:
> 1. the error code of ENOSYS indicates Invalid system call number,
>    but there is not system call
> 
> 2. unified the logging error message, when slave_set func is NULL

That is two different things, and as such, should be two different
changes, right?

Yes, it's picky, but that's what the staging driver code is for, to get
comfortable doing kernel development changes properly.

Also, are you sure this second change is correct:

> 
> Signed-off-by: Piro Yang <piroyangg@gmail.com>
> ---
>  drivers/staging/vme_user/vme.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> index 5c416c31ec57..e9461a7a7ab8 100644
> --- a/drivers/staging/vme_user/vme.c
> +++ b/drivers/staging/vme_user/vme.c
> @@ -340,8 +340,8 @@ int vme_slave_set(struct vme_resource *resource, int enabled,
>  	image = list_entry(resource->entry, struct vme_slave_resource, list);
>  
>  	if (!bridge->slave_set) {
> -		dev_err(bridge->parent, "Function not supported\n");
> -		return -ENOSYS;
> +		dev_err(bridge->parent, "%s not supported\n", __func__);

__func__ is not the same here as "Function", right?  "Function" is the
functionality of the thing that is attempted here, so replacing that
word with the function name seems odd to me, don't you think?

thanks,

greg k-h
