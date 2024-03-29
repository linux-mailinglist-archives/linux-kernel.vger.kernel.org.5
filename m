Return-Path: <linux-kernel+bounces-124249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B22891461
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168A41F22EEB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43BC4087D;
	Fri, 29 Mar 2024 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CWVV+xYa"
Received: from sonic310-23.consmr.mail.ne1.yahoo.com (sonic310-23.consmr.mail.ne1.yahoo.com [66.163.186.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CDB38FA1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697619; cv=none; b=rEfk+ReUNFE23fky13+5w7OezqCVPgDGOzReEtie5U+MxtyzrX4C2BjX0oUzGeLVLrIZCzcCIOv4zEWoU6n/cp5day3D1pkgh8jtfPNSldazyPi27H8btzitA9nfA2d4YBNKnIE1DkGj5XqLBdJ3cWr7Q9J+aNxf2fXnBnHpxHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697619; c=relaxed/simple;
	bh=3zB3Gcc8KXNMcKPXSSPa0Bhb4MhzReR+4gGltLBn2+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dAdYbTi/vU7A9uxuogLmlCRmdZMLAgThVcF37JRD4wPZf3tINH/niTBc5VCCsLpzK2mE4Gt0cuR/dC3c5gB2a2LKa/HAYBhQf7KpbiFPznNyOgaEjW0nj+jVGUzQFwRSA9JAEoB/lUDFayLGmv6kpKHPoUpv+1kx6dYi02bZKA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=CWVV+xYa; arc=none smtp.client-ip=66.163.186.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1711697617; bh=3zB3Gcc8KXNMcKPXSSPa0Bhb4MhzReR+4gGltLBn2+I=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=CWVV+xYaR0CRiuVU+yE08GWC0E8l3Tz7suUbw55kS488uMu681ndYmTGZzjsMS8mCgegYQ522Bzi0505qlP2UKIclVo7PPB2xg0zRlh/oSnE1eNo/2feWN57HOxI5a3a0BSk2lkmJwVAcZ4IXGroSrlM3BXsz8cdEtR5Pfo+7WaCSMiOxclhgtCuqNriPACsBXcMHf6/4tC90HDUlKV9jVDcBiv+k9PId7mJ67oOnOABEXc/SW+XPmcjrvu88xVzovfmUiFaUbQrvHSyQBLzvQjgDh6SHryTXqmurqqcPnow1n8LKk3nZjnD4XEZX/ioe1R3hf3Oqnoracy6aCjiBg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1711697617; bh=dzq2eqPh514hNZevCH4BZZExeTG45I3TBOE4/qQ0Z+x=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Wj+WkgOt6+uOiN6fNM7Yfngn+mCxDmRLa24hevq7P9IBJqtPINoiArOrcyR2CkPLcxG4rx59vEhrIZhmdFqgRl8kFtymFdz+WhLcBCTQCI5wxFN4oEtjUl/zTolGgWmQe34pSob8qamo40glHIrwXM5VV/sOgpCzmgsmoas50XaBhq09Jo/ddxENTGsVHec3NygZBUjWHKLyjoHyoWouu3WUrTcZGBGy31/CeiFOhAwfUWG9iZHEYwkfoWx8EQzgTjc18OWfWon/La+nTVAy1gBkhsW5T2+jQVQmfu0ZgCQRfK7KWIdi1MGoV8M1QFb61tyqqqYFd2XFXDfMgjUaHQ==
X-YMail-OSG: D8Yl0X8VM1kyGkdFxhlOEuA2MLGab6rZvotUhS7KDnrSEQ8A1W5fY8EtiW06WqZ
 3rdmDdZ5uNQAdJqglpZAXxooRnA00F8w3pGErHj1QR2gbL2h2tET49_Iag0svDhfnebeOiawU4PY
 P4bLHyfisuxkDzGvnfKMoLz2q1gYsf4M4zvaD.txgKoct4dMIkaEERsRZi8eV51xER_c01AAMkXA
 OiF1m6xNVgL_EyzKYwkkXy4De75ECRsrQGDb9UaNxEI0qizhsY7gGHAMldggYH5Ca8pXqVoMaV.T
 WyG8rt59SpAcdV3ea345koxqWFeRj6BSe8KIWs68NZFyYl2C_.eBLIGbSPPJhrSQ7xdB37anu.Ac
 eKZHN5LczITHBQXrsRLhb3yB11LCIOegRan3hqiWiGN96TdE4Dk37EKpn9nOaVp.t6yEd7FpJcsW
 NnHk6oxRW9_YUL9T0SPRw.9kdzR77n440EO_7hh_BqT0UEoB0x3AhP.zbIVHh6NO2WQUjM6DAxV3
 fxqY6L1uvR4p0wxLFBmtwk4I2MFGmWQIuCF8Qofhk9YpGMvRzzCZpfrqtt1apyhpwi.mINnEeg4d
 D7gvaBEJPoVSAzYmls4sieWaBrqGqWhLaIIjG42xJ567EjrknICyQq0ZmiT2Z94Xxna36A3cFM1z
 mNUl4kUuJVpPKC4aKcx1hXuT.Op925C87oKOFK7QOLpd0W8Wf5RfOeuen8r0hDFQZBLNql2jP6Qf
 Hr4LY56aowGSIS_JOcFOU5VrjV6IpS0sGH8hCc3RfUv0wyjhL.vLHiKzqn9O7BLQARs5Ciw4AQhQ
 g67dO8FHYsYOJqbs.KFHlGVlndxR.Zuayp5f3oNkfYdPygzNCl0lwMNrtZAHPVwFrkfPYyqPgaUY
 V0H5FrtXtSdhjs0vkKrTZ1slfaOblqj96Er9gAuyYna_hAAZDLvfiaS2slETc5Q7cB_MpAX77KCD
 ORoq9UiWRXtFEHuYG6PUXt0xblbWo6NWKnhvMDLByEE_LlrJUyvcEoIZYyJViSaZXJmiJVxABxWb
 MDmfUDsEdHrPejY93quQ7YdtBefwDz8iavlH2MvVHkl2D6_Dl_8.9c8_HIIP2i.n0WrAP_MYgt4X
 HEPd0mqqikfQ6Zt6ukucwEEJzTwy9wGc6Kg2Kfd8.Oink3OJXZHSBkD4FbIlV9oLQYRyG8debQlr
 Xyq.A62RUemZt3ztFMyQKlDetxKBLte7diDOuWK954M8raLpXXJ_EiRJG1qOcK.c2Q7ibV_PZLwx
 6hUe5o3e4ryNotdaRQhtLOoM3slpVU7Xt2N44PFz8p9dk9wcaSps_0Z7imoAKvcol5bPoAsBzz.z
 AqEmHpttqescCRTWUvH1Y.6VLpGciICzfZYxp.o9xFgnB6BPPqZLibFkuhWZWERJKY_C23uBpSQC
 .9BGv2aKoQ5can0rAz3V.11a8NXslCkW9vUra.T4iV.xebOFdIjG0rutZC6elyUp2wlG6OGq7ar0
 4BaDoE5tMO7RBgwrmNRmCYVaH6bmuBFA961bWoVAaWK1dDxuxEvSGc_GhUeZa_9eyMQwp67wHpRH
 3_xyp_tlWvP7g0GY8ifMC5Fs4bF9t1mUw403NElvafFR9W9_5yRzlt7hyCKDfpxke3O1bK9SDjGy
 h5.hzu4oVWzBptTfGo4aXMfU5jGD_ss.EOsKGpiLczE8_BxNeD4RHIk4g.gAUg6FkM43DO8i1BOZ
 2gIKRBXXQ3_o_SEhzQZWjbf7Ay2vrOitExzSd6mnXfrksWYZvXZNy7EwZpLA8ZISLXWvFgDv1iUk
 e..EoE35qwVAyWRV1Qw8sH0oYuhxS78eQ0OYLJdQmMYXRR7Spu0HapGKZhGMzrFi3zgN5X1vR6GK
 x0virE9PpyTmkScfcJhuLA8wbnKFZxEATCidi6wSuQBZ3To6apcjlJCRJ9iPkKjSPCK5wDa4FVm3
 vGVK1RDP2RsIbvy1kt.uoyPnj_nVfqbp._xMKH.5tMSTBB5Ambra83m_cpraxQzx_xKOBAvYdccY
 symCd3qf5qq_lDy8zDb36l0zuCSPSzAT.8ryPHGUcDuCBl7GZIjtkKYqPUuVIYETbcrEx54u5eZf
 cZqzkuZvlG9OfnEyQ4Wkf87H3x_6J4bEvruK.9e3TCpGcV0JYMm6UmBV_bmnaH4A03kEwkhE2jHI
 baD1cFlE3PFzHeFe3rVhAkLZI5xYWpOVF0yXtMWdRSoeftpuOdz8mlq9mPgRAHSrFC5WSEpDNG0r
 qz0lO4WSX6jIzm9V8H5_0CYqT.hhhizcsHDBxMg5Y2j82MT8owj9x0C0Vy.HMu7GpmRQ-
X-Sonic-MF: <serdeliuk@yahoo.com>
X-Sonic-ID: 6c97460c-e784-4241-8f28-8e2d8036dd0f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 29 Mar 2024 07:33:37 +0000
Received: by hermes--production-ir2-7bc88bfc75-7f2jw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7d954246ec0744b9efc2d2bb63deca80;
          Fri, 29 Mar 2024 07:23:27 +0000 (UTC)
Message-ID: <673ce5e1-edcd-414f-9346-ae50bccd88a5@yahoo.com>
Date: Fri, 29 Mar 2024 08:23:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] v2 arm64: dts: qcom: Add support for Samsung Galaxy Z
 Fold5
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240329-v2-dts-add-support-for-samsung-galaxy-zfold5-v1-0-9a91e635cacc@yahoo.com>
 <20240329-v2-dts-add-support-for-samsung-galaxy-zfold5-v1-2-9a91e635cacc@yahoo.com>
 <4e1c225f-9b9a-4300-b4d3-2fc38c9b573c@linaro.org>
Content-Language: en-US
From: Alexandru Serdeliuc <serdeliuk@yahoo.com>
In-Reply-To: <4e1c225f-9b9a-4300-b4d3-2fc38c9b573c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22205 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Thanks, indeed, v3 will contain the right messages

On 29/3/24 1:54, Konrad Dybcio wrote:
> On 29.03.2024 12:08 AM, Alexandru Marc Serdeliuc via B4 Relay wrote:
>> From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
>>
>> Add support for Samsung Galaxy Z Fold5 (q5q) foldable phone
>>
>> Currently working features:
>> - Framebuffer
>> - UFS
>> - i2c
>> - Buttons
>>
>> Signed-off-by: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
>> ---
> Looks like the commit message and contents got mixed up!
>
> Konrad

