Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767A179B708
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358321AbjIKWIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237712AbjIKNLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:11:21 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ED5E9;
        Mon, 11 Sep 2023 06:11:16 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7F5A21C001B;
        Mon, 11 Sep 2023 13:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694437874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NeifM5Ih+521Ky4D24H4As0XME/ed4hRcIxhZQ8/dgE=;
        b=IOKTk7Bo1joFyMSyQQe9dQCAEqfFrfp5mky8/tCsgjXhAwX1NbApy3lWmjMyKfVf8RCZCQ
        CGIYWseGm0QD9rNS7e6zmaXdHsMZgAEAGru4DdTxlIuSyCrIkYym91+tdOLpve2xjcxxNK
        nGdKKh/H62C05+iTtX52jI8yJ5iB4512pF9LLsT7DZsfmAWsZVXAFwRFV94BRbiyyhoHZe
        oySapmD0ydh9xZB4RfJUU1PdKO7FE75sRYd9zH3Gmyhr141wVtO6tKZKX2b5WFpmoiWsLc
        v8EhHsisx91O2t8iRBxtRWQEZu643cdSQB/2Rcb7qDoGHdflI3izj+UrHwFv0w==
Date:   Mon, 11 Sep 2023 15:09:31 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Jakub Kicinski <kuba@kernel.org>
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
Message-ID: <20230911150931.2832b266@fedora>
In-Reply-To: <20230908084108.36d0e23c@kernel.org>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
        <20230908084108.36d0e23c@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jakub

On Fri, 8 Sep 2023 08:41:08 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu,  7 Sep 2023 11:23:58 +0200 Maxime Chevallier wrote:
> >  - the netlink API would need polishing, I struggle a bit with finding
> >    the correct netlink design pattern to return variale-length list of u32.  
> 
> Think of them as a list, not an array.
> 
> Dump them one by one, don't try to wrap them in any way:
> https://docs.kernel.org/next/userspace-api/netlink/specs.html#multi-attr-arrays
> People have tried other things in the past:
> https://docs.kernel.org/next/userspace-api/netlink/genetlink-legacy.html#attribute-type-nests
> but in the end they add constraints and pain for little benefit.

Thanks for the pointers, this makes much more sense than my attempt at
creating an array.

This and your other comment on the .do vs .dump is exactly what I was
missing in my understanding of netlink.

Maxime
