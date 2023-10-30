Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFC07DBDCA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbjJ3Q0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjJ3Q0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:26:43 -0400
Received: from cnc.isely.net (cnc.isely.net [192.69.181.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438CBDB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isely.net; s=deb;
        t=1698682891; bh=yfEzguf+zGpDH2x/gZ3OO2CO6rmHu/YpBrxxePlvktE=;
        h=From:To:Cc:Subject:Date;
        b=BplNkoX6hh+QLoF208UCPGUKLMS4PGE3nYIRktVv00iCxN2ZcRN7mJQcj3khbLq4P
         Spu8hicV4/noL0iEsimvDEKhRgukw7PUyGbc2pJD+eB805i2RB3MxoJV0zb7nTDPKg
         v6W1D6+1PO5Wy3FrlKzHTFGuIEjPcQKf7cTTGcVZZCqyvQhHcsPcb6RceCFjE
Original-Subject: [PATCH 0/2] Fix error-leg bugs / misbehaviors in i2c-bcm2835 driver.
Author: mike.isely@cobaltdigital.com
Original-Cc: Mike Isely <mike.isely@cobaltdigital.com>,
  Mike Isely <isely@pobox.com>,
  Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
  Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
  linux-rpi-kernel@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Received: from cobalt1.eng.cobalt.local (ts3-dock1.isely.net [::ffff:192.168.23.13])
  (AUTH: PLAIN isely, TLS: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by cnc.isely.net with ESMTPSA
  id 00000000000804E2.00000000653FD80B.000079FD; Mon, 30 Oct 2023 11:21:31 -0500
From:   mike.isely@cobaltdigital.com
To:     Andi Shyti <andi.shyti@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     Mike Isely <mike.isely@cobaltdigital.com>,
        Mike Isely <isely@pobox.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix error-leg bugs / misbehaviors in i2c-bcm2835 driver.
Date:   Mon, 30 Oct 2023 11:21:12 -0500
Message-Id: <20231030162114.3603829-1-mike.isely@cobaltdigital.com>
X-Mailer: git-send-email 2.39.2
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Isely <mike.isely@cobaltdigital.com>

Correct issues that arise when a slave select error happens, including
incorrect hardware cleanup & missed interrupts.

All issues were found and debugged on an RPI CM-4 which actually uses
a BCM2711.  I2C hardware apparently is compatible with BCM2835.

Mike Isely (2):
  [i2c-bcm2835] Fully clean up hardware state machine after a timeout
  [i2c-bcm2835] ALWAYS enable INTD

 drivers/i2c/busses/i2c-bcm2835.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.39.2

