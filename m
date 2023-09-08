Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB021798444
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239950AbjIHIkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236018AbjIHIkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:40:17 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16821BEA;
        Fri,  8 Sep 2023 01:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VXnhsorUHK5Bf5MDGsHtvKrSDEvw0CRZTu4ZdbI4RRA=; b=vfF7vs85iyrVRu/FjEGzcFMQ+w
        yBlIpvaSAxF6F+FTBO02CmBnUp/KXRXkVTmz2xzwgwwB7UDdiB2Hxdy32TIarFJKuvzem3AeRbelM
        LhiSNZXoNYfTWUnj+d8PCTkg7p8mzeaBM3LnCui838zR4QAc8PpeH6v1rDDWIbDBxtZrhQoCYYQZK
        /HRgerpP8/fhPTQT6mX4akDaDnH/3HkZoITL2XCR1rDKIF1BKqbRi7SDALO8ycQ57VEO8GPaCa2I7
        LbyySbBkGk6V+xlR2B69Tn8f2PxNoiUn7QZpmurkGSsLg/FwEcjWTAQWPtjXuZwIhWpHEF7epdFvt
        ZmVQFTCA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35414)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qeX1r-0004kU-0Z;
        Fri, 08 Sep 2023 09:39:51 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qeX1m-0006kZ-Tw; Fri, 08 Sep 2023 09:39:46 +0100
Date:   Fri, 8 Sep 2023 09:39:46 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     justin.chen@broadcom.com, florian.fainelli@broadcom.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mw@semihalf.com, nbd@nbd.name, john@phrozen.org,
        sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
        lorenzo@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        maxime.chevallier@bootlin.com, nelson.chang@mediatek.com,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 2/3] net: ethernet: mvpp2_main: fix possible OOB write
 in mvpp2_ethtool_get_rxnfc()
Message-ID: <ZPrd0madH5Z+Ptve@shell.armlinux.org.uk>
References: <20230908061950.20287-1-hbh25y@gmail.com>
 <20230908061950.20287-3-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908061950.20287-3-hbh25y@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 02:19:49PM +0800, Hangyu Hua wrote:
> rules is allocated in ethtool_get_rxnfc and the size is determined by
> rule_cnt from user space. So rule_cnt needs to be check before using
> rules to avoid OOB writing or NULL pointer dereference.
> 
> Fixes: 90b509b39ac9 ("net: mvpp2: cls: Add Classification offload support")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
