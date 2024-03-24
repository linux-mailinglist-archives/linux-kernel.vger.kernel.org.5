Return-Path: <linux-kernel+bounces-113214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B18988825E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1DB1F21DA2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A391913C804;
	Sun, 24 Mar 2024 22:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ha5vsQVj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B5017F38F;
	Sun, 24 Mar 2024 22:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320015; cv=none; b=HrbC2+I8bwXlr+1rm9CclsNdf85OROmuRUTr3CEkfGLW7qS4RnhSA4WoyQZPZBX1km1240eQ0VEpnuYZffj7qI+yeLQ1ZEF4M5XeUQGd0Njz0jhCvFPmdHJWKiC+jun/f5eLOCL9IAk1g7z/RMPTiDnWm6KLvZXEvhjTuMM5w50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320015; c=relaxed/simple;
	bh=xFqGKpyx47Kh25uyLbApAyioWas3r0gmrmDyV1O32aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEEz0qVRlEItBY4hd2ZmHhwjuXpoKZ6LMKao448F74tHxeWQEh9Rd6ZEruaxI2kaby2Y+IUlIjWKZ3RR+ht1wSU5FYK7wggr+S7JTFNNmRCMEbVSwjC9l3xeJy7ZIlmj5AUF6hLRNvQ5YwJZM2kURdk988CvbOR3lS9rlAH5stc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ha5vsQVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C48C433C7;
	Sun, 24 Mar 2024 22:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320015;
	bh=xFqGKpyx47Kh25uyLbApAyioWas3r0gmrmDyV1O32aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ha5vsQVjhUJAKfSGUq3hOk1dFclMFVpuHvV9/zhhqHhFJPjMY6j3oZJ9zWECY8wx4
	 yz4ChDdfJZYgZXYuGQqchxhcV0dr5pZLguyWudBjAP6nL+RhmxrjUIENyVKosK9b2b
	 AQiTsiWILwpKQlrMGQ1WXq7lbkleo4c5mMHDSexbe4YZ7otcqkOVqAroS9KtCfUHSX
	 pZklloPiCbSQ56ZJrurwyRKr+TBRrFGjks/dmNNu2jt1WrrhwkdHWCKT9+LRkXZf7q
	 1ste+galcrPZBY9zdCg/+RbdAT76Kui5JsLcu94xW62umtfAmI//fZTavOhEy9zJcL
	 2c9hoTXnApzXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 323/715] dpll: spec: use proper enum for pin capabilities attribute
Date: Sun, 24 Mar 2024 18:28:22 -0400
Message-ID: <20240324223455.1342824-324-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

[ Upstream commit 5c497a64820ef9f10962a9c37607df45d6395fa5 ]

The enum is defined, however the pin capabilities attribute does
refer to it. Add this missing enum field.

This fixes ynl cli output:

Example current output:
$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml --do pin-get --json '{"id": 0}'
{'capabilities': 4,
 ...
Example new output:
$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml --do pin-get --json '{"id": 0}'
{'capabilities': {'state-can-change'},
 ...

Fixes: 3badff3a25d8 ("dpll: spec: Add Netlink spec in YAML")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20240306120739.1447621-1-jiri@resnulli.us
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/netlink/specs/dpll.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 3dcc9ece272aa..d0c821c202036 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -274,6 +274,7 @@ attribute-sets:
       -
         name: capabilities
         type: u32
+        enum: pin-capabilities
       -
         name: parent-device
         type: nest
-- 
2.43.0


