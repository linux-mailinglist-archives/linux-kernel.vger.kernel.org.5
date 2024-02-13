Return-Path: <linux-kernel+bounces-63812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 538BF8534C6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1169D2870B0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7697E5F48A;
	Tue, 13 Feb 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0CcMPpP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE565F467
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838554; cv=none; b=frRvFGJb7JATspCK7S3z2J/WgleJ8wHnK4K4FVabqTIxR/jKCjYr9wXEIW7V3dVySdLUTgIsu3bldf7lMZXIhGdy8Mep2OBT+D2df9cROjxaubJOgTLwNwdGG2ZZHu5EPdBFVef7bZ7xUF6nG+QiRqHtR0Mwbd6Rq+EnMdgFhtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838554; c=relaxed/simple;
	bh=3QP5xdQgCtutqWVSSb21JK6+dtuADu8WvFbwQO2EMwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CqI61iJgjkcmn9DjAqkGcLhSDk9OPBeZHy5nZgXtufVPoMP7EW9TS26K/EuCE/lqPNLnFOVYSzVThX9AyX6bYXzoRPmr5HJoKqPadjPhiLBgn1s47kdFezXoiz9nLlMsYq3dj3LCC4IRyzhdS7ccXuLTpzqlNc2sQQyFTMj5T7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0CcMPpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3C0C433F1;
	Tue, 13 Feb 2024 15:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707838554;
	bh=3QP5xdQgCtutqWVSSb21JK6+dtuADu8WvFbwQO2EMwE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z0CcMPpPKSEqSEkrJ8GWhfqOB59+LE1ZCYDCIWlQUQxGvnHCc5UcuvW7hTvKzjEct
	 VVzNQLvxGHww6+0O28Vk2HqP7LwI8R4iEkLpIOJMm/yhR5IthxW5z8DUGPMUVBzB/S
	 ngXi/4fauKql39WahyPOmof613fXlhQ0Vz0KPKa3tgD4ySdLvBinkNQqbzlB2UYQqB
	 BSuzgpuO6zhhfWmNUyNIAlJ6WiY/gBK44cFnBmKsHsArls4n+GeFanY0QnH9BLIQEQ
	 ZIFOjlouV0DmK1Pd6T4XyzfVRQdtykc1GjSXvelON6WCVhaym3binh+CYHKuEXVeJl
	 Kd/5CjcsEwvRQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 13 Feb 2024 15:32:46 +0000
Subject: [PATCH 2/2] arm64/sme: Ensure that all fields in SMCR_EL1 are set
 to known values
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-arm64-fp-init-vec-cr-v1-2-7e7c2d584f26@kernel.org>
References: <20240213-arm64-fp-init-vec-cr-v1-0-7e7c2d584f26@kernel.org>
In-Reply-To: <20240213-arm64-fp-init-vec-cr-v1-0-7e7c2d584f26@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=981; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3QP5xdQgCtutqWVSSb21JK6+dtuADu8WvFbwQO2EMwE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBly4xUA3rs0ghZm22tJlDf7DiTmlghGGgzwk5+CB7+
 o8iscR+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZcuMVAAKCRAk1otyXVSH0A3DB/
 4nCFlJDvs+F0CTlMKwubqM8n+bW2BzQNqbAeq+wTMLRi7W6b6FyPofh0STmmfdePtpS4d1Y4jR16Ce
 21nbI1rJfcnJhj0i4VofrhgfcYjvkEVXRJc6GTDWMOgpZj1pOno/HCUbKHZz+icpqMXuqlMRTQu+lg
 zM+sA2yJpndyJRBtrXYShEiYLdo+tS4Xo+yQgGdXBuf/dN+cUTYRNAHwQxEsK/BHPb9A5UlcF3ApCR
 XK6RyI+8Z4gRKs0dggA8u6rSIdt4fQjzG+qh0xkn1b7uwrkTP2uJgG0RnZRgehnrNx0gzdlTZVrQeh
 8WLSDDH8meCJ2fQkPPMkavpklqjWbA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

At present nothing in our CPU initialisation code ever sets unknown fields
in SMCR_EL1 to known values, all updates to SMCR_EL1 are read/modify/write
sequences. All the unknown fields are RES0, explicitly initialise them as
such to avoid future surprises.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index cc3c9ad877a8..f96907b813fa 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1247,6 +1247,9 @@ void cpu_enable_sme(const struct arm64_cpu_capabilities *__always_unused p)
 	write_sysreg(read_sysreg(CPACR_EL1) | CPACR_EL1_SMEN_EL1EN, CPACR_EL1);
 	isb();
 
+	/* Ensure all bits in SMCR are set to known values */
+	write_sysreg_s(0, SYS_SMCR_EL1);
+
 	/* Allow EL0 to access TPIDR2 */
 	write_sysreg(read_sysreg(SCTLR_EL1) | SCTLR_ELx_ENTP2, SCTLR_EL1);
 	isb();

-- 
2.30.2


