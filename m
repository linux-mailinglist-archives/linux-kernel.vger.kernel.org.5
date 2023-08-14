Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDF577BF61
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjHNRyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjHNRxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:53:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45FBB10F7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:53:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E2BC1063;
        Mon, 14 Aug 2023 10:54:21 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C44E73F762;
        Mon, 14 Aug 2023 10:53:37 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, john.g.garry@oracle.com,
        zhangzekun11@huawei.com
Subject: [PATCH 0/2] iommu/iova: Make the rcache depot properly flexible
Date:   Mon, 14 Aug 2023 18:53:32 +0100
Message-Id: <cover.1692033783.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Prompted by [1], which reminded me I started this a while ago, I've now
finished off my own attempt at sorting out the horrid lack of rcache
scalability. It's become quite clear that given the vast range of system
sizes and workloads there is no right size for a fixed depot array, so I
reckon we're better off not having one at all.

Note that the reclaim threshold and rate are chosen fairly arbitrarily -
it's enough of a challenge to get my 4-core dev board with spinning disk
and gigabit ethernet to push anything into a depot at all :)

Thanks,
Robin.

[1] https://lore.kernel.org/linux-iommu/20230811130246.42719-1-zhangzekun11@huawei.com


Robin Murphy (2):
  iommu/iova: Make the rcache depot scale better
  iommu/iova: Manage the depot list size

 drivers/iommu/iova.c | 94 ++++++++++++++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 29 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

