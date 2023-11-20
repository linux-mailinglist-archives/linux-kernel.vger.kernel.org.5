Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78647F0EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjKTJOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjKTJOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:14:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C2EBA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:14:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441F9C433C8;
        Mon, 20 Nov 2023 09:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700471681;
        bh=k6d0lM2+y9b16G3yyqRXaBCz7ulXb/nq5YVNLW0SRa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RhdxgwzTZTzphlnqO+ks94VV8+EVDg2G3VZURo5HN+D0ghfDpb4gw6Yx5Ozld/FZd
         m/he1krbAShfl8untN3cb1ZaXgVM2/4HY0DaLqoGvIZRPFA4W+/4uUOUP4vVNy7OW1
         oJSsHaK3fAdy7F43iUsEj0X7sJEQ/1AoP98azjm4=
Date:   Mon, 20 Nov 2023 10:14:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     tomas.winkler@intel.com, arnd@arndb.de, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        alexander.usyskin@intel.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] misc: mei: client.c: fix some error code problem in
 mei_cl_write
Message-ID: <2023112010-ceremony-salad-145b@gregkh>
References: <20231120085343.157381-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120085343.157381-1-suhui@nfschina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 04:53:45PM +0800, Su Hui wrote:
> Clang static analyzer complains that value stored to 'rets' is never
> read. Remove some useless code, and let 'buf_len = -EOVERFLOW' to make
> sure we can return '-EOVERFLOW'.
> 
> mei_msg_hdr_init() return negative error code, rets should be
> 'PTR_ERR(mei_hdr)' rather than '-PTR_ERR(mei_hdr)'.
> 
> Fixes: 0cd7c01a60f8 ("mei: add support for mei extended header.")
> Fixes: 8c8d964ce90f ("mei: move hbuf_depth from the mei device to the hw modules")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/misc/mei/client.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
> index 9c8fc87938a7..00dac0a47da0 100644
> --- a/drivers/misc/mei/client.c
> +++ b/drivers/misc/mei/client.c
> @@ -2011,7 +2011,7 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb, unsigned long time
>  
>  	mei_hdr = mei_msg_hdr_init(cb);
>  	if (IS_ERR(mei_hdr)) {
> -		rets = -PTR_ERR(mei_hdr);
> +		rets = PTR_ERR(mei_hdr);

This looks like a bugfix, while the other changes here are just a normal
cleanup.  Can you please split this up into different patches?

thanks,

greg k-h
