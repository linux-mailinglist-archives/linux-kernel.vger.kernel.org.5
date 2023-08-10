Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FC7777D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbjHJQAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjHJQAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:00:41 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313E826B7;
        Thu, 10 Aug 2023 09:00:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A9ED160ED81F;
        Thu, 10 Aug 2023 18:00:36 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NOlwUiZruBJ3; Thu, 10 Aug 2023 18:00:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4A1E8635D295;
        Thu, 10 Aug 2023 18:00:36 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YnW_UZS0Pu1b; Thu, 10 Aug 2023 18:00:36 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id C7225635D290;
        Thu, 10 Aug 2023 18:00:35 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephan Wurm <stephan.wurm@a-eberle.de>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 0/7] Fix UBI Block wrt. highmem
Date:   Thu, 10 Aug 2023 18:00:11 +0200
Message-Id: <20230810160019.16977-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 changes UBIblock to use a copy of scsi_kmap_atomic_sg()
for sg list processing. This patch is meant for backporting to stable.
It makes use of kmap_atomic() and a bounce buffer because MTD/UBI IO
can sleep.

Patches 2 to 7 move scsi_kmap_atomic_sg() into lib/scatterlist.c,
convert it to kmap_local(), convert all users to it and remove the
bounce buffer from UBIblock again.

Richard Weinberger (7):
  ubi: block: Refactor sg list processing for highmem
  scatterlist: Add kmap helpers
  scsi: dc395x: Switch to kmap_sg
  scsi: esp_scsi: Switch to kmap_sg
  scsi: fdomain: Switch to kmap_sg
  ubi: block: Switch to kmap_sg
  scsi: core: Remove scsi_kmap_atomic_sg()

 drivers/mtd/ubi/block.c     | 11 +++----
 drivers/mtd/ubi/eba.c       | 50 +++++++++++++------------------
 drivers/scsi/dc395x.c       | 12 ++++----
 drivers/scsi/esp_scsi.c     |  4 +--
 drivers/scsi/fdomain.c      | 10 +++----
 drivers/scsi/scsi_lib.c     | 60 -------------------------------------
 include/linux/mtd/ubi.h     | 12 ++++----
 include/linux/scatterlist.h |  3 ++
 include/scsi/scsi_cmnd.h    |  4 ---
 lib/scatterlist.c           | 55 ++++++++++++++++++++++++++++++++++
 10 files changed, 100 insertions(+), 121 deletions(-)

--=20
2.35.3

