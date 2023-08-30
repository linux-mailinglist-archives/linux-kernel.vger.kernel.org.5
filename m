Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B88D78DF60
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbjH3TJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243711AbjH3Lfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:35:36 -0400
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C9D1BB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:35:31 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-jd2J6nWIP-ub-FPQJRRIag-1; Wed, 30 Aug 2023 07:35:14 -0400
X-MC-Unique: jd2J6nWIP-ub-FPQJRRIag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A2C23811F26;
        Wed, 30 Aug 2023 11:35:13 +0000 (UTC)
Received: from hog (unknown [10.45.224.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A130940C6F4C;
        Wed, 30 Aug 2023 11:35:11 +0000 (UTC)
Date:   Wed, 30 Aug 2023 13:35:10 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v2 5/5] net: phy: nxp-c45-tja11xx: implement
 mdo_insert_tx_tag
Message-ID: <ZO8pbtnlOVauabjC@hog>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-6-radu-nicolae.pirea@oss.nxp.com>
 <ZOx0L722xg5-J_he@hog>
 <5d42d6c9-2f0c-8913-49ec-50a25860c49f@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d42d6c9-2f0c-8913-49ec-50a25860c49f@oss.nxp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-08-28, 16:46:02 +0300, Radu Pirea (OSS) wrote:
> 
> 
> On 28.08.2023 13:17, Sabrina Dubroca wrote:
> > 2023-08-24, 12:16:15 +0300, Radu Pirea (NXP OSS) wrote:
> > > Implement mdo_insert_tx_tag to insert the TLV header in the ethernet
> > > frame.
> > > 
> > > If extscs parameter is set to 1, then the TLV header will contain the
> > > TX SC that will be used to encrypt the frame, otherwise the TX SC will
> > > be selected using the MAC source address.
> > 
> > In which case would a user choose not to use the SCI? Using the MAC
> > address is probably fine in basic setups, but having to fiddle with a
> > module parameter (so unloading and reloading the module, which means
> > losing network connectivity) to make things work when the setup
> > evolves is really not convenient.
> > 
> > Is there a drawback to always using the SCI?
> > 
> 
> I see your concern. If the PHY driver is reloaded, then the offloaded MACsec
> configuration will vanish from the hardware. Actually, just a call to
> phy_disconnect is enough to break an offloaded MACsec iface and can be
> achieved by:
> ip link set eth0 down && ip link set eth0 up

And it's not restored when the link goes back up? That's inconvenient :/
Do we end up with inconsistent state? ie driver and core believe
everything is still offloaded, but HW lost all state? do we leak
some resources allocated by the driver?

We could add a flush/restore in macsec_notify when the lower device
goes down/up, maybe limited to devices that request this (I don't know
if all devices would need it, or maybe all devices offloading to the
PHY but not to the MAC).

And what happens in this case?
    ip link add link eth0 type macsec offload phy
    ip link set eth0 down
    ip macsec add macsec0 rx sci ...
    ip macsec add macsec0 tx sa 0 ...
    # etc
    ip link set eth0 up

Will offload work with the current code?

> The only drawback is related to the PTP frames encryption. Due to hardware
> limitations, PHY timestamping + MACsec will not work if the custom header is
> inserted. The only way to get this work is by using the MAC SA selection and
> running PTP on the real netdev.

Could you add some documentation explaining that? Users need this
information to make the right choice for their use case. Maybe
directly in the description of the module parameter, something like:
"Select the TX SC using TLV header information. PTP frames encryption
cannot work when this feature is enabled."

If it's in the module parameter I guess it can't be too
verbose. Otherwise I don't know where else to put it.

And the parameter's name and/or description should probably include
macsec/MACsec if it's visible at the level of the whole module (ie if
macsec support isn't a separate module), just to give context at to
what the TXSC is (and what the encryption for the PTP frames refers
to).

-- 
Sabrina

