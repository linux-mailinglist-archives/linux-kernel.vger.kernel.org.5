Return-Path: <linux-kernel+bounces-77001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC2485FFE3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A737828B8F2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DFE157E8C;
	Thu, 22 Feb 2024 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="BiO1UabS"
Received: from smtp35.i.mail.ru (smtp35.i.mail.ru [95.163.41.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F255E155A5D;
	Thu, 22 Feb 2024 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623786; cv=none; b=nMNH/5TsNEYKHPCIRkwqX0Z5XJIfMOKb2hAWeXQstbOGUXSS55aTKqGmZTAXkg050QBWYP+HwqnOHW7iYEEYXBdY5oh7soEXcrECu/u3LAYLgtJoIcdP6eH9rlexpw8l/1AosFlK76ASLfy3gvMCvuElC7ZYfpM7HcR7gh5VGVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623786; c=relaxed/simple;
	bh=WIVrwDsBbPzNaMTb/dnHv/LOTju4W7kM0gkxzAbBHjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kh02kaervwlX/M84H9C1vHgnRa2OxPGNK/VPZtGVGLA/8HQVxTlVOXlkjwt/5tkniIRY6SLxZP5lkNitjQAyDKKd1GyZ3Imsxms/iC2Xxm3bubEL+vI56R2G4yIOoNPBj98jnn/g983/huld2/Cyig8+dvk5Fs/vVlTQ+MztneM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=BiO1UabS; arc=none smtp.client-ip=95.163.41.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=1TenuOkcG5evzoXACnxDUOLvNvTUV6mwDyHgHdTFX6U=; t=1708623783; x=1708713783; 
	b=BiO1UabS3WtRHwzHu4jq4ZVGUYECgnHMUVqxYDATusNP3DUuvn+bRnJsyFZ/MDN5Ld9AHWzxFQF
	Zw2d6ViRaz76hbC5od3dhoRbNAWw1VGREahFUlwP4VKydrpU+lqzj285p4BpkuGXUoyBw0DbRuVyN
	8BFRUQhLkIzsaGGYEWo=;
Received: by smtp35.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rdD5x-0000000BMIH-1gOl; Thu, 22 Feb 2024 20:42:54 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	djakov@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH v2 0/2]  Add interconnect support for SM7150 SoC
Date: Thu, 22 Feb 2024 20:42:48 +0300
Message-ID: <20240222174250.80493-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp35.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9A0539DA8B638EEE24480D7EFA423187C2F2D41C068758ED8182A05F5380850404C228DA9ACA6FE275F91DB108F9063E233594132A326AF8B58F75731F803AB97B13BC05B40DCEAA5A7398ABDDC9FB8BB
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE72E2D36A15E1833D8EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063764BF1E09E94CC6278638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8EF89892920D8F9F2E3BE5448EA843F6215E66FA7512B0D92CC7F00164DA146DAFE8445B8C89999728AA50765F7900637A359038F01FFAF82389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC878444BBB7636F62AF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C6A1CB4668A9CA5FAAD7EC71F1DB884274AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3056D5A8E4C6B598EBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF17B107DEF921CE791DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3CD42BCEBB57B85E635872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5D26ACACEAAE7E4505002B1117B3ED6969193E638BD89DD93D57BAD45EC4C5DE1823CB91A9FED034534781492E4B8EEADF12279BA039A6965C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFD2B247E9CF04F14960109914BCFAB4729AE3539482CB76B6A0CA6D78E6D66DEADDCE95BB4BF576A60C89D780EEF94DBEEA0DBE6432E8D8EFDEAC876D50C401A62B426FFEA59737B1AF108DC32EA72A8402C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojjw0udeJQYBTEXJUu31OKJw==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981B30287F184E31E97BC5A20191D90C84F23187A5E454F60C90BEC391E8E0905FF2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

Add dtbindings and driver support for the Qualcomm SM7150 SoC.

Changes in v2:
- dt-bindings: Drop "'#interconnect-cells': true"
- driver: Unwrap qnoc_of_match entities and add a space before the closing
curly bracket (Konrad)
- driver: Use core_initcall instead of module_platform_driver (Konrad)
- Link to v1:
https://lore.kernel.org/all/20240218183239.85319-1-danila@jiaxyga.com/

To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Georgi Djakov <djakov@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>

Danila Tikhonov (2):
  dt-bindings: interconnect: Add Qualcomm SM7150 DT bindings
  interconnect: qcom: Add SM7150 driver support

 .../interconnect/qcom,sm7150-rpmh.yaml        |   84 +
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/sm7150.c            | 1754 +++++++++++++++++
 drivers/interconnect/qcom/sm7150.h            |  140 ++
 .../interconnect/qcom,sm7150-rpmh.h           |  150 ++
 6 files changed, 2139 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/sm7150.c
 create mode 100644 drivers/interconnect/qcom/sm7150.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm7150-rpmh.h

-- 
2.43.2


