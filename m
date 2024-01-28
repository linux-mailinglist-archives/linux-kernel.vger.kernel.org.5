Return-Path: <linux-kernel+bounces-41856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E2F83F8B5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9141C21B53
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCBA4C62A;
	Sun, 28 Jan 2024 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpFb5uSY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CBE4C60B;
	Sun, 28 Jan 2024 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706463969; cv=none; b=CBWsYL9AJibCf0kbxW9UlfBmP8HjiVaTrtBcwaH0ohRoz2r19zl7PeLbuJcug5wp2zHXnjM6hbBc4njnArNgbGhei+VXHvaOEAh2F54E0WFa/aWZs7BaBapHznA81FCJkN3u94pHuI8bt0c/BWqomSySKTc5/l2pr5A4SHAot3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706463969; c=relaxed/simple;
	bh=kPoqfY9K78eerpaz+5IEw5d038Vg8EM4N2U9dT+Jg+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yc8gRnWQWlN8uomcDa2n9nlNnz46DQMSZ/U0YkTZ3iNDFOMwT2mUgmC1oVufeVT4/+9YghG+B8kRL/4W8ZUFHGDODRrQOWauNyV3mJfSIQu5dumIVVdk9G+skb5unN5Bm/udpP6US9rETIf8LrCEsgqm8PN3WXFjAksFkx6qXsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpFb5uSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F0EC433C7;
	Sun, 28 Jan 2024 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706463969;
	bh=kPoqfY9K78eerpaz+5IEw5d038Vg8EM4N2U9dT+Jg+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZpFb5uSYe3ZaQubiOpkh6P4No+W8WlTjM+sivoKwZO+hSMN/cgiFW9VFKjfmMzCgW
	 b3DaV9aOaEA6s2VEZWMvHQ1E4RKFnsjQYqWXxJIeWX0MM9G8LHJiKA3kQE/BtiWG8R
	 3i4DnLOUz3MMvn6uFRopnMnUCX86gaRnZU0ZoQgBnmUFfwbY90zVUFTVtR1trpzYEL
	 jgH+mM53nvb5yy06VaJV/KHlGx/N0bOjWuNHuLABhLHaKW0IP9xVL6PzpArOgBTKYl
	 A9v0LOrSd0jNU0C1SlSIBfbH4J8M3qgW+QjqbiW0zFYlLpVVLR7uYiRK3MEPovpgat
	 v4m71ZDK6UWzQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>
Cc: kernel@quicinc.com
Subject: Re: (subset) [PATCH net-next v9 2/3] arm64: dts: qcom: sa8775p: enable safety IRQ
Date: Sun, 28 Jan 2024 11:45:51 -0600
Message-ID: <170646395040.64610.3852658876222651330.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110111649.2256450-3-quic_jsuraj@quicinc.com>
References: <20240110111649.2256450-1-quic_jsuraj@quicinc.com> <20240110111649.2256450-3-quic_jsuraj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 10 Jan 2024 16:46:48 +0530, Suraj Jaiswal wrote:
> Add changes to support safety IRQ handling
> support for ethernet.
> 
> 

Applied, thanks!

[2/3] arm64: dts: qcom: sa8775p: enable safety IRQ
      commit: 7e4ed7db95279d37e9934e30d84bd7335d0a224b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

