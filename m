Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCC2792BDA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245000AbjIERCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353859AbjIEIWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:22:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81D5CC7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:22:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5052460ABD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 08:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC4EC433C7;
        Tue,  5 Sep 2023 08:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693902165;
        bh=o+ZGlAMObEDJBIPsyoWsE0YE8FuZ4lKzyNTKvi6BMhY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KiSwNP5L91KskXMYDz3YRi1JHcGLqINOPP0MoeZW2Ditw67Og9uAxojKUEGP2v0kR
         ILHhtv5oU/ERoIO8Ix4RY2bxpfNhEPq1ub08HBXfBP4cnAWSfToHK/glteix06dbZk
         m34yk8I9QEphfPGJjFUqkAktXyImdVdq7RCc2O10SC8m5xqwMO2aQzLQ+asam2TSm5
         1desbj3jzAQTgPoQZWwaCg2IUvi3bmtViwi3KCe8RA48qp+Pe3Tma8TzLEPGJ0yqul
         v2j2PN00SB5kdRVNFORgg330GvyvOcnEzbZ91RdrZu8xvgxfjIYg4iaScwjoLT+Usb
         CmTrZzaGjtmhQ==
MIME-Version: 1.0
Date:   Tue, 05 Sep 2023 10:22:40 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?Q?Marek_B?= =?UTF-8?Q?eh=C3=BAn?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 02/11] net: phy: introduce
 phy_has_c45_registers()
In-Reply-To: <ZMrYcbY65yOZyaxo@shell.armlinux.org.uk>
References: <7be8b305-f287-4e99-bddd-55646285c427@lunn.ch>
 <867ae3cc05439599d63e4712bca79e27@kernel.org>
 <cf999a14e51b7f2001d9830cc5e11016@kernel.org>
 <ZMkddjabRonGe7Eu@shell.armlinux.org.uk>
 <bce942b71db8c4b9bf741db517e7ca5f@kernel.org>
 <ZMkraPZvWWKhY8lT@shell.armlinux.org.uk>
 <b0e5fbe28757d755d814727181c09f32@kernel.org>
 <7c29bfa7-b4a6-49c9-9369-d98bae98f135@lunn.ch>
 <ZMqOA+NblHun1hbo@shell.armlinux.org.uk>
 <cdd97217-d5e5-429b-bcda-2248f0de12ce@lunn.ch>
 <ZMrYcbY65yOZyaxo@shell.armlinux.org.uk>
Message-ID: <e7ecdbc54d55316735cd1d39dd31cc77@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Hence why I disagree with your suggestion.

So how can we make progress here? I tried Russells suggestion using
phy_supports_c45_transfers() and phy_has_c22_registers(). You can find
a possible v4 of this series on my github [1].

Some uses of .is_c45 seem to be to test whether the c45_ids are valid. 
E.g.
from the phy.h:
* @c45_ids: 802.3-c45 Device Identifiers if is_c45.

But if you test if a bit is set, you can skip that. For the opposite 
test
you'd need to have some kind of indication whether c45_ids was populated
in the first place.

If you convert all these uses of is_c45, there will only be a handful
of uses left. And replacing these by phy_supports_c45_transfers() sounds
sane to me except for for these two:
(1) drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
(2) drivers/net/phy/mxl-gpy.c

(2) will eventually replaced by my phy_promote_to_c45(). I might reorder
the patches, so I'll get rid of the .is_c45 use there before the
conversion to phy_supports_c45_transfers().

But honestly, for (1) I don't have any idea whats going on. If I look
at the very first commit, it seems that the is_c45 property is used
to distinguish loopback handling between a gigabit and a 10g PHY (?).

Btw, Russell, I've noticed that phy_restart_aneg() and phy_config_aneg()
will test for c22 registers, but phy_aneg_done() tests just for .is_c45.
Is that correct?

-michael

[1] https://github.com/mwalle/linux/tree/feature-c45-over-c22-v4
[2] 
https://git.kernel.org/torvalds/c/b5996f11ea5496d0445078f47d22c987888ed467
