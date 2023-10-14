Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9C77C923F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 03:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjJNBz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 21:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjJNBz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 21:55:56 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0346CBF;
        Fri, 13 Oct 2023 18:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=cjW+qsUfbs6nzKf1dTERhV/HEx/8IziabIg1Ep2LkPw=; b=maqe7cYuDKIiDrqKlbKmWOn7xM
        IrpLEF9ncAqzaX8IOBfdJCyG8Q6HyvABIRi8ENKEsHWCwFEk5fAvYk3zgfB6Rqm/zVAgE1T02HSWO
        O+Pe0xzv6vu7U8uIEtWKUpGC0Qk+B/iAc2hRT6PRiRcYtwaQduanCgdydx2qIbm9+Ux4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qrTsT-0029U4-Mh; Sat, 14 Oct 2023 03:55:41 +0200
Date:   Sat, 14 Oct 2023 03:55:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Kees Cook <keescook@chromium.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: phy: tja11xx: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <a958d35e-98b6-4a95-b505-776482d1150c@lunn.ch>
References: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
 <15af4bc4-2066-44bc-8d2e-839ff3945663@lunn.ch>
 <CAFhGd8pmq3UKBE_6ZbLyvRRhXJzaWMQ2GfosvcEEeAS-n7M4aQ@mail.gmail.com>
 <0c401bcb-70a8-47a5-bca0-0b9e8e0439a8@lunn.ch>
 <CAFhGd8p3WzqQu7kT0Pt8Axuv5sKdHJQOLZVEg5x8S_QNwT6bjQ@mail.gmail.com>
 <CAFhGd8qcLARQ4GEabEvcD=HmLdikgP6J82VdT=A9hLTDNru0LQ@mail.gmail.com>
 <202310131630.5E435AD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310131630.5E435AD@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been told that this whole ethtool API area is considered
> deprecated. If that holds, then I don't think it's worth adding new
> helpers to support it when ethtool_sprintf() is sufficient.

I think deprecated is too strong. The current API is not great, so
maybe with time a new API will emerge. But given there are around 160
users of the API, probably over 100 drivers, it will be 20 years or
more before all that hardware becomes obsolete and the drivers are
removed.

> Once you're done with the strncpy->ethtool_sprintf conversions I think
> it would be nice to have a single patch that fixes all of these
> "%s"-less instances to use "%s". (Doing per-driver fixes for that case
> seems just overly painful.)

I guess it is the same amount of effort to replace them with
ethtool_puts()?

checkpatch warns about seq_printf() which could be seq_puts(), so
somebody thinks using puts is the right thing to do?

	 Andrew
