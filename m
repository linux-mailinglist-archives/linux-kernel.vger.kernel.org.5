Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5C57BFD37
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjJJNWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjJJNWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:22:06 -0400
X-Greylist: delayed 169 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Oct 2023 06:22:01 PDT
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A77B9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=CgV//G1uYpZ5/atwrJv//Vk46ibNjcYmUJiUebJQ2ZU=; b=E7BDpSyvGvx2hyzaiwyJaiJdDD
        YkeGYaa1yYc2RbrAfWZoKjHsti8hzK3YPiSNSEmg0Afr5diR01tCfJzLoLy56TEGCPDXEmhAf9EqZ
        VGPElWQRTo2UGDZXdDgRdTsuM+i5rHyasbnQFYOX7h5QNK1MQh3KXt15vBPk6AjpbpDjXXPg9b3Ez
        /Rqmp/fS4ySuBkkT2rQE7hl55LucM3f3VKpcMHi85LQgf15Fua4qPN1lNOZE6TMj+SdjL6Vogxs7A
        W0p8lW0I1992RYflW3KHrLRt0FVu7eN+0yJ6lHD81pdd0lr3AhQgC8oZJckfkZ9K4XhjHLZ3iwJ5A
        D4pbQyBQ==;
Received: from [192.168.1.4] (port=20309 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qqCdW-0001iY-1y;
        Tue, 10 Oct 2023 15:18:58 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 10 Oct 2023 15:18:58 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <netdev@vger.kernel.org>
CC:     <woojung.huh@microchip.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <marex@denx.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>,
        Ante Knezic <ante.knezic@helmholz.de>
Subject: [PATCH net-next 0/2] net: dsa: microchip: enable setting rmii reference
Date:   Tue, 10 Oct 2023 15:18:52 +0200
Message-ID: <cover.1693482665.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KSZ88X3 devices can select between internal and external RMII reference clock.
This patch series introduces new device tree property for setting reference
clock to internal.

Ante Knezic (2):
  net:dsa:microchip add property to select internal RMII reference clock
  dt-bindings: net: microchip,ksz: document microchip,rmii-clk-internal

 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 6 ++++++
 drivers/net/dsa/microchip/ksz8795.c                          | 4 ++++
 drivers/net/dsa/microchip/ksz8795_reg.h                      | 3 +++
 drivers/net/dsa/microchip/ksz_common.c                       | 3 +++
 drivers/net/dsa/microchip/ksz_common.h                       | 1 +
 5 files changed, 17 insertions(+)

-- 
2.11.0

