Return-Path: <linux-kernel+bounces-6640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12DB819B60
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7E61C24C62
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633E11EB46;
	Wed, 20 Dec 2023 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0+sG3HK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21091DA33;
	Wed, 20 Dec 2023 09:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A486C433C8;
	Wed, 20 Dec 2023 09:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703064406;
	bh=j222JJR/D8hXfjZV0XkzJEjLU8itQUo0kwMu0IT0jyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H0+sG3HKttzfQQ6tBgwUGrqhtUgzp4AWDqD/SE022vHvySXzgL4lNOcklYpx5S3S0
	 lMaP3YoqiJIdk6awQJOmLbKjbv65rNp+P3nwzF/FSlKxm/tyhsPYv/3P/nhzu5hlv3
	 Papeuj9WTYboalFcurYUPC4bLm900nuZg+4yeuxcoNQIFnYILOaYk7X1gzeiQmAimK
	 KBl6Zhl01iEHpO267Dm2yxL+IHUI2aJLhPRQNmalIs+bjNjjnHwUi8A7yIsz1iVYnv
	 GoVYQWp+gjCx9eOU1YEz6tCtfyMOhpROsKbZBy1tNVWBlVkOcDBy63FWxD/OpNl5uN
	 FWODUjDgdLJjg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rFsqh-0001A0-0v;
	Wed, 20 Dec 2023 10:26:44 +0100
Date: Wed, 20 Dec 2023 10:26:43 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 04/15] clk: qcom: gcc-sm6375: Add runtime PM
Message-ID: <ZYKzU4FFCc9lnE-p@hovoldconsulting.com>
References: <20230717-topic-branch_aon_cleanup-v3-0-3e31bce9c626@linaro.org>
 <20230717-topic-branch_aon_cleanup-v3-4-3e31bce9c626@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717-topic-branch_aon_cleanup-v3-4-3e31bce9c626@linaro.org>

On Wed, Dec 20, 2023 at 01:30:45AM +0100, Konrad Dybcio wrote:
> The GCC block on SM6375 is powered by the VDD_CX rail. We need to ensure
> that CX is enabled to prevent unwanted power collapse 

As I pointed out earlier, this bit of the commit message is incorrect
and misleading as the power domain will never be disabled until you
enable runtime PM as part of this very patch:

	https://lore.kernel.org/all/ZLaSpFFBzP_Yz5yY@hovoldconsulting.com/

Specifically, genpd will not power off CX (at runtime) while the driver
is bound when runtime PM is left disabled.

> and that the
> reference is dropped when unused so that the system can enter a
> firmware-managed lower power state.
> 
> Enable runtime PM to keep the power flowing only when necessary.

The rest is correct.

Johan

