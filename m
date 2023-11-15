Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381507EBC71
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbjKOD6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKOD6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:58:06 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED8FD7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:58:02 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 255F92C018D;
        Wed, 15 Nov 2023 16:57:59 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1700020679;
        bh=uA0rlb6Ck8yhsN/S3XkQO0YUcaI5j9KtFBfH6I+NaZo=;
        h=From:To:Cc:Subject:Date:From;
        b=n7qxPWtYjW1Wj2ip0rg6lHeDSRcFSnbVa1U6mjbn964MFmC/zQW9qqT1uRF2P0C0V
         4TiAaYWKj9TBc+KzR21B28aPdOWvP9gzBjum6ckMuPm5K34vL6d1DuPT9xaDmN7AOT
         LXS+wIUpXN3+EndQcqJJ28rPqGHrsa8v6+evvorWGjAf974t3O3LmQaXvpHLPT12/k
         rM/ezjTtiihfFdYBHrqcXdL9rX6zqG3RBdXX/DsJCqf3elv7qK6FNQ7IzU4nBcwQHN
         I/DNjJaMkwGueIFkuxfjARRGJvB9fTTtUSCL5jiXGvsfkCkhCdeOYkU2d2Y59wCQf1
         uk/GCopvXAOoQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B655441c60000>; Wed, 15 Nov 2023 16:57:58 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 8827613EE3F;
        Wed, 15 Nov 2023 16:57:58 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 7FFFE280590; Wed, 15 Nov 2023 16:57:58 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     wsa@kernel.org, andi.shyti@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregory.clement@bootlin.com
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v6 0/2] i2c: bus-reset-gpios
Date:   Wed, 15 Nov 2023 16:57:51 +1300
Message-ID: <20231115035753.925534-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=L6ZjvNb8 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=BNY50KLci1gA:10 a=VwQbUJbxAAAA:8 a=DIZWHGWb_bPM9LNtZTAA:9 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the ability to associate a gpio with an I2C bus so that
downstream devices can be brought out of reset when the host controller i=
s
probed.

v5: https://lore.kernel.org/lkml/20231027033104.1348921-1-chris.packham@a=
lliedtelesis.co.nz/

The conversation sparked from v5 was heading in the direction of this nee=
ding
to be more generic. So I've moved the changes up to the i2c core, which i=
s
about as generic as I'm comfortable with.

Chris Packham (2):
  dt-bindings: i2c: add bus-reset-gpios property
  i2c: add an optional bus-reset-gpios property

 Documentation/devicetree/bindings/i2c/i2c.txt |  8 ++++
 drivers/i2c/i2c-core-base.c                   | 39 +++++++++++++++++++
 include/linux/i2c.h                           |  3 ++
 3 files changed, 50 insertions(+)

--=20
2.42.0

