Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E24A7DA0B6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbjJ0Slf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbjJ0SlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:41:24 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7AC30F3;
        Fri, 27 Oct 2023 11:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=YAfUWxLC1GUf2fMq8BZjyh6NawC+UIiZZsgihycoOF8=; b=iClpXEymV0uPqKDpSL6LJaRvLT
        czGTYAl1cxP2ielr6UGJSBLC/dKdvju8+FslemWkqy6SdQHYMnWNyqqdLxi7/m+EP2NSIKTcNZwjG
        HXLE6EV2HSMFLwJ1aLOE1ZFP57R3gnMORBlbLEg4G55xfouAz66ufGyoAk7nq5YkxueE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qwRbq-000MPT-PO; Fri, 27 Oct 2023 20:31:02 +0200
Date:   Fri, 27 Oct 2023 20:31:02 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Gal Pressman <gal@nvidia.com>,
        Willem de Bruijn <willemb@google.com>,
        Daniil Tatianin <d-tatianin@yandex-team.ru>,
        Simon Horman <horms@kernel.org>,
        Justin Chen <justin.chen@broadcom.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Joe Damato <jdamato@fastly.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Jiri Pirko <jiri@resnulli.us>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 5/5] net: bcmgenet: Interrogate PHY for
 WAKE_FILTER programming
Message-ID: <47ed806c-69b9-401b-81ee-ec88235092a6@lunn.ch>
References: <20231026224509.112353-1-florian.fainelli@broadcom.com>
 <20231026224509.112353-6-florian.fainelli@broadcom.com>
 <0a164b9b-4f9b-4886-b19e-48298cdcff8d@intel.com>
 <2eeb8e24-4122-450b-adf5-8c8a746db518@broadcom.com>
 <6456509b-9df7-47e3-b941-c307594a80d2@intel.com>
 <93abb8d0-40c6-4758-a8de-c79d7acce6bc@broadcom.com>
 <2ad82651-8e52-47ea-a567-2382b26f3c71@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ad82651-8e52-47ea-a567-2382b26f3c71@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It does seem like an acceptable compromise here, and perhaps being
> driver specific is ok, since this does depend a lot on the individual
> device support, thus broadly applying this across all drivers could be
> problematic.

The Marvell PHYs have a similar capability. Its actually more feature
rich. It allows upto 8 matches, each being of up to 128 bytes, and you
can enable/disable each byte within the 128 bytes. This would in fact
be better for Florian's use case, since it could match deeper into the
frame and reduce the false positive. But its a Marvell device...

My real point is, other hardware does have similar capabilities. Its
unclear if anybody else will ever actually need it, but we should try
to avoid a one device solution.

   Andrew
