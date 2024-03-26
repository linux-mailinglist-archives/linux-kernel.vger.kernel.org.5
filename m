Return-Path: <linux-kernel+bounces-119108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C22CC88C44D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE771F21A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BF87866E;
	Tue, 26 Mar 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4IrpKc2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1023F757F9;
	Tue, 26 Mar 2024 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461693; cv=none; b=ffu1OgJ3IM/4y+4XkK2Ewda+LW6zdUsL3LvpTBQi9s6liWCRh/a5/Qoehe9kXqR5AE0Ry4rHW5chg0P7JbVW4QlEu+6TkQ/Mv109H6rN+laYL+O9yIue4/Z8ysKT7eNTEW6Tf3R93lLPosrFyqnaZuVgliMEB0MvjrnFFLM5la0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461693; c=relaxed/simple;
	bh=p+neOEhyWFphQhEik04O1urueBIxb2LuKNjZUh6Stbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUt5Li8bXQSQu+hEIf2chfzwzBEDMlJv3dz6zlIgclnJ+o2tjbNgUPYjJE3C1u7ZahPu9kWln0G16fxKPVVuwpEj3VUvrTTYEOkedmXSm9XXv94o3HMvMlwzbhEJXtf1OGx0szh7oDUTCsTIDWv5PgopIkVNQ85/2l2jY7D9muM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4IrpKc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E239C43390;
	Tue, 26 Mar 2024 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711461692;
	bh=p+neOEhyWFphQhEik04O1urueBIxb2LuKNjZUh6Stbg=;
	h=From:To:Cc:Subject:Date:From;
	b=u4IrpKc27wjvhL8s1IZu9fX2qsZAGyeifmsxwJPicGBy6UXtAZy2hhKH6VPUKSbxy
	 6eB76/hcljUgXwh/uK6XQqGUVNqpzKBmnueNax7ANv1YwV7i0iwhQ0LokGBe94yyuE
	 x1HCEADMgnuqX0UUOuvHTdtosZL/tPDwqQKWrMDWbq+sghjUDb2VaOOgE36VNF7cCM
	 hzl2KL/7xR0GcEcpLeug3XG9RVOKSND5xfE2HJfQgFMbUfmDBK7SAGjEZnBlrA4yQt
	 yGYILrbzfMlagwnRpFPxS3a3d7hg3+sgpaF8WFvab1SaltwBnMHlIPXCV4JAXyOOZw
	 2aN2/u9g2Vpww==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rp7My-000000005Yn-2fq0;
	Tue, 26 Mar 2024 15:01:40 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/5] clk: qcom: gpucc-sc8280xp: fix GX external supply lookup
Date: Tue, 26 Mar 2024 15:01:03 +0100
Message-ID: <20240326140108.21307-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SA8540P platform is closely related to SC8280XP but differs in that
it uses an external supply for the GX power domain.
    
This series adds a new SA8540P GPU clock controller compatible which
can be used to determine whether to look up the external supply.
    
This specifically avoids warnings such as:
    
	gpu_cc-sc8280xp 3d90000.clock-controller: supply vdd-gfx not found, using dummy regulator
    
on SC8280XP, which were introduced in 6.9-rc1.

Note that this also avoids triggering a potential deadlock on SC8280XP
even if the underlying issue still remains for the derivative platforms
like SA8540P and SA8295P that actually use the supply. [1]

Also note that this is a better alternative to simply making the
external supply optional as that would suppress any warnings about
missing supplies on platforms that actually require it. This series
therefore supersedes [2].

Johan


[1] https://lore.kernel.org/lkml/Zf25Sv2x9WaCFuIH@hovoldconsulting.com/
[2] https://lore.kernel.org/lkml/20240325081957.10946-1-johan+linaro@kernel.org/


Johan Hovold (5):
  dt-bindings: clock: qcom: add SA8540P gpucc
  arm64: dts: qcom: sa8540p: use sa8540p gpucc compatible
  clk: qcom: gpucc-sc8280xp: make cc descriptor const
  clk: qcom: gpucc-sc8280xp: fix GX external supply lookup
  arm64: dts: qcom: sa8540p: drop fallback gpucc compatible

 .../devicetree/bindings/clock/qcom,gpucc.yaml |  1 +
 arch/arm64/boot/dts/qcom/sa8540p.dtsi         |  2 +
 drivers/clk/qcom/gpucc-sc8280xp.c             | 42 ++++++++++++++++---
 3 files changed, 39 insertions(+), 6 deletions(-)

-- 
2.43.0


