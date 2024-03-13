Return-Path: <linux-kernel+bounces-102093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B69787AE55
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCBA1C23433
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A025916B;
	Wed, 13 Mar 2024 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUYPNu7X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D7E18CEA7;
	Wed, 13 Mar 2024 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348478; cv=none; b=VFiZAW72m2RdtAh4eiJcCIyL+figzg7BTgLGQVbGNdk38FZlPgGjyPHE8oSq0sCEhwmBEhCpoZZxVlWvn2R2mzJd4YGZ2DfbHQV+0y5deFn2j/kHae/MCUtmznAZVmv8neb3KGfk5p98mv49G4Rkw2lkWjqTE7+lbPZDvZ/XNao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348478; c=relaxed/simple;
	bh=XuQhqZUrOCgjE5sn6FggSkuNapMlOOqVxZbhbkA4jrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeiUyAyE1V9X0K7Q6gY8OkC6U2NPWjzR29ApNAJWCo4irOhxidcjUvRE1jdbCtaNSFUBWrES8Xgmtp57Genf9XAbDfD7+9BY21sVqVQwN8eI5tk87VPNjcUEn61mo3JVi3gc1M3H/ScJ3pGrI6qeN4LzIre6KwkF5Tmc1wjJeHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUYPNu7X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B45C43394;
	Wed, 13 Mar 2024 16:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348477;
	bh=XuQhqZUrOCgjE5sn6FggSkuNapMlOOqVxZbhbkA4jrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SUYPNu7XlogvB77vc13dBPB61lDFEh4qjCZ7H++C7V5ytilMhiWhyCVdnvInRYPlq
	 v3gU/JJQd7Mx5CNaTMfd2U3LDWJgIaYFaOQvIEzuobbLDJTvXvVnyp+OogL3Oj4TUg
	 Xtzql7etY68EopUeEjJKv/BOGg6FPCaJEkQYnWzCz6spF2aAFfWbDGhjrr5wlpJODh
	 tc65YB1A0CkH6rfFN15zbgg+ePFOFLDcByIl5D3EMJG+y1z+UGuev89J9MhHxFRbn4
	 JDp+piyi31NRKgpeKgz1sszODcfbQX5wrbHjZ9zmtQxXrxIhlFnNWGoXjBegsHnG3Q
	 S4ytB20bPAy3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 67/73] Drivers: hv: vmbus: Drop error message when 'No request id available'
Date: Wed, 13 Mar 2024 12:46:34 -0400
Message-ID: <20240313164640.616049-68-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>

[ Upstream commit 0c85c54bf7faeb80c6b76901ed77d93acef0207d ]

Running out of request IDs on a channel essentially produces the same
effect as running out of space in the ring buffer, in that -EAGAIN is
returned.  The error message in hv_ringbuffer_write() should either be
dropped (since we don't output a message when the ring buffer is full)
or be made conditional/debug-only.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Fixes: e8b7db38449ac ("Drivers: hv: vmbus: Add vmbus_requestor data structure for VMBus hardening")
Link: https://lore.kernel.org/r/20210301191348.196485-1-parri.andrea@gmail.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/ring_buffer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index a0ba6ac487368..a49cc69c56af0 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -326,7 +326,6 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 		rqst_id = vmbus_next_request_id(&channel->requestor, requestid);
 		if (rqst_id == VMBUS_RQST_ERROR) {
 			spin_unlock_irqrestore(&outring_info->ring_lock, flags);
-			pr_err("No request id available\n");
 			return -EAGAIN;
 		}
 	}
-- 
2.43.0


