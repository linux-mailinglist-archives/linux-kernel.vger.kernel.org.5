Return-Path: <linux-kernel+bounces-69913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 015EB85902B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D761C20410
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47C27C0B0;
	Sat, 17 Feb 2024 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prRb962i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF3B1D543;
	Sat, 17 Feb 2024 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708181701; cv=none; b=HafZt7Q/QCbNdWqXv63MaKi7rv58Hk2cSzA5alq1l0CndSxUx661GAr04ZWhzwTQKHG/E4HNW+1YCUZQiPkgvcmemhj7ZauGi/I7+DsuQJf3wTFN0b+6R2moLWWpcQgurmjGs4DQ0/mOYWGRA4jBHarHxzOPpp0EZgHZa2MkhXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708181701; c=relaxed/simple;
	bh=Yi5Gd0jnq8M0zygFXNIozQY9SSvV949fbUeccyzerYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mhVRX0N8IZzhv4HArsz5ySc9WOaR5o688outEVC7wzyz30MOQZnMgMGQokRIUKu5g4BkFHQgB30em5i7d/2SDwlBvP3s00R1yssvP/lf0NXnQpb+tSBxXeQovHGPADAre4/vHwYvpM/Ik6AHE28Mo3SGQEnzzz0pUZSbPW/Ozbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prRb962i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9E2C433F1;
	Sat, 17 Feb 2024 14:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708181700;
	bh=Yi5Gd0jnq8M0zygFXNIozQY9SSvV949fbUeccyzerYY=;
	h=From:To:Cc:Subject:Date:From;
	b=prRb962iIfd64tAiJtAt+ySH250xUoL0By4O1DslWr0WnDu6BW+Ccc9Nvkowq1CXE
	 CJNNW0A2XR9nO3jlYgEqvzHifu6l95YzbFISYmCcdu16NwGKypa8cb6tnUNRl6SYFl
	 +Hhv6nL/8CFDQCh5O+qPJoP8rBn10/99yN5zFPAwrfgDOLkdc8ihkQRYIE2ls+R2W/
	 gkUnRMjjjHlPTBC97DqjO9dAtYLYSocw4YYZ12gTvJL7bh9huLgPJdQSK3RQ1FTEt9
	 cYGfc0UU87TVPJ5tDyGmrq+glKxW5J3Fph4xGy5c0F81wopekm/kIa+x1i3DrRyefs
	 2vcHrEccXIBmg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 0/2] mmc: sdhci-of-dwcmshc: support Sophgo CV1800B and SG2002
Date: Sat, 17 Feb 2024 22:42:00 +0800
Message-ID: <20240217144202.3808-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the mmc controller in the Sophgo CV1800B and SG2002
with corresponding new compatible strings. Implement custom sdhci_ops.
Currently, only sd card and no-1-8-v is implemented and tested, I will
try to find a board with emmc and sd/sdio sdr104 support.


Jisheng Zhang (2):
  dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo CV1800B and SG2002
    support
  mmc: sdhci-of-dwcmshc: Add support for Sophgo CV1800B and SG2002

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  2 +
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 66 +++++++++++++++++++
 2 files changed, 68 insertions(+)

-- 
2.43.0


