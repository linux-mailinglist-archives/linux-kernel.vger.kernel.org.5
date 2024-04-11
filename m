Return-Path: <linux-kernel+bounces-140162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3DD8A0C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BBE01C21E31
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5007B1448F3;
	Thu, 11 Apr 2024 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mVpdCujo"
Received: from sonic314-49.consmr.mail.ne1.yahoo.com (sonic314-49.consmr.mail.ne1.yahoo.com [66.163.189.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADE762144
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827482; cv=none; b=rhmXgCp9L8N5JAYKnHlywoswujnifRaXU7f3rV/z/BESmOO2c1On6HO3DZQ7Abfvn0aYPLfyAtYUldz7YUDgej5Du1zsrnkX7OM5JZLkd0ggWaGl1dkYqhiDTE3pizadEgmBQMGGenlUV5yBUYJeOUIVIFiey4qwreqjtE0ujeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827482; c=relaxed/simple;
	bh=nLPiicAZhj668D8fB5GjdtT8makd/lwgyoDBhv9tku4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBtDmWRB8qxH+Xu5wigX/WPgi6BtkbUAXSp6Wgov68OwWaE7hgQ0IJ6WrIQ/chzJdNjuBOcD5bxidYsZOKvQCyMTWGg2iuyLMm0llZmAs/dVZMy36IwoUselpOeE9YtikEOtLBmMyIWaxzyHPVaXNlTx9HectjQ/DrYRfrsCdpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=mVpdCujo; arc=none smtp.client-ip=66.163.189.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1712827480; bh=FyWFp6hm6KQidmYIN5llczicdOuEw/7yhwY+6fnIACg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=mVpdCujoXqkudL6nvADe6ksa8N1arYxqtff3gljjxJ6FBxjUVF4fbnQg89s+bhurYGJiTUhQvFrUXl0D/r9uFywVcLdTteFJEY6Qs850pD89YB0UKbnk4MFtPJ2uC3l0Y3ok9e2KlylfZrWaZ/c4sbzqlfLwxnY8p+S61YhdnfLMZJ0r3I5222wDpxbug+yWGLnG25sovVUdyVXahVRDOc7MLtI9cYbpXT/aS8H1NXquIqfsFs97akTtezpSmgyicRarvEQGGgS+Jg8hHlMdTbBOrxwJt2quBTbWmudxvKaLYbkfbK2pvHyu101BYdwh97Rcdipo5sUnPn6U0K/hUg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1712827480; bh=FnYBwzj5nDJXkDnV2eAZ/30GyLbTw6A0zMmSoLeSKmK=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=lkEMBOSgQMofSkdTssPaKC8BFDpfHBl+upex5AHA01fdQMdLW7cveIOh0JE4SY05ndtSEV17pMd0v4oF/D4WcT3aso3o7WOTDbo7KICAYQ8e8TQCMNS/JrgQ0QmzHqSHk5j9yMBf58gFMUzLcjrcXcpcwHQZ3lJifNERMQhCDQ4Wfd34ctCFLvH3lhOaXOPaenZ6ulpLgct4k9zEgsN3xFE6V2UYZlLtZA9ZhqIS+HhvlnJ2S8C9JIp98jf98XzYtaqAjH3vhW6akizqxLcC9y5kMb5l2AMvqMUIn95qD4IJIyX1/up/a/Wx0+h357ChU9fPtEu8lIbqrj5mHS8ilA==
X-YMail-OSG: xZrHN7wVM1l5H.UsOGDFs_zafXNU.i3oIrg78LRA65ku141t9CeluXwNsIB_d3d
 TrtAwy.aspM3NqONvT5ZbSlm.6agHr6SgCIvyijrkIZwnYUiPf6PcQCiOx_YOi4cd7VT6Px_pFdG
 a.49GeBuMQLPf8t7Tvko3XOrhVpT40y75b86nLyrhZnY8nEquyH.s20Z7XW5dGkqv6Jfewa_t_AG
 vWspCTJKiy.hdPhOIlpJkp7omrguNI3zQyCL8gofSd28xtBOa2HyF4H92u2m8Qmk2FDAJE5JyGac
 c.z02hcnVjc3G9RlOx4QOg3c3Gan8FkNIFtKTqy.VjsznOh9JxMzkFv8YxyRhX3gaU5KJVw9uIBU
 urfe_IhCh7m6QtdtmpJm1wWLTED0aWbSNWsoAHQDQF5vZfKWDoakzL9kJxwDpFogfZAohOPSt90G
 gxD6bhsZoEbRDFxFYqbG9Gb7BGyYjQQO.LO3ODtT8Dik_xof9x178IZ0PGUzfFmAAnfvo2Z64zL6
 kLARV9ktmuPGzKbFZbAPGvHd3s7x8i56qM_MSsOaEC_YY_765Ls2Wwsd_l.xOFldlVZd.pmHlB9V
 LXtfcRhxTCuIYMekpXx.FAyFylvfL0fMVN_4dEFqJPEc60CwAbHk9c5uBA2bFKGYTyVEQO0LpoNc
 oX9O3l8jcpC6BdtKSgEP50U5Y1nYLTzqtTrFIzSJg5I.ZDQSlkncXGu8aOrLUwyXFsU3RRQoNe8X
 ecDFq5EDQJkS7IRTugNK45snDf9YIp9fhUwEGl6FfZq59PTFEjaPLzZAvL8zYkn08z_C6hF7E4Ca
 kXm2qD2FBE7HMtWfTbcSSNvIBLQNFFMrbd0AZ17gKYvIjK7ajQN.tlHuqvZte9SmBgxT8yZ.rNrg
 itZGSbk9megmg9z64AOrAvNHG_ro0k.GTa1KA3JSq2P4MjTYxaWAN43UKlkMgwzJNLQhbE4I.zXm
 NJ7MjRBGR7vXo7sMQTNXL8hkyoThWBoG3MrHdcP4PMIyZgIfqK5CQ_1e0WD3ELubGBjYLUpy7dVm
 ZbAGL094fHfm_oNHTmNxapc5tR2HV.JpKNBxyYQ12nLXErhvzYHx9Eiil2tgMy5QE2n8gc1QfMNO
 9D_V_lwMcG18yaEpUAzPWgvYMXhgPBwqLY1z5WVTd.urStmDFHsrcd9d9ncWTketiXCc709CYnu7
 CaPd1.trCMGHGzpm.Yqj7tSY7kNgcDZt.GeMSUmL6z7sTppU4nnslzE9rxEn7kgDEW8wmOQfeb2H
 P1OUZYl7WfJXUJ5FWWf.fqXAomWmne8zJGpo8ZQagVR4dYQMHdMZ.B75N6bwrdfvZsCyNC4kp37a
 Dkjn9hntOvGen1woUepQfndFbzZIfY5fzD2YzlH4xBrPOQAY1cwT553MZcp0gixoViWD35O_6EWV
 aL8x8AdqHsvIs43.tUYeaeg9jGLCapDv1t1FEy1NhahVN9htkjvxS6SIQXjZvWxEZwhzHzxF0GjJ
 jCUOyGA52SChNfzJHy4XBIonOEAg4p2LA2lad527efIy9Atz2FuEDVzGwscyUdT1aY7J2T.Yx6UQ
 fnjgQORB7YZEIl8tzzF5bKnaOrvtzeNWoTMHQow9hUJ27F6KDHGOB4eZoIkAxJcIp8U5zpn2Za6k
 AVZWB4dSOl7tb1q3w1aYPGA95eTchKlyhSNzY68A0xio5IqrtLl7HRT0F5bF_aYV.PGYi53sWsKx
 AAy4vYcfk3f9yNJL77M2zoPg3MI4AGdYfaVfIAev8gs324Z9PtlALe5sWUMppeLquFAzzHGKEqCy
 0xZI9VGU7XMj6qtNv2_Sy7KF9doWjRWd_y3PGSKrXjTyMNcfDSRxuYo.eBPtGAm.kNBBuLl_JBrn
 Bx_hYpWI_1z90d0Y9K_GBKbsl8OSa8OP1ah1ZboR9KmMWSl2FO1uRykFHyHW6NK3qfCUi7vxkzuT
 wLJ6BxdLTeaNGRdLzGIy093CUxr7Df6G47Z6B8IVjJ.RgwgfTSX9.S72mRc8AZL7wwAFJJZVCj72
 R4ynTaw_mF5uegDB2L2XPEQNc2dgiOUOWVjt1xJeU.gD8AWCKYHQ4MtuGKdNTK0gSAi2qgxQOP7v
 t5pLpqoabvDOJp8aYub9x5uWbKAF9GPuxFL7G0Xu4cKCYEMzOUpZgdzZ4f9MYSZ4cvXTaX144PLI
 CBqB1s29VxdCXOhK06NSEuprjEFYW0Q03EtAs.9Rmk56xpS53s5ABZRvlc2aKdIUI5soq0_SDNzM
 oGMX69jpCrxVUFEO7rJwEccD5doZ4aNpXHDVInXL53m_5O49Zw3PU9QNYLNAeskqYVIpC4i9yge7
 I58ObdBfe.hu3yYjurfw-
X-Sonic-MF: <serdeliuk@yahoo.com>
X-Sonic-ID: 3765697e-1a35-48c8-acaa-1614da562948
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 11 Apr 2024 09:24:40 +0000
Received: by hermes--production-ir2-7bc88bfc75-8kqvj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4610702f466598076d8aedf02a619181;
          Thu, 11 Apr 2024 09:12:31 +0000 (UTC)
Message-ID: <13e5f1ee-a036-417f-982b-7fe8ec6d8f1c@yahoo.com>
Date: Thu, 11 Apr 2024 11:12:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] Samsung Galaxy Z Fold5 initial support
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240410-samsung-galaxy-zfold5-q5q-v5-0-9311ee9a55f7@yahoo.com>
 <8f2c7963-c660-41b6-a93c-0ac19818ecda@linaro.org>
 <46bee5df-3d66-44c1-9d7a-86e32a2149dc@yahoo.com>
 <37c5710a-426f-4054-8632-e24b9d920bcc@linaro.org>
 <fda53b22-c3b6-4c9f-80e6-8f22637b8b63@linaro.org>
Content-Language: en-US
From: Alexandru Serdeliuc <serdeliuk@yahoo.com>
In-Reply-To: <fda53b22-c3b6-4c9f-80e6-8f22637b8b63@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22241 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi Krzysztof,

Thank you for your time and please excuse my lack of knowledge, 
reviewing the first reply I clearly see now the details, but i missed 
them initially, I suppose that due to the lack of knowledge in regards 
to the procedures here.

I am going to  generate a v6, thanks again for your valuable time spent 
helping me.


Best regards,

Alexandru Marc Serdeliuc


On 11/4/24 10:47, Krzysztof Kozlowski wrote:
> On 11/04/2024 09:34, Krzysztof Kozlowski wrote:
>> On 11/04/2024 08:36, Alexandru Serdeliuc wrote:
>>> Hi,
>>>
>>> The list of changes  (changelog) from the cover is not what I should  add?
>>>
>>> My patches received only two ACK tags, on V3 and on the initial request
>>> (v1), I was not able to identify any other, I added them to their place
>>> in the change log
>>>
>>> ...
>>> - v3
>>>     . added b4 version 3
>>>     . removed address and size cells in device description
>>>     Acked-by: Rob Herring<robh@kernel.org>
>>> ...
>>> - v1
>>>     . The initial request was split in two patches sent due to the following checkpatch warning, was requested to re send them together:
>>>       WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
>>>     Acked-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
>>>
>>> I suppose that adding them to their place in change log is wrong, I
>>> should create a v6 and put them at the end of the cover letter? Or how
>>> to proceed?
>> Please don't top post. If you add them to the changelog, how are they
>> going to be effective? Please apply your patch (e.g. b4 shazam) and look
>> for them...
>>
>> Submitting patches explains where to add tags. Look at other mailings.
>> And finally: why even bothering about this if b4 does it for you?
>>
> BTW, in reply to your first posting I gave you detailed instruction how
> to proceed with tags. Let me quote:
>
> "Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag"
>
> I think it is clear where you should add it. I gave this instruction on
> purpose so we will avoid this mess...
>
> Drop all invalid acks from cover letter and send v6 with proper tags
> places in mentioned place.
>
> Best regards,
> Krzysztof
>

