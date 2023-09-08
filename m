Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097F2798A14
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244687AbjIHPgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244686AbjIHPgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:36:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDBF1BFF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 08:36:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE04C433CA;
        Fri,  8 Sep 2023 15:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694187370;
        bh=MsN/E8Lt6hH4KPpdsvQ2Ji9T8x03+Y8LmtLC9vNNBz0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K2iNi8lSJqnR+5Tc8nOPLtMrOnnmRXqtdYHV94IFzhRIEVioXkO+cbDcWxjPACPvF
         xk2pPvPZ3NF93q6cg1ss3WfItcV5WB48g9NI3OENFyRCUpi0HqliwFe38+wMpOkW0w
         T7B1HU4DDsrGd5ATBvDw0Bum0vdMZFwo73inBDPW7CfkGufNqHWh2Kw63PQtYVDGVw
         mklIu75RxO3Sqq1ZoGyDRtzYUJE1fr+t/Mp6P3dAKrc/Iuc0zQaH7a0wbNcSOHCnqw
         6EFAUdjgbVWvU8PXj1fgXVd/ReV5CTybZX8a+84vBKHzW+Oj54tekLMRu3nLzJDfN7
         Qiu8+QedHA2lg==
Date:   Fri, 8 Sep 2023 08:36:08 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>,
        thomas.petazzoni@bootlin.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 1/7] net: phy: introduce phy numbering and
 phy namespaces
Message-ID: <20230908083608.4f01bf2c@kernel.org>
In-Reply-To: <20230907141904.1be84216@pc-7.home>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
        <20230907092407.647139-2-maxime.chevallier@bootlin.com>
        <ZPmicItKuANpu93w@shell.armlinux.org.uk>
        <20230907141904.1be84216@pc-7.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2023 14:19:04 +0200 Maxime Chevallier wrote:
> > I think you can simplify this code quite a bit by using idr.
> > idr_alloc_cyclic() looks like it will do the allocation you want,
> > plus the IDR subsystem will store the pointer to the object (in
> > this case the phy device) and allow you to look that up. That
> > probably gets rid of quite a bit of code.
> > 
> > You will need to handle the locking around IDR however.  
> 
> Oh thanks for pointing this out. I had considered idr but I didn't spot
> the _cyclic() helper, and I had ruled that out thinking it would re-use
> ids directly after freeing them. I'll be more than happy to use that.

Perhaps use xarray directly, I don't think we need the @base offset or
quick access to @next which AFAICT is the only reason one would prefer
IDR?
