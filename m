Return-Path: <linux-kernel+bounces-153892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F3D8AD495
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0A21F253B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C85315531B;
	Mon, 22 Apr 2024 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tgenwn46"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96787219E0;
	Mon, 22 Apr 2024 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812651; cv=none; b=MioiFfhmnlc9JHXSLbxJ/RzB6BS1sMofLMoJsA2Fc/TyVptEU3tdFdojQg6cnShRmfyFZjBTRrsGNX9l1DcLibqIA5IHVVglhksawSpnNkr4LCYgBIFpmp25Oo9hs3lLEyLsB2cUu2ZiXyK85laqBlRoNDVnj6A56x1JjrQe1Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812651; c=relaxed/simple;
	bh=EphLAmMsX4Mj13yYilOanf7ouqQ6tlq2qxKHgIcnZ8E=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Ro7g19e3lo5vOtYtFM4DjQOQ0NLrZ6S7qg845LgpBOX5RBZ78zctF5tJYGhr4JM7CTS0HBmx799+t6KMzTFGkmWhWVUYSzrexzXRZcgwNMeUIrnYr9Mau2FccDi2aY9vLal01I2nDi8ZeVfG+LcddL6tCnKQz79fg+dBIr4msxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tgenwn46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA02C113CC;
	Mon, 22 Apr 2024 19:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713812651;
	bh=EphLAmMsX4Mj13yYilOanf7ouqQ6tlq2qxKHgIcnZ8E=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Tgenwn46LM3zm5EbNxpJuQ7p4+lBl7+RxWS0QDo/dilKN3O6govUQa8FS8e1qBRwk
	 ZOJ//k4faFT6PYc8BR6a1aAwK8BlxovAWGysxNNMdbW6NKcKybv/lW+hyqXL3p/uhl
	 9LTo3VI+wm1K8MuGdM2OMbp1qTnHRtSm0CycMBGBohH5N+y5zkQogqcguLk4JubHGP
	 gagB0YEiqCUD0nPxcn60yKXXs7FsNuL3bNieqxipQroXr9VyQ8P/Cncij7TD/SrPOf
	 yP6eZ6IamRZ9bg8VwXZxAssi52x5dMOb6wrNG/8myh7ZELJFCKKXQXSaZoHAF+4FNF
	 SHQKDn2WKGLWg==
Message-ID: <3a9a22e68a9421caa14ce00a636842ce.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240415163649.895268-4-cristian.marussi@arm.com>
References: <20240415163649.895268-1-cristian.marussi@arm.com> <20240415163649.895268-4-cristian.marussi@arm.com>
Subject: Re: [PATCH v3 3/5] clk: scmi: Add support for rate change restricted clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, f.fainelli@gmail.com, vincent.guittot@linaro.org, peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com, quic_nkela@quicinc.com, souvik.chakravarty@arm.com, mturquette@baylibre.com, Cristian Marussi <cristian.marussi@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 22 Apr 2024 12:04:08 -0700
User-Agent: alot/0.10

Quoting Cristian Marussi (2024-04-15 09:36:47)
> Some exposed SCMI Clocks could be marked as non-supporting rate changes.
> Configure a clk_ops descriptors which does not provide the rate change
> callbacks for such clocks when registering with CLK framework.
>=20
> CC: Michael Turquette <mturquette@baylibre.com>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: linux-clk@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---

Applied to clk-next

