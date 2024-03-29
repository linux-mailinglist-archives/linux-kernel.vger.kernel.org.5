Return-Path: <linux-kernel+bounces-124360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F8D891638
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39BA1C235F8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2EA45971;
	Fri, 29 Mar 2024 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qP0Osn8N"
Received: from sonic312-23.consmr.mail.ne1.yahoo.com (sonic312-23.consmr.mail.ne1.yahoo.com [66.163.191.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD383EA8A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711705352; cv=none; b=A3/JOtTbSME4PAQ7WjsHzm5ebiNRA3/QihggzEen3T6sJ3OUjD49C/RQVbcOeOWTlBiDEBRAsbhJTEpx0FA9Mo/ouXsRB5vR/1cyTCzG2TPXkSVaSa8FgyCoG2UxcGeXgWJYVgAvCmbCTLHPG1guwuBDrkWjDYOdOF/9kf/GYJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711705352; c=relaxed/simple;
	bh=9bhZAagYnhyc0XJ059rEA+DZruPfYX0CNjIi1zz95xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+wkrGDlYh/pZbmgnFiA7M+QV0JWgTSejU6Wgq+qdyX//Ssfh3Nla1k8VnMVTZ9AD49MdFtuhYifp5WQKVslTJA1jZhnNL0wRli/3NSp1SoOjaaGTbTcQJ2XlfTnYHTYW/vXCkz/9mLCqq91iL/52QqDYkg1CdBJrviiYlAA4aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qP0Osn8N; arc=none smtp.client-ip=66.163.191.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1711705349; bh=90ky2frqnuFOvlqQMi/ghKyPwofOOLJUR1qU/c20GSE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qP0Osn8NI+2sycsfgk9wKm3lIhTFhZnu1imhOf6y6JlBeSugwOxj6AIJPvsENjr3Ddlk6g9QrFHyBziSd6RvBusE6A1N/lUbRNpFAI9WAux5QNbW8IypmQXjbNclS5S8ftoEw2nG24KcvtCV9cS2e7QdIUcttBEEaV7gIjfQvdZTQXWH/iAFq+8x29wi9gHmttiA4vuY/Jw28zMMKEE1h0AqQnMts7J1UssSHvc4b5QT68k6PvknJ0SrsV4RA6Ae5SZgo9H75X5oVBqIHOQX//pekxOwTsjr+LuQ6mCARR740HKeRwweUC36N9zvmEVfTK4P/tTtTGO/VERQFrIx1g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1711705349; bh=5Lz6CX0NgTLEJzx4JHl/oxvYgMuqGaWM6umP7DpA9Yc=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=GPn07lx6jzm6Yrk/6j84RzLaq1x1lxcPYtu+DHRCqO7xpaRLbgD/0TEXmuBPUHhz8N6wp7dkfl6kV4oP/C0dx8k4+HcVFBmpVIJg/beLw5jKX2TjE8qMOUZGqoLlluSadCioxRnmMFRsiKX+54nzu3gTOyms2OYZO8DlPc3kOhxUNYAxkRyT916iwTwAv9I4k+qWnzgGdn938TEe0Wac4gRaa7l7kuct0xc76ZG57RpJreQE83t6hapYJbI/ao8wdpyGYuUGVAx9oOmYcA+FJK4eTXT3u5HjUyjWSgCZDnTsL0zssXaHFnCky7lqN4q7XmkYXOTi2lSFNmLwOz9YYg==
X-YMail-OSG: yh4cmsgVM1lWs90KRm6irab9JP05KYEFKFuQqcAN9KfI6ERvehjKJ30CGUB_.kf
 9qJLr.IZhIdZ20DHigny60OIfUi_XunjFqtvqw8J08WWi1wGxuDvMYcYcTIFeaWTNkYR5CoIXvya
 RAzFhQYB3h08kDv7DmXoyfX5808z5ULy0Lvxr.yaO0JTbTEkckjCVIJAE2czjQMWvjU2LkCAdXHV
 3D6xcym3CGp7oXw448o_o_ztbR.MOVHqkFLB71mYhgsSkP7tFjymGqokFkkAcuc9J7JMXhK3A1IQ
 qEaNzY03KVZNrsQfAOsWiOPYAPhtVL0EkOyvIZF7o9klHRIVg16NOFief4uT3Nr6xc93i5wY8sIb
 .dG2WzQideH1b0utr.ChCVB019U6D8AGbIZKwYFBK8pq8dI2iH.jF2xUu4oLcaxZawmhhsa1IO0h
 jwwtj43cBh_H.5zBVhAUK63ewVJQQoW6PnhTol5s2YbACi.u51Lksq7Nu9RwGCq.JSSitmWgNzLh
 kcR6nX6LY73wbOrMsHWacVIWYsvH4yANgEeeucHM1FsbmFE85gthm6p299fM8Vt9nz1QDQJnbwkl
 cSM.up1hJ5gVIJzJtZBRcIgLw2ncZP3.cl7otIy00p1oPjsXmgO9OLuQ0GtFw0XIRac08191WOu6
 9Qts3B3gL0IZHEJH0AQwEIlp4oPCORWA.eOtxsl82fU5wfCXcX000uOyydmHXEaeezIbPh0vsnDy
 iC_eBVJR6xaunn0Q2D18jtcvcjDzRgJakCqnRR3JFRm9npO945BpNVmcGYEHonWXK8iQBqhtuvi.
 Q_W9kveyE0g2XJDKTGAv95r4xKUs6C1XO9usnrvjmu0od5EWJI6ABS482N_Vk2GAyDk3T99V1mlU
 lh14ZaF4EdcPUcaFSuO8rQFq9ClzN5E3aUzF9kmZkuM8FffTfv9jwX3tOikmFsf1dmretYs.iY5D
 eWWEII0glEqo5cQMumGXyzcBXpiJp1dTfB.r3TQ7u5Ajze2n5pPPl.r0wtQqQ58uqyFZ5n3Bzr4v
 J4A0Z62oK1y9i4QuI9NpSRd0don.qGOKoMaa78CiDM0TkluSE_OyU1.YEvl..CyHcRevtBbzEB14
 RpyTE0pw1qE9XhgaiGkfxkSsZJn0pYdxqfnCWHM0fVwb4ASbMAs.sYCwi4q6Wi63YB5642ypeVbx
 rKsZS0f3PBJ4EcjC4Ruv3V5iECqlOvdLltgHmgWjDPcGnXWp1U05Oeut.Q8pGGF61.ba_D5RCCCt
 PD2m7a7FJu4lJ9a1gS5lR4SHgOrssTW4qxSjweugbYBklJ.FQVsD7YW6lBxGvCblFu2KbJs0Uhyw
 a5LW..91Nr4MzStkcyx2kBkwlNTJ2nUDalg2iVp0aj4XR_u_Nqsg1AcK_8ofYGIekEFU_.4fu78a
 mu.TaWMhLtLIkm5i4L_PLVdWNUxlNgX2_9Z9pxoJmSDty8SUy9YMv7e67rhKAonr2mJWxW7okiQy
 NwAbbdzivcsWNZFApkrBSbOeIHklLwFd6TPleGAH.YGFDEekbCKIdGnJR1u3R7LKwFy6s0OAEFWL
 6um9XeuxS.AzKLYCKTb.WfWmJVIlT35KKHVVjm4TdCeYp2CsDyYLsEzjzvlPrCIHiupYJ3P.Wv6A
 K7wpIg7Q2UhRK49yKiuj5eDb.EwNFItbopASgmwnxlBRkp99i22vQ7Z8pyTmpdWGmSXn0xCT2T8u
 zE2cjIHAWdDCl4.TD_sQPP866rQSSQBY46o2MpgJmLACcctpnOn4FlrlMvGn4swPiJ2Plmx2VBWb
 G2ppgVDzKqGAC.T80gGw0loIiFAj_F2EvrmA0EGHHwF0KgKvoObCj.AemNmxzrclB5ACVOnblKx3
 z1F6X6Sk8Scm7oSezNvXFHS9.6j_HsNxnDfQ2F6lPQkR3AG.Lw5a6YLFV49oNZOIluQdGKwXQ49m
 mt_9LLfT2uQUg_sydCCg8EFKzRC.U8UlWCH5Hn_5vZL8M45BIJowqr0Klxz8ohHBcofY9WM6Z8F1
 ZksSuLQR9g3Dsh5nmTdGLA37SX3tP8h.LvZyT3G5MrHr30p6X2XRBFGMg5J.P8bdiQFFuS7fIreT
 hCzHSq7otEpSSMhXvR9lij3vih58GM839p4we9g1jtxz7ioLdKbKNBWe2liJoScN1RuWXYgluEHV
 arvmz0ser5QYaydCr9dWiTOu2Jz.X.i6pWxjZPLVgDQ7gNGNu8ZIiIPizoNyl.H64TBgF_.1DTMa
 VrhFhBys.Ly9PB_bLoM2F.7J6y3f7BUKrEn_NqCIBI_Y9cgVY4bmC4vBMoW2YWgmoWXM-
X-Sonic-MF: <serdeliuk@yahoo.com>
X-Sonic-ID: f2927a9f-48fc-4dd1-a7d5-c578f13d313c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 29 Mar 2024 09:42:29 +0000
Received: by hermes--production-ir2-7bc88bfc75-9nfhm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 765ec3141b99f80c289d78adc4080c41;
          Fri, 29 Mar 2024 09:42:24 +0000 (UTC)
Message-ID: <5c9523db-0cbd-44b7-ab49-4ef0ee48dd80@yahoo.com>
Date: Fri, 29 Mar 2024 10:42:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] V2 arm64: dts: qcom: Add support for Samsung Galaxy Z
 Fold5
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240329-v2-dts-add-support-for-samsung-galaxy-zfold5-v1-0-9a91e635cacc@yahoo.com>
 <20240329-v2-dts-add-support-for-samsung-galaxy-zfold5-v1-1-9a91e635cacc@yahoo.com>
 <1cdbd387-e937-4d5c-bedb-b4275fdf84cc@linaro.org>
Content-Language: en-US
From: Alexandru Serdeliuc <serdeliuk@yahoo.com>
In-Reply-To: <1cdbd387-e937-4d5c-bedb-b4275fdf84cc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22205 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Thanks, i added some notes inline as I do not know how to proceed with 
some if the requirements.

Just to be noted, the sm8550-samsung-q5q.dts it is based on 
sm8550-mtp.dts so most of the stuff is from there


On 29/3/24 1:52, Konrad Dybcio wrote:
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
The [PATCH] string is added automatically to the subject by b4, I don't 
know how to add/insert custom text in there, I am going to read the b4 
docs and see if i can spot how to do it.
> Your commit title now includes "V2". Move it inside the square braces the
> next time around, so it's like [PATCH v3 1/2]. With b4, this should be done
> automagically, though..
>
> [...]
>
>> +/ {
>> +	model = "Samsung Galaxy Z Fold5";
>> +	compatible = "samsung,q5q", "qcom,sm8550";
>> +	#address-cells = <0x02>;
>> +	#size-cells = <0x02>;

thanks, going to remove them

> These two can go
>
> [...]
>
>> +	reserved-memory {
>> +		/*
>> +		 * The bootloader will only keep display hardware enabled
>> +		 * if this memory region is named exactly 'splash_region'
>> +		 */
this is a reality, without it the framebuffer do not work, due to abl

https://git.codelinaro.org/clo/la/abl/tianocore/edk2/-/blob/LA.VENDOR.1.0.r2-09400-WAIPIO.QSSI14.0/QcomModulePkg/Library/BootLib/UpdateDeviceTree.c?ref_type=tags#L220

How to proceed?

> Ouch.
>
> [...]
>
>> +		vreg_l15b_1p8: ldo15 {
>> +			regulator-name = "vreg_l15b_1p8";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-allow-set-load;
>> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>> +						   RPMH_REGULATOR_MODE_HPM>;
>> +			regulator-always-on;

I have removed the nodes that uses this as the driver for "Texas 
Instruments i2c eUSB2" is not yet submitted by the porter, however, 
those are took from the existing sm8550-mtp.dts

How to proceed?

> Any particular reason as to why?
>
> [...]
>
>> +&remoteproc_adsp {
>> +	firmware-name = "qcom/sm8550/adsp.mbn",
>> +			"qcom/sm8550/adsp_dtb.mbn";
>> +	status = "okay";
>> +};
>> +
>> +&remoteproc_cdsp {
>> +	firmware-name = "qcom/sm8550/cdsp.mbn",
>> +			"qcom/sm8550/cdsp_dtb.mbn";
>> +	status = "okay";
>> +};
>> +
>> +&remoteproc_mpss {
>> +	firmware-name = "qcom/sm8550/modem.mbn",
>> +			"qcom/sm8550/modem_dtb.mbn";
>> +	status = "okay";

Those are took from the device's running Android /firmware and load 
without error, I used this kind of firmware loaded on other devices as 
well and seems to do the job, the lines are as well on existing 
sm8550-mtp.dts

How to proceed?

> Unless you stole one from the factory, these firmwares will not
> load on your phone..
>
>> +};
>> +
>> +&sleep_clk {
>> +	clock-frequency = <32000>;
>> +};
>> +
>> +&tlmm {
>> +	gpio-reserved-ranges = <36 4>, <50 2>;
I have no idea, i took the ranges from  the running Android FDT, without 
those ranges the kernel do not boot, i can dig more into these ranges if 
required
> Would you have an idea what these GPIOs are used for?
>
> Konrad

