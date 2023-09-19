Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CDB7A57DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 05:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjISD1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 23:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjISD1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 23:27:47 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59E0A95
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 20:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:Reply-To:MIME-Version;
        bh=xSjnYJ6kacZY7UCZLdel3UJ+ItlAuPMrAohzlcPsg08=; b=UFxUY6tZ4d52P
        CsUT+pL3PPmJeKgcGP6c0u1APPPLIv7DgYNbQsD4gyzX0Kmnz5A/gqe3vdCmfkaX
        aqccK/p+BbGD/GumOmAZFWmNRzDq6C+NASiknZpvJwY2Z8KiAISpN8CDVGKDMnbi
        yX4+d7b9lAPidvhz0FX64GemA18nAY=
Received: from localhost.localdomain (unknown [183.192.130.204])
        by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wB3Lij7FAllZePxCQ--.10947S3;
        Tue, 19 Sep 2023 11:26:55 +0800 (CST)
From:   Ping Gan <jacky_gam_2001@163.com>
To:     chaitanyak@nvidia.com
Cc:     ping_gan@dell.com, kbusch@kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        jacky_gam_2001@163.com
Subject: [PATCH 0/4] nvmet: support polling queue task for bio request 
Date:   Tue, 19 Sep 2023 11:25:39 +0800
Message-Id: <cover.1694592708.git.jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230919032539.71629-1-jacky_gam_2001@163.com>
References: <28949e52-7db7-4227-6bbd-cb8b627b390f@nvidia.com>
 <20230919032539.71629-1-jacky_gam_2001@163.com>
Reply-To: chaitanyak@nvidia.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3Lij7FAllZePxCQ--.10947S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWDWr45ur1xZrykKry8Xwb_yoWfKFX_Cr
        10vr9rKFW8uF1DtFW7Cr1UXFZFka1Fvr92gFs0qr45Kr9rury5Jrn2vF9xAw4xAw48Zrn8
        GryUGr4FkrWUWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRiyCJPUUUUU==
X-Originating-IP: [183.192.130.204]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiWB-vKWNftq5OugABsQ
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since nvme target currently does not support to submit bio to a polling
queue, the bio's completion relies on system interrupt. But when there
is high workload in system and the competition is very high, so it makes
sense to add polling queue task to submit bio to disk's polling queue
and poll the completion queue of disk. 

Ping Gan (4):
  nvmet: Add nvme target polling queue task parameters
  nvmet: Add polling queue task for nvme target
  nvmet: support bio polling queue request
  nvme-core: Get lowlevel disk for target polling queue task

 drivers/nvme/host/multipath.c              |  20 +
 drivers/nvme/target/Makefile               |   2 +-
 drivers/nvme/target/core.c                 |  55 +-
 drivers/nvme/target/io-cmd-bdev.c          | 243 ++++++++-
 drivers/nvme/target/nvmet.h                |  13 +
 drivers/nvme/target/polling-queue-thread.c | 594 +++++++++++++++++++++
 6 files changed, 895 insertions(+), 32 deletions(-)
 create mode 100644 drivers/nvme/target/polling-queue-thread.c

-- 
2.26.2

