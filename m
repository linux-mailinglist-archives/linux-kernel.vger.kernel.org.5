Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5457FC85F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346614AbjK1Vfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345025AbjK1Vfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:35:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AD912C;
        Tue, 28 Nov 2023 13:35:40 -0800 (PST)
Received: from beast.luon.net (cola.collaboradmins.com [IPv6:2a01:4f8:1c1c:5717::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BF98766022D3;
        Tue, 28 Nov 2023 21:35:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701207338;
        bh=sv/2D1zMBLJgchnhIhV6rK/+bWi0GcCcH0kKNpe62Ws=;
        h=From:To:Cc:Subject:Date:From;
        b=cbk9zdgl0apMId4gfLfr4H/GO4fNNOOaJLurMJ40z0HDkC0g97Zu1F4q/cGGhqQZ3
         IvQ9EFdhtt6eicA1jz8CY3Gu+ch5HR/Tf67mF5DxZ2fWJR08TZ3bSItPyCjWiQL0nZ
         IyEnNLxwQrQ0qwT5QO2pPEQQGYyAtaeNqmcqY5DBX5Nff9RZ/AMlCfO5XXp3Smvm8q
         hR1tuT/wX7PFnkJRm3gvyVHiu9j/geX+Ouyx6UC3VxJrupIiNehsRHnFZrY72O3/Oh
         KMSAqJ0UyFEYxYvd8+rghc1aDnxKEGf/FRvc59IDPI4HBJ95dDuBju946ODg7ymIIO
         kdwxp4X+t1XJA==
Received: by beast.luon.net (Postfix, from userid 1000)
        id E9D929676CF8; Tue, 28 Nov 2023 22:35:36 +0100 (CET)
From:   Sjoerd Simons <sjoerd@collabora.com>
To:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        kernel@collabora.com, Andrew Lunn <andrew@lunn.ch>,
        Conor Dooley <conor+dt@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Moxtet bus fixes
Date:   Tue, 28 Nov 2023 22:35:03 +0100
Message-ID: <20231128213536.3764212-1-sjoerd@collabora.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


It seems the moxtet bus support was broken since 21aad8ba615e ("arm64:
dts: armada-3720-turris-mox: Add missing interrupt for RTC") for two
reasons:
* The moxtet irq isn't marked as shared so the driver fails to load if
  the rtc driver gets set up first.
* The dts change didn't set the IRQ type, so in case the rtc driver got
  probed first irq setup ended up wrong (rising instead of falling edge).

On top of that the moxtet module isn't auto-loading due to a missing spi
table

Changes in v2:
- Add cover letter
- Add patch to set the irq type

Sjoerd Simons (3):
  bus: moxtet: Mark the irq as shared
  bus: moxtet: Add spi device table
  arm64: dts: armada-3720-turris-mox: set irq type for RTC

 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 2 +-
 drivers/bus/moxtet.c                                   | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.43.0

