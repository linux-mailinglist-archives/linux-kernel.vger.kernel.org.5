Return-Path: <linux-kernel+bounces-26271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E9D82DDCD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009631C21D29
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A054817BDD;
	Mon, 15 Jan 2024 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suf4V63z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0DC17BC2;
	Mon, 15 Jan 2024 16:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D5EC433F1;
	Mon, 15 Jan 2024 16:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705337094;
	bh=C955p/TjvNoTugL316DL2X2XF95oKi/HO/h6KILl/eQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=suf4V63zKRMAm5pBkyGXyJwsSq944YrcVcj2TLFi+3iiuym1+HJjAT8/a4ODrhgep
	 cCho0atZI4ZP01YEJejORFOkl0UhFWz/gVw3l1BvqSS3INrVe6jesOzJoo3Dr0Oc+T
	 oSn7F9iQf7QKKxNZ/4vBL0YzpH4Cm6KJ3dJAw3EFqvLnjdXOa19LBqiK7IaBHzKn6c
	 Nnbvb6lvJvLPp8Kv3JzUZG0O5PJKPprBaSd4wqxjPBGuwUoX7a0IWI4nIns8y4jeHm
	 pow0PERkpG4Cb3cMwiFBUcQr/9k64v8DVAmWdy9BTE55Qo1MOL0yivnKCxH+ZbEJpf
	 DbRSimKKvTRXQ==
Message-ID: <201733c1-dc24-4d77-9967-f52c8e81d35b@kernel.org>
Date: Mon, 15 Jan 2024 18:44:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: qcom: sm8450: Revert "interconnect: qcom:
 sm8450: Enable sync_state"
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240115153420.1525037-1-krzysztof.kozlowski@linaro.org>
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20240115153420.1525037-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.01.24 17:34, Krzysztof Kozlowski wrote:
> Revert commit 16862f1b2110 ("interconnect: qcom: sm8450: Enable
> sync_state"), because it causes serial console to corrupt, later freeze
> and become either entirely corrupted or only print without accepting any
> input.

Sounds like some driver is not requesting bandwidth and is relying on
bandwidth requests made by other drivers. Maybe we are missing some
"interconnects" property in DT?

Thanks,
Georgi

> Cc: <stable@vger.kernel.org>
> Fixes: 16862f1b2110 ("interconnect: qcom: sm8450: Enable sync_state")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/interconnect/qcom/sm8450.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
> index b3cd0087377c..952017940b02 100644
> --- a/drivers/interconnect/qcom/sm8450.c
> +++ b/drivers/interconnect/qcom/sm8450.c
> @@ -1888,7 +1888,6 @@ static struct platform_driver qnoc_driver = {
>   	.driver = {
>   		.name = "qnoc-sm8450",
>   		.of_match_table = qnoc_of_match,
> -		.sync_state = icc_sync_state,
>   	},
>   };
>   


