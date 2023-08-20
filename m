Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC2A781F6D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 21:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjHTTSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 15:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjHTTSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 15:18:11 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802592105;
        Sun, 20 Aug 2023 12:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=WgJ8CrolknwjFwN0OyobejCpVpfKcAujTpI4FL8b0/s=; b=PsTiMnr8r12HO3sDikExAkyprm
        ZtqNizIeluuRqhu3jAMSreEmA0CSPK65eV2AnRr4ORczF6xxNtAenmrbvmaqMT41fMnRdAB5X0JHE
        B+ArNrC5lSsdXJUDXNn7HFt+b2y0UYlA5AswFd1TUpSIaRbe0/4vkasW6gEdsBP+WSlo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qXntC-004dSm-Le; Sun, 20 Aug 2023 21:15:06 +0200
Date:   Sun, 20 Aug 2023 21:15:06 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v4 2/9] net: stmmac: xgmac: add more feature
 parsing from hw cap
Message-ID: <9e55fd03-6b05-46de-874e-01d9cdbf4524@lunn.ch>
References: <20230816152926.4093-1-jszhang@kernel.org>
 <20230816152926.4093-3-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816152926.4093-3-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 11:29:19PM +0800, Jisheng Zhang wrote:
> The XGMAC_HWFEAT_GMIISEL bit also indicates whether support 10/100Mbps
> or not.

The commit message fails to explain the 'Why?' question. GMII does
normally imply 10/100/1000, so i would expect dma_cap->mbps_1000 also
implies 10/100/1000? So why also set dma_cap->mbps_10_100?

Maybe a better change would be to modify:

        seq_printf(seq, "\t1000 Mbps: %s\n",
                   (priv->dma_cap.mbps_1000) ? "Y" : "N");

to actually say 10/100/1000 Mbps? It does not appear this is used for
anything other than debugfs?

	Andrew
