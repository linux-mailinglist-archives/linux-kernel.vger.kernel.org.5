Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F323771DA1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjHGJ4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjHGJ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:56:53 -0400
X-Greylist: delayed 520 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Aug 2023 02:56:52 PDT
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [IPv6:2001:1600:3:17::8faf])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA5AF4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:56:51 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RKBMY4RNRzMpntf;
        Mon,  7 Aug 2023 09:48:09 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RKBMX6qBgztQ;
        Mon,  7 Aug 2023 11:48:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=smartandconnective.com; s=20191114; t=1691401689;
        bh=0dDAO1bt/2vWPfDekSlH01rl3211+tDoxSvSMKqyrA0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=V9qiAjkMjTDbr7D9WqO0lKigdfdlzbj+HEe9bSOiA2pHQki2d+2hm5wmdTi1R/8gH
         IqjrqYTt/3u33aMgG7CFrDQJf4T3C2f3z1Nm4Jfjm3mE27uhw+KNl1oUPBFIN2gSS9
         05Kk15y2TVHMuUbJfmMGDZ3C7yIGqRmZyjl7Mw0U=
Message-ID: <6cd83d97f76217e10ebc8ea788e38db671218ab6.camel@smartandconnective.com>
Subject: Re: [PATCH] tty: serial: imx: fix rs485 rx after tx
From:   Sebastien Laveze <slaveze@smartandconnective.com>
To:     Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org,
        Thibaud Canale <tcanale@smartandconnective.com>
Date:   Mon, 07 Aug 2023 11:48:08 +0200
In-Reply-To: <20230616104838.2729694-1-martin.fuzzey@flowbird.group>
References: <20230616104838.2729694-1-martin.fuzzey@flowbird.group>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Since commit 79d0224f6bf2 ("tty: serial: imx: Handle RS485 DE signal
> active high") RS485 reception no longer works after a transmission.

I can confirm on a Modbus/RS485 setup.

> Fix this by moving the existing loopback disable code to a helper
> function
> and calling it from imx_uart_start_rx() too.
>=20
> Fixes: 79d0224f6bf2 ("tty: serial: imx: Handle RS485 DE signal active
> high")

Unfortunately this doesn't fix the regression on my setup and I had to
fully revert 79d0224f6bf2.=C2=A0

Since there's a Modbus layer on top, it's always TX to remote then RX.

Note that RS485 communication has never been perfect on my setup. After
TX the DE line is often held active for too long leading to corrupted
RX if too close from last TX. This leads to occasional frame loss in
Modbus but it's not a blocker. Hope to get some time to investigate.

https://bugzilla.kernel.org/show_bug.cgi?id=3D207751

