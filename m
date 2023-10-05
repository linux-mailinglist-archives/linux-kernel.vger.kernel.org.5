Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429447BA883
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjJER4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjJERzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:55:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA53EE;
        Thu,  5 Oct 2023 10:55:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82002C433C7;
        Thu,  5 Oct 2023 17:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696528538;
        bh=syrxBjcZsi/Kog//nnV2tNttcVlAwK5eng/5m4lhvGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CmqQBLZ1xFpKi+cuDEg6u4hCv7CRv257LFpQZs9CWOAr5UGFLNwni2tKsA9Qm9oiD
         VSaetGacFCk323jeULlESt+CsK0pMCQOwPbAbmFz3ZzbYFZrx2HCRVulSJ6/iTt/Kv
         Jq4nLoxThnUyL5Keov8m02Q97IJc5cuyyhLEv/oM=
Date:   Thu, 5 Oct 2023 19:55:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: stack leak via uart_get_info() ?
Message-ID: <2023100517-washer-why-7513@gregkh>
References: <967b9ef1-fb36-48bf-9e6a-1b99af24c052@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <967b9ef1-fb36-48bf-9e6a-1b99af24c052@p183>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 07:34:21PM +0300, Alexey Dobriyan wrote:
> If this check ever triggers
> 
> 	static int uart_get_info(struct tty_port *port, struct serial_struct *retinfo)
> 	{
> 
> 		uport = uart_port_check(state);
> 	        if (!uport)
> 	                goto out;
> 
> then all those sysfs users will print stack contents to userspace.
> 
> Can it trigger while sysfs read is executing?

I don't think it can ever fail, we don't even check the result in other
places, so it should all be fine.

> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -775,6 +775,8 @@ static int uart_get_info(struct tty_port *port, struct serial_struct *retinfo)
>  	struct uart_port *uport;
>  	int ret = -ENODEV;
>  
> +	*retinfo = (struct serial_struct){};

This is good (although I hate the implied memcpy), a real memset would
be best to ensure that any holes are also filled.  Want to do that, or
want me to?

thanks,

greg k-h
