Return-Path: <linux-kernel+bounces-34134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5948837423
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504181F244A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA7E481C7;
	Mon, 22 Jan 2024 20:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gm/qcEFf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6E6481B1;
	Mon, 22 Jan 2024 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956144; cv=none; b=rXK4EBUCf8k2xrVwa08OKaEbkYz04fuDkH653ZTxiBCwKNJo2MB7MemBP6Iu6YJ2AoKEyoS/Ja+OEso6/Xb0Z3rW6PX4fSqcdkpY5FaD9NYGMHNtyYlpqAgBX/D8jmDkqBASxeKzozU9V5iMlrIZd8LQudXY7fQfYlUV2kdpd2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956144; c=relaxed/simple;
	bh=fjtGYrPLVAgmnbjt+Ekb+IEbQu2c0zwfHg/G7gZsVmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PcFiVrntOcXj4NjIjIlU8ZbzepPDlgrzA5tmsspLCO6WNE2dmR63KIHcmzHyKq6qKK2mzunXkXxMi5hb39bceCQqXQORp6p8GwQW5uKFrM+OX7jVDmvwBL+Wutt4CuV71keJ+3NxNhko+LpCXFp6FWG4xozS1RIlnglLlU10AbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gm/qcEFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D76C43394;
	Mon, 22 Jan 2024 20:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956143;
	bh=fjtGYrPLVAgmnbjt+Ekb+IEbQu2c0zwfHg/G7gZsVmI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gm/qcEFfiSNUvkiYPekzxnCgffzrZrI0Jbe2TkhEzD/a1Bgwo9j9yFsV9UTTPJozG
	 wYPAqCysMsWfPqH/Y4fv9gPhoIhFODWmE55a1CPr0O7yocY3N2t8+C5ldmR/RYqRyy
	 D0zhzdYC5LGHrBZdaZldNRZ/xUd22SbYm+Gxbuab+V6Ycg2im9X1hoyGJa6VJsxmOh
	 ipY42DR0cQy1Ch90ARtStJ1BEYHhKDaah3Q6Dvg7XSMhAd4aY+0Iv7uHPMvdgN0Df8
	 1h+FMpMxljyMaL65Bt9TPlnVn/+/79cBmayWIJGk5tH64lAU6xdGYyOlqbbg9+5miQ
	 4UABMgXSkbZWQ==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 22 Jan 2024 20:41:53 +0000
Subject: [PATCH 3/4] arm64/fp: Clarify effect of setting an unsupported
 system VL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-arm64-sve-sme-doc-v1-3-3d492e45265b@kernel.org>
References: <20240122-arm64-sve-sme-doc-v1-0-3d492e45265b@kernel.org>
In-Reply-To: <20240122-arm64-sve-sme-doc-v1-0-3d492e45265b@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, 
 Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=2147; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fjtGYrPLVAgmnbjt+Ekb+IEbQu2c0zwfHg/G7gZsVmI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlrtMiH/73f//2tkGiaJyZTf5xHRxxVBa9xFB2oZ2L
 zwYsEhaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZa7TIgAKCRAk1otyXVSH0PHiB/
 9zHa9KEFYs2ugoCsm80PWrKpmYx7jbcBOAt1g3oeczKb/va6JJ8R8yS4RO+t0zjM+SgEWE2gMboGMz
 WfUNahqBNUYMy30d0sUCnj0ykg/ghbn/SY0Ng5wfRLG0yExhnde4OSIbdtV8MB3S22TuOgevK6y2RB
 NUWNljFA3h031svejBLxzIuKg+BAZJshAKtavwWDxY3N4og3h/KBeyvwhSpyPuZaVAOtZgODrcLwUX
 l6hTlmcn8M0E0Vwsjb9KonvrLA+FW/5yDNZVqYKSTEpbmDkZIHE4+FJpFY1ysmbj5ulodp1nN+V2Y4
 9AkkJP5c4s66BXeveCA9VgM1Wv2K2x
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
index 3133d0e91b48..ba0a5e5b2523 100644
--- a/Documentation/arch/arm64/sme.rst
+++ b/Documentation/arch/arm64/sme.rst
@@ -379,9 +379,8 @@ The regset data starts with struct user_za_header, containing:
 /proc/sys/abi/sme_default_vector_length
 
     Writing the text representation of an integer to this file sets the system
-    default vector length to the specified value, unless the value is greater
-    than the maximum vector length supported by the system in which case the
-    default vector length is set to that maximum.
+    default vector length to the specified value rounded to a supported value
+    using the same rules as for setting vector length via prctl().
 
     The result can be determined by reopening the file and reading its
     contents.
diff --git a/Documentation/arch/arm64/sve.rst b/Documentation/arch/arm64/sve.rst
index b45a2da19bf1..b923727ff4b9 100644
--- a/Documentation/arch/arm64/sve.rst
+++ b/Documentation/arch/arm64/sve.rst
@@ -423,9 +423,8 @@ The regset data starts with struct user_sve_header, containing:
 /proc/sys/abi/sve_default_vector_length
 
     Writing the text representation of an integer to this file sets the system
-    default vector length to the specified value, unless the value is greater
-    than the maximum vector length supported by the system in which case the
-    default vector length is set to that maximum.
+    default vector length to the specified value rounded to a supported value
+    using the same rules as for setting vector length via prctl().
 
     The result can be determined by reopening the file and reading its
     contents.

-- 
2.30.2


