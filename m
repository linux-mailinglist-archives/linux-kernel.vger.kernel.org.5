Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17997EBDED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 08:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjKOHXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 02:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOHXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 02:23:16 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5A3FE;
        Tue, 14 Nov 2023 23:23:12 -0800 (PST)
Received: from dggpemd200004.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SVZJp2fhzzMl6P;
        Wed, 15 Nov 2023 15:18:34 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemd200004.china.huawei.com
 (7.185.36.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.23; Wed, 15 Nov
 2023 15:23:09 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH 0/2] Fix invalid wait context of set_track_prepare()
Date:   Wed, 15 Nov 2023 16:21:36 +0800
Message-ID: <20231115082138.2649870-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd200004.china.huawei.com (7.185.36.141)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert reported an invalid wait context[1] which is resulted by moving
set_track_prepare() inside kmemleak_lock. This is not allowed because
in RT mode, the spinlocks can be preempted but raw_spinlocks can not,
so it is not allowd to acquire spinlocks while holding raw_spinlocks.
The second patch fix same problem in kmemleak_update_trace().

Link: https://lore.kernel.org/linux-mm/CAMuHMdWj0UzwNaxUvcocTfh481qRJpOWwXxsJCTJfu1oCqvgdA@mail.gmail.com/ [1]

Liu Shixin (2):
  Revert "mm/kmemleak: move the initialisation of object to
    __link_object"
  mm/kmemleak: move set_track_prepare() outside raw_spinlocks

 mm/kmemleak.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

-- 
2.25.1

