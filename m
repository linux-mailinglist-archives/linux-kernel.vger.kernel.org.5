Return-Path: <linux-kernel+bounces-63418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B11852F03
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F122880FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFB4374FC;
	Tue, 13 Feb 2024 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qmrk2F4r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E0E3716F;
	Tue, 13 Feb 2024 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823261; cv=none; b=SnSJaBMHsxHr9KH+jpvTIwgj06BA7WWiOTKZcSKQIzQ/lSemJWd3X5/LkBH53D5KHO2lXS+ap330Nb9jgkaH55qYoEEkYNucCSVtHXUKfFQP7OXTU1sBelTYs/GF7ZiNATOL8qq1pQRq4Nraz+FR9im5PRw4jocdS+sRJLyZR9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823261; c=relaxed/simple;
	bh=2Ywh4OzY0chZDpnSXV5NPQrPw3P/Ggi/eWmN3vNLbvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFKM6fSTXUrfqx7ZFxI+yL/aNP4LiJ6rGRJYDxhUPGwU9cfwmdYSGz+2lbw4FutSohqx1GYQ5obPfU8I4tNyjQ7o839wvG4HOkQ9d9C3RfozwKTCnBI+u95/nQWjB5vQlyJXCDH5DDovfmTjiXqxy9C30U8LkE11r0LmZKTv6Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qmrk2F4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60626C433C7;
	Tue, 13 Feb 2024 11:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707823261;
	bh=2Ywh4OzY0chZDpnSXV5NPQrPw3P/Ggi/eWmN3vNLbvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qmrk2F4rCd2WSIl36Y6lDgYxriYXibf5WUnr64oOngjSxBCVQrpuAlmOY3mQif9++
	 NsCxVVnhF4vSJmkHAVA9o8MNQjg0B5PCM8nzkP2YZ4VZl4tCbr1tOxdP/5ePHyT4cT
	 57G8frJcO2TbDcDVtXCPEkjEtYedPNgGW6yO3quk+V0kOe4lSUld4pJmsfl4lly70Z
	 QNlW89CUBsbx5rm3otlRRKbuSRlUOHTu2eS/2Kne+GxrzyJsgfLKDSkldRG/qBxIAi
	 bu9rIvDS9Z5CP0ScTfomqKn68xmrM2uek4Ju5sAPrHIsv0L1rXgGwIGbeZw/eRFxUt
	 yYg4SM0R8q6SQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: bp@alien8.de
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org
Subject: [PATCH 1/7] EDAC/amd64: Remove amd64_pvt::ext_nbcfg
Date: Tue, 13 Feb 2024 12:20:45 +0100
Message-ID: <20240213112051.27715-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213112051.27715-1-jirislaby@kernel.org>
References: <20240213112051.27715-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cfe40fdb4a46 (amd64_edac: add driver header) added amd64_pvt
struct with ext_nbcfg in it. But noone used that member since then.

Therefore, remove it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Robert Richter <rric@kernel.org>
Cc: linux-edac@vger.kernel.org
---
 drivers/edac/amd64_edac.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 1665f7932bac..b879b12971e7 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -345,7 +345,6 @@ struct amd64_pvt {
 	u32 dchr1;		/* DRAM Configuration High DCT1 reg */
 	u32 nbcap;		/* North Bridge Capabilities */
 	u32 nbcfg;		/* F10 North Bridge Configuration */
-	u32 ext_nbcfg;		/* Extended F10 North Bridge Configuration */
 	u32 dhar;		/* DRAM Hoist reg */
 	u32 dbam0;		/* DRAM Base Address Mapping reg for DCT0 */
 	u32 dbam1;		/* DRAM Base Address Mapping reg for DCT1 */
-- 
2.43.1


