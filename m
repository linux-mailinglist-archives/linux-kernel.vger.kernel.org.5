Return-Path: <linux-kernel+bounces-164973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF0E8B85A8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A028B21F4B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B75548CE0;
	Wed,  1 May 2024 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7z4YgZX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A5A29CF7;
	Wed,  1 May 2024 06:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714545811; cv=none; b=nO0BfA0vXiKZJ5JdTY7DuLEQCAOsHVxLOnzULGmW3IXVgQqkYVCil2kyXzlv/WgxqyLRHgmOPuKxdiMqxR3HijdHzC88pDP6iVCmEFQ2TGdkAvcIIQkRKgRIAwRnfUVQi4RkETac2mQVzREWqEja+tdaL4By9MylzwuaF74PPJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714545811; c=relaxed/simple;
	bh=nyLX7tZ+dutpM4iXlRXNeVz8vFpRGVO28XgstJYVyiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwSi5SVPVj5nT/uOhAJR3bMH+kejwYgvqvxT8WwnILjzUSS8cnI9iUJlR5mDzW4/Syqm+T1w1cnnhV+zL5J2DEQUqcA2lCnboJTFPgEm0PhShGD4gf6OtOcBm7QKqk1Qj92cPxGML1kjzjPezRxotRzmq+J/4biJc0+04LYGYus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7z4YgZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C8FC113CC;
	Wed,  1 May 2024 06:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714545810;
	bh=nyLX7tZ+dutpM4iXlRXNeVz8vFpRGVO28XgstJYVyiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7z4YgZXRockdwpyxA9k39KUwsEjcgdvup1Habv5ifx4dSZ2mmsqBg7j7f22F9IYI
	 Znrl1XuURJVH7Ywv5pn0KS94JbxwWOZPDf2iBEV3XTulAL9vKLCPRhLoDXRTkqKMIN
	 P5d+PWgMJU7ZjoqNzFyVEPOU8e6A5OXYizGbTQm5ma4wFmv52q9KndCzl2xzpxnG8e
	 3j14+GkZRR4FrYugO2hxhY1ewSr+ewHfvxtiVqfkv/yJp9DVDNF6gdKu0F+zRqaPD4
	 sGZbdU0nO3jXhEd0e1RlQAfwp5KHED3Z6ui4dXugbkqY1ruo7cBtaU2pHQBKbLIFmX
	 FWTSSKnbDKayw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s23gi-000000008RA-2jX5;
	Wed, 01 May 2024 08:43:32 +0200
Date: Wed, 1 May 2024 08:43:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Taniya Das <quic_tdas@quicinc.com>,
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
	Ajit Pandey <quic_ajipan@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>
Subject: Re: [PATCH V3 5/8] dt-bindings: clock: qcom: Fix the incorrect order
 of SC8280XP camcc header
Message-ID: <ZjHklEN4zV5QG5Zv@hovoldconsulting.com>
References: <20240430142757.16872-1-quic_jkona@quicinc.com>
 <20240430142757.16872-6-quic_jkona@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430142757.16872-6-quic_jkona@quicinc.com>

On Tue, Apr 30, 2024 at 07:57:54PM +0530, Jagadeesh Kona wrote:
> Fix the incorrect order of SC8280XP camcc header file in SM8450 camcc
> bindings.

Try to avoid using the word "fix" in the commit summary (Subject) and
commit message for things like this which are essentially cleanups to
avoid making it sound like a bug fix (which automated tooling may then
select for backporting).
 
> Fixes: 206cd759fbd2 ("dt-bindings: clock: Add SC8280XP CAMCC")

Also drop the Fixes tag as this is not a bug fix.

> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
> index fa0e5b6b02b8..bf23e25d71f5 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
> @@ -14,9 +14,9 @@ description: |
>    domains on SM8450.
>  
>    See also::
> +    include/dt-bindings/clock/qcom,sc8280xp-camcc.h
>      include/dt-bindings/clock/qcom,sm8450-camcc.h
>      include/dt-bindings/clock/qcom,sm8550-camcc.h
> -    include/dt-bindings/clock/qcom,sc8280xp-camcc.h
>      include/dt-bindings/clock/qcom,x1e80100-camcc.h

Johan

