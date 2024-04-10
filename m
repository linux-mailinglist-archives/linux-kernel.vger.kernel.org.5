Return-Path: <linux-kernel+bounces-139094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DA889FE94
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27E0FB2BD72
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7038717F36C;
	Wed, 10 Apr 2024 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXmi1ZgJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38C117BB2D;
	Wed, 10 Apr 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769986; cv=none; b=hrE2gKd186dqFfMpaQjRKIOog9sQhOIn0X+3odoGRRD8AegWclv02kjyPPaKkf817mwvcC1JpkCXb/KEK2cXRslFbXzra/HnGY0WMvCpF/OswqQWbGurF/Uak9mFSEjwMaVs0fcUXCs0/H66jhbvfpdHQz84TSkhIhPHEbcuJvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769986; c=relaxed/simple;
	bh=7oHK6s4i3cvHhuJkFOrbb9FT3TDWKEOZ2hlMIcUo2wA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eQmq7PPkYLbQgTitMPq4Rfjbu6aNdC+MgTYcNCIMNEQidclUz/mo2V9EBdahKVPUVGk4q90RTiwGIMmqQ3164GJs/MosL5JhY0C1HnEzKl8HjlbAAUUfFC2WINqaTYkK8SD39Tyo8sKGDA45dL+t4KTC8OyGKlkxE4aI9ngKTnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXmi1ZgJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20792C43394;
	Wed, 10 Apr 2024 17:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769986;
	bh=7oHK6s4i3cvHhuJkFOrbb9FT3TDWKEOZ2hlMIcUo2wA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kXmi1ZgJ5nPVxrt7kA/96YNgUb7yik+VKaJT4mt9gXfM6fii/V3dryu5y2Mm8xmsw
	 rIbNCWR/nJBhDhxsIqQK1vQ0Gpa4hzoHwZBr6FHbZvV5jA96dJHE32FuoAK1kwKbuM
	 BYnI4Ol9q1y55WAqhN8AKocoFHUHFPZsOtMLwb+azF2ZPEmmWoiLkI3s2me/ot/U/r
	 dakoV8Q+96B+VSrx1/VqgqCJCGpbTCRbju+NdcizzL2qPJWxBKV1le4p4diG0VU3zC
	 gM9eoNfWGUHOSweTemZRx78hLZd0LKrIfXqwMTQnwTlW3D8ErP+TSvZ9EeCeNXP+D3
	 ZGaWkaxhdJFZg==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Robert Marko <robert.marko@sartura.hr>,
	Luka Perkov <luka.perkov@sartura.hr>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] regulator: vqmmc-ipq4019: fix module autoloading
Date: Wed, 10 Apr 2024 19:26:15 +0200
Message-Id: <20240410172615.255424-2-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410172615.255424-1-krzk@kernel.org>
References: <20240410172615.255424-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/regulator/vqmmc-ipq4019-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/vqmmc-ipq4019-regulator.c b/drivers/regulator/vqmmc-ipq4019-regulator.c
index 086da36abc0b..4955616517ce 100644
--- a/drivers/regulator/vqmmc-ipq4019-regulator.c
+++ b/drivers/regulator/vqmmc-ipq4019-regulator.c
@@ -84,6 +84,7 @@ static const struct of_device_id regulator_ipq4019_of_match[] = {
 	{ .compatible = "qcom,vqmmc-ipq4019-regulator", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, regulator_ipq4019_of_match);
 
 static struct platform_driver ipq4019_regulator_driver = {
 	.probe = ipq4019_regulator_probe,
-- 
2.34.1


