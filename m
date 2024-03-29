Return-Path: <linux-kernel+bounces-124752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEB4891C25
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D2D1C26FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035E917D25F;
	Fri, 29 Mar 2024 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWj35Ysr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D66217D24D;
	Fri, 29 Mar 2024 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716078; cv=none; b=LGWIKZySMONzHr4L6kJPFuSb9CzXXO+qAEtSWClCKEKo3anMe47tPF0ge6wnFBxBMmN6XHmEHvTgYLmtjTIE1Hr9Q9II8K0rkrSRWy5Hgse5sPCFWzw1aQLIFRQ98YvrbZm+NRsqxTzmYP+T+ejCkuVZvGD4gR6NEPVSvqjJYok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716078; c=relaxed/simple;
	bh=4O1Vte6fsnpVIqKWi6MUYJs7yvI0UQm1XS+XRgmqiWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GeQIKovujJIdM0LvPnKP6o34JxBZp/XUVj3eRETLI2uWLlQ9htbWjyMfx76m/2rC8X+6C3s+KQw3PMq/eL/toODG581Bhy8rN5hA5Ju+0cHlHTZt8j/FYOsqE/ZThDnRefvaIrTjA3AW4xPH3spNnJBu+g5RPAt1xPxT3Duzd/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWj35Ysr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51371C43390;
	Fri, 29 Mar 2024 12:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716078;
	bh=4O1Vte6fsnpVIqKWi6MUYJs7yvI0UQm1XS+XRgmqiWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OWj35Ysr7Ba/zJE7FU3tPNrw53DSjtX9v56KLVPYwzenlqbbHdlo2+s1M7hyofitm
	 q6qqsrUGa2uwyIPJr3rShSZQLUd+I8N8v9HBWvCHvoBC//ofiRkmWWS/v4gEedX6ef
	 JZma3w22G1MSUwBmZVaG7MzOWxAqibiCOjwqTGm0FunuwlBWSNr4jlYrh4pCfiFhrn
	 1cVeXv50lQtWEoAYS3uDOMPnIuKK/MhF9L2OK7C1WlZgEV1GFFAMiILyFKkvybDJF1
	 9yF/Yjq8OFY4Zf6O7qZw8hmBt45IkNjGsot3nDxZvnJ4VqqD7m34ieYQ064uaMYiIO
	 O2HV0Ng7URlMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sviatoslav Harasymchuk <sviatoslav.harasymchuk@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 43/98] ACPI: resource: Add IRQ override quirk for ASUS ExpertBook B2502FBA
Date: Fri, 29 Mar 2024 08:37:14 -0400
Message-ID: <20240329123919.3087149-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Sviatoslav Harasymchuk <sviatoslav.harasymchuk@gmail.com>

[ Upstream commit 0793e511c4c66c38dd26add86f7236bcdc70c3b5 ]

In order to fix the keyboard on ASUS ExpertBook B2502FBA, add an IRQ override
quirk for it in analogy with how it was done for other members of this machine
family.

Link: https://lore.kernel.org/linux-acpi/20230411183144.6932-1-pmenzel@molgen.mpg.de
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217323
Signed-off-by: Sviatoslav Harasymchuk <sviatoslav.harasymchuk@gmail.com>
[ rjw: Subject and changelog rewrite, fix broken white space ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index dacad1d846c0d..2f7ae709bb192 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -489,6 +489,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B2502CBA"),
 		},
 	},
+	{
+		/* Asus ExpertBook B2502FBA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B2502FBA"),
+		},
+	},
 	{
 		/* Asus Vivobook E1504GA */
 		.matches = {
-- 
2.43.0


