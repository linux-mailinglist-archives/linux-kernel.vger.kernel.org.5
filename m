Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F4E771A43
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjHGGYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHGGYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:24:43 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6CC10F9;
        Sun,  6 Aug 2023 23:24:41 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3776O0je067960;
        Mon, 7 Aug 2023 14:24:00 +0800 (+08)
        (envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RK5nq5kmwz2P65sW;
        Mon,  7 Aug 2023 14:22:07 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.72) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 7 Aug 2023 14:23:57 +0800
From:   Xuewen Yan <xuewen.yan@unisoc.com>
To:     <rafael@kernel.org>, <pavel@ucw.cz>, <len.brown@intel.com>
CC:     <qyousef@layalina.io>, <guohua.yan@unisoc.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] PM: QOS: Always use "kstrtos32_from_user()" in cpu_latency_qos_write()
Date:   Mon, 7 Aug 2023 14:23:45 +0800
Message-ID: <20230807062345.490-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.73.72]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 3776O0je067960
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cpu_latency_qos_write, there is a judgment on whether the count
value is equal to sizeof(s32). This means that when user write 100~999,
it would get error value because it would call the "copy_from_user()"
instead of "kstrtos32".
Just like:

 # echo 500 > /dev/cpu_dma_latency
[T4893] write: qos value=170930229
[T4893] write: count value=4

[T4893] write: qos value=170930226
[T4893] write: count value=4

To prevent this happening, delete the "copy_from_user()" and
always use "kstrtos32_from_user()".

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/power/qos.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 782d3b41c1f3..21a2f873e921 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -379,17 +379,11 @@ static ssize_t cpu_latency_qos_write(struct file *filp, const char __user *buf,
 				     size_t count, loff_t *f_pos)
 {
 	s32 value;
+	int ret;
 
-	if (count == sizeof(s32)) {
-		if (copy_from_user(&value, buf, sizeof(s32)))
-			return -EFAULT;
-	} else {
-		int ret;
-
-		ret = kstrtos32_from_user(buf, count, 16, &value);
-		if (ret)
-			return ret;
-	}
+	ret = kstrtos32_from_user(buf, count, 16, &value);
+	if (ret)
+		return ret;
 
 	cpu_latency_qos_update_request(filp->private_data, value);
 
-- 
2.25.1

