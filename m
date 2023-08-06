Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4923F77159D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 16:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjHFO1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 10:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjHFO1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 10:27:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285DDE49;
        Sun,  6 Aug 2023 07:27:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A21BB6117F;
        Sun,  6 Aug 2023 14:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD045C433C8;
        Sun,  6 Aug 2023 14:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691332050;
        bh=k7Wz5My+7y3gVES1fFNpSuU/X31s8HmopFxP7aidXy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hOhrseXDh8smzJLqzn5JMnrQ1JlOrcR/7m0rx32YCV/jfEvBxLxJLP26t1eKCCm3R
         ap5kt7nu01tatM0i4du1IW4yIO5zzSbWCbw/P3AeRJFfoWY6xllJF11Oww2hvBdgX4
         MpqQ8p53clg9JYy89ix1047wMe9DLCjm4wX+hQWs=
Date:   Sun, 6 Aug 2023 16:27:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     jgross@suse.com, xen-devel@lists.xenproject.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen: fix potential shift out-of-bounds in
 xenhcd_hub_control()
Message-ID: <2023080659-turban-exemption-1196@gregkh>
References: <tencent_15DD79B42AD8A0D64A7CDC24D4FE6C85800A@qq.com>
 <2023062628-shame-ebook-56f2@gregkh>
 <4825193.GXAFRqVoOG@localhost.localdomain>
 <tencent_942CC5C35E410E3545C2E386BE566B8B1405@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_942CC5C35E410E3545C2E386BE566B8B1405@qq.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2023 at 10:11:43PM +0800, Zhang Shurong wrote:
> 在 2023年7月1日星期六 CST 下午11:51:43，Zhang Shurong 写道：
> > 在 2023年6月26日星期一 CST 下午1:52:02，您写道：
> > 
> > > On Mon, Jun 26, 2023 at 07:48:05AM +0200, Jan Beulich wrote:
> > > > On 25.06.2023 18:42, Zhang Shurong wrote:
> > > > > --- a/drivers/usb/host/xen-hcd.c
> > > > > +++ b/drivers/usb/host/xen-hcd.c
> > > > > @@ -456,6 +456,8 @@ static int xenhcd_hub_control(struct usb_hcd *hcd,
> > > > > __u16 typeReq, __u16 wValue,> >
> > > > > 
> > > > >  			info->ports[wIndex - 1].c_connection =
> > 
> > false;
> > 
> > > > >  			fallthrough;
> > > > >  		
> > > > >  		default:
> > > > > +			if (wValue >= 32)
> > > > > +				goto error;
> > > > > 
> > > > >  			info->ports[wIndex - 1].status &= ~(1
> > 
> > << wValue);
> > 
> > > > Even 31 is out of bounds (as in: UB) as long as it's 1 here rather
> > > > than 1u.
> > > 
> > > Why isn't the caller fixed so this type of value could never be passed
> > > to the hub_control callback?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Although I'm not knowledgeable about the USB subsystem, I've observed that
> > not all driver code that implements hub_control callback performs a shift
> > operation on wValue, and not all shift operations among them cause
> > problems. Therefore, I've decided to fix this issue within each driver
> > itself.
> > 
> > For example, in r8a66597_hub_control, it will first check whether wValue is
> > valid (always < 31) before the shift operation. In case of an invalid
> > number, the code would execute the error branch instead of the shift
> > operation.
> > 
> > switch (wValue) {
> > case USB_PORT_FEAT_ENABLE:
> > 	rh->port &= ~USB_PORT_STAT_POWER;
> > 	break;
> > case USB_PORT_FEAT_SUSPEND:
> > 	break;
> > case USB_PORT_FEAT_POWER:
> > 	r8a66597_port_power(r8a66597, port, 0);
> > 	break;
> > case USB_PORT_FEAT_C_ENABLE:
> > case USB_PORT_FEAT_C_SUSPEND:
> > case USB_PORT_FEAT_C_CONNECTION:
> > case USB_PORT_FEAT_C_OVER_CURRENT:
> > case USB_PORT_FEAT_C_RESET:
> > 	break;
> > default:
> > 	goto error;
> > }
> > rh->port &= ~(1 << wValue);
> 
> Hi there. I apologize for reaching out once more. I'm feeling a bit puzzled 
> about what my next step should be. I'm unsure whether I should rewrite this 
> patch or attempt to address the issue at the caller level.

Try addressing it at the caller level first please.  If that somehow
does not work, then we will take a patch series that fixes all of the
host controller drivers at once.

thanks,

greg k-h
