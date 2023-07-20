Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFA775AA41
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjGTI7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGTIjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE3C26A9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689842332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=uD8lCSCMjSGZH3wOzVWgkovAsvnWHdzdpIGokpNxVkQ=;
        b=ZL8pSSWqUAWmwgl/TRVir4n0vx9ZNfenxfVmUvxwxKqcloa31x/JB/3a9FM5wculs2f3m4
        D/QELC6eNgAFHUMACq+wWg2PtBzjQzP+JMC1RGgAFgB0MSLGN4ffhRtHIGCtG9d00AVLYR
        rZ7kvFXUu1FfNwzYvh/G7J/q/5B7zb8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-MUO2sSHNPdOz-BhsdqPtqg-1; Thu, 20 Jul 2023 04:38:47 -0400
X-MC-Unique: MUO2sSHNPdOz-BhsdqPtqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4532E1C04B62;
        Thu, 20 Jul 2023 08:38:46 +0000 (UTC)
Received: from dell-per430-12.lab.eng.pek2.redhat.com (dell-per430-12.lab.eng.pek2.redhat.com [10.73.196.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAEEBF6CD8;
        Thu, 20 Jul 2023 08:38:41 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alvaro.karsz@solid-run.com, maxime.coquelin@redhat.com
Subject: [PATCH net-next v4 0/2] virtio-net: don't busy poll for cvq command
Date:   Thu, 20 Jul 2023 04:38:37 -0400
Message-Id: <20230720083839.481487-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

The code used to busy poll for cvq command which turns out to have
several side effects:

1) infinite poll for buggy devices
2) bad interaction with scheduler

So this series tries to use cond_resched() in the waiting loop. Before
doing this we need first make sure the cvq command is not executed in
atomic environment, so we need first convert rx mode handling to a
workqueue.

Note that, this doesn't try to solve the case that a malicous device
may block networking stack (RTNL) or break freezer which requries more
thought to gracefully exit and resend the commands.

Please review.

Changes since V3:

- Tweak the comments
- Tweak the changelog to explain the rx mode lost after resuming.
- No functional changes

Changes since V2:

- Don't use interrupt but cond_resched()

Changes since V1:

- use RTNL to synchronize rx mode worker
- use completion for simplicity
- don't try to harden CVQ command

Changes since RFC:

- switch to use BAD_RING in virtio_break_device()
- check virtqueue_is_broken() after being woken up
- use more_used() instead of virtqueue_get_buf() to allow caller to
  get buffers afterwards
- break the virtio-net device when timeout
- get buffer manually since the virtio core check more_used() instead

Jason Wang (2):
  virtio-net: convert rx mode setting to use workqueue
  virtio-net: add cond_resched() to the command waiting loop

 drivers/net/virtio_net.c | 59 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 4 deletions(-)

-- 
2.39.3

