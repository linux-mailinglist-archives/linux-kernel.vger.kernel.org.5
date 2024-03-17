Return-Path: <linux-kernel+bounces-105471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8279B87DE7A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 17:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82AA21C21108
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B271EB5F;
	Sun, 17 Mar 2024 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnr+K96M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD10E1E886;
	Sun, 17 Mar 2024 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692849; cv=none; b=UF178sER21s6BxdIqb2F+CevhG2U2aWxlckvUiULgXoWd3MXXsQcyt19LS3VxQLU4EwsmeoHLyAI/BpZZ1VH9fAUqKMHZQPqhaZKmKQ5vmSqykBFb6SBCa5IdZESdbv6yqAGQOGhrVcEx2Yt+oqbVE+7F93ZE7nnNXQDuL7YOaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692849; c=relaxed/simple;
	bh=e1yrZg+3gGOIu/yZ8QcVOfLHJF4YsZ392kVTBBszooc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxLETndZPMK5e/i4uYXcZKLR1P0iArWo7pyc9JAPiAqhojW2la5IvnlY5zN1LlvUeYn1pkfH0oTRJaF7pruVv0KvVdKEc619eG2VxwTBrJcQQ+7ulx/4gxRNAJs1QP3yjv6ePFI6+vqzQzIIeXVM9CuTSfAtiVmAYBFbBVGbZQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnr+K96M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791F9C43399;
	Sun, 17 Mar 2024 16:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692849;
	bh=e1yrZg+3gGOIu/yZ8QcVOfLHJF4YsZ392kVTBBszooc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dnr+K96Myo0jBPVtCiJ+IQ5ep65pXBhz4KrYu8EYoCrVaG233TxDibQY8IcgwWvTg
	 5cW6UNQXfT1An3RZgly2TQkW2fjpoJbUZrInsctcvNj6sDQ32W6zpJlgmhLrkpROlA
	 L2e8KxVFKBbu65x77ZJJivXM0v1+iQEB5tDHHApaxm3nZ0HjsIVT81izzD+8f+7aKX
	 AtZn0nc/ePeQJrvqqMCBE7rYQvRmkbFjeXekKxI7ZRP9hQ71CPnzMtMcmTjodGB3SO
	 XZHNgQk4rOocXW645dH15ta2i7mjETjr+q3eAJPqk4EjDcq1M5oJwrvExLh75tfzql
	 d9x05Q3ygPR5A==
From: Bjorn Andersson <andersson@kernel.org>
To: krzysztof.kozlowski@linaro.org,
	konrad.dybcio@linaro.org,
	wangkaiyuan <wangkaiyuan@inspur.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: icc-bwmon: Convert to use maple tree register cache
Date: Sun, 17 Mar 2024 11:27:20 -0500
Message-ID: <171069283518.134123.993755796831857709.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240309072825.45385-1-wangkaiyuan@inspur.com>
References: <20240309072825.45385-1-wangkaiyuan@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 09 Mar 2024 15:28:25 +0800, wangkaiyuan wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> 

Applied, thanks!

[1/1] soc: qcom: icc-bwmon: Convert to use maple tree register cache
      commit: a8adf216136a16f8b31ece4455f60d59db3d6d62

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

