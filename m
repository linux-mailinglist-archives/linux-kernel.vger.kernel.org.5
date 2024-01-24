Return-Path: <linux-kernel+bounces-37495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5653F83B114
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6503B36D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB11612BEB3;
	Wed, 24 Jan 2024 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhzBkrtP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3886E12BEA2;
	Wed, 24 Jan 2024 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119972; cv=none; b=W6/2XUUuYk2U0gs8FAd7IqzjQcbHMc44tAoxK036+269CQ06HLdn1/u/+Y4PTreDPiayNjlmpB//xGq/tyXRFvd7OXpztXPGNsbWEnNa0W0pspJZpfMIB31H69vsg7aB0YwsdUmFfMdJVZ7SYYYZZHLtbJ7VSo0YejSD1jv0gQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119972; c=relaxed/simple;
	bh=SZE/NEKa8x7WLFeaaJG3HC5W7JWmr0VNMdNibq7Cpz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B0Nw8Nw6x/+KyYS5kAoS0uAJMumc92aWLoiXrWMM1uLJP7PvKWGW7t/MzJyoD4LM0CEO7F10bLjbinIqUF9bY3PqbHfoPI4MfsXTIorBFxyoUJq9EwwfGuOO4GxGJJmmHL0n+P64aztsD2iwx1/e6L/rgW34/DYwQVI/muVijQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhzBkrtP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A04C43390;
	Wed, 24 Jan 2024 18:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706119971;
	bh=SZE/NEKa8x7WLFeaaJG3HC5W7JWmr0VNMdNibq7Cpz8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DhzBkrtPs6ZKDJAaSiEMKQASXyB3DKkTRbivSAWpMlE8hGwlWMonvwe+sLGYqZxZU
	 rTt8F2caoXVnvtMiz8G2SQywSfF+WWN95zBQPcAWxgGxjBoUdAEARBG/2kkii1Ho1X
	 cEhU/gmzwuG3nSPC75OHgZImBN4LPC941Gr69TjyA39vNH+RKwEEIgQztrMGfKKWA9
	 G9wfX85Zlgm69KeBPBeDtv+FcqsMWmfkzWfXzH3ag6wRseFZbeAnO82+Rs+PcJNdS+
	 tpUtToxWNiN04PfUlfRqDZJeEoBL1RZ38I5Zn4/U0It6JUnhItM9GAy56TzFgk/jPZ
	 /M4X8O3dLtbiQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 24 Jan 2024 18:12:37 +0000
Subject: [PATCH v2 3/4] arm64/fp: Clarify effect of setting an unsupported
 system VL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-arm64-sve-sme-doc-v2-3-fe3964fb3c19@kernel.org>
References: <20240124-arm64-sve-sme-doc-v2-0-fe3964fb3c19@kernel.org>
In-Reply-To: <20240124-arm64-sve-sme-doc-v2-0-fe3964fb3c19@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, 
 Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2159; i=broonie@kernel.org;
 h=from:subject:message-id; bh=SZE/NEKa8x7WLFeaaJG3HC5W7JWmr0VNMdNibq7Cpz8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlsVMZuoJ837tq8yyiOk6QDDv0LqvP8sPwfC9POuaW
 cRNacMuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZbFTGQAKCRAk1otyXVSH0IbeB/
 9uVCyeNQpECVM396Hnf/CcRMD/pftd849z37RwVfAGu2PVR32XoC7Xc5HL6+pAPSC1WzROF48vajD4
 +SkqG6ViZPiC0StIEtsCiYUOcX1sgsld2OgweiWJkUERIm2n/8GlU5azPGxHEzO0TGsJZ46kyXSGU8
 PMdNrMC4c9GE8py4j0yPwhckaFDnS1Ne5jq40+eLOuGuHxj201TcPX5FCyZwI9Y/rk8qOvE6hqAObq
 av1K7DAUNHaeRuOY8UL3iwuyBD/a/eTP9nhBs0yk1meLjenQ3gXh2jfBXCbe1Znz3PiOBLnjbXE8X6
 QXbdSV9M392527bpXFNRh0v3E9o5BL
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The documentation for system vector length configuration does not cover all
cases where unsupported values are written, tighten it up.

Reported-by: Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/sme.rst | 5 ++---
 Documentation/arch/arm64/sve.rst | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/arch/arm64/sme.rst b/Documentation/arch/arm64/sme.rst
index 3133d0e91b48..f4376c06f447 100644
--- a/Documentation/arch/arm64/sme.rst
+++ b/Documentation/arch/arm64/sme.rst
@@ -379,9 +379,8 @@ The regset data starts with struct user_za_header, containing:
 /proc/sys/abi/sme_default_vector_length
 
     Writing the text representation of an integer to this file sets the system
-    default vector length to the specified value, unless the value is greater
-    than the maximum vector length supported by the system in which case the
-    default vector length is set to that maximum.
+    default vector length to the specified value rounded to a supported value
+    using the same rules as for setting vector length via PR_SME_SET_VL.
 
     The result can be determined by reopening the file and reading its
     contents.
diff --git a/Documentation/arch/arm64/sve.rst b/Documentation/arch/arm64/sve.rst
index b45a2da19bf1..8d8837fc39ec 100644
--- a/Documentation/arch/arm64/sve.rst
+++ b/Documentation/arch/arm64/sve.rst
@@ -423,9 +423,8 @@ The regset data starts with struct user_sve_header, containing:
 /proc/sys/abi/sve_default_vector_length
 
     Writing the text representation of an integer to this file sets the system
-    default vector length to the specified value, unless the value is greater
-    than the maximum vector length supported by the system in which case the
-    default vector length is set to that maximum.
+    default vector length to the specified value rounded to a supported value
+    using the same rules as for setting vector length via PR_SVE_SET_VL.
 
     The result can be determined by reopening the file and reading its
     contents.

-- 
2.30.2


