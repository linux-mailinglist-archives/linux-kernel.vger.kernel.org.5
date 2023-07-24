Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53AC75EB69
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGXGWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjGXGWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:22:20 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9F7E52
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:21:55 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666ecb21f86so3822529b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690179715; x=1690784515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vEgIOhnjJFOuBfQSwGjfY7uJsZuGLdD13XcGGvP6YGY=;
        b=TGImT1/FEN8ssaeZsj5As+U+pYXzZkFsvYR6F/1xLsVUaLXRgB4YiibaRYVLDtuPV1
         LspiIu4xLdv1T99qiDkdaftxbVLkqAC1lRdxeQ3zR+ZdO+KIhFz/cSvq2xGa0KNxnh3h
         TvehrRCiXi1bzj2z+ANM6MRjZ/fogxByHruxpvsx7r4wj8IIhmLXVsOWllLhaRWTEri3
         tGcjMhTOC44Oj/FnoCQGtG4QGvIh9D63sMdtdDS0NNd4LJagUdfOP3PlOXpJMfMDNlHB
         fU+k4VSpGW3+94wS1MRRq5UH7yLB8whf/iI7khCb6yStg5B6HcCbW6JLkKcUnQBhgaRI
         JlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690179715; x=1690784515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEgIOhnjJFOuBfQSwGjfY7uJsZuGLdD13XcGGvP6YGY=;
        b=jIsZTvG6oahqzTWRDgjhfoKd9ljyGZRTIlGPig0KbYfmaGVtaFEsazlYliI7qwWO8R
         nN9QgMkfPTuajts+X+9LITLc7lxckmmT5MIUSjU8jq+lHN6XfRb2EUg8awzC3guMTqYm
         gfUtdzM7uLbuem5jCtkdz11V8TK5dorOMhWbsunEi9F0YMoV6P2+U+5tK9jwj6jUtO0d
         Dxz9/K8Mzlf1tc8ool4ZzMnfPS1Hwhg3uX6unK7/TmPt7sxiscVIkGs4xLBHHJ266iQW
         Tqfmu49YIbDiGdIXEl1iRZ+OOKu6r+pSKqyNstSlSXGNVNOCf9jRANe4+kDiMbuRy+4z
         nP/A==
X-Gm-Message-State: ABy/qLZOi8e2+rtsUlBDe18T/xKnYAi+thQO6RwKgcbZMwY42eY5oT3l
        bYb/OriAOCn1HbW2ettJW/uhxgnMIzMekSQXb+GSNg==
X-Google-Smtp-Source: APBJJlHBHTU5/ig0tcLlK9MobubjQ2/sxG12roeHPbT21t2WE8xxD7ylwRH3L9uP3q/CvO84nFxSxA==
X-Received: by 2002:a05:6a20:3207:b0:130:f6bc:9146 with SMTP id hl7-20020a056a20320700b00130f6bc9146mr9930949pzc.14.1690179714940;
        Sun, 23 Jul 2023 23:21:54 -0700 (PDT)
Received: from Tower.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id p26-20020aa7861a000000b006758ae3952bsm6833336pfn.122.2023.07.23.23.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 23:21:54 -0700 (PDT)
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     minchan@kernel.org, senozhatsky@chromium.org, mhocko@suse.com
Cc:     david@redhat.com, yosryahmed@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [RFC PATCH v2 0/2] zram: memcg accounting
Date:   Mon, 24 Jul 2023 14:21:43 +0800
Message-Id: <20230724062143.2244078-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

 drivers/block/zram/zram_drv.c | 46 +++++++++++++++++++++++++++++++++++
 drivers/block/zram/zram_drv.h |  1 +
 include/linux/memcontrol.h    | 12 +++++++++
 mm/memcontrol.c               | 24 ++++++++++++++++++
 4 files changed, 83 insertions(+)

-- 
2.25.1

