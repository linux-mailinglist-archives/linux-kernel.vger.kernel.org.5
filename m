Return-Path: <linux-kernel+bounces-152625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B0C8AC1B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D141F21027
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC1746558;
	Sun, 21 Apr 2024 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fa4Eqt0r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC52746441;
	Sun, 21 Apr 2024 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738576; cv=none; b=bq3KZkyNnRJb9NEtLb/6ZBclR+X7wSC5AP0NAzSJ/nDSRFC/PBG6s8Lcp5cLwuUjGER7D475UMqvbH6lIpBieStlNAhnAm9KyPOSG03WQXIxQmQsxtgMuIkDUKf8phim9XiiWLV/m6SBrYB7rY0a8rKkm611breitS/gq2WYEdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738576; c=relaxed/simple;
	bh=6XVpcxeckTk1DXaAZ0OyOE5BP3T7lQ6rvs7nNWoOeJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byay7UmNoruaLVzmEpYA0o3zPfs+qO/SjjR3uVqwE9OlcJJ8K/wvyzTFuO/qDhJ40QgV68Cki1wFPQGwv6gVVL8BOUVws/h75EcXTxaL21ssm0TuFHzG9xv96tHyD/mOFxriPV7FWFyMRxvC+XlN1c10GarkEPz5TrebxBfISjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fa4Eqt0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EDBC113CE;
	Sun, 21 Apr 2024 22:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713738576;
	bh=6XVpcxeckTk1DXaAZ0OyOE5BP3T7lQ6rvs7nNWoOeJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fa4Eqt0rTbAOHYGo6wHoe3KPTFjRUTobcSjc0zMzbuG4rKTQ3VzpvAJmzr8VhAG5F
	 WtVU1FKJ+fijsHu4MidXUUX39Xzp8f5LCBWYSMbc6qDEVEPhdBoT4QkvdGxEp6i2PY
	 +y4LQIPRakTRtIpmSeUHB5aLXiy3d6jG9WOliUVY9zMJ0UbkAevVrh6zJP1k4ryMzo
	 Sfsi3pJjgRjWdZZXanQOc4xCoUV22nfzL6WjfBhJpgZ1KD+6XHcYkMToemU4pWTXjK
	 WpvhX0n3ZO1g1WuDP+WvbBqfHBk7YG+ah1qDAAbNafrNctlMG0IEQSnT+iMeMNzowZ
	 fq62FYtRrXIow==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH v2 0/2] soc: qcom: pmic_glink: fix client handling
Date: Sun, 21 Apr 2024 17:29:10 -0500
Message-ID: <171373856755.1196479.15193091525751594267.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403-pmic-glink-fix-clients-v2-0-aed4e02baacc@linaro.org>
References: <20240403-pmic-glink-fix-clients-v2-0-aed4e02baacc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 03 Apr 2024 06:10:56 +0300, Dmitry Baryshkov wrote:
> Fix two issues with the way the pmic_glink driver handles its clients.
> First issue is mostly theoretical, while the second issue can easily be
> reproduced if the drivers are built as modules.
> 
> 

Applied, thanks!

[1/2] soc: qcom: pmic_glink: don't traverse clients list without a lock
      commit: 635ce0db89567ba62f64b79e8c6664ba3eff6516
[2/2] soc: qcom: pmic_glink: notify clients about the current state
      commit: d6cbce2cd354c9a37a558f290a8f1dfd20584f99

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

