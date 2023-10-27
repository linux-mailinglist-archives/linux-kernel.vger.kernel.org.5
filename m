Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D390E7D8EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345189AbjJ0Gnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0Gne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:43:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CC9121;
        Thu, 26 Oct 2023 23:43:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AF0C433C8;
        Fri, 27 Oct 2023 06:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698389011;
        bh=KGXKiq9/VImXyR51J/+ak66IF52o9zUiuOaFpU02Cmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tjwp8i+he7nUfKuVK7ic7roJ2dFtUlSeXz23MOZBAwAPCphfUilacNafOWwde3iQ0
         U/nh4WG9WuOwFDNoKHJZy6RaP3GvT4plh6co7Gz8/wtrlROCeXmE91Xaw+UXjJak3r
         vp2KdPo4ZoEkVfRJhxO1bgcWbXZmmPAmi7ZD4P2k=
Date:   Fri, 27 Oct 2023 08:43:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vamshi Gajjela <vamshigajjela@google.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, ilpo.jarvinen@linux.intel.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
Subject: Re: [PATCH v3 3/3] serial: core: Update uart_poll_timeout() function
 to return unsigned long
Message-ID: <2023102712-frolic-bush-3d67@gregkh>
References: <20231026135628.2800617-1-vamshigajjela@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026135628.2800617-1-vamshigajjela@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 07:26:28PM +0530, Vamshi Gajjela wrote:
> From: VAMSHI GAJJELA <vamshigajjela@google.com>

Please use lower case letters like I think you mean to?

Also, where are patches 1/3 and 2/3 of this series?  I can't do anything
without them as well.

> The function uart_fifo_timeout() returns an unsigned long value, which
> is the number of jiffies. Therefore, change the variable timeout in the
> function uart_poll_timeout() from int to unsigned long.
> Change the return type of the function uart_poll_timeout() from int to
> unsigned long to be consistent with the type of timeout values.
> 
> Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
> ---
> v3:
> - updated description
> v2:
> - unsigned long instead of unsigned int
> - added () after function name in short log
> - updated description
> 
>  include/linux/serial_core.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index bb6f073bc159..6916a1d7e477 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -773,9 +773,9 @@ static inline unsigned long uart_fifo_timeout(struct uart_port *port)
>  }
>  
>  /* Base timer interval for polling */
> -static inline int uart_poll_timeout(struct uart_port *port)
> +static inline unsigned long uart_poll_timeout(struct uart_port *port)
>  {
> -	int timeout = uart_fifo_timeout(port);
> +	unsigned long timeout = uart_fifo_timeout(port);
>  
>  	return timeout > 6 ? (timeout / 2 - 2) : 1;

So we are now doing 64bit math?  Did that just make things slower?

What bug is this actually fixing?  How have you tested this to verify it
works?

thanks,

greg k-h
