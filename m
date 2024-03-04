Return-Path: <linux-kernel+bounces-91293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77764870D13
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5111F270F2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F59D61675;
	Mon,  4 Mar 2024 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUNmQLrL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE64200CD;
	Mon,  4 Mar 2024 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587431; cv=none; b=GT6TRa6AAgEw9WQ2ywueHFsr1ugosmyVBWxZ9CwtAfHqsHb3QdpRSrlBJycFN82e60eIhtuojNSL9NSeOobr5st931OoiESOAXLJECfaiaRxq2YK2C12z2KPx53qpYhkgHpHODmhLNuCBZP2RsCAE48iR8VSgHKSRNuvxBLbDkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587431; c=relaxed/simple;
	bh=ABJaKWCXEacOoDgtKpa/n7nVPFnRtFcoMNI5LRacs+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhH/8GsJEuKlphXlOXh7OJ8ZSMsLR96LCXSZUjJhRFkarkaTPDMMSfmXYX2fRsoxPMqcDj3WC4anECg4Gjk09B3FSZ8eDPia2Xxp3NRE2/uBtC/TB7OU8EJRSOjNaPC9q+cbJae5T5TdjjgY7ZtGhWSjDpfmQwEaSd5Zoit4ggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUNmQLrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F9BC43390;
	Mon,  4 Mar 2024 21:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709587431;
	bh=ABJaKWCXEacOoDgtKpa/n7nVPFnRtFcoMNI5LRacs+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fUNmQLrLhgkBhJRgmw3I+IlJRlGRmg76l+4FxuQt7LWJToAjfJxNaSjJ1sHR1WlYK
	 jmyrnZBlCiWX+g0I1t4olZoTpsdHOI26Web3v4dkABhSFTuGY9L25l4UNLZ2NK8BHK
	 Z8fTwawUKn6WFSMNUPnxTRDH21QrzTi8P308H8+dQYAfAaaaKake5pvsOigPRSAxRG
	 /YEWiU99O+lzLsCBDElG7T3XqhKQSy9/wRwGslFYjwmmq1u+We6SdyKcxsA6hoOrSu
	 jIHBX5Wb9Hwh9evK/pGlb5OG14mqxOsiCpgpzdSKRPn/rul+x3GvoI8mb38pnVPRAD
	 OXp+djjD0dQ2A==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>,
	Yangtao Li <frank.li@vivo.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: spm: fix building with CONFIG_REGULATOR=n
Date: Mon,  4 Mar 2024 13:28:39 -0800
Message-ID: <170958768036.1828118.11265005592143636750.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221154457.2007420-1-arnd@kernel.org>
References: <20240221154457.2007420-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 21 Feb 2024 16:44:51 +0100, Arnd Bergmann wrote:
> The newly added code causes a build failure when -Werror is set:
> 
> drivers/soc/qcom/spm.c:388:12: error: 'spm_get_cpu' defined but not used [-Werror=unused-function]
> 
> Remove the #ifdef and instead use an IS_ENABLED() check that lets the
> compiler perform dead code elimination instead of the preprocessor.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: spm: fix building with CONFIG_REGULATOR=n
      commit: 26a526c25606495e7442feeea53061f81eca22be

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

