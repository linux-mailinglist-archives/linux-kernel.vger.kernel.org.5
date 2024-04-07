Return-Path: <linux-kernel+bounces-134302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8606889B013
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324A228222A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6314014F78;
	Sun,  7 Apr 2024 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aATv4b2/"
Received: from sonic316-21.consmr.mail.ne1.yahoo.com (sonic316-21.consmr.mail.ne1.yahoo.com [66.163.187.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376C914273
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712482329; cv=none; b=qifIV94+iYTP7+CxxBCiNM8Nu2i4NhNhAzHEuw3NyYYLs5cQS5P8ZeKqgji676hLK+52uMyoO3ku0sCWYdC2/eRRaygCsTgkx1YESlbjxVQ8rAwF8aT7yzX+J09ksag4rVrmH7mVoX2Uw1xEhSy4p/I0h5Zm6ik/2Mu/YYqUvB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712482329; c=relaxed/simple;
	bh=IWTIjbsO7ky6wjX0WM/09NBDuwxkAXd4zp0bVFc/FtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5ooDh3QoL6wAjfaqo0/oQOuaXs73RNYQvIR7TPSCsQ1YA024QlBA7eu8Dvxieu0RmIYkUFGqK74dMCO5fMSl9j29rAXHhgsCHZ9MWH21aMB8jye/xW3C5iw7WvAzvfLta1+3Ba8hu8rNgVWRlbk1F6DtkwIhoA8Y6TmI05JcF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=aATv4b2/; arc=none smtp.client-ip=66.163.187.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1712482321; bh=hB89fBU1gf++hm9muSsqTrPVUIEBVDR5AlHXJ0AmO2I=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=aATv4b2/X7TkNcxnTn0JM5Is3RlFzFr3iDiuebrWv3S0qdGTAFBefWbN6TRnWywJeOwSEISHymIt1p4KZHMyhhsY/081nWVpwklxP8U7iZi5GtNK3qA2nM/82DY5q/eZnpC4so5ryFkn9iFvdwJ/ALJ0ls/b/3B+9VZ81+yxRYHNyYCwVF4AqNb6pglQkgHkX92Dw2wlHpRjEVA7xBf5oDGk7EZCMl6Ult3CTMH5PkQ5m0dke4+7RxrNvDTKxlnEuiFOzCPLlQ7fCyN/VhsTKlB+ydTRXy6RxntQJQRf+4ytpzUVv53r0YyINshP/G0dkh1cZFwwe4YYlXxyfcyREg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1712482321; bh=hVTz+bUgigHMvG+hBoTKtdLfZtu3ty/x02B4xSuM/u1=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=FUjaXqBoZ83PxBIq5b/woMVen8tPmm97nsijgR8NKUPqiX4j3aYwLharxtTbQPbAaSmaR3p5SCDQfc8O3IYn+LsMtEtk6gZuTkcFSU7i9TTJzOB92zqQcYRoGwuLgDqTjyLcswfXzQXGz8Loc9VsquJAeXLjFrxgkkKd+rBtV1gzGgcRKSgqJ9S8gJODsZ3Rf+JgwCj05P+j5TFfJ8PyLYTyCydB7amwcSbEggHb9Dj4RS6CEwEdq3Fa74rnd7P7fdAcsUbyzr7UrgD3z6nSteVsPavtg1N7EVZpuolpn9YGH3W4nSPGsjaKkcy3MYp5kF1B7SePZAoeEwvT81m/rQ==
X-YMail-OSG: dGKwT_QVM1n3ifVo18XuI4LRTSPwXAO6P5PcF2l1dl64t4U2t.sYjZZiVgjHv0V
 qihZU_lDhdrunQ_5qCvMfvpoLBIPOEYYwS0n0zbYYXkKdJArz8m5ZLHOAWtTqWt7gZEXCb6hGbwb
 LWu5n1OXUmVhYsEvCgfYHxHXgZ_WYtINsrYkcQ9Lyo8GyQh2M5M777pWRnukDkJPFRrjhmC2.tCW
 PRIs3myAr2sZNbBQ32f2MWqmbmLAFJYJQNHaLi0zIf_IHEwGqz9Zobhd0.whhkvYY2T75xbgPPGP
 xR74WzmFvpeUtTY9XWcugO1_uafbr0CMzpSjdO2Gm586zgugRXRyVadAO5t6LFA0CdjrvkbgVauN
 fEIcazDy4uy9wcP..DaKv5GdQKZRYl5XfDchv.Nn36j_yoqsn4khC2f7OWeCe3KsXMpLGJOHquiX
 zrAYe8giV_IauUvGGW.VdkeB8z0.5wIpCFgsJK4sIH96nKOQxNq8ZAvyN1DWhLzsU2Imoht6SkEX
 O8o1aw92ULb5C8FAoOQbXf_PKVggnOqQr90UXRNf17.mtCpsrF92dACjHAHYwbdkvk7Xdl_Q6rwW
 eJpAAFY99Agv6cbfzXJDGmRPOjH.4icNj3k02CXNParZTBMOS6ACPxoYpK2SwaUnPPTfl._HTE8w
 Y3nSaB7Dbr2_W3yal81a9pswfj5Dnurq5vaMAUR7aIIEUH1nIskobcUuxs_xy0ijR_a1YnfQ5K4C
 0C7bEsQzdA0F0CoJpM_AXWKSWPBDuEDTqPAJeosDGViV9dGhfSKwIebILSbfQLVaoD.WwelKhksQ
 5T53dwhAe9YSLkY9OQvpbYvdwIutppHJ9dUFgB9Z435ryMUjz3VT9qg74Zk5knxmFxSUu_8wHRWg
 YmkZmFU7odBxxsE16IvDyHd9r_rDG5h1RFBt0NnB5saRkqbUj3LUYKvlmTeKAnWxnOuo5b_LbFFp
 qYQvrwdDEWoGVtuk4UHAJg0S_UYc3YA.mBI.OqoDEMCqgPucik_v8BlTzl_xVujukcLrSU1F32ZW
 kEvkUTMoOc0keC06aRNIq01yvLVTAsPSzs0b_Rt5puCXg_gImgU0EqGrp_4dAtvce.wqKvwORn3I
 ypvMkVIOvTbiRdIPCQQcasEUi4tOTExhpOUu5I_uV7bIV1shVeCOXpOc8Vf7JdGoNUxs7vLO7ukc
 8vYDqmkqD0hXIiBva89ncUCo0TqFdrgl2TUYkVbs4ppEbS.gkClYfXDObHJOqxc1abYUoav9P_Wh
 rK6hKzW8hH8mWJ68th6VkBDHIPikS6FsGRoHVqZmNZy89s7XXfW2ueAveP3iq4vGkpQ4gGv4bSWr
 .qZMdVQ39EkybBb_7q2AHYx6PiaaDiIq5RqkbbvH9RXSH.X.YK9vwzuHNa7h4Kxh27n._uXm.c60
 fwYuzERMPz9yTijROWbMThW00pcLv7sbVuTy725UqGSErzNWZTdJQOT6nyJpnMGH9WF2uFGKPEUe
 2JgmIHK_ULnjp3knTmyJL5ng.g6ABYEi4tB9WWwD6U9BEr8AQuHq7Qu4ni9vaGyDn7JWuv80XKvL
 ftqw9w6wL1b1ICl_MEnroY6W1AMwpZJ_PYMwgtmReQpgri1N_mMv8aRLBD7fS_N8spmGKi9LfBAk
 5upaHNFUgHq4NqB6_NEmMJvAUA9fTb42VHaKK_fXzJTaht_W9TDrPqTUqS0j31A0.u9vLih6El4L
 zmu4zphZOatD3LWiPPaGdDG_8..kpmPmgYei3sVWvW25L2CsB4mTE4lyrQimVJFCQjHz_sQPFi5h
 Q_C4gVyLrwJcmD_KOeQT1q76YT.o14zuKc_g1_KcN5EabrYikFCdwd3dq6hid_UJr.KkijVjZGWc
 vo5hBOQfyZX19XyKjSFE08YPYLs4N3Yjj4tzhOT1M3XVjtE5bSggTClqoQWinRDGlSaoaagYYb_K
 _CoUBaKlnZZPSEHhsN6BAfrxArHrVMOHZapsJve.dKBCyTGGwzLVUlHiJWUCJUy4jBt4PgtJ64Ud
 TIbjW2ukuWMAgJ0IfsfQaecyfKS4WKUkmmOv35m4bYVW4Bnz5o5_tiF7MGipapWVIJYM3frYyrbZ
 nuX56YxABuJ4.ceahe8liN66hr20YduxG4lzl7G2abvn_s6ugpsS0bY1xbcUQW84.SMjoc5gpExQ
 xObw7b.k0YGcH35IQvjMyL5KhkzFjf6p0FJI7gATFgFptEKWJQ7rwnE.mQS91dy3N0rikwbn.LjB
 4GKRiGrKsLKgEX3IgbPKh.F7oW2R4qH3L39oej2KPN.iv75dImcIKfQA66d4-
X-Sonic-MF: <serdeliuk@yahoo.com>
X-Sonic-ID: a0bca023-4f5a-4498-a152-d9853cf88d13
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Sun, 7 Apr 2024 09:32:01 +0000
Received: by hermes--production-ir2-7bc88bfc75-6cqn4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 69da7276310ac0065901e6077002f504;
          Sun, 07 Apr 2024 09:21:52 +0000 (UTC)
Message-ID: <46ca8527-8b3e-4894-a1ee-8f2663e457fb@yahoo.com>
Date: Sun, 7 Apr 2024 11:21:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: qcom: Document the Samsung
 Galaxy Z Fold5
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240407-samsung-galaxy-zfold5-q5q-v4-0-8b67b1813653@yahoo.com>
 <20240407-samsung-galaxy-zfold5-q5q-v4-1-8b67b1813653@yahoo.com>
 <32b01e4e-dcdb-49bc-90bd-a75bb34c5b1b@linaro.org>
Content-Language: en-US
From: Alexandru Serdeliuc <serdeliuk@yahoo.com>
In-Reply-To: <32b01e4e-dcdb-49bc-90bd-a75bb34c5b1b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22205 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

I am terribly sorry, this is my first patch sent  here, I am still 
trying to understand what and how to do it.

How to proceed with those missing tags? i should create a v5 and add them?


On 7/4/24 11:01, Krzysztof Kozlowski wrote:
> On 07/04/2024 07:38, Alexandru Marc Serdeliuc via B4 Relay wrote:
>> From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
>>
>> This documents Samsung Galaxy Z Fold5 (samsung,q5q)
>> which is a foldable phone by Samsung based on the sm8550 SoC.
>>
>> Signed-off-by: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
>> ---
> This is a friendly reminder during the review process.
>
> It looks like you received a tag and forgot to add it.
>
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
>
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
>
> If a tag was not added on purpose, please state why and what changed.
>
> Best regards,
> Krzysztof
>

