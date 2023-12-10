Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F6F80BD73
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 22:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjLJVuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 16:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJVue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 16:50:34 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4444CF;
        Sun, 10 Dec 2023 13:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FewMH2e65vLlSlAlvvNbXt8MICx3KL/gTD+zmuCLG/M=; b=6WiLE4GA5TFbCooHIYnga01kqi
        C9hC0tViHv8oP/IZ6ouEkJOJNTTBo9p9fDtohOZQrmuQE/sn1LhQYcz9RrtbjbA5scS17WxgpJB/a
        19cH/bH7JhQX0j/yQulhoVdzdL+vzgT5afCQLKFQj9NeoWKOn6HfgLJaZn4eI4oU63nyIIhh62cDk
        7i8TvxqJnsgft3IGV+iWvvS95Drk1+D6redXYCChqM8SemB515nFbJ+AO0wPJeotDuI9rMqyZtd/f
        8XZjfOXNs4lSWIyfbTjYIwi7emWjZAgwvn7KnzznksExdl8fythfBpONpgD1ooTCCyqp6bRJvJdR3
        1zALeNZw==;
Received: from p200301077700c3001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:c300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1rCRh5-007FGn-Fp; Sun, 10 Dec 2023 22:50:35 +0100
Date:   Sun, 10 Dec 2023 22:50:32 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        johan@kernel.org, arnd@arndb.de, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, tomi.valkeinen@ideasonboard.com,
        Tony Lindgren <tony@atomide.com>,
        =?UTF-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>,
        robh@kernel.org
Subject: Re: [RFC PATCH 3/3] drivers: misc: ti-st: begin to deorbit
Message-ID: <20231210225032.38d8c36f@aktux>
In-Reply-To: <2023112729-qualify-relearn-6a72@gregkh>
References: <20231126191840.110564-1-andreas@kemnade.info>
        <20231126191840.110564-4-andreas@kemnade.info>
        <2023112729-qualify-relearn-6a72@gregkh>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, 27 Nov 2023 08:25:46 +0000
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sun, Nov 26, 2023 at 08:18:40PM +0100, Andreas Kemnade wrote:
> > The TI-ST driver seems not to be used anymore. For bluetooth needs
> > there is hci_ll.c which has device tree support and can work without
> > this one. Also firmware download support is there, so it is also not needed
> > here. GPS can also reuse parts of the framework in hci_ll
> > 
> > Contrary from this driver, device tree support has been removed.
> > 
> > So start deorbiting it by marking it as broken.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  drivers/misc/ti-st/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/misc/ti-st/Kconfig b/drivers/misc/ti-st/Kconfig
> > index 1503a6496f632..6bf9cc845745c 100644
> > --- a/drivers/misc/ti-st/Kconfig
> > +++ b/drivers/misc/ti-st/Kconfig
> > @@ -7,7 +7,7 @@ menu "Texas Instruments shared transport line discipline"
> >  config TI_ST
> >  	tristate "Shared transport core driver"
> >  	depends on NET && TTY
> > -	depends on GPIOLIB || COMPILE_TEST
> > +	depends on GPIOLIB || COMPILE_TEST || BROKEN  
> 
> Why not just delete it?  Why have it stick around any longer?
> 
Well, I just thought that marking something as broken and then deleting
it if no one complains would be the standard procedure. So we can
delete it now since there are obviously no users (no board files, no
device tree support)?

The logical connection between the other patches of this series is given
only by the fact that patches 1+2 are for me the proof that we do not
need that ti-st driver. 
I think since there are no in-tree users, having that proof in lkml is
enough, so we can probably remove the driver now?

I will send a separate remove patch including going with a brush through
include/linux/ti_wilink_st.h

Regards,
Andreas
