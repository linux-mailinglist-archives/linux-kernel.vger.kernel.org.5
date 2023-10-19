Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C357CFAF3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345924AbjJSN1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345767AbjJSN1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:27:48 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D09C112;
        Thu, 19 Oct 2023 06:27:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 274A460007;
        Thu, 19 Oct 2023 13:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697722065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tb30KokhMfhJFg4x7SAE9KT+pO7hqq9T0nfilt18P3g=;
        b=MV7QCSQ1J88BtyakxCd7vSwceC0N69+8kKIiYqzwgw7dzB5U11hLTrmGq/4UbsqVWR+yWA
        i+0rHiSEuSyznUvi+jJNhdk455Bg6rc9Qu0r5+c5fZkKv8dgQMxAJqb5uMJAAXeAkjN9t9
        NDQb6gxEmI61qG4SeuZBEffFToiQVuAvNFMrF1fF/LFfacEpkAeDAJWk1e6MHRd1xG2wHH
        6lchYuSz65Dh5x4xMQbCbxwW79/cHVyNcPLm+iylS+Ez8pw763cCHoT2+ZOVA0y4phOkkA
        IVm3Zp6ozPuXj6Rm2aX0Ne5mFr8glYJCzA5zqvx18Ze5lD8LXWL6GFvbdTARVQ==
Date:   Thu, 19 Oct 2023 15:27:43 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] ethtool: fix clearing of WoL flags
Message-ID: <20231019152743.09b28ef4@kmaincent-XPS-13-7390>
In-Reply-To: <20231019105048.l64jp2nd46fxjewt@lion.mk-sys.cz>
References: <20231019070904.521718-1-o.rempel@pengutronix.de>
        <20231019090510.bbcmh7stzqqgchdd@lion.mk-sys.cz>
        <20231019095140.l6fffnszraeb6iiw@lion.mk-sys.cz>
        <20231019122114.5b4a13a9@kmaincent-XPS-13-7390>
        <20231019105048.l64jp2nd46fxjewt@lion.mk-sys.cz>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 12:50:48 +0200
Michal Kubecek <mkubecek@suse.cz> wrote:

> On Thu, Oct 19, 2023 at 12:21:14PM +0200, K=C3=B6ry Maincent wrote:
> > On Thu, 19 Oct 2023 11:51:40 +0200 > Michal Kubecek <mkubecek@suse.cz>
> > wrote: =20
> > >=20
> > > The issue was indeed introduced by commit 108a36d07c01 ("ethtool: Fix
> > > mod state of verbose no_mask bitset"). The problem is that a "no mask"
> > > verbose bitset only contains bit attributes for bits to be set. This
> > > worked correctly before this commit because we were always updating
> > > a zero bitmap (since commit 6699170376ab ("ethtool: fix application of
> > > verbose no_mask bitset"), that is) so that the rest was left zero
> > > naturally. But now the 1->0 change (old_val is true, bit not present =
in
> > > netlink nest) no longer works. =20
> >=20
> > Doh I had not seen this issue! Thanks you for reporting it.
> > I will send the revert then and will update the fix for next merge-wind=
ow. =20
>=20
> Something like the diff below (against current mainline) might do the
> trick but it's just an idea, not even build tested.

Seems a good idea without adding too much complexity to the code.
Will try that and send it in next merge window.

K=C3=B6ry
