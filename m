Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ABA78454D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbjHVPUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjHVPUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:20:50 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19340CD9;
        Tue, 22 Aug 2023 08:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=j7dccOxm/oPivTdOBSmOXPPu0sVwTdHd1TVVg6mfImQ=; b=jtLyJAjm9RaGoQDTEOw/dfKFkT
        6DW7BdJSJcJQUt4xUWRDvj7XoY2GOUltc9Th4srekp3SDPZeVRUW9GRQyyWm096X0Ya0EoCOye164
        jJKhrXWzAtjxxqPDWdr0trqb4PFFaMKIHEzFpw5joJCtwj/AwtjpZUp/QatWKRs5EWtQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qYTBL-004nDz-T5; Tue, 22 Aug 2023 17:20:35 +0200
Date:   Tue, 22 Aug 2023 17:20:35 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v2 3/4] net: stmmac: Add glue layer for Loongson-1 SoC
Message-ID: <150ae6c1-8a2f-4fd7-b012-a53a909919d4@lunn.ch>
References: <20230816111310.1656224-1-keguang.zhang@gmail.com>
 <20230816111310.1656224-4-keguang.zhang@gmail.com>
 <c3454ad9-1874-4301-b1b1-4f76886802fb@lunn.ch>
 <CAJhJPsWVRJg7zNeXPDovkBM4pm7hD+RP21DRxt0726VXtzvCHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhJPsWVRJg7zNeXPDovkBM4pm7hD+RP21DRxt0726VXtzvCHw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > What about the other three RGMII modes? Plain rgmii is pretty unusual,
> > rgmii-id is the most used.
> >
> According to the LS1B datasheet, only RGMII and MII are supported.
> And I can confirm that MII mode does work for LS1B.

What does your device tree look like? What are you setting phy-mode to
in the rgmii case? As i said, "rgmii" is pretty unusual, you normally
need "rgmii-id".

Something in the system needs to add 2ns delays to the RGMII clock
lines. Generally in device tree you pass phy-mode = "rgmii-id"; The
MAC configures itself for RGMII, and passes
PHY_INTERFACE_MODE_RGMII_ID to the PHY when it is attached. The PHY
then inserts the delays.

What is inserting the delays in your system?

     Andrew

