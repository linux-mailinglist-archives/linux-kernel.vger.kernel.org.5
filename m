Return-Path: <linux-kernel+bounces-26687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2408282E534
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FFA5286E81
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B072B249E2;
	Tue, 16 Jan 2024 00:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIEiRdGl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2146249F5;
	Tue, 16 Jan 2024 00:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD46EC43390;
	Tue, 16 Jan 2024 00:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364105;
	bh=dpJBmRkvN5a1m3Hw4ezVRUa5yHqdrRbbSVIB+kwRQAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iIEiRdGlJJw9+wZ+0G81bhGHWS1HyrWcTGdFw+W2QjT8y4tZSv5RSA2hwQCWPUu8B
	 UGM/ltwTyVSCX8O5U+CMiGBvdGZ47oUosWzTOcRXKJ/CQiEjTjG7v5DuBrVOq2dEz6
	 /H1Frc0x1AxZNb3HqQfcfliFv6AxI3uuuW2ZoGKI/nNFpscjWp4jjCmUKTIcrfuJy3
	 5BTyrpo/ePEqVEXIKviC/H5QhRe7eldya8P8gl1Pd/ynTye584391QN46de62geXyJ
	 y4ntB0998NNs4+SIJ5zisnwCT1nFPan3bxze4RPbMx4NJMBRLoCEOXcLk2Vl+p6JsL
	 Lz4G8EJBmcFsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Kees Cook <keescook@chromium.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 5/8] PNP: ACPI: fix fortify warning
Date: Mon, 15 Jan 2024 19:14:51 -0500
Message-ID: <20240116001457.214018-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001457.214018-1-sashal@kernel.org>
References: <20240116001457.214018-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit ba3f5058db437d919f8468db50483dd9028ff688 ]

When compiling with gcc version 14.0.0 20231126 (experimental)
and CONFIG_FORTIFY_SOURCE=y, I've noticed the following:

In file included from ./include/linux/string.h:295,
                 from ./include/linux/bitmap.h:12,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/paravirt.h:17,
                 from ./arch/x86/include/asm/cpuid.h:62,
                 from ./arch/x86/include/asm/processor.h:19,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:60,
                 from ./arch/x86/include/asm/preempt.h:9,
                 from ./include/linux/preempt.h:79,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pnp/pnpacpi/rsparser.c:11:
In function 'fortify_memcpy_chk',
    inlined from 'pnpacpi_parse_allocated_vendor' at drivers/pnp/pnpacpi/rsparser.c:158:3,
    inlined from 'pnpacpi_allocated_resource' at drivers/pnp/pnpacpi/rsparser.c:249:3:
/include/linux/fortify-string.h:588:25: warning: call to '__read_overflow2_field'
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Wattribute-warning]
  588 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

According to the comments in include/linux/fortify-string.h, 'memcpy()',
'memmove()' and 'memset()' must not be used beyond individual struct
members to ensure that the compiler can enforce protection against
buffer overflows, and, IIUC, this also applies to partial copies from
the particular member ('vendor->byte_data' in this case). So it should
be better (and safer) to do both copies at once (and 'byte_data' of
'struct acpi_resource_vendor_typed' seems to be a good candidate for
'__counted_by(byte_length)' as well).

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pnp/pnpacpi/rsparser.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index da78dc77aed3..9879deb4dc0b 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -151,13 +151,13 @@ static int vendor_resource_matches(struct pnp_dev *dev,
 static void pnpacpi_parse_allocated_vendor(struct pnp_dev *dev,
 				    struct acpi_resource_vendor_typed *vendor)
 {
-	if (vendor_resource_matches(dev, vendor, &hp_ccsr_uuid, 16)) {
-		u64 start, length;
+	struct { u64 start, length; } range;
 
-		memcpy(&start, vendor->byte_data, sizeof(start));
-		memcpy(&length, vendor->byte_data + 8, sizeof(length));
-
-		pnp_add_mem_resource(dev, start, start + length - 1, 0);
+	if (vendor_resource_matches(dev, vendor, &hp_ccsr_uuid,
+				    sizeof(range))) {
+		memcpy(&range, vendor->byte_data, sizeof(range));
+		pnp_add_mem_resource(dev, range.start, range.start +
+				     range.length - 1, 0);
 	}
 }
 
-- 
2.43.0


