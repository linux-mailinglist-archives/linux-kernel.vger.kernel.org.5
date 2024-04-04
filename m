Return-Path: <linux-kernel+bounces-131578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FA18989B0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE39FB25050
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EF2129E6B;
	Thu,  4 Apr 2024 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="da6dwdfX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8617C1CD03;
	Thu,  4 Apr 2024 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240133; cv=none; b=no/Oap6Qs5gf2GEQOnO7Yig9iruyls3jy/ZsczyQKPVy9lF/1WTm3gepPQrSRzupaOp74XvCZSb0m6rfuPPJPi2e8F8Y3982Ny2M4tDTHrx5emKSotPsAx8TMqGgvj/kVY34/x7OsqC00a930ZwXnR84FoxPcUtHD3G7bAKIiNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240133; c=relaxed/simple;
	bh=5mRLZJpdw6WkB0SSyJ4/aJtAg0Lr9QOhnDLZhWIwlXw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UCC/dsVbfMuYNng94agqeLSu7eDHl39J3wwT6tjwcK9vXllmeL4VV5FpY1AY37Wbj7CYg8nMn5DW3d9aszs7m8axQ8fb+kerI0S74gZQwIfiqb88R3FL/C2f1wpI0kizUYpVc8dKwJsu+cZMLxHzGTqAUkzbSOucYcyDhNhJ1UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=da6dwdfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC8FC433C7;
	Thu,  4 Apr 2024 14:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712240133;
	bh=5mRLZJpdw6WkB0SSyJ4/aJtAg0Lr9QOhnDLZhWIwlXw=;
	h=From:Subject:Date:To:Cc:From;
	b=da6dwdfXp3t2QYrMLxkFcWIl33faaUCyNJbw3kCwhWnRoswr+xjeEMWJ+1SdBThLQ
	 6yoD9iBh6AI6zMFk0ECjZwjIVB6XB2bUaDYr4jEHGwRfZA5nkVfwr/tVPqGPj32Nmp
	 SE1WF9nRvd+Mk7BZ35WB7ufFakN+T1Fjt+wC9ke3PxebP5mMsPe8pKKebOuHKN7ajy
	 raLjGlqsCweFmM5lHFeamClTwCmJHXq0I4XLHomObMbwsk2nzpHHLY/Ho59erKMSRs
	 Oxv5fGAm4jYgvZ+b200OZFN/ylpqE3nCxX3vtU+9xvOnQCA+05GfZHxdNh17dii7Ym
	 PA8LhGrLdYpjw==
From: Rob Herring <robh@kernel.org>
Subject: [PATCH 0/3] of: Use __free() based cleanups
Date: Thu, 04 Apr 2024 09:15:09 -0500
Message-Id: <20240404-dt-cleanup-free-v1-0-c60e6cba8da9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO21DmYC/x2MQQqAIBAAvxJ7bsHSJPpKdLBcayEstCIQ/57En
 OYwkyBSYIowVAkCPRz58EWauoJlM34lZFscWtEqUUB74bKT8feJLhChtp2Ualaz1D2U6gzk+P2
 P45TzBx0o0jxhAAAA
To: Saravana Kannan <saravanak@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev

This small series converts the DT code to use __free() based cleanups 
for kfree() and of_node_put(). Using __free() simplifies function exit 
handling. Initial support for struct device_node was added in commit 
9448e55d032d ("of: Add cleanup.h based auto release via 
__free(device_node) markings").

Signed-off-by: Rob Herring <robh@kernel.org>
---
Rob Herring (3):
      of: Add a helper to free property struct
      of: Use scope based kfree() cleanups
      of: Use scope based of_node_put() cleanups

 drivers/of/address.c    | 60 ++++++++++++++++---------------------------------
 drivers/of/base.c       | 34 +++++++---------------------
 drivers/of/dynamic.c    | 37 +++++++++++++-----------------
 drivers/of/of_private.h |  1 +
 drivers/of/overlay.c    | 11 +++------
 drivers/of/property.c   | 22 ++++++------------
 drivers/of/resolver.c   | 35 +++++++++++------------------
 drivers/of/unittest.c   | 12 +++-------
 8 files changed, 70 insertions(+), 142 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240404-dt-cleanup-free-6d5334b4b368

Best regards,
-- 
Rob Herring <robh@kernel.org>


