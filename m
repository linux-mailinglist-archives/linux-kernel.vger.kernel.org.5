Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E51F769679
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjGaMhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGaMhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:37:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C21BE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:37:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D6BD61121
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D63AC433C8;
        Mon, 31 Jul 2023 12:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690807070;
        bh=ApO8m6zye0g9dKvQHchLqDIT5ABjMHIonrwA8y0QdUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bJhuf4fjEgdjXZ73s8E05Vs30ZDVmj/tO1dDknsdkXkUWDna0+IluAgHWkfnIR3Ev
         54eJwIBKoKZsfH/lcvfN+HwrqV4Pf4QKLTTwuAMM1eoVK33lkJt6RdGARSd4lU6Vb8
         iE0n4CjHeZJPzT40wuj/BNVfYGqEDUhevMs/aJik=
Date:   Mon, 31 Jul 2023 14:24:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@amd.com, git@amd.com, nikhil.agarwal@amd.com,
        Nipun.Gupta@amd.com
Subject: Re: [PATCH v2 1/4] cdx: Introduce lock to protect controller ops and
 controller list
Message-ID: <2023073148-carried-unshaved-77e4@gregkh>
References: <20230731120813.123247-1-abhijit.gangurde@amd.com>
 <20230731120813.123247-2-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731120813.123247-2-abhijit.gangurde@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 05:38:10PM +0530, Abhijit Gangurde wrote:
> Add a mutex lock to prevent race between controller ops initiated by
> the bus subsystem and the controller registration/unregistration.
> 
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> ---
>  drivers/cdx/cdx.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index d2cad4c670a0..66797c8fe400 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -72,6 +72,8 @@
>  
>  /* CDX controllers registered with the CDX bus */
>  static DEFINE_XARRAY_ALLOC(cdx_controllers);
> +/* Lock to protect controller ops and controller list */
> +static DEFINE_MUTEX(cdx_controller_lock);

Wait, why do you have a local list and not just rely on the list the
driver core has for you already?  Isn't this a duplicate list where you
have objects on two different lists with a lifespan controlled only by
one of them?

thanks,

greg k-h
