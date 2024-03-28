Return-Path: <linux-kernel+bounces-123099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6EB890226
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769BE297CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD64112BF08;
	Thu, 28 Mar 2024 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uX75/+yJ"
Received: from sonic309-20.consmr.mail.ne1.yahoo.com (sonic309-20.consmr.mail.ne1.yahoo.com [66.163.184.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D714127B66
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636988; cv=none; b=aZop5k/qO7p5kYuLX1Py2oebFScz1dWjUGN0AGqfR5AoUQG80TlrrhggqXS4DuOMLWkVtsmmIu1oM+iHR4hna3ahlPrsfwN5h+4NUVyl6TonIbXd5ajv7eBU1uZZvPrb8AoIxik4icztx7Lajm49hLutINWPZnJPlSK71Wa8vXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636988; c=relaxed/simple;
	bh=bZGqD1Qko3l8gQBtb0dEESAh+VdOR3Psbbmt/CLYtqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gdwptpn8HR2vBkDWgOgi5CKoaqIfkJ4hH+A0xC+5maR/EO8cpBnO1bWLnKu4S6jnBu/7HZvgBM4ovj8HkhSdW0EC7GcvlCM3sG6mql94Yv7LwVvsvkWJ9ck5QXaS2VVqfNAjeIkTZkCYWc50BhYkCjlnbkw7RneXKQfBQzfXVkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=uX75/+yJ; arc=none smtp.client-ip=66.163.184.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1711636980; bh=g1anJ9SArd8svSUwZTdW2RVW0ATJLmdpNNQgfHQxsYM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=uX75/+yJGtvxLlsg8k6Osju8giMukFoeDCN7vRznFDRe5fTD2qwi91ES1HWF1OQGcgYHkgsAtkl5qAsUYCJNmvwZB8CyVRHX7Ww73tZnQNVcsQEv3ZiU9DPba6j0zUeM6gOlCXbfoG3M6QusQHFSkYSDaAk1UEji40EjDEG1gPN4s/tg78D+hnnFYts5qugnwL8b2wk6OO9NDQNuW41P88me8K34Rd0f2hbCRJNJczhIupN+/Jlpo6LY3wRvOYEtd01KX0ZgdhhM7VlgEkN6MGwBjm4gNKspt7VuvXnvJ+1c/bZ32/DwMjxgV7yCe8HHGHoAyFoGJ/MF+vh4H2HKLA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1711636980; bh=sEeIUzNwSaiytCMALB8Zm+O498jy0t7jmE7z6F1Veqb=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZrYNoncDRxbXgTW6X/fM01KS7QuH58t4az+INfb7IjPbqdwfWL6/dPcZSaS9TZ4V/8OqfpE0PH1VDssPjvSIUzuqw+GO94Pr0zmIWnNGN8GtbfME0bUIPlI5LAwp4On2E2jtrANTmt61Mk5I8PAIlsStc3JW8JJXPN57NUdMybp+T3BQ1pZQHdh6keWs0rnyaPzLMgNGw5bN82trQ7cVHqfNLE1GhFNDbyLYhq8PnJUDeHEw3QyFsyFfxIVe9++C10Cq6Kt+qG1QKErgJeOqNFufNHI29y+XC0pKUxJnY4VTVUSvukhXSvE3dWE86myBHIiJX5xL9lFi1V1fPYJDCA==
X-YMail-OSG: o0BZUZ4VM1koiDp.F2VfpVIV3CO06UgKnbH3BsGIhukliMPxbb8_6MPmDXyY3fo
 WD1ApgEFpUur3Z9.QpznACQZAA8pSIHjbS6exB_n7SYTaly.HvyR.Axg.XKk0EDAMTrV8N_5jEHZ
 wT0H.yQakV4eVsKMTHyuwxJzDmMKW6cKq56IXluTmZN8pEUFx.VGUwzag9VX8qqAMDbE7CRBqgcr
 X0bKxuZv1D8T2n8jMFBdfelZzPHv2gDak3oRQVrh0CnbJ8fzzKz6uGulApwx7TN9ssjb4mpNbuiX
 UmPYKHcDBoXH.H_atFfYmAs5iOEOVLmHVcGeZ4uvMhL1aszEejINoMY4P6zH0qbUeg5v53nJtXB8
 jb2oUnebU6W.hyzJ.FlgqAgqK6u5yhC218BWbqs6QfKhk_XC8ClrUgVBwDPaFXblqIz74j415Cll
 6LHafRNAHvqjbwbulO2eTkIUhld6lqo27.W6QkWWJNkYFLkky3_5Tm0ZC62LsKc90aRt8tc60Q0Z
 bJbOVu0HUk62soWwFJHSwDcfuNCs.lwfJNwRhuSh8uu3Xh9qyzU6XRCIIiYVNqGrBEedZlhEr6ck
 B99TPDGfnzHhIIDjYkTOkPiGulmkR5e1uI9a0pwgOHpWUGUiFgnrTbpqQ7Ik_QyllwoBDn5v2.c6
 FvpZ7S5JDl7FwoGOsgjook.2DDm6t6xK5KHe5VmLjc3d._21ge.yq4CcVlIK12bpDo795F4rkzIB
 .IJ0d8QTRWYzAxnxQF38Gh1ISGryzTna3WojPgEpG7MDmmTxC13HWdCNydn65auxqdBSJqYEP3s4
 7Hexq_4s0BnMfsSlU4pW_ege9BD9f.m7OHpfsklBHt3IdUuzEqbtSlofEN.dFs4J1STboGDJdBf7
 bvNsA36OzbHNNM7ZKJiXmUcCOcFJP9PxrjLxgtoC_dNmIWAH8DWyR_eDSWhHv2FLU7fUktEkDjHW
 5ebCXkaPfgQaRSHRhzYGSv0SQKN9azmdFzm45FF7.tRBYUTWQc0TO8CfPaNYM1rIIvBTGvMeK5ld
 Oba6R49xybTzKxhJEsDlOJnOQKPolzvUe4C6hpxp3Jmd_jJKw.QNcOcwYxcQDe5slVam7bePvOC7
 e_4OMbUcvQ2Q6dUj4s1GI6vOf4JyAEun5SX1KOIQlSKOxS5YI_T_2tkBpwQAich0cKrQY1I85_R3
 Q2bVX8jghiU3yZVhZDbvDxXuTCEOuoruxb_736cZOrsx1xK_rWpfvIV9_RfcjZ65b7qEzP3RFeNr
 sUGCRuw5ZkvGKAgGtcnzdbctNW_6CpYtxm6gmvejTKgbiglKCGlnwb76TSSZDIYC.eAM68_EVSK5
 1loBBDyYxxzOAUqftmXIqvSZt6TCEN4LTPHZAU1nXxZ..OV7_InN17arMduCktYDbFOqTBIUjLjE
 synLShQkYmEzqRYBmvTELvpVpWq61ondtj5v88NVK1rjs.9uf8GzyCni3gqTtBa2Yfx0Vh33usO2
 _j4WbFxaBqi6DGnt1JVTvXjMvoWHpETop_wJngUzr_sfpvEp9bqBdRS1AjflBgvFX1SQ6X8nsC.O
 TQlBtgJJtU1lwHjyOKtzSQjNEVOhMlvQf63itd7O6uVIgre9zX1C2Pwj8iLB2YwsjIKeqQjpX0NK
 QdiMFL1bVHj0t1R_A4QRQbBMfBIfLX5CcIpIj4NnP9Hf_NhFzi6OG2Q5V1xOEym20QMX4hHNtn2x
 JOVU_z434g7R3zvZ53.64LbaGhVo.50kLrhEUU5oGSk0kC8DRO16A2XRj.hZ566xfGxZ0HzDfMAW
 TRPnvco6wP37dcowsVlnCP9ysaH3Gwbras9jpGUlp3FxlbziG88qZ0ZXb5vOFE1ufYRjFdn5Yw3v
 Azc4iYnKdYklKSaaHVwyt5dgAgeQHZtJO38_ajM9oLr9NxAQETpQUnmyYnDQx6LYpOAls5ubxCj_
 BcjC4Ujjb0Wx9P4ZIG3YtRSqBAijcUYANXhWOcpqvfm7YCsN4Tp6m93nG5gsknT84Id332gf3D1i
 csn4EjZmyh3f3vg.k3DKml_xcbvgzS5cdANOV8ACozyaaT1hMQ5kt0Ax1Fch1PHhvSK7_A4mIvrV
 knMBmNwhblTziQupON4neJjMXYOhrPccAmJQxxd5RuRzqKikp581Zda3BWqfqKRXYAcY1G2dNdSy
 ZZt5zauvTXG7sc8NB806HPJ6Xnz3R2MseY3G9d4pTdM.UJF032qq.A7j9uNS61FEYyw01HSI2eAy
 .170qRYH6mduThmmwO8wv5JuEdPI6n9w7CS8tLsIar3MD753eGTtBjL4WdXY-
X-Sonic-MF: <serdeliuk@yahoo.com>
X-Sonic-ID: dcae60cb-a63d-4564-bbef-99fbb1cf4b6a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 28 Mar 2024 14:43:00 +0000
Received: by hermes--production-ir2-7bc88bfc75-ll9h2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bd83f5bdb12ca9d1f475c97b948ec81a;
          Thu, 28 Mar 2024 14:42:55 +0000 (UTC)
Message-ID: <33e23d1c-5b6f-4111-9631-0f8db1100d0c@yahoo.com>
Date: Thu, 28 Mar 2024 15:42:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: arm: qcom: Add Samsung Galaxy Z Fold5
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240328-dt-bindings-arm-qcom-add-support-for-samsung-galaxy-zfold5-v1-1-cb612e3ade18@yahoo.com>
 <ca4ed5e3-32ea-451a-82ca-25fba07877dc@linaro.org>
Content-Language: en-US
From: Alexandru Serdeliuc <serdeliuk@yahoo.com>
In-Reply-To: <ca4ed5e3-32ea-451a-82ca-25fba07877dc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22205 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi Konrad,


Thanks, yes, I am new to b4 and sending patches, in a few minutes I will 
add the second patch.

That actually add the device tree, but  without the previous patch it 
showed me a warning, and with both patches provided another  warning 
that i need to split them in two.


Best regards,

Marc


On 28/3/24 15:39, Konrad Dybcio wrote:
> On 28.03.2024 3:31 PM, Alexandru Marc Serdeliuc via B4 Relay wrote:
>> From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
>>
>> This documents Samsung Galaxy Z Fold5 (samsung,q5q)
>> which is a foldable phone by Samsung based on the sm8550 SoC.
>>
>> Signed-off-by: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
>> ---
>> This documents Samsung Galaxy Z Fold5 (samsung,q5q)
>> which is a foldable phone by Samsung based on the sm8550 SoC.
>> ---
> That's very welcome, but are you going to submit a devicetree for it?
>
> Konrad

