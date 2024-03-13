Return-Path: <linux-kernel+bounces-102226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EBB87AF93
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006A61F29EAE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A22151103;
	Wed, 13 Mar 2024 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMOkcatR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9771A2B9A;
	Wed, 13 Mar 2024 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349522; cv=none; b=qQhosPAe4zIKbtvHME3pShtCK/rpIGr2v63u96QpQEteuO+Fug6aRG7l3a3os7KOhKIm7edvwwSb3By9A8O5CXCgPNApr65O1PYmEd9LUylxec9GCjmO0kz3UU9Jy7xIl3VNbkaOdYXjX0aa0jm2EMx4GXyK8pju7dKK35hMHSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349522; c=relaxed/simple;
	bh=KVPCZ3dESDnwLDlBd1+N2FxfdsqEgtThOJFch8a0b0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7rwaO24qqB3fuwKv8ZoFmWxGsAzRBgF4PBaSY3X9Dpt6SJR/NermMHCl26wiTzFLvd3MKPoqL9zGFolC9s6MqcU03gTVpkxxQvj27Wy60dU+XB1e29G1L3IFKhiQ/XwxPRinVYJaIuAXfePKMczSxk07O514znAN2+FOeoDQjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMOkcatR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111E9C433C7;
	Wed, 13 Mar 2024 17:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349521;
	bh=KVPCZ3dESDnwLDlBd1+N2FxfdsqEgtThOJFch8a0b0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LMOkcatRsmwhYdOK2xW2zkznH76fz6BA0ROVgOhKZ9ffarrGqbFLsxooZn8IpIPdI
	 DzfzKkNRNS0FMEKCWlMmYZf7cacrony3+eRUVT7gYMZIDELEn6k7wFma6m0/f3V/L6
	 TTN0IOGqYg2LXeS/UHv/9cpovM+c/cDf1UjaZJ+fH7fEZoyhmQbTYedVKW/4Ka18dC
	 o3ZfJfGMlHv0iRlmDL+blmnyZk0hrKrSFz+wRbQgWWS99pmwt7c2RGIcC3g/4ITiTp
	 JJBok1bM5QAdN6E2+/lzdOzII25cnV6iTCdcUkObjAzUToD4InOLlmzg+x/KoDH5QO
	 eXSn+ea1AtgyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 39/41] selftests/vm: fix display of page size in map_hugetlb
Date: Wed, 13 Mar 2024 13:04:33 -0400
Message-ID: <20240313170435.616724-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit 1ec882fc81e3177faf055877310dbdb0c68eb7db ]

The displayed size is in bytes while the text says it is in kB.

Shift it by 10 to really display kBytes.

Fixes: fa7b9a805c79 ("tools/selftest/vm: allow choosing mem size and page size in map_hugetlb")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/e27481224564a93d14106e750de31189deaa8bc8.1598861977.git.christophe.leroy@csgroup.eu
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/vm/map_hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/map_hugetlb.c b/tools/testing/selftests/vm/map_hugetlb.c
index ab349c6db00d4..7b41cc6ecb0bf 100644
--- a/tools/testing/selftests/vm/map_hugetlb.c
+++ b/tools/testing/selftests/vm/map_hugetlb.c
@@ -90,7 +90,7 @@ int main(int argc, char **argv)
 	}
 
 	if (shift)
-		printf("%u kB hugepages\n", 1 << shift);
+		printf("%u kB hugepages\n", 1 << (shift - 10));
 	else
 		printf("Default size hugepages\n");
 	printf("Mapping %lu Mbytes\n", (unsigned long)length >> 20);
-- 
2.43.0


