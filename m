Return-Path: <linux-kernel+bounces-132136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192AB899020
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F731C21179
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F209C13C821;
	Thu,  4 Apr 2024 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7gLn/Dr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383DE13C80F;
	Thu,  4 Apr 2024 21:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265807; cv=none; b=oUkTVXcqFo4Gz7vMlagS6Jf0L8DHluXUOvZGlP1+xHpv7MSNrxdbFT7b2VQjZ37uabqVZcBee6of9r1nt0nWJBatH549Ax/g3GDB0+e9sxkL1ry4KGshtIwphYtXcXiD2Z5EqC7JLx0cxt6202enRo5LTCRcNCGT8JrgIDoW7BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265807; c=relaxed/simple;
	bh=+dJQ2Gut7jYJKpmhtAxjwOcvH8134+AcyHVuvFjA/6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQo4smu0cCqmkKcwd7ivlRZ1PqbAmoXqknhnbQ470hkfrqinC3KR1/8dd2x8vEjshi1Jc/TW4lFf7ThAl/AY7537oXVF6COHLgdb325l4vaamt0WybYx6fOjGUS5atW0nHUof2hU6DRYMPmbPwDrsN/6NI4qkfEVfv/uaIF6SeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7gLn/Dr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D137CC43394;
	Thu,  4 Apr 2024 21:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712265806;
	bh=+dJQ2Gut7jYJKpmhtAxjwOcvH8134+AcyHVuvFjA/6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d7gLn/DrtHK/UxzowWff28wEDHB6lTn0qNssKntA5ou5v5U11e6zPa+3AvCsiGps1
	 nwS6y4BBLbEDqd/OxkTWVlMm22Zuwi3eKEePkaFlHenPx4kU7AH1RxIJyzcSdon9tY
	 4O9vaF8uudjW7M+bnXr3UB/4xMcU91GGjsbZ0MqzaPBZXv8zu7Mrm+EzrvoyQ1zOGq
	 IvBXwu8vEHaPwhyOA7GKOoxgcMe3zz7CZTImXuWUE680VOutkDZ1NEc7PLLxNCqi7H
	 krRLtbhDsm6yEg9FpM9wrS7y9EfxaSvTNFkIveEf6BDeqWDxXZYTTYdphQj09R8zCU
	 7GSLg9q/J5IwA==
From: Bjorn Andersson <andersson@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gdsc: treat optional supplies as optional
Date: Thu,  4 Apr 2024 16:22:54 -0500
Message-ID: <171226578689.615813.4474720130637817355.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325085835.26158-1-johan+linaro@kernel.org>
References: <20240325085835.26158-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 25 Mar 2024 09:58:35 +0100, Johan Hovold wrote:
> Since commit deebc79b28d6 ("clk: qcom: gpucc-sc8280xp: Add external
> supply for GX gdsc") the GDSC supply must be treated as optional to
> avoid warnings like:
> 
> 	gpu_cc-sc8280xp 3d90000.clock-controller: supply vdd-gfx not found, using dummy regulator
> 
> on SC8280XP.
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: gdsc: treat optional supplies as optional
      commit: 6677196fb1932e60b88ad0794a7ae532df178654

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

