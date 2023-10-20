Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A9D7D135A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377790AbjJTP70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377797AbjJTP7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:59:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4A8D4C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697817522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=umrr8klAQ5M6VrOQW9RqPBZxb5qUD5G43p73Sx5jNAU=;
        b=IdHiKG+4d11fIjjPcctrFQWwrHfttls1cVwhI5YGkhuhCG+oW7dMrC88fuhd/3AUxAMQ7V
        zPwD0c1kWVuhT/D0ibC7CxpD5+x9mQZG5yVqSl5vkZksh17rGjJaomNZJbqvrvRHg66hQQ
        bzAJnZyXnKAD5Ed1oY4chYsv+S3NV0o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-uMYW_5-WPJydi6sEzSiaKA-1; Fri, 20 Oct 2023 11:58:29 -0400
X-MC-Unique: uMYW_5-WPJydi6sEzSiaKA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13A5988B773;
        Fri, 20 Oct 2023 15:58:29 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9B3C503B;
        Fri, 20 Oct 2023 15:58:25 +0000 (UTC)
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        david.marchand@redhat.com, lulu@redhat.com
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v4 0/4] vduse: add support for networking devices
Date:   Fri, 20 Oct 2023 17:58:15 +0200
Message-ID: <20231020155819.24000-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series enables virtio-net device type in VDUSE.
With it, basic operation have been tested, both with
virtio-vdpa and vhost-vdpa using DPDK Vhost library series
adding VDUSE support using split rings layout (merged in
DPDK v23.07-rc1).

Control queue support (and so multiqueue) has also been
tested, but requires a Kernel series from Jason Wang
relaxing control queue polling [1] to function reliably,
so while Jason rework is done, a patch is added to disable
CVQ and features that depend on it (tested also with DPDK
v23.07-rc1).

In this v4, LSM hooks are added to allow/deny application
to create/destroy/open devices based on their type (Net,
Block).

[1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com/T/

v3->v4 changes:
===============
- Add LSM hooks (Michael)
- Rebase

v2 -> v3 changes:
=================
- Use allow list instead of deny list (Michael)

v1 -> v2 changes:
=================
- Add a patch to disable CVQ (Michael)

RFC -> v1 changes:
==================
- Fail device init if it does not support VERSION_1 (Jason)

Maxime Coquelin (4):
  vduse: validate block features only with block devices
  vduse: enable Virtio-net device type
  vduse: Temporarily disable control queue features
  vduse: Add LSM hooks to check Virtio device type

 drivers/vdpa/vdpa_user/vduse_dev.c  | 64 +++++++++++++++++++++++++++--
 include/linux/lsm_hook_defs.h       |  4 ++
 include/linux/security.h            | 15 +++++++
 security/security.c                 | 42 +++++++++++++++++++
 security/selinux/hooks.c            | 55 +++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 +
 6 files changed, 178 insertions(+), 4 deletions(-)

-- 
2.41.0

