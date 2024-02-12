Return-Path: <linux-kernel+bounces-62257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F341851DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D748B1F24E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C17A481B7;
	Mon, 12 Feb 2024 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="iOKhKaEO"
Received: from smtp47.i.mail.ru (smtp47.i.mail.ru [95.163.41.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EC04596E;
	Mon, 12 Feb 2024 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707765067; cv=none; b=hEwJDEmez5HuVLMPLiQ7a2eRQGcOrm1tjnK6VV336vJljcmJgCg5YceVfKxNl+5a6c/JyTgiAxb2z7ZSZbiSkD/Lda+qE0mpBpLuNrTf5/xvuNTu6EykBaD4xGXSL5zfPFIAKpJXEC4fRGV6vgvEh3cpiNwti/STMd/V1D3Y9ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707765067; c=relaxed/simple;
	bh=F6luEYIaTSAkrOcTBt+ARmZuZydYyQ7t4z09gM3I7JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROs+bx0GD7EyQOH5cUdrqd/9vZIbfOx5y6IO4WuGy5v9Fu/EsWKncaIoN/I5yTiSrfBgOu/KefTNThPDWY5A+RP0Q1yU0TEgrMen8+pcBuvdcNPXod4JPMu7/FzcvKAFfkKtHSaJO2VyzuMaszK2kZSe3sQeyOX19/TN3hJvrxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=iOKhKaEO; arc=none smtp.client-ip=95.163.41.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=OY1uDnbX5zsfBR8YEJfJsduikAiYEld5Wg2jUIrZZPU=; t=1707765061; x=1707855061; 
	b=iOKhKaEOr9NjERI2qSYgHMVXQdDfi3nBg5jSRgnc8pEwviBAC/L73/diOvp/k+aG0jrzkb1dJtO
	JRjE5t3MdpbZ+EhV8VjR5DaSJMXN9Zf0BjT+wN/s16LAyIA2vjDguZigTWtaBCdE/HluSxaOBP+YA
	Zgvg8sEkqvCh28q70rs=;
Received: by smtp47.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rZbhc-00000006gZh-1Kxn; Mon, 12 Feb 2024 22:10:52 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	linus.walleij@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	vkoul@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 2/2] pinctrl: qcom: sm8450: Add pll_clk to pin group 98 for SM8475
Date: Mon, 12 Feb 2024 22:10:46 +0300
Message-ID: <20240212191046.77013-3-danila@jiaxyga.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212191046.77013-1-danila@jiaxyga.com>
References: <20240212191046.77013-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp47.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD96201AD55A1C8F7DBBAC036D50690886005017D7DFF4CC2B7182A05F538085040E77BE5391BA0202B2EB5D77EF37489D1A62B0989FE57A36EE51B3825F593DFF22B0BC4687570E331
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7544B1CCE26E01C74EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637E149C29A36E092738638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D82B81A79E632A6A5B6F91843850D5FF6A55C8D6C5E6BBFF8ACC7F00164DA146DAFE8445B8C89999728AA50765F7900637A7F6C2AE60409FEF389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC882B967D547A19D2FF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CCF7CD7A0D5AA5F2503F1AB874ED890284AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3FF13C91C9B60D64ABA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF17B107DEF921CE791DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C30AD616FF17A999CF35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-C1DE0DAB: 0D63561A33F958A5FBC5FF506208C50D5002B1117B3ED696217FA40ECE3BBC1E54BB1175C6E7DD94823CB91A9FED034534781492E4B8EEAD85CCBA673D36D1A4C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF1D21BD3B795911A3F12235A73B6A52E2BDD8544A59BB600B70FCA418E1C632388657CCA151A12AF5233AFEF422F2DFF9F67683D4860108565D44EE695255846BA35D2239673AA59642BF32D1DA1046D202C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj1UUEhvrYbM2VTK9+NJrm2A==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981983862166B6422287FC47A557B39A39B8EDB258A799B3002B5E3F83EFC32AB642C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

Add pll_clk to pin group 98 for compatibility with SM8475.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 drivers/pinctrl/qcom/pinctrl-sm8450.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sm8450.c b/drivers/pinctrl/qcom/pinctrl-sm8450.c
index 617286711695..45ac8e72c1c7 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8450.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8450.c
@@ -957,7 +957,7 @@ static const char * const pll_bist_groups[] = {
 };
 
 static const char * const pll_clk_groups[] = {
-	"gpio107",
+	"gpio98", "gpio107",
 };
 
 static const char * const pri_mi2s_groups[] = {
@@ -1511,7 +1511,7 @@ static const struct msm_pingroup sm8450_groups[] = {
 	[95] = PINGROUP(95, pcie0_clkreqn, cmu_rng, phase_flag, _, _, _, _, _, _),
 	[96] = PINGROUP(96, cmu_rng, phase_flag, _, _, _, _, _, _, _),
 	[97] = PINGROUP(97, cmu_rng, phase_flag, _, _, _, _, _, _, _),
-	[98] = PINGROUP(98, pcie1_clkreqn, phase_flag, _, _, _, _, _, _, _),
+	[98] = PINGROUP(98, pcie1_clkreqn, phase_flag, pll_clk, _, _, _, _, _, _),
 	[99] = PINGROUP(99, phase_flag, cri_trng, _, _, _, _, _, _, _),
 	[100] = PINGROUP(100, cam_mclk, qdss_gpio, _, _, _, _, _, _, _),
 	[101] = PINGROUP(101, cam_mclk, qdss_gpio, _, _, _, _, _, _, _),
-- 
2.43.0


