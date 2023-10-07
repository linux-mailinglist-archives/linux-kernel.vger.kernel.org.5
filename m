Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC1F7BC664
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 11:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343750AbjJGJRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 05:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjJGJRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 05:17:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDABABD;
        Sat,  7 Oct 2023 02:17:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09543C433C8;
        Sat,  7 Oct 2023 09:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696670262;
        bh=Hj4TwF8++s63MgyWqlgNIz+WcGpWDhaMOi/4xSSl2lM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WGq38i2alQYUR8TQMyKOwcAYiDIXSgOWA8Cm0M0jXFQxYoiq1XwQKiR7+2/ZItcLb
         RQAF2vVK8dyv5CPikkKN5WQg5eXCFS5fHvcGRv7XCmq4jd85++tp7iSoBFIvc+YTyE
         Rwtfrr7UM2s0D7/u2Goo9wmV572BUdD51cqkSRBY=
Date:   Sat, 7 Oct 2023 11:17:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: add PORT_ANY definition
Message-ID: <2023100706-circle-rework-993e@gregkh>
References: <20231006115713.801322-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006115713.801322-1-jcmvbkbc@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 04:57:13AM -0700, Max Filippov wrote:
> Current pattern in the linux kernel is that every new serial driver adds
> one or more new PORT_ definitions because uart_ops::config_port()
> callback documentation prescribes setting port->type according to the
> type of port found, or to PORT_UNKNOWN if no port was detected.
> 
> When the specific type of the port is not important to the userspace
> there's no need for a unique PORT_ value, but so far there's no suitable
> identifier for that case.
> 
> Provide generic port type identifier other than PORT_UNKNOWN for ports
> which type is not important to userspace.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  include/uapi/linux/serial.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
> index 53bc1af67a41..070e50cf9e1e 100644
> --- a/include/uapi/linux/serial.h
> +++ b/include/uapi/linux/serial.h
> @@ -47,6 +47,8 @@ struct serial_struct {
>  /*
>   * These are the supported serial types.
>   */
> +/* Generic type identifier for ports which type is not important to userspace. */
> +#define PORT_ANY	(-1)

This should be at the end of the list.

And I think we need a better name, "PORT_GENERIC"?

thanks,

greg k-h
