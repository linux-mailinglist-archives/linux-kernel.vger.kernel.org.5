Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE310799468
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345941AbjIIAko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345857AbjIIAjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:39:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD52C271F;
        Fri,  8 Sep 2023 17:38:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127B9C116A8;
        Sat,  9 Sep 2023 00:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219924;
        bh=3FdsGKdIimLySiH95S3fd9cn34fEnJcqoSPUbeK7X3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jm78EsV5nGbMpPG12xfx4a1p8zRHuu6DBOzjBIyRD6iX5mJJUVPxPea5aQKoeRTCV
         /bx9IwvWQsWE30hSOdoHUvsJWLz50a7RcBRC/FwMvRdXUGTraAUgn51IM+mWgwlnFA
         4rJTgZL8gv5g9V3Lj16t8UY/kvWPKDYyIHXB8XK8sQa6Cei6wdywVpRN3dS1pIR8Ad
         sBPfcjRosova5pNSHh2QXWJAsA9y7adXgf5NvrELj76KPhHIydfICIZYtfUnhvSU9I
         v+qFGzWsGz7AQAFjrlGmo4Ba8SxVzo3FiVNyeG2jBdw/mLk1rBI2DJgJR7tp8f5mLb
         X22//wMlrV65A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chenyuan Mi <michenyuan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 14/24] tools: iio: iio_generic_buffer: Fix some integer type and calculation
Date:   Fri,  8 Sep 2023 20:38:06 -0400
Message-Id: <20230909003818.3580081-14-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003818.3580081-1-sashal@kernel.org>
References: <20230909003818.3580081-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chenyuan Mi <michenyuan@huawei.com>

[ Upstream commit 49d736313d0975ddeb156f4f59801da833f78b30 ]

In function size_from_channelarray(), the return value 'bytes' is defined
as int type. However, the calcution of 'bytes' in this function is designed
to use the unsigned int type. So it is necessary to change 'bytes' type to
unsigned int to avoid integer overflow.

The size_from_channelarray() is called in main() function, its return value
is directly multipled by 'buf_len' and then used as the malloc() parameter.
The 'buf_len' is completely controllable by user, thus a multiplication
overflow may occur here. This could allocate an unexpected small area.

Signed-off-by: Chenyuan Mi <michenyuan@huawei.com>
Link: https://lore.kernel.org/r/20230725092407.62545-1-michenyuan@huawei.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/iio/iio_generic_buffer.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index f8deae4e26a15..44bbf80f0cfdd 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -51,9 +51,9 @@ enum autochan {
  * Has the side effect of filling the channels[i].location values used
  * in processing the buffer output.
  **/
-static int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
+static unsigned int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
 {
-	int bytes = 0;
+	unsigned int bytes = 0;
 	int i = 0;
 
 	while (i < num_channels) {
@@ -348,7 +348,7 @@ int main(int argc, char **argv)
 	ssize_t read_size;
 	int dev_num = -1, trig_num = -1;
 	char *buffer_access = NULL;
-	int scan_size;
+	unsigned int scan_size;
 	int noevents = 0;
 	int notrigger = 0;
 	char *dummy;
@@ -674,7 +674,16 @@ int main(int argc, char **argv)
 	}
 
 	scan_size = size_from_channelarray(channels, num_channels);
-	data = malloc(scan_size * buf_len);
+
+	size_t total_buf_len = scan_size * buf_len;
+
+	if (scan_size > 0 && total_buf_len / scan_size != buf_len) {
+		ret = -EFAULT;
+		perror("Integer overflow happened when calculate scan_size * buf_len");
+		goto error;
+	}
+
+	data = malloc(total_buf_len);
 	if (!data) {
 		ret = -ENOMEM;
 		goto error;
-- 
2.40.1

