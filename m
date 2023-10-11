Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E593B7C4ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345580AbjJKGnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345642AbjJKGnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:43:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB81193
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697006544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Laj+I6CXEar+PfgjGUIkAgDVmXM2Vc2OugtXPoguS2U=;
        b=gw1ucMD/pnXGwhSgyrf5EYAb2UdrAzSXfQAhB+fAbiStdzObTS/KMpf5S5F5wi7w9EdU74
        S7tDOC0I5CsS7Vamt2xekKG9GkvkhA7QSZ/d1hH5iI8dpXvJBk32O9EYb+UwHftPFjd8wl
        RIcxH5qpceqq52wCmXlrkwa4I2+YSiM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-DZDbT5Y6MEq5Ze6LWwX2TQ-1; Wed, 11 Oct 2023 02:42:21 -0400
X-MC-Unique: DZDbT5Y6MEq5Ze6LWwX2TQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 563FB185A78E;
        Wed, 11 Oct 2023 06:42:21 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A4CC170E9;
        Wed, 11 Oct 2023 06:42:18 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com
Subject: [PATCH v1 0/4] vduse: Reconnection support in vduse
Date:   Wed, 11 Oct 2023 14:42:04 +0800
Message-Id: <20231011064208.2143245-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the reconnect support in vduse, 

The kernel will allocate pages for reconnection
userspace needs to use ioctl VDUSE_GET_RECONNECT_INFO to 
get the mmap related infomation and then map these pages
to userspace. 
The kernel and userspace will use these pages to sync
the reconnect information

Tested in vduse + dpdk test-pmd

Cindy Lu (4):
  vduse: Add function to get/free the pages for reconnection
  vduse: Add file operation for mmap
  vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
  vduse: update the vq_info in ioctl

 drivers/vdpa/vdpa_user/vduse_dev.c | 175 +++++++++++++++++++++++++++++
 include/uapi/linux/vduse.h         |  43 +++++++
 2 files changed, 218 insertions(+)

-- 
2.34.3

