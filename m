Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECFE769C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjGaQWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjGaQWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:22:31 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2659A7;
        Mon, 31 Jul 2023 09:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=RBXOtrD3ZlEhqpLX1FdhLeJavuxWtGfwI1ATytFWQb8=; b=UiIuoVqEYu3NR1hGJVRxRVn3bQ
        FcamShq7Ai1mI/W3PvHdyZJwpyAvpQc4W5Qac0gyeYVGB9lwiHktKxPNWmdbJ/A+yeeEZ91PkKcbs
        ZP2Raqh4BqUHratH+wjTBGKT/RyOTxnCNC4FMMF+Sigzz4mtAwbL/mr49f5DDl+nTnNM=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:53968 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qQVev-0006ZN-7g; Mon, 31 Jul 2023 12:22:13 -0400
Date:   Mon, 31 Jul 2023 12:22:12 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, Lech Perczak <lech.perczak@camlingroup.com>
Message-Id: <20230731122212.3f64d0dc5adf8d23eee1de62@hugovil.com>
In-Reply-To: <2023073108-footboard-chooser-d20e@gregkh>
References: <20230725142343.1724130-1-hugo@hugovil.com>
        <20230725142343.1724130-3-hugo@hugovil.com>
        <2023073108-footboard-chooser-d20e@gregkh>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v9 02/10] serial: sc16is7xx: mark IOCONTROL register as
 volatile
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 17:50:40 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Jul 25, 2023 at 10:23:34AM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Bit SRESET (3) is cleared when a reset operation is completed. Having
> > the IOCONTROL register as non-volatile will always read SRESET as 1,
> > which is incorrect.
> > 
> > Also, if IOCONTROL register is not a volatile register, the upcoming
> > patch "serial: sc16is7xx: fix regression with GPIO configuration"
> > doesn't work when setting some shared GPIO lines as modem control
> > lines.
> > 
> > Therefore mark IOCONTROL register as a volatile register.
> > 
> > Cc: <stable@vger.kernel.org> # 6.1.x
> 
> Why 6.1.y?  What commit does this fix?
> 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> > Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
> > ---
> >  drivers/tty/serial/sc16is7xx.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> > index 8ae2afc76a9b..306ae512b38a 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -488,6 +488,7 @@ static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
> >  	case SC16IS7XX_TXLVL_REG:
> >  	case SC16IS7XX_RXLVL_REG:
> >  	case SC16IS7XX_IOSTATE_REG:
> > +	case SC16IS7XX_IOCONTROL_REG:
> >  		return true;
> >  	default:
> >  		break;
> 
> Is this the same as this change:
> 	https://lore.kernel.org/all/20230724034727.17335-1-hui.wang@canonical.com/
> 
> confused,

Hi Greg,
yes this is the same.

You simply accepted an exact equivalent of my patch by someone else in
your tree, no confusion there.

I will remove this patch from my series and rebase it on your tree
gregkh_tty/tty-next.

Hugo.
