Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8B276A8EF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjHAGYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjHAGXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:23:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6104226B5;
        Mon, 31 Jul 2023 23:23:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91D876130B;
        Tue,  1 Aug 2023 06:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C464C433C7;
        Tue,  1 Aug 2023 06:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690871000;
        bh=sV2Zm0kBAMSrCeyGVjK76flPxnbWT5/g+TdWt8iisNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lKGukOoxdaP8wCrzKiXWdvkEtD9bIHazQpImZGxN/U6e+zNlas3LfVp9ZXzoO3tlG
         UwcJ5U5teTN3fNXwlCs252+NfDGeR+5M6vRi7pCueaE+cG/JWb2hTXxlLRwpcwWVdS
         8RCRodhfpl/0oTlU4/YlA9L7V7QkIjLe7RHpUxwE=
Date:   Tue, 1 Aug 2023 08:22:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5ZGo5Z+O5Lic?= <zhouscd@gmail.com>
Cc:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de, john@keeping.me.uk,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: gadget: Fix the function name error in
 sourcesink/loopback.
Message-ID: <2023080108-resilient-citation-9a34@gregkh>
References: <20230801045449.156348-1-zhouscd@gmail.com>
 <2023080159-uncorrupt-chamber-7de0@gregkh>
 <CAN4mUXNNM-25oCx1jjVqqoPpX1P8Z4zkjh84Azprz52O4_AMNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN4mUXNNM-25oCx1jjVqqoPpX1P8Z4zkjh84Azprz52O4_AMNw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 02:15:50PM +0800, 周城东 wrote:
> Hi,  Greg KH
> 
> > I do not understand this text at all, sorry.
> > What exactly is broken and what is changed here to resolve the issue?
> 
> The reason for the problem is that the value of struct
> usb_function.name is "loopback", while struct usb_function_driver.name
> is "Loopback". The same issue exists for sourcesink. When using USB
> Config FS, it won't be possible to enable these two functions.

Please document this in the changelog text.

> > And please use your full name for patches.
> 
> I'm sorry, this is my first time sending kernel patch. How should I
> modify my name for the patch that has already been sent? Or should I
> resend a new patch?

Yes, you need to send a new version, please read the section entitled
"The canonical patch format" in the kernel file,
Documentation/process/submitting-patches.rst for what needs to be done
here.

> > You just changed a user-visable api, right?  Where did you document this
> >  and what will it affect?
> 
> Yes, I removed lb_modexit and lb_modinit and used a simpler method for
> function initialization. This does not affect any other
> functionalities. In the old way, the loopback function was called by
> sslb_modinit in sourcesink. I believe this is not a good approach as
> the loopback and sourcesink should be independent functionalities.
> Their purpose is to provide simple examples for USB beginners like myself.

But you changed the name:

> > > -     ss->function.name = "source/sink";
> > > +     ss->function.name = "sourcesink";

isn't that visable to userspace?

thanks,

greg k-h
