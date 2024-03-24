Return-Path: <linux-kernel+bounces-113485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6CD8884AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F261F2338A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4539B1B6FAB;
	Sun, 24 Mar 2024 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwKhKGGF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDCF1B6777;
	Sun, 24 Mar 2024 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320286; cv=none; b=Cgz1y1fwxxanzf5AinTmaLpDzT42rz+UZiJsq/wxdRtfVw5LITh4OpEfHwS+Urgqbmt7UE8tAvwRfQFnxwsYUlgeZkMAnKt1EE64horxS6r0PK/MCHFatk2Xtj5Dze+SHI207jnKm5ilUul6X1dtN1ubSHUnWBZqmXEY3pKAQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320286; c=relaxed/simple;
	bh=xadalg1Sr91bx1/Rxh82aDwXOY/crHp5LGjE7QOmfNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IO0Jw6ISdOizbYjoY6DVDZiVyTPHf6MOTgnZHb31eXdCuu40W/THVlU4jYbllYp22e8bMXXgzvY6WtjftF2pLZyQmAd6T+G1sQjlGl7KfwlcuBENxc99V8vk+1gbdq/x+N22dHlPytYw42x08g3VIzH9OIHOmUExH8ulBLq9Wms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwKhKGGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660F0C433C7;
	Sun, 24 Mar 2024 22:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320286;
	bh=xadalg1Sr91bx1/Rxh82aDwXOY/crHp5LGjE7QOmfNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lwKhKGGF4PaUyC81+6g4HUYrmp/3zFYodyrxcvzD5UW4VlaaFMGvjDSdA3IAFfppG
	 7a6DQt19XVQ9+O8F+hvoPSa2dwVowMVUnrN00lamDyxaVvQJ+g672UegiEv+WYHPos
	 iGqlFgZLsMWDuvNrvYM+HIHyxxTA6vHHRlqMIlVUPByQzMkoYG/kyF8vWL2e/Ndxa9
	 M/iDgqZlcQyuhIUQFc5uONgZT7L0L/Q3Bo7xc/g1bM81bTRejH9qBmjO6Ti5A9IaBQ
	 G9Igs/+F8tounB2ijFc4cN1vf1bwte2quluc8pMhNP92POKP61MZpo5tIcyzGEbFOp
	 PQvywTNABPmeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 594/715] ACPI: HMAT: Remove register of memory node for generic target
Date: Sun, 24 Mar 2024 18:32:53 -0400
Message-ID: <20240324223455.1342824-595-sashal@kernel.org>
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

From: Dave Jiang <dave.jiang@intel.com>

[ Upstream commit 54b9460b0a28c4c76a7b455ec1b3b61a13e97291 ]

For generic targets, there's no reason to call
register_memory_node_under_compute_node() with the access levels that are
only visible to HMAT handling code. Only update the attributes and rename
hmat_register_generic_target_initiators() to hmat_update_generic_target().

The original call path ends up triggering register_memory_node_under_compute_node().
Although the access level would be "3" and not impact any current node arrays, it
introduces unwanted data into the numa node access_coordinate array.

Fixes: a3a3e341f169 ("acpi: numa: Add setting of generic port system locality attributes")
Cc: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/20240308220055.2172956-2-dave.jiang@intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/numa/hmat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index d6b85f0f6082f..a26e7793ec4ef 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -770,12 +770,12 @@ static void __hmat_register_target_initiators(struct memory_target *target,
 	}
 }
 
-static void hmat_register_generic_target_initiators(struct memory_target *target)
+static void hmat_update_generic_target(struct memory_target *target)
 {
 	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
 
-	__hmat_register_target_initiators(target, p_nodes,
-					  NODE_ACCESS_CLASS_GENPORT_SINK);
+	hmat_update_target_attrs(target, p_nodes,
+				 NODE_ACCESS_CLASS_GENPORT_SINK);
 }
 
 static void hmat_register_target_initiators(struct memory_target *target)
@@ -835,7 +835,7 @@ static void hmat_register_target(struct memory_target *target)
 	 */
 	mutex_lock(&target_lock);
 	if (*(u16 *)target->gen_port_device_handle) {
-		hmat_register_generic_target_initiators(target);
+		hmat_update_generic_target(target);
 		target->registered = true;
 	}
 	mutex_unlock(&target_lock);
-- 
2.43.0


