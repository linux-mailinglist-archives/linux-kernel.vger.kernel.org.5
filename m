Return-Path: <linux-kernel+bounces-109269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF5F881707
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72761F22127
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2566A8B5;
	Wed, 20 Mar 2024 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxaYGgfw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508756A327;
	Wed, 20 Mar 2024 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957789; cv=none; b=HhRB3nb2l9RyFgy6nFtKQ/cKjuEtMhS+XsbJ5IEuS0yTy/jm5q56mzUpm/yO84ycK434TtosVs66UzKrETJATtDPIcKpvyQIFi9h4XSqRsEevFHaDqo2Wl6ObQ2dd0vf1vFUZU99evSiYFPZYRx9TmW0HSLjK4fvTSDjYcEMRMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957789; c=relaxed/simple;
	bh=sQaZL7VLbnroXfvNjOJrzk5y7wEaU2H+hGDvuuVnmt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RB3bX8qI8QXCek5TE6Xznzb11Da+GcGdWgqx4WAoVELvClNZd24+kzOBq6Qov7Omve5eZsKdtpTD19Ss42WqfpyLik3PV+qIY76pxC6La0tVolCmhs/FmSNWuSKLOlbYKT1JX/vewUTs3nJz2UgezdYs+ZGjqx4eNWhfJDbjfKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxaYGgfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1E0C433C7;
	Wed, 20 Mar 2024 18:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710957788;
	bh=sQaZL7VLbnroXfvNjOJrzk5y7wEaU2H+hGDvuuVnmt4=;
	h=From:To:Cc:Subject:Date:From;
	b=pxaYGgfwM5gWfUwAIQVlvbsFIvuR9xWLbhy80E2Y1VaeUB7Errm0apfISDlmeqp/N
	 Czc4TuEQ/cPtriXw/RWwCyWFz3ardBGSic0KeDlKpgROUVkYm1R3RUBoxUf9YTPOby
	 fNHMzg7BJP374ArTFNYeGN9POxQeidOiMX4l3TYsX7Jvisgzdo9ifIZ4/OB94cQB4c
	 GMFWBwAkJ39BRxDBArgDoiafbGvCD5LQjh75wIli3Npl1eHMPw/y4vb/xDRyL3BnmB
	 3jTA3TtH/dtAZ+GGEbyQoa68/PZCuaIKl95vUttTCKv9DHF1bne5TPsKOu9UaQ71fp
	 cjqj3M79ewPng==
From: Arnd Bergmann <arnd@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ben Cheatham <Benjamin.Cheatham@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Avadhut Naik <Avadhut.Naik@amd.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] acpi: EINJ: mark remove callback as non-__exit
Date: Wed, 20 Mar 2024 19:02:50 +0100
Message-Id: <20240320180302.143707-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The remove callback of a device is called whenever it is unbound,
which may happen during runtime e.g. through sysfs, so this is not
allowed to be dropped from the binary:

WARNING: modpost: vmlinux: section mismatch in reference: einj_driver+0x8 (section: .data) -> einj_remove (section: .exit.text)
ERROR: modpost: Section mismatches detected.

Remove that annotation.

Fixes: 12fb28ea6b1c ("EINJ: Add CXL error type support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/apei/einj-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 66e7f529e92f..01faca3a238a 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -851,7 +851,7 @@ static int __init einj_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static void __exit einj_remove(struct platform_device *pdev)
+static void einj_remove(struct platform_device *pdev)
 {
 	struct apei_exec_context ctx;
 
-- 
2.39.2


