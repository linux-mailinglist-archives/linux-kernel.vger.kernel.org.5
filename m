Return-Path: <linux-kernel+bounces-61927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D34A4851887
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B96A1C21F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334563D0AF;
	Mon, 12 Feb 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="kHJS4noC"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B970B3C473;
	Mon, 12 Feb 2024 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753377; cv=none; b=apV1loz64EOwzzDoejNm0L+WBRDVXvMNtgHfvLiy9yu+FIVWrZNkpy+G2GMX1RO1nsWAgU/E06Zw7gaJ0osM94T0fhHjRgctX0R1ZMrfshW1JfGcadxWcjHjoZ+2iYAySHc4qvNX9LTep7YWnEhKXMsFLoDx7LeU+jC3AZ7DkKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753377; c=relaxed/simple;
	bh=UEoUzI0eopOfpfMWL9+ubXLmnf6UPKl4bf+SH/FfhF8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:Date:CC:
	 Message-ID:References:To; b=f/PNH0VE/4LcNtjcSvRC3BxycJUq2PbfzXMqiNKlSiNkAZp8JPMvL20Afu5E7suYsWj0ahSfphyeIpyy6glYl2xEKJq4l9ncrsQKBHr/ILDKuWplqtoIRA9EdEUumts0QUp6tZwJ0WeIdqXTTULvUAXbWKGtcsZsAhEqNAZ8rSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=kHJS4noC; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41C7wuOt021531;
	Mon, 12 Feb 2024 09:55:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	content-type:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to; s=
	PODMain02222019; bh=UEoUzI0eopOfpfMWL9+ubXLmnf6UPKl4bf+SH/FfhF8=; b=
	kHJS4noCFaqhHA00df2Nyt5FmY+gB7OQUEEpeP6D0ExctWUJA3mYo5WEuWviyrsZ
	zHrY3ylV93fWTxp591elNivJTtdqJyFz84ghlZhNvVbLM/Li4w8cSVjED4gkx51C
	s4zl9UzYuYZNN7Cg86cNIsX6NftCxBvhN8UlXkMfAlPN4EYP+owuwTQYVAA60zpa
	gxzz2LJgSv2+w2XisaJbdqntbrL1ARM57umBDUA/n2AN0PAqEf/xCTXMjvqdanPN
	JbN6nYOJQL1XQf5Rhm61D1HnvGjI82/rS/IijKmAjCLoHhqhKYdTqliVB8S9UqRP
	vA+9bmzebhDR/jr8EXGHwQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3w67e220gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 09:55:47 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 15:55:45 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Mon, 12 Feb 2024 15:55:45 +0000
Received: from smtpclient.apple (unknown [141.131.76.118])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 7CA6A820242;
	Mon, 12 Feb 2024 15:55:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 1/7] dt-bindings: ASoC: cs35l45: Add interrupts
From: "Rivera-Matos, Ricardo" <rriveram@opensource.cirrus.com>
In-Reply-To: <ac5cbfbf-45ea-4d34-ac3d-d3a0fc6ff061@linaro.org>
Date: Mon, 12 Feb 2024 09:55:29 -0600
CC: James Schulman <james.schulman@cirrus.com>,
        David Rhodes
	<david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Kees Cook <keescook@chromium.org>, Tony Luck
	<tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Marijn
 Suijten" <marijn.suijten@somainline.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-ID: <C8A97AB6-A3BB-4018-A8E3-CEEECFCBECE2@opensource.cirrus.com>
References: <20240210-topic-1v-v1-0-fda0db38e29b@linaro.org>
 <20240210-topic-1v-v1-1-fda0db38e29b@linaro.org>
 <ac5cbfbf-45ea-4d34-ac3d-d3a0fc6ff061@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-Proofpoint-ORIG-GUID: HVAAhL2KDvY-331du_lPmDeJ2OJzJ91Y
X-Proofpoint-GUID: HVAAhL2KDvY-331du_lPmDeJ2OJzJ91Y
X-Proofpoint-Spam-Reason: safe

Konrad,

> On Feb 12, 2024, at 7:25=E2=80=AFAM, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 12/02/2024 14:10, Konrad Dybcio wrote:
>> This chip seems to have an IRQ line, let us describe it.
>>=20
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>=20
> Subject: ASoC: dt-bindings: cs35l45=E2=80=A6=E2=80=A6
ditto
>=20
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com =
<mailto:rriveram@opensource.cirrus.com>>
>=20
> Best regards,
> Krzysztof
>=20

Thanks,
Ricardo


