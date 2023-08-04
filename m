Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C5576FBC4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbjHDIP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjHDIP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:15:26 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E01912B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:15:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vp.kW45_1691136918;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0Vp.kW45_1691136918)
          by smtp.aliyun-inc.com;
          Fri, 04 Aug 2023 16:15:20 +0800
From:   Ruidong Tian <tianruidong@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     tianruidong@linux.alibaba.com, alexander.shishkin@linux.intel.com,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        mike.leach@linaro.org, suzuki.poulose@arm.com, james.clark@arm.com
Subject: [PATCH v3 0/1] coresight: tmc: Explicit type conversions to
Date:   Fri,  4 Aug 2023 16:15:13 +0800
Message-Id: <20230804081514.120171-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20230714084349.31567-1-tianruidong@linux.alibaba.com>
References: <20230714084349.31567-1-tianruidong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf cs_etm session executed unexpectedly when AUX buffer > 1G.

  perf record -C 0 -m ,2G -e cs_etm// -- <workload>
  [ perf record: Captured and wrote 2.615 MB perf.data ]

Perf only collect about 2M perf data rather than 2G. This is becasuse
the operation, "nr_pages << PAGE_SHIFT", in coresight tmc driver, will
overflow when nr_pages >= 0x80000(correspond to 1G AUX buffer). The
overflow cause buffer allocation to fail, and TMC driver will alloc
minimal buffer size(1M). You can just get about 2M perf data(1M AUX
buffer + perf data header) at least.

Explicit convert nr_pages to 64 bit in tmc driver to avoid overflow.

Changes in V2:
Suzuki K Poulose:
    Add another 2 places where needed to fix.

Changes in V1:
James Clark:
    Use a more accurate commit message.

Ruidong Tian (1):
  coresight: tmc: Explicit type conversions to prevent integer overflow

 drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 5 +++--
 drivers/hwtracing/coresight/coresight-tmc.h     | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.33.1

