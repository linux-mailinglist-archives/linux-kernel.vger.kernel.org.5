Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCCF798681
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 13:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbjIHLhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 07:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjIHLhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 07:37:07 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547F01BE7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 04:37:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qeZnF-0007tr-F7; Fri, 08 Sep 2023 13:36:57 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qeZnE-004rrl-2v; Fri, 08 Sep 2023 13:36:56 +0200
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qeZnD-003K9l-Gt; Fri, 08 Sep 2023 13:36:55 +0200
Date:   Fri, 8 Sep 2023 13:36:55 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>, Yanik Fuchs <Yanik.fuchs@mbv.ch>
Subject: Re: [PATCH] wifi: rtw88: rtw8723d: Fix MAC address offset in EEPROM
Message-ID: <20230908113655.GF637806@pengutronix.de>
References: <20230907071614.2032404-1-s.hauer@pengutronix.de>
 <bed0e0cacc44476582fc58180d77519c@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bed0e0cacc44476582fc58180d77519c@realtek.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 12:23:13AM +0000, Ping-Ke Shih wrote:
> 
> 
> > -----Original Message-----
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Thursday, September 7, 2023 3:16 PM
> > To: linux-wireless@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih <pkshih@realtek.com>; Yanik
> > Fuchs <Yanik.fuchs@mbv.ch>
> > Subject: [PATCH] wifi: rtw88: rtw8723d: Fix MAC address offset in EEPROM
> > 
> > The MAC address is stored at offset 0x107 in the EEPROM, like correctly
> > stated in the comment. Add a two bytes reserved field right before the
> > MAC address to shift it from offset 0x105 to 0x107.
> > 
> > With this the MAC address returned from my RTL8723du wifi stick can be
> > correctly decoded as "Shenzhen Four Seas Global Link Network Technology
> > Co., Ltd."
> 
> With this correctness, my stick can be recognized as: 
> " Bus 003 Device 010: ID 0bda:d723 Realtek Semiconductor Corp. 802.11n WLAN Adapter"

It should be recognized like this also without this patch, but with this
patch the MAC address should be read correctly.

> 
> Should it add a Fixes tag? 
> Fixes: 87caeef032fc ("wifi: rtw88: Add rtw8723du chipset support")

Yes, I forgot this. Kalle, can you add it once again while applying?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
