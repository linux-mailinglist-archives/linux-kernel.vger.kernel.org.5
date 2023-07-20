Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70A775AB64
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjGTJtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjGTJsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:48:10 -0400
Received: from out-29.mta0.migadu.com (out-29.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4244C26B8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:47:12 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689846430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IWsEdoCST2RLmfVQaJhpZTZMKhLTaQ2FtZavGotVcwk=;
        b=ArIuxhs1r2s5cqxco09D6B5rx6QvqHCe/RVtqG9xHgrhTTe3P6anSMkPsaV7TAdgKySdlp
        wWKwzvzJ+s7pDJXcQzBeMdD0NKeQzvAnDXznzmeB3hiZ83Rv9teoKiC3fOZZWs4zp5LVrX
        MA4XhAe/raHLdU4dPf7IHKLJ4hcdw4w=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, osandov@fb.com, ming.lei@redhat.com,
        kbusch@kernel.org, krisman@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 0/6] sbitmap: fix offset hint wrap and some optimizations
Date:   Thu, 20 Jul 2023 17:45:49 +0800
Message-ID: <20230720094555.1397621-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Hello,

This series aim to fix and simplify the offset hint wrap logic, also
include some minor optimizations.

patch 01,02 fix offset hint wrap logic in strict round-robin mode.

patch 03,04 simplify the sbitmap_find_bit() code by removing wrap logic.

patch 05,06 are two minor optimizations.

Thanks!

Chengming Zhou (6):
  sbitmap: fix hint wrap in the failure case
  sbitmap: fix round-robin non-wrap find with hint > 0
  sbitmap: don't loop twice in find_next_zero_bit()
  sbitmap: remove offset wrap logic when finding bit in word
  sbitmap: wake_index doesn't need to be atomic_t
  sbitmap: check ws_active before check waitqueues

 include/linux/sbitmap.h |  2 +-
 lib/sbitmap.c           | 66 ++++++++++++++++++++---------------------
 2 files changed, 33 insertions(+), 35 deletions(-)

-- 
2.41.0

