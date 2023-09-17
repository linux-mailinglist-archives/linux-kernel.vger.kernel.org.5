Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C67A3DDF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 23:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239308AbjIQVfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 17:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjIQVfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 17:35:23 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E283131
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 14:35:17 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Rph6T6vVHz62;
        Sun, 17 Sep 2023 23:35:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1694986514; bh=ZXKOuSqqrpe9gHfiZs/YFUPhkzcUcHYoH9le5k5Brg0=;
        h=Date:Subject:From:To:Cc:From;
        b=CiifftBrNTE4JluaAJIPMFmQhNAxHryOvCcqDE4PsE6qRjIOlGdOAdSz4ZDAwnhJJ
         p0s/wyI3WoFig9i/RlZw92+YrWiYyt/d9GvNbqCT/Cb9UrRPErbY6Qg3Wx/+2o8Ahs
         vwZlk6hbjCeoWKYJQ17ekjas6hwrCPZGjmCTuJUTAyd0xwJO1yJfNRtNThU/Trzdex
         /e2RMzj1T8ISUXTSWP62RCfsAkZMsjDdWEpoza1ZUlX45bnFzu6ZiN21tbsNBa2axq
         MccqfqwtLheu4owkZj14WtzOBsZbDCnUBK1TUB3hgQ+JzaDLre97uSlyTdXkX7qIm9
         eNtJdnH9d7fMw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Sun, 17 Sep 2023 23:35:13 +0200
Message-Id: <cover.1694985959.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 0/2] regulator/core: A quick fix for struct device handling
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
        Zeng Heng <zengheng4@huawei.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fixing a memory leak in commit d3c731564e09 ("regulator: plug of_node
leak in regulator_register()'s error path") it moved the device_initialize()
call earlier, but did not move the dev->class initialization.  The bug
was spotted and fixed by reverting part of the commit (in commit
5f4b204b6b81 "regulator: core: fix kobject release warning and memory
leak in regulator_register()") and introducing a different bug: now
early error paths use kfree(dev) instead of put_device() for an already
initialized struct device.

This series fixes the original bug and reverts the problematic fix.

Michał Mirosław (2):
  regulator/core: regulator_register: set device->class earlier
  Revert "regulator: core: fix kobject release warning and memory leak
    in regulator_register()"

 drivers/regulator/core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

-- 
2.39.2

