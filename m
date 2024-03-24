Return-Path: <linux-kernel+bounces-114508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CFF888AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A701C29102
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B192318146D;
	Sun, 24 Mar 2024 23:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssergmit"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B8F149DF5;
	Sun, 24 Mar 2024 23:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322140; cv=none; b=J0waVERVMdCMzvg3rFQc25wFJ0hGtFpQI3TD1VSXF+t0H+9ia8XSFUgfLGwPJxRvKz1MtY2o+bP6f/fUwpagmZVR0yV8LyohtKolKIpLMWI7jCvbg02u3VgSQSxGdTk/IYIQp8MOc0IaxRHTRMWTfdNQzk7h01YtMb3ilhqAztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322140; c=relaxed/simple;
	bh=X9MIaMx4/X/hpsf2k8Bfn4ehDYLzQVMVPWQEQv9aeww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwykwVoFnamEurz4fQLa+gMXtNc/baP9QDx74LD31eOeNYmKRHxE3zCd19Up6Htb2tKBljHAMx0xQHR/RG2fZQ8u4I/rYZB2dUHv+CbV4MhXgQMwB2tDkiv4ILDpigLMGpusJDU+93p/hF1mGuHGMEFu3IulkH+N81T0+FqPbrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssergmit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09751C43394;
	Sun, 24 Mar 2024 23:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322138;
	bh=X9MIaMx4/X/hpsf2k8Bfn4ehDYLzQVMVPWQEQv9aeww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ssergmitX1PN9aZG6AuFg7249sjBSlgZ5KU8k4zCsJbjxBcCKcWM1fImMUEITeCub
	 aPB7K9IFS2CEB5EjhY9NoPwhXMFh/xPFhU3YqpGq79atSXsClgwzsY6smqxcwi20NR
	 LhuTcrtiwsWsRRaxp7u6mf1nKEdepi47u8LuDVGA1Qfj945nJaE3ANW1DAc/EHl1T3
	 0B9kOZAFdL2QQqjXXZMBV+Vow2Ulpt9pt1D0HIbo1Ci6HCh//veC0tGaIcGGsLtM2v
	 rU0ufrzsEvRbZKvaiJPBNCzTs6ejGycq/RZOdRtgtUupz5JhQZrK1OEjAPPXfoIVdE
	 JYoMGJqxhdL4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?K=C3=A9vin=20L=27h=C3=B4pital?= <kevin.lhopital@savoirfairelinux.com>,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 215/451] net: phy: fix phy_get_internal_delay accessing an empty array
Date: Sun, 24 Mar 2024 19:08:11 -0400
Message-ID: <20240324231207.1351418-216-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Kévin L'hôpital <kevin.lhopital@savoirfairelinux.com>

[ Upstream commit 4469c0c5b14a0919f5965c7ceac96b523eb57b79 ]

The phy_get_internal_delay function could try to access to an empty
array in the case that the driver is calling phy_get_internal_delay
without defining delay_values and rx-internal-delay-ps or
tx-internal-delay-ps is defined to 0 in the device-tree.
This will lead to "unable to handle kernel NULL pointer dereference at
virtual address 0". To avoid this kernel oops, the test should be delay
>= 0. As there is already delay < 0 test just before, the test could
only be size == 0.

Fixes: 92252eec913b ("net: phy: Add a helper to return the index for of the internal delay")
Co-developed-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Signed-off-by: Kévin L'hôpital <kevin.lhopital@savoirfairelinux.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 944f76e6fc8eb..45b07004669d6 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2893,7 +2893,7 @@ s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
 	if (delay < 0)
 		return delay;
 
-	if (delay && size == 0)
+	if (size == 0)
 		return delay;
 
 	if (delay < delay_values[0] || delay > delay_values[size - 1]) {
-- 
2.43.0


