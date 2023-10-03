Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9E57B6AEE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbjJCNzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjJCNzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:55:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EF5B7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:55:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4BCC433C9;
        Tue,  3 Oct 2023 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696341342;
        bh=RehqYHD6T9b4MqkacWDHh6XWfs2/J+zU49r0P9HOHb8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KXpPCd6PFi2WwOjKwlOgrSI7MBF5fd6TGaZIcrzCeCExQos1tKIg5hjcRx+z9rOu+
         7tOuJu2YCqW4ZHEUwCoSJyKDUyuk2eqdlU/qrHmSBx2bSJBiAkViz3ooZUKQFEbP6d
         kxEPB8YrkHzGm+DBjNVSwslBHxraQ7Uib6VjvUliQIwqwPTqCLcGgZGReHxMz5dUNR
         79XWxmSmCRLQP/kosQh4SKpONj3URHPYbAkKXY1kw0gATD6ILvSNFLJT2uL/c8sHW3
         fAG7WSzjJvUPF74EQ6hdCzbWL5ZNILVkqp/yz4yoqsD3bBN9bldBa8wRhbXxLsnG78
         1QwGjzWuHZcWg==
Date:   Tue, 3 Oct 2023 06:55:35 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>,
        thomas.petazzoni@bootlin.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 6/7] net: ethtool: add a netlink command to
 get PHY information
Message-ID: <20231003065535.34a3a4e0@kernel.org>
In-Reply-To: <20230914113613.54fe125c@fedora>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
        <20230907092407.647139-7-maxime.chevallier@bootlin.com>
        <20230908084606.5707e1b1@kernel.org>
        <20230914113613.54fe125c@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023 11:36:13 +0200 Maxime Chevallier wrote:
> I'm currently implementing this, and I was wondering if it could be
> worth it to include a pointer to struct phy_device directly in
> ethnl_req_info.
>=20
> This would share the logic for all netlink commands that target a
> phy_device :
>=20
>  - plca
>  - pse-pd
>  - cabletest
>  - other future commands
>=20
> Do you see this as acceptable ? we would grab the phy_device that
> matches the passed phy_index in the request, and if none is specified,
> we default to dev->phydev.

You may need to be careful with that. It could work in practice but=20
the req_info is parsed without holding any locks, IIRC. And there
may also be some interplay between PHY state and ethnl_ops_begin().

=46rom netlink perspective putting the PHY info in the header nest makes
perfect sense to me. Just not sure if you can actually get the object
when the parsing happens or you'd need to just store the index and
resolve it later? PHYLIB maintainers may be best at advising on the
lifetime expectations for phys..

Sorry for the delayed response, #vacation.
