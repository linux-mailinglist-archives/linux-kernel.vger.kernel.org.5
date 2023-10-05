Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A707BA95B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjJESoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjJESox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:44:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA1990;
        Thu,  5 Oct 2023 11:44:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9b96c3b4be4so236011266b.1;
        Thu, 05 Oct 2023 11:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696531491; x=1697136291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PFWNBtU76KeJxQDIO0H4Sfx+OEo8k0YfwMgIigfU3y4=;
        b=esLrc60YZ050PpyPfGaBa3NrN/iXKEVKVKrJwLZhl8RGs2VsmLMtGZ7hjI1BiIzEBM
         ElSzpWvQARbVZvY6OWrzKsm7e8/NdC0z0une1B1uG6gpUMlFLY0AGnpReSnjSqcWPeye
         mZ4SRfgxC4kAaC/EAlNMF+H0ODaJqCwnWTWSiwLILKjtFtxSo84Rj7oYmk9dl1f21hTw
         7MUFVf4wq7JgoxQSkf14bAEaU4R+3353cYIWXZbJigxrCIkeh3IUt3EwNt+Foqko9FNT
         Y6u6tAjlp1f4hLRtBlgXa70Ae01XC7OaJhSuXcGLmWTmE5jkAiGzrdsWZ0r60NSR9bVG
         a4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696531491; x=1697136291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFWNBtU76KeJxQDIO0H4Sfx+OEo8k0YfwMgIigfU3y4=;
        b=WPIaWMzJ38oMTUnCrsXBvGe1LCQGCOcBCAmYbco9SS+vb66YtMVPwEGzgzAj2eEGq+
         EyTTeUcwXPtjtQHDl8NwfwEzOr/tSIuMbCpl0+F6ichIJwUTVocq/oK6e/jT9owzIRTO
         qAZCQd4e2OxOV2J/8DkNavNOQoJ2H41w7UvMZcY2bTmZH8R7+4TkKzA5UHk+9yVsS+sy
         Cf8JSH+W+hlhA/epicrFqnq5/WsnPBXoTYBqQv7joHvSpBG1xZr8ol6XdWP/r5lP/Nsk
         WJDG+5NPSM5jQLynfGVBqKzvm8YRDWEYVtu+aNAxwOXtQw+4dNSrA/iumds20h9LizZZ
         seFw==
X-Gm-Message-State: AOJu0Yx6dNh816/cI7idQSpebrrqq5ClM59zSIme7DPw75eVTF0uzBl+
        fsPHGHs/2gJ3ZoQbPIGlvPeoJxmJQg==
X-Google-Smtp-Source: AGHT+IFWXvrZu4aCXs4zboJsobrVMpPTUNnb21FYrPXw/V8l88YlfWVulP2h/oXPDHUNcN0gPIm2NQ==
X-Received: by 2002:a17:907:75e5:b0:9a5:852f:10ae with SMTP id jz5-20020a17090775e500b009a5852f10aemr5208540ejc.60.1696531490553;
        Thu, 05 Oct 2023 11:44:50 -0700 (PDT)
Received: from p183 ([46.53.253.206])
        by smtp.gmail.com with ESMTPSA id ks8-20020a170906f84800b0099b6becb107sm1596011ejb.95.2023.10.05.11.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 11:44:50 -0700 (PDT)
Date:   Thu, 5 Oct 2023 21:44:44 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: stack leak via uart_get_info() ?
Message-ID: <4bb69834-405c-40da-ac3d-f5b29d2eecf0@p183>
References: <967b9ef1-fb36-48bf-9e6a-1b99af24c052@p183>
 <2023100517-washer-why-7513@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023100517-washer-why-7513@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 07:55:34PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 05, 2023 at 07:34:21PM +0300, Alexey Dobriyan wrote:
> > If this check ever triggers
> > 
> > 	static int uart_get_info(struct tty_port *port, struct serial_struct *retinfo)
> > 	{
> > 
> > 		uport = uart_port_check(state);
> > 	        if (!uport)
> > 	                goto out;
> > 
> > then all those sysfs users will print stack contents to userspace.
> > 
> > Can it trigger while sysfs read is executing?
> 
> I don't think it can ever fail, we don't even check the result in other
> places, so it should all be fine.
> 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> > 
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -775,6 +775,8 @@ static int uart_get_info(struct tty_port *port, struct serial_struct *retinfo)
> >  	struct uart_port *uport;
> >  	int ret = -ENODEV;
> >  
> > +	*retinfo = (struct serial_struct){};
> 
> This is good (although I hate the implied memcpy), a real memset would
> be best to ensure that any holes are also filled.  Want to do that, or
> want me to?

I don't mind memset(), but "struct serial_struct" structure has kernel
pointers:

	unsigned char* iomem_base;

so it is not shipped to userspace, so padding isn't an issue.
