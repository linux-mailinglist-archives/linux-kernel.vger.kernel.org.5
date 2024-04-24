Return-Path: <linux-kernel+bounces-157380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EBA8B10D6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DAB1F25D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B53016D4F1;
	Wed, 24 Apr 2024 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="ixctkXiQ"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C98915E7E9;
	Wed, 24 Apr 2024 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979320; cv=none; b=BCu6jvFvaCb2brhJgaqeB09DRy/rFi5FYn55/np7z/s8vWGxTHPte/v8KuIDYhLfLJ8Fuj1cPtqa9jlQDWfDbV7K/a0Q/E7di6bWm61QMUiUrqni6NJEifrflw+J5Yl0U/cLIltDljRhTXr3HymBuVEb4++sxtsAqiBdwY4Xe+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979320; c=relaxed/simple;
	bh=XpEmF5NrYHWlUdqf2Ekgejd6UqOWMp+Xvsdh90tMXtY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Idu2Nk/z/jU0ZVTbAKjuaJXt+1rOwwjbJP/42j3M3nhpn8bBvqM1msHs2BxqjjbEA/X5+W71XqKytUaTIX8DjRThMDJ/F7NCVWEa3AbQSXVsEz0sGEfbGZnTPpRc2T/YUxdOGRHYnxsy8Aei+KX7LwDb/fs1JgbRO+0aI31ePxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=ixctkXiQ; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1713979317; bh=XpEmF5NrYHWlUdqf2Ekgejd6UqOWMp+Xvsdh90tMXtY=;
	h=From:Subject:Date:To:Cc;
	b=ixctkXiQxNkfMGNL9M3kgzKjJD+ce868et17NWNH3W/vzzSDrsIsahWwUFwJOm06u
	 KcOJB11QRiOwPDMbu9QDBXwJOcRhlyjJgF7aLEwhGO4xepIyPEKAZkHEDd30EFDDPM
	 ogRHVFaNCTG7tS4mlzRgHt6/uOXU02qd+46XsqDo=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH RFC 0/2] Support mailbox interface in qcom,smsm driver
Date: Wed, 24 Apr 2024 19:21:50 +0200
Message-Id: <20240424-smsm-mbox-v1-0-555f3f442841@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK4/KWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEyMT3eLc4lzd3KT8Cl0DMzOzNGPT1MRUExMloPqCotS0zAqwWdFKQW7
 OSrG1tQA5HkRGYAAAAA==
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=XpEmF5NrYHWlUdqf2Ekgejd6UqOWMp+Xvsdh90tMXtY=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmKT+yz2easagHF2UMvf0ae2B3KYiAfDUdFZAik
 BFcnzKiTpqJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZik/sgAKCRBy2EO4nU3X
 Vod1D/9zjpmXjqw4EPuOOo9qFWxej1vk2AhH38D5+5gKdreJLdaWnoxYJLV69oeqGJmDSmVPUu5
 I+HLJVPrxH1BhA6bJF8Hraxx4PRKlmPDb56hK43NGff+QJmPhOiGZu7U8AQHSeXH4bu+m78OS2Z
 2eK1aJTephDNJBxejVmOZDb5cZnSepYF2ZsodxlxvpRNLwN0qEvnOm0eNqOnw8B/2JOOVaeMm7o
 y4J7VMySvBHh4QMuYlG4RuH3ezNdGXS8T6y9AmYkqx2Invx4KD612sGVHcIOW/fiZsmq2LzIFp+
 X4dmcrsLvZJ1Izn7yDBpy7Ma3lY4Nd3SWTk+I1cnyoWlezltg3xAsR6TrNODplL/kCZI8W5x904
 puA4kHbYyeF1BR6951sRvQ8+jgKOGas+ZJB/5Yx8pX8HacXBEV5jHWi0BR+tzh2M6hF7eUuWwV4
 dmo71zd5MdEoD0i0O4tVVJbAh3gVhftHqCI/k5332qe3eVpbPPOgfC2a6IIypK/ysAqCE+7fNhz
 h2JXuyqvLdu5TtzYluUm7RvAmCRmjDp8D61w593M2ykfPMX0R52eJ3IsSDkBVhWVggHZagKTvfU
 /yMEWy9LOFk0M0PtNL9DijwpsjxSeWJBWb/aYIegHcKOjk3KytNn9q+01U3AFuEaFnmDUNHESfw
 Y6Dl+8SMpF5sFxQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Take a shot at converting the last driver that requires direct
"qcom,ipc*" syscon references in devicetree by allowing the smsm driver
to use the mailbox interface to achieve the same effect.

I'm not very happy about how the devicetree change looks in the end.
Perhaps it's better to use mbox-names to not have <0> elements in dt,
and reference the items by name from the driver?

e.g. this change for msm8226 could be represented differently.

-		qcom,ipc-1 = <&apcs 8 13>;
-		qcom,ipc-2 = <&apcs 8 9>;
-		qcom,ipc-3 = <&apcs 8 19>;
+		mboxes = <0>, <&apcs 13>, <&apcs 9>, <&apcs 19>;

vs. for example:

-		qcom,ipc-1 = <&apcs 8 13>;
-		qcom,ipc-2 = <&apcs 8 9>;
-		qcom,ipc-3 = <&apcs 8 19>;
+		mboxes = <&apcs 13>, <&apcs 9>, <&apcs 19>;
+		mbox-names = "ipc-1", "ipc-2", "ipc-3";

But also here the name with 'ipc-N' is probably not particularly
fitting?

Please let me know your thoughts and any suggestions.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (2):
      dt-bindings: soc: qcom,smsm: Allow specifying mboxes instead of qcom,ipc
      soc: qcom: smsm: Support using mailbox interface

 .../devicetree/bindings/soc/qcom/qcom,smsm.yaml    | 48 ++++++++++++++++----
 drivers/soc/qcom/smsm.c                            | 51 +++++++++++++++++++++-
 2 files changed, 90 insertions(+), 9 deletions(-)
---
base-commit: ed30a4a51bb196781c8058073ea720133a65596f
change-id: 20240424-smsm-mbox-0666f35eae44

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


