Return-Path: <linux-kernel+bounces-119726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F5788CC73
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9183091CE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429A613CA97;
	Tue, 26 Mar 2024 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJpjPqdN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723D513C3CD;
	Tue, 26 Mar 2024 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479314; cv=none; b=s0YBKZkxLw1EBjbk3mtlUVUl4vaK6WvpHrrNNRWnZknRHx5yE2Gpvi4syK50OQO5/yOGX3joqeHI5Vh5eEJUyYlB/qdhYDiEYYu/KzRNQnR3SSb005717YupbHlwM+WV+2NgdHKOFC8/yOBUYASPffbmssczgS9ZiA/GF2AV2RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479314; c=relaxed/simple;
	bh=eLWdTmkX6BBbodK2iLPdweL1DI0T40cTBvjP1ZxdWVg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dENtc095nYgr1Vj/hka5Nt6yY+xf3Op8w7YWJgiDbbkPSkBqoZdo0nOOoQ22olhAXDQMjQhyBwhs8IdQ0gOrr2XMX5g1DTtRmfYcbtpy5G+gqzrIPPEdRh8eTQmnfum8b96JLKraM2n0khI9eyUY8bQ8LBNriAb4JNiVzNQzKdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJpjPqdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F7DC433F1;
	Tue, 26 Mar 2024 18:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711479314;
	bh=eLWdTmkX6BBbodK2iLPdweL1DI0T40cTBvjP1ZxdWVg=;
	h=Date:From:To:Cc:Subject:From;
	b=gJpjPqdNq3WnXv3+hUhWUVvUEF2NVYR0ZLnvkhMZ6KJ7JwzrdDRRjJkf841deUGnE
	 tw2eZq/tSx9X2gsKS6VrjhTRfVwwuWYaQmxHIRMhpfOL3+O5i98IQtIDBxORllWLlq
	 2kAJLNNHuUjftF90xiWDKuDzkuY/OB+KpbAyGd02iXXULptedGgYZZ5XHd2hMaaTx7
	 eXyx/DYxp+2avG+l1fSqnrpn/hH3DtwinSf+XiYiU6wjdEWJcD61POOcG+4oEyYbC7
	 rSapuobRYB8ansUL5Eqf/Xkq0FMgxxUk+X103J25tGliAgww+MEofAK0EPy6VOs5aw
	 Xk362C9Qp0vqA==
Date: Tue, 26 Mar 2024 12:55:10 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] platform/chrome: cros_ec_proto: avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <ZgMaDl/of8YC445S@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warning:
drivers/platform/chrome/cros_ec_proto_test.c:1547:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/platform/chrome/cros_ec_proto_test.c:1607:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/platform/chrome/cros_ec_proto_test.c:1645:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/platform/chrome/cros_ec_proto_test.c:1668:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Link: https://github.com/KSPP/linux/issues/202
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto_test.c | 72 ++++++++------------
 1 file changed, 30 insertions(+), 42 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index b6169d6f2467..41378c2ee6a0 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -1543,21 +1543,18 @@ static void cros_ec_proto_test_cmd_xfer_normal(struct kunit *test)
 	struct cros_ec_device *ec_dev = &priv->ec_dev;
 	struct ec_xfer_mock *mock;
 	int ret;
-	struct {
-		struct cros_ec_command msg;
-		u8 data[0x100];
-	} __packed buf;
+	DEFINE_RAW_FLEX(struct cros_ec_command, buf, data, 0x100);
 
 	ec_dev->max_request = 0xff;
 	ec_dev->max_response = 0xee;
 	ec_dev->max_passthru = 0xdd;
 
-	buf.msg.version = 0;
-	buf.msg.command = EC_CMD_HELLO;
-	buf.msg.insize = 4;
-	buf.msg.outsize = 2;
-	buf.data[0] = 0x55;
-	buf.data[1] = 0xaa;
+	buf->version = 0;
+	buf->command = EC_CMD_HELLO;
+	buf->insize = 4;
+	buf->outsize = 2;
+	buf->data[0] = 0x55;
+	buf->data[1] = 0xaa;
 
 	{
 		u8 *data;
@@ -1572,7 +1569,7 @@ static void cros_ec_proto_test_cmd_xfer_normal(struct kunit *test)
 		data[3] = 0x33;
 	}
 
-	ret = cros_ec_cmd_xfer(ec_dev, &buf.msg);
+	ret = cros_ec_cmd_xfer(ec_dev, buf);
 	KUNIT_EXPECT_EQ(test, ret, 4);
 
 	{
@@ -1590,10 +1587,10 @@ static void cros_ec_proto_test_cmd_xfer_normal(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, data[0], 0x55);
 		KUNIT_EXPECT_EQ(test, data[1], 0xaa);
 
-		KUNIT_EXPECT_EQ(test, buf.data[0], 0xaa);
-		KUNIT_EXPECT_EQ(test, buf.data[1], 0x55);
-		KUNIT_EXPECT_EQ(test, buf.data[2], 0xcc);
-		KUNIT_EXPECT_EQ(test, buf.data[3], 0x33);
+		KUNIT_EXPECT_EQ(test, buf->data[0], 0xaa);
+		KUNIT_EXPECT_EQ(test, buf->data[1], 0x55);
+		KUNIT_EXPECT_EQ(test, buf->data[2], 0xcc);
+		KUNIT_EXPECT_EQ(test, buf->data[3], 0x33);
 	}
 }
 
@@ -1603,26 +1600,23 @@ static void cros_ec_proto_test_cmd_xfer_excess_msg_insize(struct kunit *test)
 	struct cros_ec_device *ec_dev = &priv->ec_dev;
 	struct ec_xfer_mock *mock;
 	int ret;
-	struct {
-		struct cros_ec_command msg;
-		u8 data[0x100];
-	} __packed buf;
+	DEFINE_RAW_FLEX(struct cros_ec_command, buf, data, 0x100);
 
 	ec_dev->max_request = 0xff;
 	ec_dev->max_response = 0xee;
 	ec_dev->max_passthru = 0xdd;
 
-	buf.msg.version = 0;
-	buf.msg.command = EC_CMD_HELLO;
-	buf.msg.insize = 0xee + 1;
-	buf.msg.outsize = 2;
+	buf->version = 0;
+	buf->command = EC_CMD_HELLO;
+	buf->insize = 0xee + 1;
+	buf->outsize = 2;
 
 	{
 		mock = cros_kunit_ec_xfer_mock_add(test, 0xcc);
 		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
 	}
 
-	ret = cros_ec_cmd_xfer(ec_dev, &buf.msg);
+	ret = cros_ec_cmd_xfer(ec_dev, buf);
 	KUNIT_EXPECT_EQ(test, ret, 0xcc);
 
 	{
@@ -1641,21 +1635,18 @@ static void cros_ec_proto_test_cmd_xfer_excess_msg_outsize_without_passthru(stru
 	struct cros_ec_proto_test_priv *priv = test->priv;
 	struct cros_ec_device *ec_dev = &priv->ec_dev;
 	int ret;
-	struct {
-		struct cros_ec_command msg;
-		u8 data[0x100];
-	} __packed buf;
+	DEFINE_RAW_FLEX(struct cros_ec_command, buf, data, 0x100);
 
 	ec_dev->max_request = 0xff;
 	ec_dev->max_response = 0xee;
 	ec_dev->max_passthru = 0xdd;
 
-	buf.msg.version = 0;
-	buf.msg.command = EC_CMD_HELLO;
-	buf.msg.insize = 4;
-	buf.msg.outsize = 0xff + 1;
+	buf->version = 0;
+	buf->command = EC_CMD_HELLO;
+	buf->insize = 4;
+	buf->outsize = 0xff + 1;
 
-	ret = cros_ec_cmd_xfer(ec_dev, &buf.msg);
+	ret = cros_ec_cmd_xfer(ec_dev, buf);
 	KUNIT_EXPECT_EQ(test, ret, -EMSGSIZE);
 }
 
@@ -1664,21 +1655,18 @@ static void cros_ec_proto_test_cmd_xfer_excess_msg_outsize_with_passthru(struct
 	struct cros_ec_proto_test_priv *priv = test->priv;
 	struct cros_ec_device *ec_dev = &priv->ec_dev;
 	int ret;
-	struct {
-		struct cros_ec_command msg;
-		u8 data[0x100];
-	} __packed buf;
+	DEFINE_RAW_FLEX(struct cros_ec_command, buf, data, 0x100);
 
 	ec_dev->max_request = 0xff;
 	ec_dev->max_response = 0xee;
 	ec_dev->max_passthru = 0xdd;
 
-	buf.msg.version = 0;
-	buf.msg.command = EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX) + EC_CMD_HELLO;
-	buf.msg.insize = 4;
-	buf.msg.outsize = 0xdd + 1;
+	buf->version = 0;
+	buf->command = EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX) + EC_CMD_HELLO;
+	buf->insize = 4;
+	buf->outsize = 0xdd + 1;
 
-	ret = cros_ec_cmd_xfer(ec_dev, &buf.msg);
+	ret = cros_ec_cmd_xfer(ec_dev, buf);
 	KUNIT_EXPECT_EQ(test, ret, -EMSGSIZE);
 }
 
-- 
2.34.1


