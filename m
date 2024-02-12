Return-Path: <linux-kernel+bounces-62472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A70852157
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3ADE2841EE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4C04E1CE;
	Mon, 12 Feb 2024 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hmgv4A+B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A2F4C627;
	Mon, 12 Feb 2024 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776555; cv=none; b=ETwMEaG3ikpT17amhe2Pk5t/C7VUAFfrDxEy9WzazjJP/4KQXxl5/zXUeW0nMDQPJuQOEW2m3z1SsATCK2T99NZRGEkrELLYs0UqCxx25OYyEqAEVCTvUP2VXX1BZxaeK2SUYnfW2W2vqSKjpYfmb3mPhNmYOZZw5PBH/asXaUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776555; c=relaxed/simple;
	bh=0IusXPQHXi66v5j+nmnkJrxK8Pdqo4Ksu739OrYknrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS5kin9jbzH0BtJN0po1WDA3YKHclY7wMwNhSEd5yFVJG7T74AXHjB0pkG4cgZH+dPkWYrmFMfuOh8AjBcjVZPrJJhZQPSo7cVyTMtloQZxkMzqfrjSslEoRup/jvLsOTw81ahA7hSd+Nv/S+2ge6qhPoaevX2ZwzudKxKnULbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hmgv4A+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D63C433C7;
	Mon, 12 Feb 2024 22:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707776554;
	bh=0IusXPQHXi66v5j+nmnkJrxK8Pdqo4Ksu739OrYknrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hmgv4A+BeRMvlSjxes5DlqJTRfGXFLA4EQJFae22u5pAp8YsBpncoyUnMRysNiogZ
	 lsX/d5Whk/aBo4JZqiVapBKNf6OuyE3DBHR5NWX1hyAhZZojukhq3f4Lhl6EVPqhFp
	 BbvIqBZ9a3zoU75koZjO8f+ALB8hU4tr2vjFa6uUYNv+A77uLjEfUWdX4qXX63aMZZ
	 xtHMBUsAu8woT1hbyp4mh62luHt6uq+CZVP8NpZkgRayGj+O1KVkBRdwUU5J0SB5yb
	 WutQATu4qOrMHZ9vnIItqGyRbEujU+WBGNHwDBADHex9zQBS67PwiXBxg1FsxYKDuE
	 J22waLRABKb1w==
Date: Mon, 12 Feb 2024 16:22:32 -0600
From: Rob Herring <robh@kernel.org>
To: David Wronek <davidwronek@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-phy@lists.infradead.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 2/8] dt-bindings: ufs: qcom: Add SC7180 compatible
 string
Message-ID: <20240212222232.GB2655166-robh@kernel.org>
References: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
 <20240121-sm7125-upstream-v4-2-f7d1212c8ebb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121-sm7125-upstream-v4-2-f7d1212c8ebb@gmail.com>

On Sun, Jan 21, 2024 at 05:57:42PM +0100, David Wronek wrote:
> Document the compatible for the UFS found on SC7180.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Should have been picked up by SCSI/UFS maintainers, but it 
hasn't, so I applied it.

Rob

