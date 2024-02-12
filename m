Return-Path: <linux-kernel+bounces-62256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E90E851D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239531F2325A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC7546B9B;
	Mon, 12 Feb 2024 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="am4SrgKM"
Received: from smtp47.i.mail.ru (smtp47.i.mail.ru [95.163.41.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF63F3EA78;
	Mon, 12 Feb 2024 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707765064; cv=none; b=b/1a03YvwpaeJ2PUDmPRiPVYa0jUsTLurV+V+I8WkEoB4MbA+DmD2Hv0L+eZ09nbfysbd3slEcA6QKQSckEyxFvCXDTslBVmT7eoZw2ppyrOTaRfGDiu6/5dV75yTsLBzIDPzw8X+7xU5B/WAkCZD0nuaxPD+kCjKyv99EbJLmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707765064; c=relaxed/simple;
	bh=pufIjUalkJOUuQI62GHNy6tzjDh11aWkPFy25ZLPkFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tcOvKY+6U8Lv3BiYsDskue/SXnoY/GdpBTv1n1nvWfuOxYLqKqpjhPzScngTqPcu7JUu2HpecipxVIzuVZuIT/cFKDcXFrPlCSFoDhFmu2/iRw6q/OqREA3U4ckWfnrkKQVTJMQ68NmsZXkCsRHky16ETQeCJKCJaChvn4r0fN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=am4SrgKM; arc=none smtp.client-ip=95.163.41.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=iA8Wl86EoCHuOnRPeH06uMKkPJEBJBHggtb9rh5PkDk=; t=1707765059; x=1707855059; 
	b=am4SrgKMucsMThX9flRVPLmqOKl188woWGZyi4cyFYL1U1R+6onpkdKhUzzhHR5tSUmuI6sInMC
	Gt7+2IkcfUvpOh6HB7j5Uy4KuMY8tfgF0sOqAnzocCo8hR5vbVRpaCWRZ3jc5ukjzoNPNlxOpGHeL
	mygwZNhOnhjerd9Lido=;
Received: by smtp47.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rZbhY-00000006gZh-2skK; Mon, 12 Feb 2024 22:10:49 +0300
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
Subject: [PATCH 0/2] pinctrl: qcom: Add SM8475 support
Date: Mon, 12 Feb 2024 22:10:44 +0300
Message-ID: <20240212191046.77013-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp47.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD96201AD55A1C8F7DBA68A15D1D35E5CC5CF7D7F77DA5535F2182A05F5380850404BAAE315F9C669162EB5D77EF37489D1A8A3064AB119E1FDE51B3825F593DFF20C8629FDE0E8EB2A
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7BCC85671EC7A750CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063702DFA59B3C994360EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B73AB1701401CD8718E4E89096DE07AD7FA8D73926623C3E3AA32EDAE551AB609A471835C12D1D9774AD6D5ED66289B5278DA827A17800CE73CD73D99384BA5CA9FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C3A367EA73E0D98AAD117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CFFFA21EE48555ABE0BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B6922E583744E2C36876E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249957A4DEDD2346B42E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B690A324785FE7B950089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-87b9d050: 1
X-C1DE0DAB: 0D63561A33F958A558C1EF4E60FD35075002B1117B3ED696EC0DA9C4757FAEBFAD0703CEB2EF9A27823CB91A9FED034534781492E4B8EEADC3194D76C41E9723C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFD41107F383D4208A08443702DC345A5AE3975F14A4B398A39D1AEA5FA8D32351673DC415E80A8BD9233AFEF422F2DFF9F6B0B1ADEAF281FA5D44EE695255846BFD7CDB12671657C842BF32D1DA1046D202C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXiSGYHknyUbxBfnTB+P1lvX
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981983862166B642228ED188C5D0CCD93D4A95D4247FF2147493A3B37D2368DB9712C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

After comparing waipio (taro) and cape pinctrl in downstream, I found that
these are the only differences. Let's just add this as it shouldn't cause
issues on the SM8450 instead of writing a separate driver.

To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>

Danila Tikhonov (2):
  dt-bindings: pinctrl: qcom,sm8450-tlmm: Add compatible for SM8475
  pinctrl: qcom: sm8450: Add pll_clk to pin group 98 for SM8475

 .../devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml      | 7 ++++++-
 drivers/pinctrl/qcom/pinctrl-sm8450.c                      | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.43.0


