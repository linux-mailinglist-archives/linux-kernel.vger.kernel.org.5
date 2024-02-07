Return-Path: <linux-kernel+bounces-55964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEFF84C427
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403901C23113
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9F53C699;
	Wed,  7 Feb 2024 04:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICgaYb2R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07323C484;
	Wed,  7 Feb 2024 04:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281243; cv=none; b=lguT5eGM9E165VNg1B/gk0OOK144uidN/K9/6b7DWTAztkYDJq0oZWgKaDOCHdGLzElLKO5BqPojbhNMIgGAvYJ0bS1+1lT7/9u3JdSjTWx7hdNUuOm8E+A2Jq0mcIBj6KAtXR+xQdLRnsciK5w7bY20Uumiyg7M0790snYQ5Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281243; c=relaxed/simple;
	bh=W4jNnzamHvL5OMxPz1dZaazdUYHtuxetiFSr3KAKYqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3ZXhtRZFYkcg3btTDIS46BjHYgOu4M/GowS9nvkD6EjxlKyfoO3WXjgrKE4s+tXltD9hwgocyqhHz+NcpMZ7KZMT3vC7n/wySiNUfhetir/pJmrfbGHF2yKXabyq/0vckPiyJJjGzTOCQ36/OSvR7Jbqqt48PyVCJZFJ8PIDMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICgaYb2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4914C433A6;
	Wed,  7 Feb 2024 04:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281243;
	bh=W4jNnzamHvL5OMxPz1dZaazdUYHtuxetiFSr3KAKYqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ICgaYb2RWyV36FxQ4DfmOgLdthBRxtd49CTlSve7do19SlK3FKRYsaVMLAz87YOnm
	 ff9CNZ3qBiv1Jym/iwfGYwFP5kAuDN16BhaJ17cHWAZuB4Yr7DCuDc0pELtlhf7iTr
	 d7JAdgXyGOPWe5c7k/pLDMRKibyuLir8VKkpdVaBlyJWOtO88TGrACFYYVHlYH3sbk
	 5IDbitdcS4T7Lc+PN+olJ9DAll2H/o+6LDhDCn3F4WZb9Guy7NcAFYbY/MxGNTGNck
	 qcsXdW2W4WnvXyt7qUcKS9bMGw0S7aO5WG3BEoO8TdJpPCMZ/JisEd2ROEeA0NwFgD
	 U11ms6QMyCHdg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ajit Pandey <quic_ajipan@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: Re: [PATCH] clk: qcom: dispcc-sm8250: Make clk_init_data and pll_vco const
Date: Tue,  6 Feb 2024 22:46:40 -0600
Message-ID: <170728117690.479358.14903409462589922744.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201-dispcc-sm8150-v1-1-cbeb89015e5d@quicinc.com>
References: <20240201-dispcc-sm8150-v1-1-cbeb89015e5d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 01 Feb 2024 13:38:28 +0530, Satya Priya Kakitapalli wrote:
> The clk_init_data and pll_vco structures are never modified, make
> them const.
> 
> 

Applied, thanks!

[1/1] clk: qcom: dispcc-sm8250: Make clk_init_data and pll_vco const
      commit: fb86b16d687efd7f07ef767c6febc92c41360043

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

