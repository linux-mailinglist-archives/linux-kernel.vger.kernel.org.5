Return-Path: <linux-kernel+bounces-22803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E9A82A314
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30CA2825C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019A14F8B8;
	Wed, 10 Jan 2024 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fATdJl5O"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F2A4F89C;
	Wed, 10 Jan 2024 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704920900;
	bh=noDFINTUJw7LAeahmfm3fQbOwo432AdB3LzyaJ+7kRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fATdJl5Obq39/BQX/tzMPIr9P1qEn2ATIxmvZ12H1B7w2KNZ6XkA7mq7STR8tszwD
	 3VsWoUuKq+O4JRpj38WWpljzEGFDwHwGMH0H1LDrYS0tGZv+yvTro8mk9YVbXV0map
	 XK2UdZ/Ryu7R9D/bq8Eh8GHSdPmnOSmtOFTF96mnnXo7+SHPxGEo2+e+284jSOK0O4
	 /qRyBTuDTz9FaESOA6TqXMi07k5A8B+0PInSYOLB8X3OEZHQJ8XahsKWyNGIdydVuz
	 f2fxWMe5elCLj8EYlhErwL5SOqLMtHj/Jt1weedGa1IhePKoncPQZmCJQ5xySYeaiP
	 EaE0Bv9x0wC+g==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E6D8D378148C;
	Wed, 10 Jan 2024 21:08:13 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Kees Cook <keescook@chromium.org>
Cc: kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tony Luck <tony.luck@intel.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: defconfig: Enable PSTORE_RAM
Date: Wed, 10 Jan 2024 18:05:03 -0300
Message-ID: <20240110210600.787703-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110210600.787703-1-nfraprado@collabora.com>
References: <20240110210600.787703-1-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable PSTORE_RAM, that is the ramoops driver, in the defconfig, to
allow logging and retrieving panics and oopses to/from RAM automatically
for platforms that have a ramoops reserved memory node in DT.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d48659217bb4..0b0ef6877a12 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1589,6 +1589,7 @@ CONFIG_HUGETLBFS=y
 CONFIG_CONFIGFS_FS=y
 CONFIG_EFIVAR_FS=y
 CONFIG_SQUASHFS=y
+CONFIG_PSTORE_RAM=m
 CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
 CONFIG_NFS_V4_1=y
-- 
2.43.0


