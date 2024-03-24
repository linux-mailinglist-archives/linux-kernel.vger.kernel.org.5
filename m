Return-Path: <linux-kernel+bounces-114572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3585A888B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60EB28E78D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533D1185F09;
	Sun, 24 Mar 2024 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgBwFWEF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C59A22F8D5;
	Sun, 24 Mar 2024 23:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322215; cv=none; b=UTAF1AnmosptfNQMwuAX7EMvk+0KwxIHEkJpUOYaJkariJ+dFV91jigVL5R1FdYSKXTeKknWIIgu5O7dAMsL3eKHUOM6z75vRllW/GitFTki09CwITWhjaM6zknE2WA5HlW/ubANz7SgoyJH2MjwnQZQxeype2ba8rBNqk4lSGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322215; c=relaxed/simple;
	bh=6/TKhYAWFLjY1q5mVhCWhWF3ca2KGgT9UOud7UTcL94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLfMxX5WKQ6EVy7Eo+NeYsAtb1LqJ7q6M3beQ26hflzV9bMGBafCKSoOuT2Wp7RlKbuvCbioFQvTe8CylaFrTAEky+hgmgm0CpUmqHUR9v/NrasNposCg31ACbjUgxHqdb6D0RM1o8UQPZnbYCX8S88Cw13Dk7FX4frU4ReDDWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgBwFWEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9400C433C7;
	Sun, 24 Mar 2024 23:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322214;
	bh=6/TKhYAWFLjY1q5mVhCWhWF3ca2KGgT9UOud7UTcL94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JgBwFWEFtQ7I58mLgmVHeoSRUP+uoUe6NTypo1I1l56zslx5yUFPfPOxPhtkjSvwF
	 0jFarhfgenYH5xKF3DUsCWarcOuvIUk8dedCZQWQ2gMMMq9k5ATQuGBZNyM3C7g3Ba
	 9fqhxh7eVRzHjI9ZpCL/EhuQxOvZUiCxc0VfGGvvpfUkWyDEn0lo6KF/p/GC6JuHtT
	 lcIr35ARIbtbdolNN15oBXBs/UiNc/A/FakJKTGeXJiKQiJ9d2PY5IlUiloH5Dd78U
	 Zbyt4i5FFl8glWqHNJp4C+dTlWLmiJNmxbpLPavFEjH6kBseQZAxcRkOeshs3bFGtC
	 t9N0NxZXtn8Cw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: ruanjinjie <ruanjinjie@huawei.com>,
	Jon Mason <jdmason@kudzu.us>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 294/451] NTB: EPF: fix possible memory leak in pci_vntb_probe()
Date: Sun, 24 Mar 2024 19:09:30 -0400
Message-ID: <20240324231207.1351418-295-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: ruanjinjie <ruanjinjie@huawei.com>

[ Upstream commit 956578e3d397e00d6254dc7b5194d28587f98518 ]

As ntb_register_device() don't handle error of device_register(),
if ntb_register_device() returns error in pci_vntb_probe(), name of kobject
which is allocated in dev_set_name() called in device_add() is leaked.

As comment of device_add() says, it should call put_device() to drop the
reference count that was set in device_initialize()
when it fails, so the name can be freed in kobject_cleanup().

Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Stable-dep-of: aebfdfe39b93 ("NTB: fix possible name leak in ntb_register_device()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 8c6931210ac4d..cd985a41c8d65 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1288,6 +1288,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_register_dev:
+	put_device(&ndev->ntb.dev);
 	return -EINVAL;
 }
 
-- 
2.43.0


