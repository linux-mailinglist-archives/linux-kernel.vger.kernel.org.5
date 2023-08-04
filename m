Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F43576FB80
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbjHDH5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbjHDH5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:57:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2864228
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 00:57:32 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686f8614ce5so1694092b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 00:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691135852; x=1691740652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rG4+kOpeg7A78jhutmi+pmLSeK2TMW5Crpxh1v3NLCg=;
        b=PPDqJV2pkFNJHNQaw3+BhtMGjHyrERQm5XAh5t0a5vWBqtdpVhLn3oHVBXPLf4Mnyn
         vEe7DWeUU1qceoplDuR9I1bCscMs+2qhw7dOR4oNxlza+ZIPx/bofBdkR6HlsD+UvLsO
         qLsxlP/Qg3XH6Lrfyq08v8VddcQLDaSbYoNDvuhdQNE8jy75soPp08ctNZ2k94L95pET
         kzsalaBbJmlFlzZ8OqymsWR2lrx2e40NkZYAXYWaTbcdFx86P8t6Bwg90U8sXZvBjQB/
         RXY9DkxMcN2MnGm+m9tNwk5D5GFNaJ4mwwWG3yMgQk75uYg4mhfW1BeaRITDUHT7v0lT
         UV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691135852; x=1691740652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rG4+kOpeg7A78jhutmi+pmLSeK2TMW5Crpxh1v3NLCg=;
        b=KLMuUs0OfJy/dRbA48/83p2DuUuGsFfvw71NaDTSx4SQ7Z2UXLsTA4lp5b4T9nglME
         bxvg7xn1sMel9inpmusu8QKX+fnbU7KPzT4T3rXA9tejW0pCiK+vWgYESWus5qlD9hHF
         k7qFNiUT5Pc0tS4+chSNQiuIPzXboL+Tzi6MoXTkand3jNZfLBsawpraDs/3ZzH4hW0s
         AR5SVg7AungpCWZJbBomt/4Z9PZ/1rbeYXMSjTZ84WIZg9DtXUUYtgvnZH+jTICfBjc2
         9n4dXRl5mN9Dvzzoag/5k4omL0m+EETRHix7Ydi7KJcB1dEX3gC94YUIKRm8p1a7OTcU
         y/DQ==
X-Gm-Message-State: AOJu0YwXSHze1oIO4KJPjhvm4hetbwXvWJsRKMdRrIcxTJGyg2J4YN4I
        e/9RiB3ziYpIQAiNGYC9zf3vjA==
X-Google-Smtp-Source: AGHT+IEt7HGaPrPteBwIU1n3ZevOva5VIISA2YP7MmTzWbf+MJj9gTQGy9uSwIeKmudb+/ofm4T4wg==
X-Received: by 2002:a05:6a21:6d88:b0:13f:68fd:6ae8 with SMTP id wl8-20020a056a216d8800b0013f68fd6ae8mr1357604pzb.57.1691135852009;
        Fri, 04 Aug 2023 00:57:32 -0700 (PDT)
Received: from Tower.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id p26-20020a62ab1a000000b006871fdde2c7sm1008676pff.110.2023.08.04.00.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 00:57:31 -0700 (PDT)
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     minchan@kernel.org, senozhatsky@chromium.org, mhocko@suse.com
Cc:     david@redhat.com, yosryahmed@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [RFC PATCH RESEND v2 0/2] zram: memcg accounting
Date:   Fri,  4 Aug 2023 15:57:20 +0800
Message-Id: <20230804075720.207943-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applications can currently escape their cgroup memory
containment when zram is used. This patchset adds
per-cgroup limiting of zram compressed memory to fix it.

As we know, zram can be used in two ways, direct and
indirect, this patchset can charge memory in both cases.
Direct zram usage by process within a cgroup will fail
to charge if there is no memory. Indirect zram usage by
process within a cgroup via swap in PF_MEMALLOC context,
will charge successfully.

This allows some limit overrun, but not enough to matter
in practice.Charge compressed page once, mean a page will
be freed.the size of compressed page is less than or equal
to the page to be freed. The numbers of excess depend on the
compression ratio only. The maximum amount will not exceed
400KB, and will be smaller than the hard limit finally,
So not an unbounded way.

Changes from V1:
- remove memalloc_noreclaim_save in zram_recompress()
- add gfp_t flag in obj_cgroup_charge_zram()

V1's link:
https://lore.kernel.org/all/20230707044613.1169103-1-hezhongkun.hzk@bytedance.com/

The first patch charged in zsmalloc, now aborted:
https://lore.kernel.org/all/20230615034830.1361853-1-hezhongkun.hzk@bytedance.com/

We charge compressed memory directly in the zram module
instead of in the zsmalloc module because zsmallc may
be used by zswap, zswap objects has been charged once
in the zswap module, so zsmallc will double charge.


Summarize the previous discussion:

[1]Michal's concern is that the hard limit reclaim would fail.

Chage compressed page once, mean a page will be freed, so
allows some limit overrun not exceed 400KB.

[2]David's concern is that if there is a page in the BIO that
is not charged,we can not charge the compressed page for the
fs->zram and whether the recompress case is charged.

As i can see, page caches are alloced by user with cgroup.
For the corner case, ZERO_PAGE will not take up space after
compression. Besides,the recompress case is charged.




Zhongkun He (2):
  memcg: Add support for zram object charge
  zram: charge the compressed RAM to the page's memcgroup

 drivers/block/zram/zram_drv.c | 45 +++++++++++++++++++++++++++++++++++
 drivers/block/zram/zram_drv.h |  1 +
 include/linux/memcontrol.h    | 12 ++++++++++
 mm/memcontrol.c               | 24 +++++++++++++++++++
 4 files changed, 82 insertions(+)

-- 
2.25.1

