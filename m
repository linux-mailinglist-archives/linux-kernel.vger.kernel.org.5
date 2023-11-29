Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0107FDD0B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjK2QcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjK2QcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:32:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B423BF;
        Wed, 29 Nov 2023 08:32:30 -0800 (PST)
From:   Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701275548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wgM6REurFe0euNPRsJDjg3HXoLEfDSQ4SWRzMt9M5cI=;
        b=XpqxKD4qG4IArSrfbweYlaVcHx5kpYWy0Fqnhl7xxcyCd+SwoUhjJYaPSRB/Ei/3jhjZkX
        VH8jZ+40xLF248HPNpe/HZq2ON4qzAZGoKdqcOYOXl2BICeGo1MhLaHbBekMYO7R1OTO1s
        O6Hcv3rBMJD/hRBVadpfqCJRtm/Ir112/N00belHKO3DfAsEitj8eRYWq1MothKK/wc2lM
        5tLecwZJooVolLjDPkFileVyWxLWnjyM5d7Q9OY+QkJ4yEJ11erb+vqdBWF3oacArwmMjA
        sp/7oDwwpfAfziwJhTHOXsvpAeTQZFjynfy/Y2+ztiJ5jalgUq5Pv+usmzmbMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701275548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wgM6REurFe0euNPRsJDjg3HXoLEfDSQ4SWRzMt9M5cI=;
        b=78QriPAcEvZ6gzjZS4NXrw2dqKDfscF3IfvztobeI6yP+Q+8MqK0H+86nx0AgLQqgHAwVR
        afyoW1AmUv1McxAQ==
To:     linus.walleij@linaro.org, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 0/2] spi: spl022: fix sleeping in interrupt context
Date:   Wed, 29 Nov 2023 17:31:54 +0100
Message-Id: <cover.1701274975.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

v2: add some documents for the new flag. No functional change.

Nam Cao (2):
  spi: introduce SPI_TRANS_FAIL_IO for error reporting
  spi: spl022: switch to use default spi_transfer_one_message()

 drivers/spi/spi-pl022.c | 372 +++++++---------------------------------
 drivers/spi/spi.c       |   3 +
 include/linux/spi/spi.h |  12 +-
 3 files changed, 77 insertions(+), 310 deletions(-)

--=20
2.39.2

