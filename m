Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1E87F2656
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjKUHbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjKUHbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:31:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5887A94
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700551858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KvOMkKMo9cUccrHmegIWh9nJKRwsAB54DEFShO3Xn1I=;
        b=eJU+Zg2gHy+YBQQC/wqD4KdrnXm5IheAzZCGbKNca4R39olMZAad9WX6Lg1MfVARaO9L4n
        0Y8rPfxO3JD2EDM0XDhmpu6QdVaoesx8bkio/sJCtTNN2MLm0xKrK4w766PBeJA0omn+A7
        vgEjCxxabXekGB4QZKnJ3OyAarJS6Ac=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-XT0NF6NmPSqq1tM4_FG37g-1; Tue, 21 Nov 2023 02:30:56 -0500
X-MC-Unique: XT0NF6NmPSqq1tM4_FG37g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85FCA101A52D;
        Tue, 21 Nov 2023 07:30:56 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B68BA20268CF;
        Tue, 21 Nov 2023 07:30:53 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com
Subject: [PATCH v2 0/5] vduse: Add support for reconnection
Date:   Tue, 21 Nov 2023 15:30:45 +0800
Message-Id: <20231121073050.287080-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the reconnect support in vduse,

kernel will allocted pages for reconnection
userspace need use ioctl VDUSE_GET_RECONNECT_INFO to
get the mmap related information and then mapping these pages
to userspace.
kernel and userspace will use these pages to sync
the reconnect information
kernel will use VDUSE_VQ_GET_INFO to sync the information      
userspace App  will call during the "user_app_dev_start()".

change in V2  
1. Address the comments from v1
2. Add the document for reconnect process

Cindy Lu (5):
  vduse: Add function to get/free the pages for reconnection
  vduse: Add file operation for mmap
  vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
  vduse: update the vq_info in ioctl
  Documentation: Add reconnect process for VDUSE

 Documentation/userspace-api/vduse.rst |  29 ++++
 drivers/vdpa/vdpa_user/vduse_dev.c    | 198 +++++++++++++++++++++++++-
 include/uapi/linux/vduse.h            |  50 +++++++
 3 files changed, 276 insertions(+), 1 deletion(-)

-- 
2.34.3

