Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A017E93B5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 01:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjKMAwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 19:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjKMAwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 19:52:15 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37DF1BCC
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 16:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=Jzw0daFPpuQmjQ
        /MRq+GqDYLJI86mNj6gySqOi0QmEo=; b=mY/tl3I5D2T13HeP9Y6Mwx5yD6BbVx
        vWKJlwlrKpg7eC0LE7tMh7XQwknuGoN5TCKb+gQQkN1PMLWeMf7P84yutD6eibQN
        0xYsjnBg1cn+s6hdaY9SXCSg3FqvUjixXVxfSU4O40RU+h6TCWxl6C0tDcacBgZe
        XnjOwWxUZ2ruJ9ZVTtrkoQHp2fBGvHTNe4rfezEKhR25mslhg0Ck2LXO9vYp9WSS
        K9R4QJBQWHtZNj2y4lHuUzkDpBYUAaukuHs7jAeVYTcay8mO18Q02WUUr647LdKs
        RgHKjUazLVeEL5xa7ULV7QraIXxEW7YVcHDGJi5tqKrzyAgCC3yRzURA==
Received: (qmail 4084302 invoked from network); 13 Nov 2023 01:52:07 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Nov 2023 01:52:07 +0100
X-UD-Smtp-Session: l3s3148p1@0tQ9FP4JZrsMv8XD
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] gnss: ubx: support the reset pin of the Neo-M8 variant
Date:   Sun, 12 Nov 2023 19:51:48 -0500
Message-Id: <20231113005152.10656-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas KingFisher board includes a U-Blox Neo-M8 chip with its
reset pin wired to a GPIO. To support that, we need "reset-gpio" support
(patches 2+3). But first, simplify regulator handling with a new helper
(patch 1).

Changes since v4:

* don't touch reset during open/close. Only deassert it during probe.
  [patch 3]


Wolfram Sang (3):
  gnss: ubx: use new helper to remove open coded regulator handling
  dt-bindings: gnss: u-blox: add "reset-gpios" binding
  gnss: ubx: add support for the reset gpio

 .../bindings/gnss/u-blox,neo-6m.yaml          |  5 +++
 drivers/gnss/ubx.c                            | 31 +++++++------------
 2 files changed, 16 insertions(+), 20 deletions(-)

-- 
2.35.1

