Return-Path: <linux-kernel+bounces-26688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E8D82E537
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99318B221C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFA024B31;
	Tue, 16 Jan 2024 00:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+oG9YC/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4383E24A1C;
	Tue, 16 Jan 2024 00:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55370C433F1;
	Tue, 16 Jan 2024 00:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364107;
	bh=D59vzrAcr4nIu1QBsM1dhuamAXH77x0gI+kpEJaIURY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q+oG9YC/ITvVv9TpeuBSBHWC8aDB3QW71sepaY46sRONgpzDAqQP00oCQwBGfkcQB
	 qPuChYOI8XbJ76gTGYPNKtIXmE3pc5CYjiGXHeGOzDuOt8itOOlBUZ6hxuSPMd8GMh
	 0sapsaIEaQlztaJUtvraQtPnbTzFNkdkRAdabvO3raXoeI8l9ZD/y9nEXL/gFpLNhJ
	 b3JPcQgxbSRiBc9zB99zdI7aXgKlqJJ/8o6sDEnIkD9Y14qiftmuHDkOxTjgaS3h4Q
	 YCm4iy+WE6ZDzZhg8nkifkFaE8e4xaeP/Y0/LalXIBrsxcOYEa0fMk2tQvmTlaZ4Kp
	 50iXkTCSJKxtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 6/8] ACPI: extlog: fix NULL pointer dereference check
Date: Mon, 15 Jan 2024 19:14:52 -0500
Message-ID: <20240116001457.214018-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001457.214018-1-sashal@kernel.org>
References: <20240116001457.214018-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index e648158368a7..ac89bc85a9c9 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -303,9 +303,10 @@ static int __init extlog_init(void)
 static void __exit extlog_exit(void)
 {
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


