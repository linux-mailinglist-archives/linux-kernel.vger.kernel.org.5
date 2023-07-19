Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FC6759139
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGSJKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjGSJKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:10:33 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3948A19F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AoKJ8U7zqgVLphnsB4DDPWwdoD7ZYEsS9sz4gBR8PlI=; b=CKdWhiEg60VtAnvu47b7MGXSYp
        uHHwTIOppHcxfnwHNX4UeDrqOhLBdxhT83ThPa6NlJGWxGH5+sfKIUNz546s+30fEgyPV7rmXwpb7
        0EF9GH3OcPRHWCutME47EFxm724L4uAqN7AzTrirM4/dJqUKHyDoduqczvRDZBKj+iBtjv89rUbtQ
        af7NQYmbqNFoaJUP1NUQx1ss+Mj4YFTj/VjfPpMdw/g8lBpiYiwB+3Xabq4WugFEXNXtAjDgEFwu6
        guNlDeHkWIAnE1at3weA/dNCvVHp8aQdF4hgj9IUFTLqvHeDcfPHjqUubMFYCZqNiNYruvsGxGNpS
        fSRU/0tQ==;
Received: from [192.168.1.4] (port=15906 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qM3CS-0001FJ-2d;
        Wed, 19 Jul 2023 11:10:24 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Wed, 19 Jul 2023 11:10:24 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <andrew@lunn.ch>
CC:     <ante.knezic@helmholz.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <olteanv@gmail.com>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6xxx: Add erratum 3.14 for 88E6390X and 88E6190X
Date:   Wed, 19 Jul 2023 11:10:24 +0200
Message-ID: <20230719091024.21693-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <61e40941-5e2b-48b5-bbc4-fdd94967aaf1@lunn.ch>
References: <61e40941-5e2b-48b5-bbc4-fdd94967aaf1@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I don't think so. The erratum from the patch needs to be applied on each
> > SERDES reconfiguration or reset. For example, when replugging different 
> > SFPs (sgmii - 10g - sgmii interface). Erratum 4_6 is done only once? 
> > My guess is to put it in mv88e639x_sgmii_pcs_post_config but still I 
> > need the device product number
> 
> You might be able to read the product number from the ID registers of
> the SERDES, registers 2 and 3 ? That is kind of cleaner. It is the
> SERDES which needs the workaround, so look at the SERDES ID ...
> 
> > maybe embedding a pointer to the 
> > mv88e6xxx_chip chip inside the mv88e639x_pcs struct would be the cleanest way.
>  
>  That would also work.

Correct me if I am wrong but I think we still need the chip ptr as pcs interface
provides access only to SERDES registers. If you are refering to "PHY IDENTIFIER"
registers (Page 0, Register 2,3), we need something like mv88e6xxx_port_read
unless we want to do some direct mdio magic?
