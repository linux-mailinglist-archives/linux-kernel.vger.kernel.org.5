Return-Path: <linux-kernel+bounces-141935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2F88A254A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C03286C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0905EC13C;
	Fri, 12 Apr 2024 04:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkfiMQkR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4967479DC;
	Fri, 12 Apr 2024 04:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897166; cv=none; b=fruCZr2iBdLChWTY42mQyY74EhIDJLCIKl2y2VEArN6w2uCvpoPoByO5EapsAsZrGTNghIJBuvnO7jtSLzH6Zf1tgJbFS3b4U++Z2GY3kJ9J8QdPWPQv5kCFZEqEPwXxhcK2wcErACrgBRacXmldn8QPXHUXxUsKCf27zxz/JLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897166; c=relaxed/simple;
	bh=majSr49xz6VE5z5e2UGn7sPKnKS4R4BoP42ZVgZdgqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8vSsjrPEScFFkEXl0V8aCSp/H4xPWP1rTfqMRNiiMDhmKPMp8NAefIMVE2ZLe78NgCDXH6UA4IFPMr4V7AgrtG1sFd61IRvBAA9HOxQ6XqaG5HpSBnMQLaFsmNhDRDA51PgIrM9YA4fRDrVgPzCe3KyO2P2jNuKxnuaSS0cGFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkfiMQkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEACC2BBFC;
	Fri, 12 Apr 2024 04:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712897165;
	bh=majSr49xz6VE5z5e2UGn7sPKnKS4R4BoP42ZVgZdgqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkfiMQkRhl2FYJi6v2fssQAQxIob+KfKzHV0mHFii1I2+ER6EXHB1RZm6zCMhcnny
	 fhvSz6C9OXLUY2z+ZEu655gtN3X7rklxDKa9bK9DTJm0wUD5i5+JMQwq9KycqyZc5+
	 tuxqS1ICpDuFYpa88ZZoHQU76saD8HVSvPSYXKT4cn9n85hxkjHNM/way9w+sjWBWI
	 x+Yuul4yhSMFpVMMqw2XiX1i4b38K8zbC75Tw0lk+hxqPhj5V0MP/pmVeSULRRE0EC
	 aCMFE74AIiMjtViEyiW/HdNDtcx3DYaIpxwJWfgnAQXAkWeFcO9DVXOfefzpNf9zD3
	 RrczCnf1JAd4g==
Date: Fri, 12 Apr 2024 10:16:01 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND] soundwire: qcom: allow multi-link on newer devices
Message-ID: <Zhi8iVDBtNckabjO@matsya>
References: <20240403132716.325880-1-krzysztof.kozlowski@linaro.org>
 <171285772329.544231.15578305335747563968.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171285772329.544231.15578305335747563968.b4-ty@kernel.org>

On 11-04-24, 23:18, Vinod Koul wrote:
> 
> On Wed, 03 Apr 2024 15:27:16 +0200, Krzysztof Kozlowski wrote:
> > Newer Qualcomm SoCs like X1E80100 might come with four speakers spread
> > over two Soundwire controllers, thus they need a multi-link Soundwire
> > stream runtime.
> > 
> > 
> 
> Applied, thanks!
> 
> [1/1] soundwire: qcom: allow multi-link on newer devices
>       commit: ce5e811e069168898ae2ff02a90de68637ed7dc4

b4 messed up and sent this, not sure why.. V2 was applied

-- 
~Vinod

