Return-Path: <linux-kernel+bounces-137488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D181C89E2D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056E01C21939
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200DA156F52;
	Tue,  9 Apr 2024 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqQpAnWC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635A7156F44;
	Tue,  9 Apr 2024 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689188; cv=none; b=X9cMr7lB+0sXaWinkcvYw3kBDhLUPaSeDQOZ3DbavRl8uMXUptblm5O5FRaZ2T0zdMqZW7elS0U8JFj0txxFHVoLPnFpJ98itBKkyJF1cCrph4XRYxjvL/ljYDrbY46N4XQJ/VniuJIteDQu5FaHt2nEUj/iySdSGXESCWZiDsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689188; c=relaxed/simple;
	bh=jc3efBJ47qXtIZp6pJaaV7RlQijXHYkEm7+7tWa0gbg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hrcTKfItHA0lDnlsMDVlVGXZIoQrcpNK1SCkp4MQ2mYmbAwMpwcPhkefh7ZUVqRpcV1TEA+QWSHmo6GK1V781rgKbkdCqo1JM5WpMFzWvSKBOf8lZ7O620UNV1eS4OW0nBdGCamx14NGDfXs/REX+zHo3gQoYaZIzf9cYzBpI1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqQpAnWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A88C433F1;
	Tue,  9 Apr 2024 18:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712689188;
	bh=jc3efBJ47qXtIZp6pJaaV7RlQijXHYkEm7+7tWa0gbg=;
	h=From:Subject:Date:To:Cc:From;
	b=CqQpAnWCw4AlEGOvdj5t4IBlS/XyalWUNYQFPCYUc/c7nGfvSZl+Tmu00yMrSNg6A
	 YNUHwgF1I/n7dL5lWPOoM9zfjMtF6c+XSRCm8FLEKkrvaIgWwSIuqjqenF04Kv5yl6
	 TKu+TktVacRZqiv/w3m4y9gQp7iDVXkIBD7BOJZ20zKCCfmEcUwc2rsYCg4i2KEF23
	 GKrXVzvazpnI+r8dv67gKrHJza7l5+Es7ZU9C5ezO2Qw2bXIGh5sEeBLN/B6DGmW9F
	 z0sVx9uW4FLJGeOqenUhVfb7gBnZTwfGaA1xPmdo13Ks90Ghsypgpb4SEy6EAddu0b
	 ESfmwWZVaIjig==
From: Rob Herring <robh@kernel.org>
Subject: [PATCH v2 0/3] of: Use __free() based cleanups
Date: Tue, 09 Apr 2024 13:59:38 -0500
Message-Id: <20240409-dt-cleanup-free-v2-0-5b419a4af38d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABqQFWYC/3WNwQ6CMBBEf4Xs2TWlxQY9+R+GQ2kX2EgK2SLRE
 P7dyt3M6U0ybzZIJEwJbsUGQisnnmIGfSrADy72hBwyg1a6UjkYFvQjufiasRMitOFiTNVWrbE
 15NUs1PH7MD6azAOnZZLPcbCWv/a/ay1RobeKrG9dHdz1/iSJNJ4n6aHZ9/0L1Tq38K8AAAA=
To: Saravana Kannan <saravanak@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.13-dev

This small series converts the DT code to use __free() based cleanups 
for kfree() and of_node_put(). Using __free() simplifies function exit 
handling. Initial support for struct device_node was added in commit 
9448e55d032d ("of: Add cleanup.h based auto release via 
__free(device_node) markings").

Signed-off-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
- Also use cleanup for 'dev' in __of_translate_address()
- Further simplify of_dma_is_coherent() and of_mmio_is_nonposted()
- Link to v1: https://lore.kernel.org/r/20240404-dt-cleanup-free-v1-0-c60e6cba8da9@kernel.org

---
Rob Herring (3):
      of: Add a helper to free property struct
      of: Use scope based kfree() cleanups
      of: Use scope based of_node_put() cleanups

 drivers/of/address.c    | 113 +++++++++++++++++-------------------------------
 drivers/of/base.c       |  34 ++++-----------
 drivers/of/dynamic.c    |  37 +++++++---------
 drivers/of/of_private.h |   1 +
 drivers/of/overlay.c    |  11 ++---
 drivers/of/property.c   |  22 +++-------
 drivers/of/resolver.c   |  35 ++++++---------
 drivers/of/unittest.c   |  12 ++---
 8 files changed, 90 insertions(+), 175 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240404-dt-cleanup-free-6d5334b4b368

Best regards,
-- 
Rob Herring <robh@kernel.org>


