Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D492770290
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjHDOIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjHDOIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:08:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE0C122
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:08:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F05106203B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2219C433C8;
        Fri,  4 Aug 2023 14:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691158114;
        bh=+WRwdztfVvcvK11PPGu/GvYQB8UyGhjPYg5JNWjkmuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zOvQH9eKGm5yKantARn9GqkzE/2/NdGn4CG1NNT0G7JcabMtLQMpi9N/suBj6DnlB
         /4ZS4q5uQLo6B9qLtK78X3QtGbDsxLtB76XD7bOoFFzOYn4oprQ3/1dEmS8ayMPF4k
         +EMeV3qQxVEd1uTO9zR6nsY0sjQ01xGpa3rQj+PE=
Date:   Fri, 4 Aug 2023 16:08:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wang Ming <machel@vivo.com>
Cc:     Liu Shixin <liushixin2@huawei.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] bus:Fix error checking for debugfs_create_dir() in
 mvebu_mbus_debugfs_init()
Message-ID: <2023080418-mower-bubbly-d573@gregkh>
References: <20230712132343.8802-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712132343.8802-1-machel@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 09:23:28PM +0800, Wang Ming wrote:
> debugfs_create_dir() does not return NULL,but it is
> possible to return error pointer. Most incorrect error checks
> were fixed,but the one in mvebu_mbus_debugfs_init() was forgotten.
> 
> Fix the remaining error check.
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/bus/mvebu-mbus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
> index 00cb792bda18..4c514894cc1f 100644
> --- a/drivers/bus/mvebu-mbus.c
> +++ b/drivers/bus/mvebu-mbus.c
> @@ -993,7 +993,7 @@ static __init int mvebu_mbus_debugfs_init(void)
>  		return 0;
>  
>  	s->debugfs_root = debugfs_create_dir("mvebu-mbus", NULL);
> -	if (s->debugfs_root) {
> +	if (!IS_ERR(s->debugfs_root)) {

No need for this check at all.

thanks,

greg k-h
