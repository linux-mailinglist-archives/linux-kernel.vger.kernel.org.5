Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22D47F015C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 18:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjKRRjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 12:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKRRjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 12:39:05 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935FE1AD;
        Sat, 18 Nov 2023 09:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ODf/EeD7TdfM/V4kFavfoqfzEFUPK1joSi1qIu1/vpo=; b=eGCQe3hghc9aC7kqR7Alui+/Y/
        Wd918gat2/NjcQkpHigcJScHVxcq/DLVNWKzkD+HFQ2J+T2m+AVawujJT/6g6HqDYVLeCdZYXKjVq
        fSCofpLsEC86sjc2Kmt3dhd7BKkCbqozrCVEHUGaZkmWN5kgWlx50j/BVbDWj0HUXxo0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r4PHH-000WBY-3h; Sat, 18 Nov 2023 18:38:43 +0100
Date:   Sat, 18 Nov 2023 18:38:43 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/9] ethtool: Expand Ethernet Power Equipment
 with PoE alongside PoDL
Message-ID: <04cb7d87-bb6b-4997-878d-490c17bfdfd0@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-2-be48044bf249@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116-feature_poe-v1-2-be48044bf249@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 03:01:34PM +0100, Kory Maincent wrote:
> In the current PSE interface for Ethernet Power Equipment, support is
> limited to PoDL. This patch extends the interface to accommodate the
> objects specified in IEEE 802.3-2022 145.2 for Power sourcing
> Equipment (PSE).

Sorry for taking a while getting to these patches. Plumbers and other
patches have been keeping me busy.

I'm trying to get my head around naming... Is there some sort of
hierarchy? Is PSE the generic concept for putting power down the
cable? Then you have the sub-type PoDL, and the sub-type PoE?

>  struct pse_control_config {
>  	enum ethtool_podl_pse_admin_state podl_admin_control;
> +	enum ethtool_pse_admin_state admin_control;

When i look at this, it seems to me admin_control should be generic
across all schemes which put power down the cable, and
podl_admin_control is specific to how PoDL puts power down the cable.

Since you appear to be adding support for a second way to put power
down the cable, i would expect something like poe_admin_control being
added here. But maybe that is in a later patch?

      Andrew
