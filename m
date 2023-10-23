Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301A27D38B6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjJWOAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjJWOAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:00:18 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22241110
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:00:15 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id DA0D124002A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:00:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1698069612; bh=iFQQRi702AynL/9DH88qNRr40fv94tsGYlUkbNd2M+0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=N7uhrotP+wekJVq0e7CpzAlPHahMV8F+OMntufbLbW3Apeuc82xdLHC/ivS6frjlI
         FtZU50WLmF+P4EpVqOlcRIEwBlmpXQ4NoloC0RngwitC7wI7IMkAlFvviPnRU3lux0
         gkt9JhMCjyKO3tmW1pbM4JwqfsLlVxTZwP0w+76XGRG/9yFhTbgtrAZ/3GXwkZ3/Fs
         5GZfz7rVMcCxN0wVkYLZVhB8fFM3T19qpCc5HLIH+m4dou98HTq4/SwgbT8lMt8TfO
         oBGMYwQzm1cdQMwXPjdgdkBxZdD9n3Wo0dprvZIibCeuzpmGfkF8Xmz+Np0qxT63H0
         jaGk7dWzvLsSQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4SDcJp23Dnz6tvl;
        Mon, 23 Oct 2023 16:00:10 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v2 0/3] nvme-tcp: always set valid seq_num in dhchap reply
Date:   Mon, 23 Oct 2023 14:00:00 +0000
Message-Id: <20231023140003.58019-1-shiftee@posteo.net>
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

Mark O'Donovan (3):
  nvme-auth: auth success1 msg always includes resp
  nvme-auth: add flag for bi-directional auth
  nvme-auth: always set valid seq_num in dhchap reply

 drivers/nvme/host/auth.c | 13 ++++++-------
 include/linux/nvme.h     |  2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)


base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
-- 
2.39.2

