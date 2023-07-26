Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E5F763318
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjGZKDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjGZKDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:03:35 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCEDC1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=idDRzgK+CuAVwOo84T4Kfcz9Fcy1XpgH5njbuHuJvqw=; b=IPzJ1A2XZvWMYZrnXRo5MDNvMS
        9XFLUmoz0c2+XNrPFY+e2cgcPhuyZUppO8hVf9dMoOfqB8mdx5kvjhkIeTpvXDfaRTtQxvJmBk0YX
        43l3ViCyltEOjYC6WiZ3nLPp1ai7VNMAhAjr7rOT6uHu5nDMGoFy1YahM0W0nW/J4Uh9Igj5MQ/Et
        Kp0l6porWKdkWvwzfDPCcjaGV/oR9QMAh/URywzbImsb8rJAKpT4FYWw8X5If+vD0VHYYmAcoidcg
        ANMXpResOCPqyOcH2v0lKeiJr3fWSJpEQPSjzGHCiAwkOXKZpWJcvar8s5npB0qsuk6400fPTGDOF
        FeFF+JpA==;
Received: from [192.168.1.4] (port=38008 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qObMb-0008Oh-2m;
        Wed, 26 Jul 2023 12:03:25 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Wed, 26 Jul 2023 12:03:25 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <linux@armlinux.org.uk>
CC:     <andrew@lunn.ch>, <ante.knezic@helmholz.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <olteanv@gmail.com>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: Add erratum 3.14 for 88E6390X and 88E6190X
Date:   Wed, 26 Jul 2023 12:03:25 +0200
Message-ID: <20230726100325.20185-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <ZMDtDXG4Xj94F7vw@shell.armlinux.org.uk>
References: <ZMDtDXG4Xj94F7vw@shell.armlinux.org.uk>
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

On Wed, 26 Jul 2023 10:53:17 +0100, Russell King (Oracle) wrote:
> As a longer term goal, I would like to move the pcs drivers out of
> mv88e6xxx and into drivers/net/pcs, so I want to minimise the use of
> the "chip" pointer in the drivers. That's why I coded them the way I
> have, as almost entirely stand-alone implementations that make no use
> of the hardware accessors provided by the 88e6xxx core.

Understood, I will adapt the patch as you proposed.

