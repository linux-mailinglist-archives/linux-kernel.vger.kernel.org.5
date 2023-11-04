Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88B67E0FEA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 15:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjKDO3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 10:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjKDO3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 10:29:48 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1460CD6;
        Sat,  4 Nov 2023 07:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=p8bT57HsClly0ZlYgE96HKtfTjwT9RQ0Pq63hmaeS4c=; b=kSBaYHPXQHGeNn+47G7g/lAhU4
        CP0Ima99BDWiiu2t5HQ5IDi8Zm/Ko27zNhLe/9pfgsfI6VMegSSSuezt6nLII/lIJt38v9OQE1qce
        hH4uqLkkAFplQLEk6DFLvLekYok6aEkilLjbYJZ3nDiiRgxfAGi6waiaDKcIe7zoaqYk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qzHeT-000sK1-39; Sat, 04 Nov 2023 15:29:29 +0100
Date:   Sat, 4 Nov 2023 15:29:29 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Klaus Kudielka <klaus.kudielka@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Li Zetao <lizetao1@huawei.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: triggers: netdev: add a check, whether device is up
Message-ID: <0e3fb790-74f2-4bb3-b41e-65baa3b00093@lunn.ch>
References: <20231104125840.27914-1-klaus.kudielka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104125840.27914-1-klaus.kudielka@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 01:58:40PM +0100, Klaus Kudielka wrote:
> Some net devices do not report NO-CARRIER, if they haven't been brought
> up.

Hi Klaus

We should probably fix the driver. What device is it?

> In that case, the netdev trigger results in a wrong link state being
> displayed. Fix this, by adding a check, whether the device is up.

Is it wrong? Maybe the carrier really is up, even if the interface is
admin down. Broadcast packets are being received by the
hardware. Maybe there is a BMC sharing the link and it is active?

It is not a clear cut wrong to me. And its a way to find broken
drivers. We might want to discuss this some more.

	Andrew
