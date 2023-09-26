Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AF07AE8A6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjIZJK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjIZJKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:10:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CB0DE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 02:10:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41D0C433C9;
        Tue, 26 Sep 2023 09:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695719447;
        bh=Pij0F/OHhe29LporfyG/dolasbY35LkZvuQqT1vlikc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q3R+LZ5BMFPUOh5zwmMvuhb1oJWKPSblJwKGZJQvmzRb/7bY2f+wwwOcbWp9jh1UQ
         HJX9kFv5tZ6qbTJRR4msueu090+YIRzWPnd5jAWVAjeOpl9eokhNn7eixymDZZMMXB
         LYsOhczTB8obQrjwg8aS/jnZiTJV3e4WwEhqpSU4=
Date:   Tue, 26 Sep 2023 11:10:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Piro Yang <piroyangg@gmail.com>
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vme_user: using __func__ to replace
 function's name in printk
Message-ID: <2023092654-staring-smother-9860@gregkh>
References: <9548bc1c-23c9-427f-446e-61f051f14f9c@gmail.com>
 <20230917203019.79180-1-piroyangg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917203019.79180-1-piroyangg@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 04:30:19AM +0800, Piro Yang wrote:
> Fix issue relating to prink message:
> 	*using __func__ to replace function's name
> 
> Issue found by checkpatch
> 
> Signed-off-by: Piro Yang <piroyangg@gmail.com>
> ---
> Changes in v2:
>   - Firstly, fix only one type of Waring by checkpatch.
> 	using '"%s...", __func__' substitute for function's name of printked information

This is v3, right?

> 
> diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> index 5960562dcd96..de404c6765f3 100644
> --- a/drivers/staging/vme_user/vme.c
> +++ b/drivers/staging/vme_user/vme.c
> @@ -418,7 +418,7 @@ int vme_slave_get(struct vme_resource *resource, int *enabled,
>  	image = list_entry(resource->entry, struct vme_slave_resource, list);
>  
>  	if (!bridge->slave_get) {
> -		printk(KERN_ERR "vme_slave_get not supported\n");
> +		printk(KERN_ERR "%s not supported\n", __func__);

Please move to real dev_err() calls instead of trying to fix up old and
broken printk() calls.  That's the correct solution here for this
codebase and if you look on the list, I think there are patches that do
this already, right?

thanks,

greg k-h
