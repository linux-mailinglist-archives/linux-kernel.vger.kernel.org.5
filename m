Return-Path: <linux-kernel+bounces-26702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF3682E55F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0BA1F21233
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200812C190;
	Tue, 16 Jan 2024 00:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqF5qx2D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDFB2BAFE;
	Tue, 16 Jan 2024 00:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D28C43390;
	Tue, 16 Jan 2024 00:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364133;
	bh=tWI2GLcwYJRMoLXZ+UC1Idh5hEZcoVtlUrmm3aWZ1vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rqF5qx2DY7atRPBJjLO2hkpxP46yOTEdbB1sxaeEXG2hMG13LDIdMeG0+Df8eqqHm
	 pgm1Y4x7Z/ml6tpj+KjQFaYu8M1hPe2///ujFDn62yaIREkzMYl5zOrcGFxkSHGL3L
	 Nqn0wxV2AssTYLpRU3wEFu+VHuIBwZKW6zFR/z/iPybbCjjeBJub0eXNz/c3hpcVn+
	 4fd0WPeiMfz1oi6j+miIO1I0suNctPRw0YjBjMRR9AF/QGgH7lFV3OGMBx9vDwESLT
	 q8OZlAm/aOX9lW3TWv0u0HsL7M+KQ/Hgnu8ivsfpIMXe8/Ia0WQ7piSrKuvdI0Veoi
	 VGdOMCDZUKe6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 4/5] ACPI: extlog: fix NULL pointer dereference check
Date: Mon, 15 Jan 2024 19:15:24 -0500
Message-ID: <20240116001526.214354-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001526.214354-1-sashal@kernel.org>
References: <20240116001526.214354-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
Content-Transfer-Encoding: 8bit

From: Prarit Bhargava <prarit@redhat.com>

[ Upstream commit 72d9b9747e78979510e9aafdd32eb99c7aa30dd1 ]

The gcc plugin -fanalyzer [1] tries to detect various
patterns of incorrect behaviour.  The tool reports:

drivers/acpi/acpi_extlog.c: In function ‘extlog_exit’:
drivers/acpi/acpi_extlog.c:307:12: warning: check of ‘extlog_l1_addr’ for NULL after already dereferencing it [-Wanalyzer-deref-before-check]
    |
    |  306 |         ((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
    |      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
    |      |                                                  |
    |      |                                                  (1) pointer ‘extlog_l1_addr’ is dereferenced here
    |  307 |         if (extlog_l1_addr)
    |      |            ~
    |      |            |
    |      |            (2) pointer ‘extlog_l1_addr’ is checked for NULL here but it was already dereferenced at (1)
    |

Fix the NULL pointer dereference check in extlog_exit().

Link: https://gcc.gnu.org/onlinedocs/gcc-10.1.0/gcc/Static-Analyzer-Options.html # [1]

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_extlog.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index e05309bc41cc..e148b0a28ec9 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -317,9 +317,10 @@ static void __exit extlog_exit(void)
 {
 	edac_set_report_status(old_edac_report_status);
 	mce_unregister_decode_chain(&extlog_mce_dec);
-	((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
-	if (extlog_l1_addr)
+	if (extlog_l1_addr) {
+		((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
 		acpi_os_unmap_iomem(extlog_l1_addr, l1_size);
+	}
 	if (elog_addr)
 		acpi_os_unmap_iomem(elog_addr, elog_size);
 	release_mem_region(elog_base, elog_size);
-- 
2.43.0


