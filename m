Return-Path: <linux-kernel+bounces-87758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9DD86D89B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E73A4B22ADE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A932B9D9;
	Fri,  1 Mar 2024 01:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGuxCeb8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15491E891;
	Fri,  1 Mar 2024 01:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709255856; cv=none; b=iOebQPx2mrtivRUiBCrIe8uTQ9MKdpN1GcIqZif0y29Wol3yiiycBpqEDlKYHCmVYDelkXYbd68dEsQAQ8FCX1Yc8wHEofzINCGCF7bu7/Gu8RReMIeF6w59qwF9/gi3/peQ1fopny4oPL9J8m0SJD6ZC4xb4KXBYqb7jyPs8Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709255856; c=relaxed/simple;
	bh=OxUoV6mwIFKNwTa4l5YJTZcLQY8bJRJdrHpn2V+m+ek=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=gHCJszYpyTw61vMUFf/3VphhXD19z7QJ+Y6OSNWXNGuO9NtC2OkcDVmisoCivFaiE/xy9jNZVzn6kO+CT5vyQ1oryqwPaIzPyrrLlo8ocZV59VunIwCdAuB3NutiZgtWI3FHvU9p1RFQdFDMkumTsAm9vD6OHCCcLXlztP2FIhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGuxCeb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B83C43390;
	Fri,  1 Mar 2024 01:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709255856;
	bh=OxUoV6mwIFKNwTa4l5YJTZcLQY8bJRJdrHpn2V+m+ek=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=YGuxCeb8J4UOEKVOOWHZMBJQqwlvYvy1x9WJTguwWW1A1C2qWWEu/xAKRDUKAm6WX
	 iLlLuQEMSWPRq7jFA830vE8qI6ZfdHc0Nhk+qYWqzra1NYBEPN0pPzGBQYwz2MALuC
	 uqsrVA+JKfQu23l7cIHZUiq0SpgQoo2DZa3VpA09FcITlnMU8L+QS2PoXb55s9lrTn
	 TKF8zByvgcYY1hYMpDWaJyNYeCwiAMvskAGKFLgaEk5+RS80gZrxOFMGkvkB4M53ou
	 QeS6L9rDxlQADr+U8Z/TH+anKWrnP+Cb6vYQG6nR+VTQWTJfa/zD+jgm7LIjmhckLW
	 8lUFv1WnRLsrQ==
Message-ID: <8a4dc2bae0329d742d8212f59d71d295.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240229-freq-table-terminator-v1-2-074334f0905c@gmail.com>
References: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com> <20240229-freq-table-terminator-v1-2-074334f0905c@gmail.com>
Subject: Re: [PATCH 2/7] clk: qcom: gcc-ipq6018: fix terminating of frequency table arrays
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
To: Anusha Rao <quic_anusha@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Devi Priya <quic_devipriy@quicinc.com>, Gabor Juhos <j4g8y7@gmail.com>, Georgi Djakov <gdjakov@mm-sol.com>, Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Sricharan Ramabadhran <quic_srichara@quicinc.com>, Varadarajan Narayanan <quic_varada@quicinc.com>
Date: Thu, 29 Feb 2024 17:17:34 -0800
User-Agent: alot/0.10

Quoting Gabor Juhos (2024-02-29 10:07:47)
> The frequency table arrays are supposed to be terminated with an
> empty element. Add such entry to the end of the arrays where it
> is missing in order to avoid possible out-of-bound access when
> the table is traversed by functions like qcom_find_freq() or
> qcom_find_freq_floor().
>=20
> Only compile tested.
>=20
> Fixes: d9db07f088af ("clk: qcom: Add ipq6018 Global Clock Controller supp=
ort")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

