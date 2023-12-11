Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF06180DDE8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345575AbjLKWFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345542AbjLKWFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:05:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E7BA1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:05:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF18C433C8;
        Mon, 11 Dec 2023 22:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702332348;
        bh=bloHMn43vn2xcYsWUbR9nrxraHhVosF2Fsoh1X/v0ak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EnBgkwTBQrn4TocAdIBg9b1jOpPzMhTzGDQH4EfIh5fUy7R27G6XK/S6nJaEa5PZP
         EUVojR7pR30i6qv5U02DVimYJ0xzHOCKICpJZnmgSymnMpOkmS69ZS+zIRByd4ogK7
         f/XIcfaULXdM8jSQwiPQcZ8cSQRN1dUVV3FYvpK+b3KIimU46AQ4r8iU5/rJC2OFJo
         ZiEu6/6BqIBujpN7sE6Gu8Ejx/W7oHqV3Xr6b7MTJquofKErK7Y+Rz18SSjMPj5oky
         rq9lfFPvYcQnjX3hyQ1zvMfWxqx4y/CBjpCVFySxa1jF7ZCnbD8yi1HdOPcEhslaJ6
         BPcVSewokwbsg==
Date:   Mon, 11 Dec 2023 14:05:46 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Andrew Lunn <andrew@lunn.ch>,
        Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v3 1/2] leds: trigger: netdev: extend speeds up to 10G
Message-ID: <20231211140546.5c39b819@kernel.org>
In-Reply-To: <657784f6.5d0a0220.617b5.20ee@mx.google.com>
References: <99e7d3304c6bba7f4863a4a80764a869855f2085.1701143925.git.daniel@makrotopia.org>
        <170142826116.3357002.9561246405642038358.b4-ty@kernel.org>
        <6577315e.050a0220.50f30.0122@mx.google.com>
        <20231211084656.26578d89@kernel.org>
        <657784f6.5d0a0220.617b5.20ee@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 22:53:55 +0100 Christian Marangi wrote:
> Soo that it's problematic to also have on net-next? (Sorry for the
> stupid question)

Unless I pull from Lee the patch would be duplicated, we'd have two
commits with different hashes and the same diff. And if I pull we'd
get a lot of netdev-unrelated stuff into net-next:

$ git merge f07894d3b384344c43be1bcf61ef8e2fded0efe5
Auto-merging drivers/leds/trigger/ledtrig-netdev.c
Merge made by the 'ort' strategy.
 .../ABI/testing/sysfs-class-led-trigger-netdev     |  39 ++
 .../ABI/testing/sysfs-class-led-trigger-tty        |  56 ++
 .../bindings/leds/allwinner,sun50i-a100-ledc.yaml  | 137 +++++
 Documentation/devicetree/bindings/leds/common.yaml |   2 +-
 drivers/leds/Kconfig                               |  21 +
 drivers/leds/Makefile                              |   2 +
 drivers/leds/leds-max5970.c                        | 109 ++++
 drivers/leds/leds-sun50i-a100.c                    | 580 +++++++++++++++++++++
 drivers/leds/leds-syscon.c                         |   3 +-
 drivers/leds/leds-tca6507.c                        |  30 +-
 drivers/leds/rgb/leds-qcom-lpg.c                   |  52 +-
 drivers/leds/trigger/ledtrig-gpio.c                |  26 +-
 drivers/leds/trigger/ledtrig-netdev.c              |  32 +-
 drivers/leds/trigger/ledtrig-tty.c                 | 247 +++++++--
 drivers/tty/tty_io.c                               |  28 +-
 include/linux/leds.h                               |   3 +
 include/linux/tty.h                                |   1 +
 17 files changed, 1247 insertions(+), 121 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/allwinner,sun50i-a100-ledc.yaml
 create mode 100644 drivers/leds/leds-max5970.c
 create mode 100644 drivers/leds/leds-sun50i-a100.c
