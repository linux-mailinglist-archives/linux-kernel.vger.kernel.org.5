Return-Path: <linux-kernel+bounces-5692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1748F818E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FB7286988
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2F431755;
	Tue, 19 Dec 2023 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJKVGSni"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD8E225D9;
	Tue, 19 Dec 2023 17:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B44BC433C8;
	Tue, 19 Dec 2023 17:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703006900;
	bh=LwFlemhDXsQTCT6yty5YjRZREbcZauYYlCKVORoaexg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJKVGSniX51TQl0CIvTUnJe/j7dUF0DOmBUMiVvIKXuZWEHvY4rnDXDaku6eJpaPg
	 q0sXvdfTOqEBBvmTC1957UCiN7MGiyL+qCpvUw8HdU8jwfd7x4NIg9qpmFp7cKaSq2
	 eHlfr4+C7EFFKTU37Jlv4aR3a9E1m9QyiatiLhD2iPEcOAUb7BxaTs6RF6FXzEk79i
	 YorgjIi+9O1HRbyPalfibn+3HXqnZ6RF17bF+WvqcFu2PfcG3GhDB9dQWOIzDKxLUf
	 Ga1a47sNG9diJWJkCzmeI4CDM1H6kyXaaN2e9X7kmYr8DoX6qN3nXZRw4mfjw/XbuH
	 vuV/PszECjttQ==
Date: Tue, 19 Dec 2023 11:28:17 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Georgi Djakov <djakov@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 01/12] interconnect: qcom: sm8550: Remove bogus per-RSC
 BCMs and nodes
Message-ID: <27rpxy5s5zo62o5waihq7phd67pn3hezag4xmpb3stc6x4r4bo@jysfz46pzkag>
References: <20231218-topic-8550_fixes-v1-0-ce1272d77540@linaro.org>
 <20231218-topic-8550_fixes-v1-1-ce1272d77540@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218-topic-8550_fixes-v1-1-ce1272d77540@linaro.org>

On Mon, Dec 18, 2023 at 05:02:02PM +0100, Konrad Dybcio wrote:
> The downstream kernel has infrastructure for passing votes from different
> interconnect nodes onto different RPMh RSCs. This neither implemented, not
> is going to be implemented upstream (in favor of a different solution
> using ICC tags through the same node).
> 
> Unfortunately, as it happens, meaningless (in the upstream context) parts
> of the vendor driver were copied, ending up causing havoc - since all
> "per-RSC" (in quotes because they all point to the main APPS one) BCMs
> defined within the driver overwrite the value in RPMh on every
> aggregation.
> 
> To both avoid keeping bogus code around and possibly introducing
> impossible-to-track-down bugs (busses shutting down for no reason), get
> rid of the duplicated BCMs and their associated ICC nodes.
> 
> Fixes: e6f0d6a30f73 ("interconnect: qcom: Add SM8550 interconnect provider driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

