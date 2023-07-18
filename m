Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711AD7580D5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjGRPZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjGRPZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:25:24 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CCEC0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=n3TXPBwWYpjaMEPqiiBxrC2aXEsIfs6qnSe2tMEctyo=; b=ZgdiYjuUelciD1mzmRbUQz0O99
        EBeFSf+5Kzd3CysNjOJhReSb6a3frqkqLRPBV4JRz5OC8FpaIOg7jpC3UcjCL+zqyZiln5R+FnPU5
        FftVTyGsbN3Vgl1QMG4XuWJaaJ6sEFxJcuSp/Cr2lTUs3Ix0afkzRv48ke9oNwHs/dvGs2X8W14Cf
        h4JSNjDZlLx0ujcl2diNsB6fw5YKawC1TJTxCeDvNKJa8QeurXVOSzqbksPr+b1PJ0Z1OmO8fHuad
        BIWWh0emzAo4H3MJ8mF2lIU7NCG3h9R/HCGeKjurTP+haytsOqh/Aj47Ci76J7PaWw2wA3CTNa+Qx
        kibk3ETQ==;
Received: from [192.168.1.4] (port=60931 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qLmZf-0007f3-3D;
        Tue, 18 Jul 2023 17:25:16 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 18 Jul 2023 17:25:15 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <olteanv@gmail.com>
CC:     <andrew@lunn.ch>, <ante.knezic@helmholz.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6xxx: Add erratum 3.14 for 88E6390X and 88E6190X
Date:   Tue, 18 Jul 2023 17:25:12 +0200
Message-ID: <20230718152512.6848-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20230718150133.4wpnmtks46yxg5lz@skbuf>
References: <20230718150133.4wpnmtks46yxg5lz@skbuf>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > It does not apply cleanly to net-next. Please respin. You can retain
> > > Andrew's Reviewed-by tag.
> > 
> > Respin might need a complete rework of the patch as with the
> > conversion of 88e639x to phylink_pcs (introduced with commit
> > e5b732a275f5fae0f1342fb8cf76de654cd51e50) the original code flow
> > has completely changed so it will not be as simple as finding a new
> > place to stick the patch. 
> > The new phylink mostly hides away mv88e6xxx_chip struct which is needed 
> > to identify the correct device and writing to relevant registers has also
> > changed in favor of mv88e639x_pcs struct etc.
> > I think you can see where I am going with this. In this sense I am not sure 
> > about keeping the Reviewed-by tag, more likely a complete rewrite 
> > should be done.
> > I will repost V3 once I figure out how to make it work with the new
> > framework.
> > 
> 
> Can't you simply replicate the positioning of mv88e6393x_erratum_4_6()
> from mv88e6393x_pcs_init()?

I don't think so. The erratum from the patch needs to be applied on each
SERDES reconfiguration or reset. For example, when replugging different 
SFPs (sgmii - 10g - sgmii interface). Erratum 4_6 is done only once? 
My guess is to put it in mv88e639x_sgmii_pcs_post_config but still I 
need the device product number - maybe embedding a pointer to the 
mv88e6xxx_chip chip inside the mv88e639x_pcs struct would be the cleanest way.


