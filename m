Return-Path: <linux-kernel+bounces-141427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311528A1E15
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70E81F231B3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D28417C66;
	Thu, 11 Apr 2024 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEd8xKdY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42436B08;
	Thu, 11 Apr 2024 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857726; cv=none; b=A/Cawb/QDszW25oDCxc71o1dpvrheU+L8ZZ4PXyBLFxwT3nlHd+n7oGU19BJambfKk2gXbg2Dz/T3vkgzefkKV3tbFygfoaD6MIRiqEBB7ajauGA3iOHlCbqMPjQpXhImnTPWajhvNhxRNM8rb21ZMHDQydh/lIZRUGAYe/VE/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857726; c=relaxed/simple;
	bh=9aJw8QoZy00PI1Vlq06euzR5zwJG7a7zFfna87TrmXU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FMRNjhRuuJJah9NQd+gO9jsBFsEsgoPkCeNxQz6gJrX2wOlBUekjq6cyljHxxGefXkc4iwlnGFuhZqCSiOXY8M/Qz0oBo6N1PMnYuDekwBai9WW0pgmn9iFPhgHScB9milVKdTWBrrPaeSy5wWjFyZLBbw+FwJTbuGLino7dkYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEd8xKdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B96C072AA;
	Thu, 11 Apr 2024 17:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712857726;
	bh=9aJw8QoZy00PI1Vlq06euzR5zwJG7a7zFfna87TrmXU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oEd8xKdYy3jH3o3gCDEyDn2ste+PUbngtTrUbUy1QuoIMk6Sv8L1uCxR6jZc2qLZG
	 PFBy0Y4DM+YNfPIj6B6dZhP2BIl/BxtZpX0CNhRH52BAW8JfJoz5cZYrotT8Bgvad1
	 lWlrk9zVfCKUk+vHEUUH1JZYsAEJnml+0AjMKP4gWOAph2F7a/QkLy5zoM6QVSZYIi
	 KqpZGc5hFuJ7Gm957Y2Px11Rszgi6amml5yYH1j5xMmF8/mxKWWE0I1SNC0qHFovi+
	 SrnJhTWbwd5OEbf3qXN9lXpfmbTMv3emCDAwGNWUmrNTGfjBY0WH/9q71F6cEjUYCo
	 8q6gH3YDRJ6LQ==
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>, linux-arm-msm@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
In-Reply-To: <20240403132716.325880-1-krzysztof.kozlowski@linaro.org>
References: <20240403132716.325880-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RESEND] soundwire: qcom: allow multi-link on newer
 devices
Message-Id: <171285772329.544231.15578305335747563968.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 23:18:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 03 Apr 2024 15:27:16 +0200, Krzysztof Kozlowski wrote:
> Newer Qualcomm SoCs like X1E80100 might come with four speakers spread
> over two Soundwire controllers, thus they need a multi-link Soundwire
> stream runtime.
> 
> 

Applied, thanks!

[1/1] soundwire: qcom: allow multi-link on newer devices
      commit: ce5e811e069168898ae2ff02a90de68637ed7dc4

Best regards,
-- 
~Vinod



