Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662467FD826
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbjK2NcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjK2NcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:32:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0944E9D;
        Wed, 29 Nov 2023 05:32:26 -0800 (PST)
From:   Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701264744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4kppMjNPf1GKwvIU18Ptl9YLUNAOWni/rWCQpmP6c8g=;
        b=PvEEKZi+brEqPQ8OQRPOWt0chNcNLzDHQoN0j2L2GW4V/8SPzJDhHYDof4k2PAkPf9B2jq
        9aMgfMdBtj09ljuQpoC/9h2WAKQy9JhSPz8Wa6eV5Vu2mGvTO9zzc28HG3g+ppLUt0Oz86
        B160SzuFerkL4ToSRxko96gJm6IrAvosekVRMR7aldlKEq9a3/QpTmxsjkFTEGah4dJpvM
        nGCZgwrRrHY5rflUNEMvGjpDVifP8mi6SmhQaa0O78YLuoD86Zpao7mPh+9cqa0O66kkAO
        nR9Ut5FCnp5TXiRpqihMg7OCe+p0DEon+u7V49OcX4yqBpMOseE4V1ONlVt4xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701264744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4kppMjNPf1GKwvIU18Ptl9YLUNAOWni/rWCQpmP6c8g=;
        b=cZCeWPixlXbm9/0ZN/s6Zf16kJHyUsdaXP+dwG+0mQ6kkKXSexhziIrvU57eBq/zAHiKPa
        PSo4cRDO9Ch7hMCg==
To:     linus.walleij@linaro.org, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/2] spi: spl022: fix sleeping in interrupt context
Date:   Wed, 29 Nov 2023 14:32:17 +0100
Message-Id: <cover.1701264413.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While running the spl022, I got the following warning:
BUG: sleeping function called from invalid context at drivers/spi/spi.c:1428

This is because between spi transfers, spi_transfer_delay_exec() (who
may sleep if the delay is >10us) is called in interrupt context. This is
a problem for anyone who runs this driver and need more than 10us delay.

Patch 1 adds an error reporting mechanism, needed by patch 2 who switch
to use the default spi_transfer_one_message(), which fix the problem.

The series is tested with polling transfer mode and interrupt transfer
mode. I can't test the DMA mode, so some help testing here is very
appreciated.

One question: This series is quite big for stable trees, so how can we
backport this fix? We can:
  - Let it be released, and get tested for some time. After a while
    without any reported problem, backport it.
  - Have a small patch which fixes this problem. One idea I have is to
    switch the current interrupt handler to threaded interrupt handler,
    and switch from existing use of tasklet to workqueue. So that the
    driver can safely sleep if needed. And then add this series on top
    of that.
  - other options that I miss?

Best regards,
Nam

Nam Cao (2):
  spi: introduce SPI_TRANS_FAIL_IO for error reporting
  spi: spl022: switch to use default spi_transfer_one_message()

 drivers/spi/spi-pl022.c | 372 +++++++---------------------------------
 drivers/spi/spi.c       |   3 +
 include/linux/spi/spi.h |   1 +
 3 files changed, 70 insertions(+), 306 deletions(-)

--=20
2.39.2

