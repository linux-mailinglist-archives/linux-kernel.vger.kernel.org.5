Return-Path: <linux-kernel+bounces-37725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BD083B47A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CCAB1C2235F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B2E135A50;
	Wed, 24 Jan 2024 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOoHLexc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D41135A40;
	Wed, 24 Jan 2024 22:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706134039; cv=none; b=Gpf0C1EaQn69iL/LcrM8eDASphn3+9m6yQuz4Lf94RB0sr4oYM5sggac7djX7XP0bGqtyF0wl2FoqCNlRhlpSRafb0srTO7bhHpq4bazlM8EErBm8LWTheQbLraITk+tEAMuXS7CvqiG2eV6tydt5jcvKYCWLIPwR3S9mXfqyvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706134039; c=relaxed/simple;
	bh=hnBTLdmXWaZcqPHY+gzD4i/37L5SLPfwrdKsBL0cpEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8OC+TC9VESe2MkHW4wNx9+6JsMwgKX5LAJ3LALHgov4LQUp2kKeaqnbt5rBn9ccjqH4MQLzKMwy0z6VCNSU9h3nrt71EAEjVeoVJCRvWTBuolJTCPA2Y0hiP3zKSF3tx/flUd+Zp0r3x9R8AZn7CtsY7jP+xBh0iLsKfBMuvHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOoHLexc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C878C433C7;
	Wed, 24 Jan 2024 22:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706134038;
	bh=hnBTLdmXWaZcqPHY+gzD4i/37L5SLPfwrdKsBL0cpEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oOoHLexcsJBgDEp/saL5fzCCdq86j+YUMysg/UNA+Ky/q5IVGjrRrK7kvjA6IIOmN
	 UEV2Wf5KXd4MML2fnI5w8v0jtqa7tNhTjP1RSJd8edBUhAxlWma2zhfsPlqhwbqVa3
	 GRbyiF+eTAowjZwVSCtFM+P7zOMnCSFeVZYhKQBPUB936AX1hI7zxmEySqVItwAvJm
	 C++TEA624nt6jdf4pM5S+2flo3X1uv/n7/7qV8Tw8Y8miF4gU74PGZ72T/mxvbgzGt
	 +1/E5IF3Y0fvO50Y+vAELxX8+1govwRkwydB21finM+v6D/tItKxqabiQYRZPE1DNE
	 bpCcQg03AaKOw==
Date: Wed, 24 Jan 2024 16:07:16 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/6] of: Add of_phandle_args_equal() helper
Message-ID: <20240124220716.GA2454626-robh@kernel.org>
References: <20240124074527.48869-1-krzysztof.kozlowski@linaro.org>
 <20240124074527.48869-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124074527.48869-2-krzysztof.kozlowski@linaro.org>

On Wed, Jan 24, 2024 at 08:45:22AM +0100, Krzysztof Kozlowski wrote:
> Add a helper comparing two "struct of_phandle_args" to avoid
> reinventing the wheel.
> 
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Dependency of cpufreq and reset change.
> ---
>  include/linux/of.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

I've wanted to write this series for some time. Great work.

Rob

