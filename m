Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA68079E2A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbjIMIwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239103AbjIMIwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:52:04 -0400
X-Greylist: delayed 917 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Sep 2023 01:51:59 PDT
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AECD0E73
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xSjnY
        J6kacZY7UCZLdel3UJ+ItlAuPMrAohzlcPsg08=; b=WLACnnLTEgEVh2FFtehcH
        vAxHkGuemmWMJytCpUumDGoDgFGPYBYK+O4OZinkfXhfGJV5cCzL18rCCf8P9r+Z
        n2sFjlTOvSZVnKUfYBfCNdLNpn2SvxNHYYAUWg/nrBBsZLVqP39rS1fAKHS4Y0Rm
        0QqQxdoM1YPRSYemcfeXgI=
Received: from localhost.localdomain (unknown [223.166.237.2])
        by zwqz-smtp-mta-g0-3 (Coremail) with SMTP id _____wBHOthidAFlHFGdAA--.29242S2;
        Wed, 13 Sep 2023 16:35:47 +0800 (CST)
From:   Ping Gan <jacky_gam_2001@163.com>
To:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        kch@nvidia.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc:     ping_gan@dell.com, jacky_gam_2001@163.com
Subject: [PATCH 0/4] nvmet: support polling queue task for bio request 
Date:   Wed, 13 Sep 2023 16:34:33 +0800
Message-Id: <cover.1694592708.git.jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHOthidAFlHFGdAA--.29242S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWDWr45ur1xZrykKry8Xwb_yoWfKFX_Cr
        10vr9rKFW8uF1DtFW7Cr1UXFZFka1Fvr92gFs0qr45Kr9rury5Jrn2vF9xAw4xAw48Zrn8
        GryUGr4FkrWUWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMqXHJUUUUU==
X-Originating-IP: [223.166.237.2]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/xtbBogXpKVaEJdIBfAAAs-
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

