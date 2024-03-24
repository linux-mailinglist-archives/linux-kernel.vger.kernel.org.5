Return-Path: <linux-kernel+bounces-113787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC449888EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A140B26132
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F39914D29E;
	Sun, 24 Mar 2024 23:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYGX5+/Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B071272B8;
	Sun, 24 Mar 2024 22:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320801; cv=none; b=bNQZLKpmzGaUkkkDuIad0e6DSlJz944VAtuDhnuLDBlPLRJrQCYUNrkmtAWPtGZCd5AQSDjsw/oXW0xbowGuulR/EIvSGfWQ0vX+GUxv/1gH52/8u1u9KSEnHgHkvVRwDZdoDBERw8PPk12EaoY/iXxSB0J1hyQC3gxPmrS/kxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320801; c=relaxed/simple;
	bh=9sb3DEvcgysAOVvCd3EzJUsl/MlOiN2diTQTQ94DBHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUwCg5bNStER1e5GbddVEYVBaDOGhSg4yJDoM9gKROvqjv2cCyhfZiUDW9AWU247r7SbSa1osh+C7bm2dl372xIjkmc2FSp9qEOzCrX8QHtQLGpiJ9bH7VpIkk+hwv8h3hLIVaOvym861AZVA8xsikHOgnDDLys/1R3a6vTBn7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYGX5+/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A012C43390;
	Sun, 24 Mar 2024 22:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320799;
	bh=9sb3DEvcgysAOVvCd3EzJUsl/MlOiN2diTQTQ94DBHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EYGX5+/QYzxfsaDROwBLv8xF9pFfGZzwBzaOBcLq42Sf2GEfGzOI4WLeSArN5VbnN
	 EUX5qQsrsGvXQ4TMcESldU8y2j/RNTusEmLpCmuTiw5HNPy2yADgmsVtZQGFcBurqZ
	 Z21sA7obSYuuotbcPKXhf+Ch3JJuF5UVFZgAiT2nu2MJ7ZlSQ53bjBozbJ2LVDGx2p
	 8NQnka8f8Q47a65swQ+fmX7sKMRfDnRsJN7Fa6M8jRsRzfGLgWHl200Wp42hdPWQNB
	 L6zFTf3GLnVJVDwH2h0sPPZDpzz7Evv+0E49tB5nGdr6kCXePD8NqAYFFe8+cwvkpK
	 pO04jFxxgMquQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 364/713] dpll: spec: use proper enum for pin capabilities attribute
Date: Sun, 24 Mar 2024 18:41:30 -0400
Message-ID: <20240324224720.1345309-365-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 2b4c4bcd83615..5b25ad589e3d0 100644
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


