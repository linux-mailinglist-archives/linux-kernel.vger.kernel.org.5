Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA8D7CDD30
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjJRN0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjJRN0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:26:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6044138
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:26:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12588C433C7;
        Wed, 18 Oct 2023 13:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697635573;
        bh=QibHFyUe/EPNDDhU4KtzbtUNy6mOEodj9TioLZzQ+ag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wGTnNf+Ys3HVCRBatDeBspYArhSkDCQq/SJ9wJ9HoGw7Id72lDTvgas8JTPUmzkHY
         vA6bz2PyxeGX2TfoNQmOtqtKhXx31EXv9XE/UYesjYil0+FT8Gxe0Mvko+fb1ILgK3
         NfsPThfMoOw2dFebarl11b1szGByIC4w0Ksvn8ao=
Date:   Wed, 18 Oct 2023 15:26:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/2] staging: vme_user: Replace printk() with
 pr_*(),dev_*()
Message-ID: <2023101823-unhidden-draw-d68c@gregkh>
References: <cover.1697601942.git.soumya.negi97@gmail.com>
 <a0579eeda5ce70f69b6bfdcbe534b9d37138096c.1697601942.git.soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0579eeda5ce70f69b6bfdcbe534b9d37138096c.1697601942.git.soumya.negi97@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 09:36:32PM -0700, Soumya Negi wrote:
> vme.c uses printk() to log messages. To improve and standardize message
> formatting, use logging mechanisms pr_err()/pr_warn() and
> dev_err()/dev_warn() instead. Retain the printk log levels of the
> messages during replacement.
> 
> Issue found by checkpatch.pl
> 
> Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> ---
>  drivers/staging/vme_user/vme.c | 175 ++++++++++++++++++---------------
>  1 file changed, 94 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> index 6519a7c994a0..e8c2c1e77b7d 100644
> --- a/drivers/staging/vme_user/vme.c
> +++ b/drivers/staging/vme_user/vme.c
> @@ -9,6 +9,8 @@
>   * Copyright 2004 Motorola Inc.
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

No, this is a driver, as others have pointed out, always use dev_*()
calls instead.

Yes, that means that sometimes you do need to propagate the proper
device to the function, but that's ok, it's the correct solution here.

thanks,

greg k-h
