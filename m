Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA6F78FB96
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 12:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345066AbjIAKIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 06:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjIAKH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:07:59 -0400
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BD3FC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 03:07:55 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-693-NTN9am3zM7uWtBLtTrRPnA-1; Fri, 01 Sep 2023 06:07:36 -0400
X-MC-Unique: NTN9am3zM7uWtBLtTrRPnA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2C873804514;
        Fri,  1 Sep 2023 10:07:35 +0000 (UTC)
Received: from hog (unknown [10.45.224.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6FAD493110;
        Fri,  1 Sep 2023 10:07:33 +0000 (UTC)
Date:   Fri, 1 Sep 2023 12:07:32 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     Radu Pirea <radu-nicolae.pirea@nxp.com>
Cc:     "atenart@kernel.org" <atenart@kernel.org>,
        "Radu-nicolae Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Sebastian Tobuschat <sebastian.tobuschat@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC net-next v2 5/5] net: phy: nxp-c45-tja11xx: implement
 mdo_insert_tx_tag
Message-ID: <ZPG35HfRseiv80Pb@hog>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-6-radu-nicolae.pirea@oss.nxp.com>
 <ZOx0L722xg5-J_he@hog>
 <5d42d6c9-2f0c-8913-49ec-50a25860c49f@oss.nxp.com>
 <ZO8pbtnlOVauabjC@hog>
 <518c11e9000f895fddb5b3dc4d5b2bf445cf320f.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <518c11e9000f895fddb5b3dc4d5b2bf445cf320f.camel@nxp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-09-01, 09:09:06 +0000, Radu Pirea wrote:
> On Wed, 2023-08-30 at 13:35 +0200, Sabrina Dubroca wrote:
> ...
> 
> > And it's not restored when the link goes back up? That's inconvenient
> > :/
> > Do we end up with inconsistent state? ie driver and core believe
> > everything is still offloaded, but HW lost all state? do we leak
> > some resources allocated by the driver?
> 
> Yes. We end up with inconsistent state. The HW will lost all state when
> the phy is reseted. No resource is leaked, everything is there, but the
> configuration needs to be reapplied.
> 
> > 
> > We could add a flush/restore in macsec_notify when the lower device
> > goes down/up, maybe limited to devices that request this (I don't
> > know
> > if all devices would need it, or maybe all devices offloading to the
> > PHY but not to the MAC).
> 
> Agreed.
> We can do a flush very simple, but to restore the configuration maybe
> we should to save the key in the macsec_key structure. I am not sure if
> the key can be extracted from crypto_aead structure.

Either that or in the driver. I have a small preference for driver,
because then cases that don't need this restore won't have to keep the
key in memory, reducing the likelihood of accidentally sharing it.
OTOH, if we centralize that code, it's easier to make sure everything
is cleared from kernel memory when we delete the SA.


> > And what happens in this case?
> >     ip link add link eth0 type macsec offload phy
> >     ip link set eth0 down
> >     ip macsec add macsec0 rx sci ...
> >     ip macsec add macsec0 tx sa 0 ...
> >     # etc
> >     ip link set eth0 up
> > 
> > Will offload work with the current code?
> 
> (the interface was up before)
> [root@alarm ~]# ip link add link end0 macsec0 type macsec encrypt on
> offload phy 
> [root@alarm ~]# ip link set end0 down
> [root@alarm ~]# ip macsec add macsec0 rx port 1 address
> 00:01:be:be:ef:33
> RTNETLINK answers: Operation not supported

Where does that EOPNOTSUPP come from? nxp_c45_mdo_add_rxsc from this
version of the code can't return that, and macsec_add_rxsc also
shouldn't at this point.

Ideally all implementations (HW or SW) should behave the same, but at
least that saves us from having to restore state in the HW, if we
couldn't create it at all.

> But let's consider the next case:
>     ip link add link eth0 type macsec offload phy
>     ip link set eth0 down
>     ip link set eth0 up
>     ip macsec add macsec0 rx sci ...
>     ip macsec add macsec0 tx sa 0 ...
>     # etc
> 
> In this case, any HW configuration written by .mdo_add_secy will be
> lost.

So we need a way to restore the config in HW, whether that's done
entirely in the driver or initiated by macsec itself.


Antoine, is any of this relevant to the mscc driver?

-- 
Sabrina

