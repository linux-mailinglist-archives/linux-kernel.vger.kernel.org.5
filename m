Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C1D798A1C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244711AbjIHPlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239384AbjIHPlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:41:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A1113E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 08:41:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D87C433C9;
        Fri,  8 Sep 2023 15:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694187670;
        bh=3BXc76kIRMFjhnOaKfVYbjrmTmRwWhcVytEgALnadJg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JcKpgVjD/cf2ND/B2QxKZSbgci1Akt7SrzFTW1aEzPN0e8JRXPKGzeyWIAU69dOuK
         9uc1fzd6fZM3ypJ4ODlTJYhtaOxusCa6QVVk8ZR0rTwKY9GX5agjq7HCRLUsRwBmtA
         K9zFOe3Bq9e+F3R9Zqir7b8EVhbMR01UPPBYGCWtUc3Fba/B3/NAtpHdRLIIijduoz
         zKefNCBK94i+O6fqvjXL+nWf9fntYpSlGzJmoiXvIJd6drxAh0YMFRHvXY6ls8uDn4
         AR7HZJa9KHHADu7Dy0+IBUvoBRmlaKDhJqqJbEYdjU7tKurInQlMzBvmSwqxbdYeQY
         rCqa7Jm5EGCug==
Date:   Fri, 8 Sep 2023 08:41:08 -0700
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
Subject: Re: [RFC PATCH net-next 0/7] net: phy: introduce phy numbering
Message-ID: <20230908084108.36d0e23c@kernel.org>
In-Reply-To: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Sep 2023 11:23:58 +0200 Maxime Chevallier wrote:
>  - the netlink API would need polishing, I struggle a bit with finding
>    the correct netlink design pattern to return variale-length list of u32.

Think of them as a list, not an array.

Dump them one by one, don't try to wrap them in any way:
https://docs.kernel.org/next/userspace-api/netlink/specs.html#multi-attr-arrays
People have tried other things in the past:
https://docs.kernel.org/next/userspace-api/netlink/genetlink-legacy.html#attribute-type-nests
but in the end they add constraints and pain for little benefit.
