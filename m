Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB1778F6C5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 03:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbjIABdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 21:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjIABdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 21:33:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97513E6E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 18:33:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22931B823FD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 01:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58501C433C7;
        Fri,  1 Sep 2023 01:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693531988;
        bh=nmrHaG018wY/DNDHLlevsfQP0j2tRtJhM5Z3Cv69FT4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UINJE8aYcs0nJ/rjjyxH4COFqtI/x3ioS7j4J+aucywC2O6X9H/hhu4YVFCy76WVE
         UVTBOy8ZrEkeAxMrbNK7VdPMvzRi9/0bylrlVMKM/bNgcEe+jQMre3Kub7XmSaCeOh
         X1Qu5oNj/Z5IUjsKlzcHSOf8+EocYvhiu26QhOi6bCTQGKYYAvRVE6WUxK/9l+Yfo4
         chlRXut28PpKNmrV9243b38J0Cb94UxFnhROuXx3g1HpVh6vmawsFLdfSYRruVIr8+
         amn7hnIpzy+Q43sSbh6KVMH1AVhyFvOwc6Lm6JuHbb2U/bDSpI4Oh0clGEWRYAeE84
         RdsBvFWvoW+SA==
Date:   Thu, 31 Aug 2023 18:33:07 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH net v1] net: phy: micrel: Correct bit assignment for
 MICREL_KSZ8_P1_ERRATA flag
Message-ID: <20230831183307.6145542e@kernel.org>
In-Reply-To: <20230831112342.GD17603@pengutronix.de>
References: <20230831110427.3551432-1-o.rempel@pengutronix.de>
        <ZPB3cYMnFq1qGRv0@shell.armlinux.org.uk>
        <20230831112342.GD17603@pengutronix.de>
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

On Thu, 31 Aug 2023 13:23:42 +0200 Oleksij Rempel wrote:
> > >  /* struct phy_device dev_flags definitions */
> > >  #define MICREL_PHY_50MHZ_CLK	0x00000001
> > >  #define MICREL_PHY_FXEN		0x00000002
> > > -#define MICREL_KSZ8_P1_ERRATA	0x00000003
> > > +#define MICREL_KSZ8_P1_ERRATA	BIT(3)  
> > 
> > Please can you also convert the other two flags to use BIT() as well to
> > make the entire thing explicitly bit-orientated? Thanks.  
> 
> Ack. This patch is for the net. The cleanup will got to the net-next.
> Except clean up will be accepted for the net too?

The change is simple enough, you can convert all three bits in the fix.
The commit message could more explicitly say that these defines are
supposed to be masks not bit positions, tho.
