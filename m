Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72EB7E9301
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 23:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjKLWy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 17:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjKLWy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 17:54:56 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4EC211F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 14:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=3XXX0zQ/nYYYM1
        tqk4L/LfUMpi+ajf3hbJjlbJDjsIU=; b=beafTtYwE2iZ3igRQsXZPODJZ7Sn5E
        LoXfHBzHrIn3u2qz46b7TTFglSjGJYoZrKATy1MOiwO4U2Jo5TttbJsIGsLK8HJc
        l4oSNqt4TwB3XBpwsXtGmNdT/eyVft+iiQpl5xUZY2sAtO+twWJGPijc3Ud37Fyd
        0vQmeNkNflVhDXTTFPLhBpzVWIfZdKETsDwwHiZcSTHJs8KqxUH6JO3hA/UcTFg/
        XajQGSddAMKhLrIrQ5Mn58lsu6ejErtws+LE99wzPJaYFR5sbUIcwUJ79dikq+8J
        xSFFBInSAm0eSxyyoPMXUphwjIhN2djzc+yH7Eeq4QbRKY09+8mA9X3w==
Received: (qmail 4066220 invoked from network); 12 Nov 2023 23:54:47 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Nov 2023 23:54:47 +0100
X-UD-Smtp-Session: l3s3148p1@wnCocPwJTbYMv8XD
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v2 0/3] i2c: create debugfs entry per adapter
Date:   Sun, 12 Nov 2023 17:54:40 -0500
Message-Id: <20231112225444.4487-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two drivers already implement custom debugfs handling for their
i2c_adapter and more will come. So, let the core create a debugfs
directory per adapter and pass that to drivers for their debugfs files.
Convert the two existing users as well. Tested on a Renesas Lager board
with the i2c-gpio driver. npcm7xx was tested using QEMU with the
quanta-gsj target.

Changes since v1:
* rebased to something close to 6.7-rc1 which includes i2c/for-mergewindow
* tested npcm7xx with QEMU

Wolfram Sang (3):
  i2c: create debugfs entry per adapter
  i2c: gpio: move to per-adapter debugfs directory
  i2c: npcm7xx: move to per-adapter debugfs directory

 drivers/i2c/busses/i2c-gpio.c    | 34 ++++------------------
 drivers/i2c/busses/i2c-npcm7xx.c | 49 +++++---------------------------
 drivers/i2c/i2c-core-base.c      | 11 +++++++
 include/linux/i2c.h              |  2 ++
 4 files changed, 26 insertions(+), 70 deletions(-)

-- 
2.35.1

