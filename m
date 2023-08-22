Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637BA784151
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbjHVM4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjHVM4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:56:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6755ECD1;
        Tue, 22 Aug 2023 05:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0061D61A44;
        Tue, 22 Aug 2023 12:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2D9C433C7;
        Tue, 22 Aug 2023 12:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692708990;
        bh=u83VinJfs7MQi4Ly6CqCBrjqNaWBfD36bQjG7fO9JPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AqVWJUl4Qn5JOZNqMpR6VRVx0WtUZmiKEUpN/6V9A+opPY/lHktb0qcrxfFMIzI7F
         fWNfj7k/BScCJx6pZPA9h5f6gTTXZNCs8jvpGkXJ00Ggf0SWYCSLVwQG6R8jk1UmIJ
         j+K7Ze9XDSsI7s/nt1xGL4J14mHBVvGJixcKHEqs=
Date:   Tue, 22 Aug 2023 14:56:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] tty: tty_buffer: initialize variables in
 initializers already
Message-ID: <2023082232-runaround-captive-aa7a@gregkh>
References: <20230816105530.3335-1-jirislaby@kernel.org>
 <20230816105530.3335-10-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816105530.3335-10-jirislaby@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 12:55:29PM +0200, Jiri Slaby (SUSE) wrote:
> It makes the code both more compact, and more understandable.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/tty_buffer.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 414bb7f9155f..44c0adaec850 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -262,17 +262,10 @@ static int __tty_buffer_request_room(struct tty_port *port, size_t size,
>  				     bool flags)
>  {
>  	struct tty_bufhead *buf = &port->buf;
> -	struct tty_buffer *b, *n;
> -	size_t left;
> -	bool change;
> +	struct tty_buffer *n, *b = buf->tail;
> +	size_t left = (b->flags ? 1 : 2) * b->size - b->used;

That's understandable?  Hah!

I'll take it, but ick, the original:

> +	bool change = !b->flags && flags;
>  
> -	b = buf->tail;
> -	if (!b->flags)
> -		left = 2 * b->size - b->used;
> -	else
> -		left = b->size - b->used;

Is much more readable.

Well kind of, it's all a mess :)

thanks,

greg k-h
