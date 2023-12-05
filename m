Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9800804C84
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344796AbjLEIey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjLEIex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:34:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED0FD3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701765298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EZGAiuD4c6EeeMuRKIfdrsmOYZT7el3aWkmdeOBjkLM=;
        b=QxixgYSjuN+wetjkXG/5uS2rNS+M5f51Goo4uZcGiVSQLppGhDPdu8O4eJuwzhM9oZ98tF
        B9qIeEFbNespDm1lpMrx/g8hPiKSFBVaPBmnChtEaMXjIUbKhLnYGeuA5HXXqO4sNy2gr7
        AtxW9vA75zmrWaEIMdtl8f6duV8Dcj0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-COq0lAi_O-6de5qstJLj_Q-1; Tue, 05 Dec 2023 03:34:54 -0500
X-MC-Unique: COq0lAi_O-6de5qstJLj_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 842B0101A52A;
        Tue,  5 Dec 2023 08:34:54 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B02082166B31;
        Tue,  5 Dec 2023 08:34:50 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com
Subject: [PATCH v3 0/7] vduse: Add support for reconnection
Date:   Tue,  5 Dec 2023 16:34:37 +0800
Message-Id: <20231205083444.3029239-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the reconnect support in vduse,

Kernel will allocate pages for reconnection.
Userspace needs to use mmap to map the memory to userspace.
The kernel and userspace will use these pages to synchronize the
reconnect information.

test passd in vduse+dpdk-testpmd

change in V2  
1. Address the comments from v1
2. Add the document for reconnect process

change in V3  
1. Move the vdpa_vq_state to the uAPI.  vduse will use this to synchronize the vq info between the kernel and userspace app.
2. Add a new ioctl VDUSE_DEV_GET_CONFIG. userspace app use this to get config space 
3. Rewrite the commit message.
4. Only save the address for the page address and remove the index.
5. remove the ioctl VDUSE_GET_RECONNECT_INFO, userspace app will use uAPI VDUSE_RECONNCT_MMAP_SIZE to mmap
6. Rewrite the document for the reconnect process to make it clearer.

Signed-off-by: Cindy Lu <lulu@redhat.com>

Cindy Lu (7):
  vdpa: Move struct vdpa_vq_state to uAPI
  vduse: Add new uAPI for vduse reconnection
  vduse: Add new ioctl VDUSE_DEV_GET_CONFIG
  vduse: Add function to get/free the pages for reconnection
  vduse: Add file operation for mmap
  vduse: Update the vq_info in ioctl VDUSE_VQ_GET_INFO
  Documentation: Add reconnect process for VDUSE

 Documentation/userspace-api/vduse.rst |  30 +++++
 drivers/vdpa/vdpa_user/vduse_dev.c    | 184 +++++++++++++++++++++++++-
 include/linux/vdpa.h                  |  29 +---
 include/uapi/linux/vdpa.h             |  31 +++++
 include/uapi/linux/vduse.h            |  25 ++++
 5 files changed, 270 insertions(+), 29 deletions(-)

-- 
2.34.3

