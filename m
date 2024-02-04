Return-Path: <linux-kernel+bounces-51658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19752848DFE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27127B21F72
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C372E224E8;
	Sun,  4 Feb 2024 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd49GKW0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA1E224D5;
	Sun,  4 Feb 2024 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707052181; cv=none; b=SskZoAVcE1c+Ll2yk2VXgYQiX7cRrevAYzAepiHgQPfJrbQbbR5QSBxuWH57rZ3P1jPXrJwYEW6/RbUT4USNHrxLb0J+ZT9oyoYgKXQcMEMI4vVYEGnPHCyBBc8kBfYlHmLmLyVF1oEo3rX6zxwFfrbs3+zKt5H0d1rP2NxyAKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707052181; c=relaxed/simple;
	bh=m65aPL8WYBFsI6G3xB+7VUwH3k2y+3oo8t98SWh5vqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjdQThfUiquCXAqc3GkCKylyg80RmYpY9kz16z6AAoUSzZXq1ZCY1h5H27447j62TlKMkbE/GlQ/SWrb/1mHPQOh4DoE6ve37dGcTmMqA/+CojUqRbhRXPiTrIL+bGf8MJBVi5+JHe3ie1tqUHLW21KJ3sOpFWFoZOuUZO3bXV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd49GKW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6A9C433C7;
	Sun,  4 Feb 2024 13:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707052180;
	bh=m65aPL8WYBFsI6G3xB+7VUwH3k2y+3oo8t98SWh5vqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hd49GKW0SF4TxcKLF2R0Znobet3PfPJG6a0ZlphJKmi8VdbptQNn9U3y3FK1V3HUX
	 UogBfPBYYyF0wr1WAsGndxQOFyos5ionU+lbZZh97wYCY2ZOy/D9dmEddt6MZuWRYV
	 8zBTB7WA+Pt6sE929eq3rehstCBoR/Fw7ZC1+D9txsaEtFv9qsr3m0ltExfVsZfLqk
	 sc4yqnsOlWzfwMI5yA+xr5uY7E8ewmAjKlhOkExdXWJAcQtrb3G2KqIvo+HXz1Y35R
	 QrNEm65HpmDcyPRe6oBiOXZvey6HlsX2W0oYNIfTr5r3yK5gdjDyBedrrU8FJEAGiA
	 8U6mLjYqYilnQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rWcFe-000B2k-9M;
	Sun, 04 Feb 2024 13:09:38 +0000
From: Marc Zyngier <maz@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>,
	James Morse <james.morse@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	kvmarm@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] KVM: arm64: do not source virt/lib/Kconfig twice
Date: Sun,  4 Feb 2024 13:09:35 +0000
Message-Id: <170705216023.856444.15648014100978026603.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240204074305.31492-1-masahiroy@kernel.org>
References: <20240204074305.31492-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: masahiroy@kernel.org, james.morse@arm.com, yuzenghui@huawei.com, suzuki.poulose@arm.com, oliver.upton@linux.dev, kvmarm@lists.linux.dev, will@kernel.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Sun, 4 Feb 2024 16:43:05 +0900, Masahiro Yamada wrote:
> For ARCH=arm64, virt/lib/Kconfig is sourced twice,
> from arch/arm64/kvm/Kconfig and from drivers/vfio/Kconfig.
> There is no good reason to parse virt/lib/Kconfig twice.
> 
> Commit 2412405b3141 ("KVM: arm/arm64: register irq bypass consumer
> on ARM/ARM64") should not have added this 'source' directive.

Applied to fixes, thanks!

[1/1] KVM: arm64: do not source virt/lib/Kconfig twice
      commit: 42dfa94d802a48c871e2017cbf86153270c86632

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.



