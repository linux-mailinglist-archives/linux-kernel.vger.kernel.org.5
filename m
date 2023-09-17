Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADFB7A372D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 20:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237691AbjIQSfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 14:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238354AbjIQSer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 14:34:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5111594
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 11:34:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB96C433C7;
        Sun, 17 Sep 2023 18:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694975681;
        bh=oBHKXiAaWhylyQ/KERX2Lkd4BMGD/T9k0XU2r8coW6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rKau8ERtJ1aCkNupFiwDNrNObl3COJ1LLflqmmZY9zx8PDGgnrgLe01Q1CgmQSsYE
         Bx8Pm+lAnFnykDRvvI8jU879Ssk8itcxmdoROTdvo0NKcTFMug/I1Vncqfabj3nQPr
         NHBwq56fLIFDBllNdUBEYJqhNgwXxjyOVbfPxMAM=
Date:   Sun, 17 Sep 2023 20:34:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Piro Yang <piroyangg@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vme_user: Fixed prink formatting issues
Message-ID: <2023091756-duct-agile-0023@gregkh>
References: <20230917171824.76702-1-piroyangg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917171824.76702-1-piroyangg@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 01:18:24AM +0800, Piro Yang wrote:
> Fixed issues relating to prink message including:
> 
> a. using __func__ to replace function's name
> b. using pr_warn to replace "printk(KERN_ERR"
> 
> Issue found by checkpatch
> 
> Signed-off-by: Piro Yang <piroyangg@gmail.com>
> ---
>  drivers/staging/vme_user/vme.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> index 5960562dcd96..56c528628e7d 100644
> --- a/drivers/staging/vme_user/vme.c
> +++ b/drivers/staging/vme_user/vme.c
> @@ -418,7 +418,7 @@ int vme_slave_get(struct vme_resource *resource, int *enabled,
>  	image = list_entry(resource->entry, struct vme_slave_resource, list);
>  
>  	if (!bridge->slave_get) {
> -		printk(KERN_ERR "vme_slave_get not supported\n");
> +		pr_warn("%s not supported\n", __func__);

KERN_ERR is not the same thing a pr_warn(), why did you make this
change?

And you are doing multiple things in the same change, why?

Also, drivers should always use dev_warn(), not pr_*() calls.

thanks,

greg k-h
