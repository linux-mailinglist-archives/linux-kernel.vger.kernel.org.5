Return-Path: <linux-kernel+bounces-40548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD3783E248
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195FC1F2845A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36693224DB;
	Fri, 26 Jan 2024 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VyAq24Sn"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBDF225CB;
	Fri, 26 Jan 2024 19:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706296405; cv=none; b=gJQKbDUFIAUVBlOpPEw2T5Nvc0Oh3lHgZxhioEtpDXqDZjnMiuf4zLCZwVAnsdBgLIJLTVwv8QjOrMp+NnZYM/DnzniaNB5qoxoFc3zIEPGP5KjYNmbUMBOhvZE0YNZu8gSntJZikcI6AfikTq7cTF8tvf9u9SFIaX4CmN4+y5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706296405; c=relaxed/simple;
	bh=7mhZb9ygDhp+lMS6hHQyI5VsLJG0EHa6YD7w0sZalvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIQjMmY7gHGzy5jRFD+VQLjAJFU69Py5UYuBfc1gha6jNTT3EgptKWsPiVnkyNuVV3mYNjn/e8B2K60fVINGMEc3z5AatLOB6q6v/7x16/Dq5sjjYXRwBpyFrMQ3oxCAUznhGuFEDKipdgM027RBY9lwPs+4DAiFEpdI6FTg9Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VyAq24Sn; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706296401;
	bh=7mhZb9ygDhp+lMS6hHQyI5VsLJG0EHa6YD7w0sZalvQ=;
	h=From:To:Cc:Subject:Date:From;
	b=VyAq24Sn7ivi1SKohnkqGRjltrKJ6S3yO49UwZrG/VCwwLS/fqI8rtZpYqTitf7sK
	 /5jErtvFHCv5SEsi1MeaQI4HUhwB5khcTfwSw3BkJJCaAH55zLqfsgscHiLs1Bp5dw
	 VKr7dKOLOtnxDkamPnZi2aYefR0OJZn7xesZKVrdQCrHJ8nnVkrUDxV4bvOMbZxcWR
	 zRqwP1mE3H/k8cRol3uSuX5PXFpOqkttDoMvXIzAqM80geEPKd6SnNwVabXsX5NIBY
	 tdQuUT+ZOtHGtuhFE4A+/ogJNKmM1REwyz2rmYDu2sU/ytc6M9gsAMr4c+NJ8gnSBJ
	 yu9EjAbB3z1Dg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4897D37811D4;
	Fri, 26 Jan 2024 19:13:21 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v4 0/2] StarFive DWMAC support for JH7100
Date: Fri, 26 Jan 2024 21:13:15 +0200
Message-ID: <20240126191319.1209821-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is just a subset of the initial patch series [1] adding networking
support for StarFive JH7100 SoC.

[1]: https://lore.kernel.org/lkml/20231218214451.2345691-1-cristian.ciocaltea@collabora.com/

Changes in v4:
 - Rebased series onto next-20240125
 - Added R-b tag from Rob in PATCH 1
 - v3:
   https://lore.kernel.org/lkml/20231222101001.2541758-1-cristian.ciocaltea@collabora.com/

Changes in v3:
 - Optimized jh7110 resets & reset-names properties (Rob)
 - Added R-b tag from Jacob in PATCH 1
 - v2:
   https://lore.kernel.org/lkml/20231220002824.2462655-1-cristian.ciocaltea@collabora.com/

Changes in v2:
 - Add the missing binding patch (Conor)
 - v1:
   https://lore.kernel.org/lkml/20231219231040.2459358-1-cristian.ciocaltea@collabora.com/

Cristian Ciocaltea (2):
  dt-bindings: net: starfive,jh7110-dwmac: Add JH7100 SoC compatible
  net: stmmac: dwmac-starfive: Add support for JH7100 SoC

 .../devicetree/bindings/net/snps,dwmac.yaml   | 11 +--
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 72 +++++++++++++------
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  6 +-
 .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 32 +++++++--
 4 files changed, 88 insertions(+), 33 deletions(-)

-- 
2.43.0


