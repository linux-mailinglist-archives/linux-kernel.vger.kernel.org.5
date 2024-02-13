Return-Path: <linux-kernel+bounces-63810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E207D8534C3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20EF31C22879
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CB75EE62;
	Tue, 13 Feb 2024 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfPPjjCX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B70855765
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838551; cv=none; b=BnkQuW/SaMYfpkn9KNKv+Ec2zGYPF0ACWp9yy2c1+iAJk+yBWgOJR8Ds8lL5X4+Fe3KLgJ35+m6L0j9Oj61WGX6mtdofzajU1ZIilmM3IIQJojlEDhh9oY0kfS+maB7bwfiQCBUZ/TQS69/Mtuwyv0WMoJ/wwvol9V+Xk+SuBYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838551; c=relaxed/simple;
	bh=lOi0nYWrCp4OfefqkEB1D1NwaxZ4jMMmQHpyLE+05MQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j8t7WmQU57sf8K92SS3YLgNJB7CmbJYEHBXzYd7sceeRSPnF90Rrj/DP6d7K4cayENdwmpBPHq3Neva0zS4wZrU5jYVcT3Rzr9TLKEe4uGJ86LFRKL7q+yJCIyKT0Nbk5BqKnCubkAhh+VuOmvrda1KFRSHP64mvnxKHTYN0PyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfPPjjCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF64C43390;
	Tue, 13 Feb 2024 15:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707838551;
	bh=lOi0nYWrCp4OfefqkEB1D1NwaxZ4jMMmQHpyLE+05MQ=;
	h=From:Subject:Date:To:Cc:From;
	b=MfPPjjCX9SrrR8K7K/HfWHaUcVX/sRqvql+DGvyz7L0zjceUULbMIc0HGvhKrgAp5
	 T1arEiNZbik14+uzwDzJ/Co1bb4ENQaH9Cdk7sbKy6MKznnZFXDyMygWU35u0ujniT
	 9MJFM1rXfmVqfRR0UJLLH7tsk7w706w88nSZ4pqOiUFfV/3FG2mEVfQv/QTQ3Hl02B
	 IV3BDEcQdvMQOYWBxVT+l585hcyEvjAS09ezDCEIEgC4vFPw0+y1uG3HYHYHK3kZoK
	 7R+rS5x1peNZAqxVBNIdmzXEtdudEjP/PAasvxa9DNyqwUuMDSrUTq7YrZamjG7C/f
	 DWCu54M9jkIWw==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] arm64/fp: Initialise all bits in vector control
 registers to known values
Date: Tue, 13 Feb 2024 15:32:44 +0000
Message-Id: <20240213-arm64-fp-init-vec-cr-v1-0-7e7c2d584f26@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJyLy2UC/x3MQQqEMAxA0atI1hNIY9VxriIupEbNYqqkIoJ4d
 4vLt/j/giSmkuBXXGByaNI1ZrhPAWEZ4iyoYzYwsSd2jIP9a4/Thhp1x0MCBkNyX+/bkpuKCHK
 6mUx6vtuuv+8HI4Ca+WYAAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=709; i=broonie@kernel.org;
 h=from:subject:message-id; bh=lOi0nYWrCp4OfefqkEB1D1NwaxZ4jMMmQHpyLE+05MQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBly4xTIZFC58++1TXzR5Klyk0/kcm5lwqk/TqXo2uL
 msKs0VuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZcuMUwAKCRAk1otyXVSH0BjuCA
 CDbCM/Iuvqvrsj60fYPrnoyu/HSR76EnPZnYotrVSFn+0RRWw+1DHT7DGX5ybDNrm0w+QT/LGZJPYL
 PKIUOYTglOaJFGxe5ZUXyD+VvfbmNr2/cH55fgUiHC3knApuHtWL15olvxESonvrKjvnXTmuQJ0kfe
 s4GSABb0DQnADb+TL4wJsSJgRckDRV+5//wyTnzMSyBIqqvdNEeJkmSsYahX2iy9xKiVPzCJ8qCrB1
 LNQ5M+DaxxFr73y0ycbIOc6jBvJB5keiEMOY9VguDxcIAibIdiTbx9JJdtAQ8kxB4J86MA1VCQa2uN
 HvF7VNG0a0nDul3curqeDQH/uD0Wpv
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

We currently do read/modify/write sequences whenever we update fields in
ZCR_EL1 and SMCR_EL1 so fields we are not explicitly handling will not
be initialised to known values, fix this.  The EL2 registers are already
fully configured.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      arm64/sve: Ensure that all fields in ZCR_EL1 are set to known values
      arm64/sme: Ensure that all fields in SMCR_EL1 are set to known values

 arch/arm64/kernel/fpsimd.c | 5 +++++
 1 file changed, 5 insertions(+)
---
base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
change-id: 20240212-arm64-fp-init-vec-cr-018449327500

Best regards,
-- 
Mark Brown <broonie@kernel.org>


