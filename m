Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE2C78BC84
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 03:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbjH2Bzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 21:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbjH2Bzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 21:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633A0184
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 18:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693274076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YeQOl0ZS3saHbXQy2AG80w7b5li3nGbIMrsS1CssN30=;
        b=Y8Mmx6Sji2P3cOwXXdMOkJuXfbKqT88qo28z4UFHV9UR/hRTFASZxDfEJgnEBbmYNxebVi
        6laz+zKcoIqDZLf7pakQE1ASOk9JAtBrrEbhsbAZFlGHEKcxgJbew3sNSVMKHzA/s292NE
        9Vs4sB6BEi8xV0Jk4sW+5nVE8QhO2DE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-7kD-3s0KMKmslGvURDC0qg-1; Mon, 28 Aug 2023 21:54:34 -0400
X-MC-Unique: 7kD-3s0KMKmslGvURDC0qg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FBFA101A528;
        Tue, 29 Aug 2023 01:54:34 +0000 (UTC)
Received: from gshan.redhat.com (unknown [10.64.136.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5126740C2063;
        Tue, 29 Aug 2023 01:54:31 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, david@redhat.com,
        jasowang@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com,
        shan.gavin@gmail.com
Subject: [PATCH] virtio_balloon: Fix endless deflation and inflation on arm64
Date:   Tue, 29 Aug 2023 11:54:21 +1000
Message-ID: <20230829015421.920511-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The deflation request to the target, which isn't unaligned to the
guest page size causes endless deflation and inflation actions. For
example, we receive the flooding QMP events for the changes on memory
balloon's size after a deflation request to the unaligned target is
sent for the ARM64 guest, where we have 64KB base page size.

  /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
  -accel kvm -machine virt,gic-version=host -cpu host          \
  -smp maxcpus=8,cpus=8,sockets=2,clusters=2,cores=2,threads=1 \
  -m 1024M,slots=16,maxmem=64G                                 \
  -object memory-backend-ram,id=mem0,size=512M                 \
  -object memory-backend-ram,id=mem1,size=512M                 \
  -numa node,nodeid=0,memdev=mem0,cpus=0-3                     \
  -numa node,nodeid=1,memdev=mem1,cpus=4-7                     \
    :                                                          \
  -device virtio-balloon-pci,id=balloon0,bus=pcie.10

  { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
  {"return": {}}
  {"timestamp": {"seconds": 1693272173, "microseconds": 88667},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272174, "microseconds": 89704},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272175, "microseconds": 90819},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272176, "microseconds": 91961},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272177, "microseconds": 93040},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
  {"timestamp": {"seconds": 1693272178, "microseconds": 94117},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
  {"timestamp": {"seconds": 1693272179, "microseconds": 95337},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272180, "microseconds": 96615},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
  {"timestamp": {"seconds": 1693272181, "microseconds": 97626},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272182, "microseconds": 98693},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
  {"timestamp": {"seconds": 1693272183, "microseconds": 99698},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272184, "microseconds": 100727},  \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272185, "microseconds": 90430},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272186, "microseconds": 102999},  \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
     :
  <The similar QMP events repeat>

Fix it by having the target aligned to the guest page size, 64KB
in this specific case. With this applied, no flooding QMP event
is observed and the memory balloon's size can be stablizied to
0x3ffe0000 soon after the deflation request is sent.

  { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
  {"return": {}}
  {"timestamp": {"seconds": 1693273328, "microseconds": 793075},  \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  { "execute" : "query-balloon" }
  {"return": {"actual": 1073610752}}

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 5b15936a5214..625caac35264 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -386,6 +386,17 @@ static void stats_handle_request(struct virtio_balloon *vb)
 	virtqueue_kick(vq);
 }
 
+static inline s64 align_pages_up(s64 diff)
+{
+	if (diff == 0)
+		return diff;
+
+	if (diff > 0)
+		return ALIGN(diff, VIRTIO_BALLOON_PAGES_PER_PAGE);
+
+	return -ALIGN(-diff, VIRTIO_BALLOON_PAGES_PER_PAGE);
+}
+
 static inline s64 towards_target(struct virtio_balloon *vb)
 {
 	s64 target;
@@ -396,7 +407,7 @@ static inline s64 towards_target(struct virtio_balloon *vb)
 			&num_pages);
 
 	target = num_pages;
-	return target - vb->num_pages;
+	return align_pages_up(target - vb->num_pages);
 }
 
 /* Gives back @num_to_return blocks of free pages to mm. */
-- 
2.41.0

