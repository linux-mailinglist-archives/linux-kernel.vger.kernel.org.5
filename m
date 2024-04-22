Return-Path: <linux-kernel+bounces-153140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289658ACA0E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59DA31C20F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9358313C695;
	Mon, 22 Apr 2024 09:59:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908E14317E;
	Mon, 22 Apr 2024 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713779969; cv=none; b=PpntvZjiFjARwo+Z57uVhZkr63JhFBcMse5VoH+tfRUP/lVsMGIj5yinfPJNNWYa9NlaWZhRkBf+lkllbqywgJYHkdsS7QKXoM4aFvoboZ+JzAaniv9cI4ocz7tOL81PR9UF8rMp9r72IXH7DJ+7MJIg8iOk7Ju2P2N+0EgmNGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713779969; c=relaxed/simple;
	bh=+7WqRKNKzT/Yy6npUWrE2yQ7/KFZ2uwmdSBIimyP7ZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDtV0EAqAKA8vxmAF7DAyZovmeyiZKhTL1VvHEFkTre/WNFq1f3SJ05RCZ61z/L0WMJqyEURYSpaNnpKdkm85glzr6uaxAMP354yu7l6gKZTBVKPxNOp9Bz6rhGhu5EGH6diSKZKGrCsWnMx5a55t1Cc4QxmjkwsmRgzs+4csM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CC392F;
	Mon, 22 Apr 2024 02:59:55 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1FF353F64C;
	Mon, 22 Apr 2024 02:59:25 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: krzysztof.kozlowski@linaro.org,
	linux@armlinux.org.uk,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	James Clark <james.clark@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mike Leach <mike.leach@linaro.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	coresight@lists.linaro.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH V7 00/11] coresight: Move remaining AMBA ACPI devices into platform driver
Date: Mon, 22 Apr 2024 10:59:18 +0100
Message-Id: <171377975977.3331951.13760450309364725525.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314055843.2625883-1-anshuman.khandual@arm.com>
References: <20240314055843.2625883-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 14 Mar 2024 11:28:32 +0530, Anshuman Khandual wrote:
> This moves remaining AMBA ACPI devices into respective platform drivers for
> enabling ACPI based power management support. This series applies on latest
> coresight next. This series has been built, and boot tested on a DT based
> (RB5) and ACPI supported coresight platform (N1SDP).
> 
> https://git.gitlab.arm.com/linux-arm/linux-anshuman.git (amba_other_acpi_migration_v7)
> 
> [...]

Applied, thanks!

[01/11] coresight: etm4x: Fix unbalanced pm_runtime_enable()
        https://git.kernel.org/coresight/c/caa41c47dab7e1054f587e592ab21296e3a6781c
[02/11] coresight: stm: Extract device name from AMBA pid based table lookup
        https://git.kernel.org/coresight/c/852e9a32058a73702c016a8be10c60375276e46e
[03/11] coresight: tmc: Extract device properties from AMBA pid based table lookup
        https://git.kernel.org/coresight/c/3ab210297c31b8fef1cfb2aa3d85b227b9ace09b
[04/11] coresight: Add helpers registering/removing both AMBA and platform drivers
        https://git.kernel.org/coresight/c/075b7cd7ad7dec8651a6a6654fa5ebae436ac00f
[05/11] coresight: replicator: Move ACPI support from AMBA driver to platform driver
        https://git.kernel.org/coresight/c/b448c4c72ca3327232dfb20d0065b693b3fcc2e2
[06/11] coresight: funnel: Move ACPI support from AMBA driver to platform driver
        https://git.kernel.org/coresight/c/8e3227ddfbd7216f14186ec534f43e9dbcde717c
[07/11] coresight: catu: Move ACPI support from AMBA driver to platform driver
        https://git.kernel.org/coresight/c/23567323857d2073197953bb158413be1aceca8b
[08/11] coresight: tpiu: Move ACPI support from AMBA driver to platform driver
        https://git.kernel.org/coresight/c/3d83d4d4904a47626854b6bba44127d21a7dc713
[09/11] coresight: tmc: Move ACPI support from AMBA driver to platform driver
        https://git.kernel.org/coresight/c/70750e257aab4cd4d755294ae8b9834214a624bb
[10/11] coresight: stm: Move ACPI support from AMBA driver to platform driver
        https://git.kernel.org/coresight/c/057256aaacc862356417a75ceeb1cfa41408dbf0
[11/11] coresight: debug: Move ACPI support from AMBA driver to platform driver
        https://git.kernel.org/coresight/c/965edae4e6a2bca1f6e56d2c56d992417a53bba4

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

