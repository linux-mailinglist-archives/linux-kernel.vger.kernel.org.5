Return-Path: <linux-kernel+bounces-51494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E3F848BE1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9014828206C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F45BB676;
	Sun,  4 Feb 2024 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lgsy4/RV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2297B654;
	Sun,  4 Feb 2024 07:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707032600; cv=none; b=Oeu0IaaXpnfjYtIfIvDvnJdUn6oFpY1YLyAi09KpQ1Wzdo9BbTVupwqPNJB+Pg73kAxq/wIaaHGcEp/LLuNl7Q6A/G1RwrFLwe8wabQWcoKWVUCtylsyhsRASj+6x128oXUAnNSHQKaPCrBlx98rizce9azh26KSUYro0LkQ1Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707032600; c=relaxed/simple;
	bh=gCY6a7aRfG65U/xuEIFO5NxEPEue1XRDBewjvojLT04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WJYmyWp5G2LwYRGihd6A4BzHsmiSg6H/uU+T5IqO72l/92H+y1GLUxU4ROnRoTtWnlJyLvxJTkyyY8diF5LN+A/IQKtZHZAqyRkIctUXnvXg5sTDtQb+aBIzwMwlkQePwLnPUSSOO+RV6au2yiPXOEEiDWiGpu1z+3TOVvqEhVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lgsy4/RV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A92C433F1;
	Sun,  4 Feb 2024 07:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707032600;
	bh=gCY6a7aRfG65U/xuEIFO5NxEPEue1XRDBewjvojLT04=;
	h=From:To:Cc:Subject:Date:From;
	b=Lgsy4/RVQVnP+ZtTHkAD4McQQtfczi5nCfcJgnM6YDD/V5+RLdlEsQlMD0xdcxE0o
	 pmD9gp3TOdoYcasf5VXEsq75o+2EXGY8HHCkWhx+AtOdEiP1EseOJRIvS67nmR6TwK
	 2XzcAYiPmIzEVp79pK/XOlS0SK2QAyk78hrqIYAWgWQBYx6TqFlPqsrWGsC1T4jg8N
	 ZWxyA1z0BnqpLJN/eLTOBeJTNtTPdfkOT6bllo+zOL3Ps+IwFdf8UYVCOuhOWqC4Kb
	 JJE6WtxAd3rmo5VaAt7XXCx8EObVVrT8lroW1DdQ5gtYnHus1jffIEavcI1QfICsEH
	 hXNqJRgZouvaA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	kvmarm@lists.linux.dev
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm64: do not source virt/lib/Kconfig twice
Date: Sun,  4 Feb 2024 16:43:05 +0900
Message-Id: <20240204074305.31492-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ARCH=arm64, virt/lib/Kconfig is sourced twice,
from arch/arm64/kvm/Kconfig and from drivers/vfio/Kconfig.
There is no good reason to parse virt/lib/Kconfig twice.

Commit 2412405b3141 ("KVM: arm/arm64: register irq bypass consumer
on ARM/ARM64") should not have added this 'source' directive.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm64/kvm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 6c3c8ca73e7f..27ca89b628a0 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -3,7 +3,6 @@
 # KVM configuration
 #
 
-source "virt/lib/Kconfig"
 source "virt/kvm/Kconfig"
 
 menuconfig VIRTUALIZATION
-- 
2.40.1


