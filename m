Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DA77ADC65
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjIYPyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjIYPyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:54:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647E292
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:54:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39800C433C8;
        Mon, 25 Sep 2023 15:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695657269;
        bh=VbwuYfSftjz4yAlzxKgg+THJnGjMCtfrUoHPB+hCAGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T0MwjoFQyuNUeUaE2hTBr1gh5Sz2OLJTVdVvw/FqELkETvLI8+stNeQMILiRP9run
         JxmrQiDjBbqisGW9HmUZ9VZk3XCZ0aCMX85iw6YApZZAb/bALSjfpWyMs6m1bpkGL8
         PvbC1Y6a972zMHFwHd64OZ7QUcGSj0MgNsPDC1FwJfM6EpAyvupj9elnTaecoOEIhA
         wCIjC7c9cDCiwKCjm6gx1zwtG1tcepvTy7mmHHz238J7yV1entUqyjQ/hjd4y0/g7t
         G6VNZiH2lKqVvdxEEt+HeOl6zm5UQnNE9xrVHpnGGD9n0jbKDf87KGEIABFNd3tzRY
         c832cDme1GApA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Tree Davies <tdavies@darkphysics.net>,
        Yogesh Hegde <yogi.kernel@gmail.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8192e: remove bogus __packed annotations
Date:   Mon, 25 Sep 2023 17:54:04 +0200
Message-Id: <20230925155413.471287-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925155413.471287-1-arnd@kernel.org>
References: <20230925155413.471287-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The rtllib_rxb structure contains a pointer, so this is not a hardware
structure but could benefit from loading the pointer in a single
instruction rather than assembling it from four or eight individual
bytes.

Both structures are allocated as part of larger structure that
already enforce at least a 4-byte alignment, so there is no
reason to ever have to deal with misaligned definitions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/rtl8192e/rtllib.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 7d26910a0b162..fe7b58ae33995 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -172,7 +172,7 @@ struct sw_chnl_cmd {
 	u32			Para1;
 	u32			Para2;
 	u32			msDelay;
-} __packed;
+};
 
 /*--------------------------Define -------------------------------------------*/
 #define MGN_1M		  0x02
@@ -707,7 +707,7 @@ struct rtllib_rxb {
 	struct sk_buff *subframes[MAX_SUBFRAME_COUNT];
 	u8 dst[ETH_ALEN];
 	u8 src[ETH_ALEN];
-} __packed;
+};
 
 union frameqos {
 	u16 shortdata;
-- 
2.39.2

