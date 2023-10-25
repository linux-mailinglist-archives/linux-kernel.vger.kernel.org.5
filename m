Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B9D7D6980
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjJYKvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYKvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:51:42 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D50AC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:51:39 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 51A3124002A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 12:51:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1698231097; bh=0FIw4YJi8aEpRPqIX3rgKn5FpRFYwb1qqUHkTAzLsjs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=mcHjHkuyzf94AqEZQqn0bHKE7baNtxOpkiXmJf15CI29HAIdMJKaCIHdlyd2PK3GF
         N+qx/UCsY8mDyAHXUek5mj3dgbAcxjCWO+LKtE0xEHB5722F1GifYZGpV8uoAQm1pM
         TMMiP2dsrI+xM9kMRs6NhDZYtKMhxBhUF/fWywJjMSauYOO/kjjChw922ImsfXCaQo
         lv187s3MxifVFgK9dS1eLarPLIdJLNBkhpe11HJCI3HkFDLcwIQZ6xtvELmKw2Ha2a
         T2LjC0s2IrpurKrjZDGoo8T7si4MPw5skmo8wP3QlSbMu2PG8fVYtwee5fcoK8uhTS
         SWM37OwcSwhZQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4SFm2G6rRLz9rxB;
        Wed, 25 Oct 2023 12:51:34 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v3 0/3] nvme-tcp: always set valid seq_num in dhchap reply
Date:   Wed, 25 Oct 2023 10:51:22 +0000
Message-Id: <20231025105125.134443-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch is a small unrelated fix which makes it clear that the
response data section of the Success1 message is not optional.

The second patch removes use of the host sequence number (S2) as an
indicator of bi-directional authentication.

The third patch causes us to always set the host sequence number (S2)
to a non-zero value instead of the 0 value reserved for the secure
channel feature.

v1: original submission
v2: rebased + added dedicated variable for bi-directional auth
v3: nvme-target code now reads seq-num

Mark O'Donovan (3):
  nvme-auth: auth success1 msg always includes resp
  nvme-auth: add flag for bi-directional auth
  nvme-auth: always set valid seq_num in dhchap reply

 drivers/nvme/host/auth.c               | 13 ++++++-------
 drivers/nvme/target/fabrics-cmd-auth.c |  2 +-
 include/linux/nvme.h                   |  2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)


base-commit: 4f82870119a46b0d04d91ef4697ac4977a255a9d
-- 
2.39.2

