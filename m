Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AD27632D2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjGZJvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbjGZJvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:51:10 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18542689
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=P0tMwfIEsQghasQIr74ILSz3V6gVl2gZXyyyBjB8MHs=; b=JqeAjBhQ+UeX4DjC6iXqnjy3Hz
        aHkAjcDDJTNIsF/c8W5jvaNZJDVYTTjnCun8LPnQWSvQYtpI3hK/P73GCoM8YtBPzhhSsLlUQaBqH
        laO360LCBCYvb9wKuYDhEtJsT+Ze1sxh9FOauUVwLYAOLNL1F54cRaDz8Pfs+r+v6s1BmXfTyZU1p
        KfDOmrk/mz0d3qGut/d6lzoCiVERWsQpgJYVVGaIHLg7AoqXt7yT0xdFsNojQYgZLzsf83PI04avf
        kyJeUQj+SgsaMHBVIbeimkGP2Ml1ZTUebQBkEN9CU1BzbEiZam6jTfBbNwCea1eP/rJaTkAXe2daC
        3QqEGXuQ==;
Received: from [192.168.1.4] (port=36991 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qObAH-00059K-1T;
        Wed, 26 Jul 2023 11:50:41 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Wed, 26 Jul 2023 11:50:41 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <olteanv@gmail.com>
CC:     <andrew@lunn.ch>, <ante.knezic@helmholz.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: Add erratum 3.14 for 88E6390X and 88E6190X
Date:   Wed, 26 Jul 2023 11:50:40 +0200
Message-ID: <20230726095040.12690-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20230725172343.qcqmcoygyhcgunmh@skbuf>
References: <20230725172343.qcqmcoygyhcgunmh@skbuf>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 20:23:43 +0300 Vladimir Oltean wrote:
> I'm not sure which way is preferred by PHY maintainers, but it seems to
> be a useless complication to simulate that you have a struct mdio_device
> for the other lanes when you don't. It appears more appropriate to just
> use mdiobus_c45_write(mpcs->mdio.bus, lanes[i]).
> 

Agreed.

> There's also the locking question (with the big caveat that we don't
> know what the register writes do!). There's locking at the bus level,
> but the MDIO device isn't locked. So phylink on those other PCSes can
> still do stuff, even in-between the first and the second write to
> undocumented register 0xf054.
> 
> I can speculate that writing 0x400c -> 0x4000 is something like: set
> RX_RESET | TX_RESET followed by clear RX_RESET | TX_RESET. Is it ok if
> stuff happens in between these writes - will it stick, or does this
> logically interact with anything else in any other way? I guess we won't
> know. I might be a bit closer to being okay with it if you could confirm
> that some other (unrelated) register write to the PCS does make it
> through (and can be read back) in between the 2 erratum writes.

I was able to confirm this by successfully reading and writing to the 
SGMII_BMCR register between erratum writes. This did not affect the issue
that erratum fixes. Unfortunatelly, there is no info about what the
actuall writing to magic registers does.

>>  static int mv88e639x_sgmii_pcs_post_config(struct phylink_pcs *pcs,
>>  	                                   phy_interface_t interface)
>>  {
>>  	struct mv88e639x_pcs *mpcs = sgmii_pcs_to_mv88e639x_pcs(pcs);
>> +	struct mv88e6xxx_chip *chip = mpcs->chip;
>>  
>>  	mv88e639x_sgmii_pcs_control_pwr(mpcs, true);
>>  
>> +	if (chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6190X ||
>> +	    chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6390X)
>> +	        mv88e6390_erratum_3_14(mpcs);
>
>You could at least print an error if a write failure occurred, so that
>it doesn't go completely unnoticed.

Ok, I was simply following the above notion (we don't check or print 
errors when powering on the serdes lane) but I agree with your point and 
will adapt the patch for the next version.

