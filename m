Return-Path: <linux-kernel+bounces-124362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E64689163D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336811F22046
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E98A4AEE7;
	Fri, 29 Mar 2024 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gixJf+hl"
Received: from sonic310-23.consmr.mail.ne1.yahoo.com (sonic310-23.consmr.mail.ne1.yahoo.com [66.163.186.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5584F40845
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711705423; cv=none; b=EmRJNFU2kJMnyyPwJYugq//ULp82GqVsi1L7fKekfiCqOBHK2rz+ajfi41fHK8PI9r+u168tecqwWHB75P2AqNsurGQOk8a4l9BvFECB65ZeX47oWgJnlzbjMcOPglyaTKhJi7o5YQ7oVZX43Nuf4FOX+LI7lflcuKig1XXtZD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711705423; c=relaxed/simple;
	bh=n/r5359ncoRgLk31WmLZK1PeCWCsoqFgsUDIyJPug4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rf/ncQA8SPSUQzV7OH8OskhBSvzgepE6MC5vg9q7KDrY9OmQvJ0dBI78SUkz0KVyvMELa79vNptixWySFD59+Wa7I008f6nF4kcm+Wc3nUsICR3CCX3thrmGAuk3s0uOhU32Ut9BKTbZHqTPMPa1Ko/o6h+QonUOrZbJi+ZKVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=gixJf+hl; arc=none smtp.client-ip=66.163.186.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1711705420; bh=n/r5359ncoRgLk31WmLZK1PeCWCsoqFgsUDIyJPug4c=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=gixJf+hlaOfuNNnnT9u4+lXahMNuBzeuwJigPUmwFf2nSMmBn2bPlKML9AnF2nek9XPsO3LxL35wg67sy11rAult4brOaVLEt5xGnGvhfqnyT1BRSzma7wmf5vvCrcw4hENUGRo8uk+Vk3xR3t+ghxCZI1t/OAi8Wi6ebXaZDQPx/LOKVqhyUd1mvZexUh8Vg0En+SJzo2Qsm8NFr1XuwMSKf4EsM4P8IU3HlNy9fhO+ry/bkNIwSKyJKC4H+/XVumtXcJ0xlAaDM3RlQt9aN38HG9XFgO7nDN3A6dwWTPZNXy5exYqMTSS/nRtmNYkKD34zebhTL0d/f8KIAn1t6Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1711705420; bh=4E5jNqMX/HeKEDOW9q8fSqiQGUlQ25EuPCNIZtof4SN=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=cW59ifvZ5J6QJ2yj/icpyITF+wDPzd4Qo9Srb4+LWWE0HHdxHuhjwRRuLy2vIpa95lenwEz60fLGxNOcLsdbQRk3KeK97+NQ067j7ICTpANFVlJMpWEKsgHWa9LBiLk+eiifZns2h+P0m6hOTgQpuXrBDK4NbVNnmJSQiuTeGoM1/73WrKZPCBz83Ba3HgIDg1vULyAhhCHJlJqerNUm6pY+lPZZXiDmHFpIIJCvklTdnQ3/Mw8iRiw95GhX9c30eYtRY6cslvvtEDLex8wZdGeZGC+P5eBSTc8mdkENXJacosIjvB7UFpJD8l3eHx6PdxwS22VDSV+T3MMMu8Y2GQ==
X-YMail-OSG: gatqklUVM1nK7lnaC4hA2iHDUiutYnW3878aJxrfsAiGyoZcHzynGN1D2KAy7KE
 y6fEZ1H5r0I7SDOHwQds6tNMz85EbkqdxakYmR1f.97wINRQsPLdXm6BhkPX9_.BaqSdLmAa5Qs4
 6HPbPHEnSupsgRlAEQ234tuu5AiYQfRyS6iBa2IhBdWv2TKXwOqP_H1s7tmp_X6bnhP97xWYe17Z
 Mzp3qwC.oIUQeQceY4Xx2NPQBbJsEDzM06gpcmbGWwvK_B9IdrmL1zfd4oU4x_c01m2DKbur9Hjw
 .boxiyS4xNNFuvKqfr0uuefK5ujAENlcEaOO_GziGUibMxqixG0qJI2ewx4FIxs.RUp0wgZOHJge
 2rmIcW_2qbMG6OYxo3bZWiwkZMmLwrKSEbNIljkjo9i0r_LJww8GxWPGEf2k3PL7vPnUkDiO6GTy
 fSQi6K.gMGx0655cAvd60vQ2swqThEv8VSXVFCH2geW.yDuDCKbCXYE4W67wjYRkAB_s86wPOrlL
 vh5u8a6hipLqxseuIqDYWFDzR6WRJ6jl0uNHX8ERwCgRExfkv8spld.3DL5bG5aOpMIQtCyRbRhT
 7rHUJ1Ko21nofKkACI7MuxgdrhAZ2H22Jbw9UvpmSBlravSM2BdsIN1hCskKWfcWOX4d56InbnN3
 fzObNh_n6gEV4D__re2cx8gt7KGo6do6iwMvYBztPjVeS9k.H3pvKGw44LT7RvSnei22euNvt_su
 u6R_LCUDiKSimUKAuZi5Uk2VOCzPfQQoBcQLjrG5HmYxcRfjjgMldWdRyC4fk3I4PMmXIjNkuq.X
 H5Q0Lj21zeNJxm_rFtB14e9pqWicuNSo8NKuZ6hCsUsg679qYB9uMjFC55oiOJr9rzz.5TVdxSbr
 UqhUUg_P9Pqe6AmJgNyl5LvW3BFKSBSnmctf4sztBt91xQQsa9vI5VSVLfbG3jHIb4I1yEVMeHle
 NCaixOWbrNjT4Q8kZUmFIYwzjN_KlWT7cjNzByOuD11JsNpDsMuIRd9vQC8LxfgAbysKrsD9EV.8
 u8MRLkmkt4d1LDrMaIeukEZfI1RftZC7fHue4Zm9kLmCHzNmgJ94MBn.o3JMpBewNC1nmuOGPXaa
 HH7k.o7FG25B.f44V6wMN8RuZ3nzoskRJZTfzbxAo5wAXbwRH.3xdxRIvoH6KYMnfKDpRe0cgUiM
 yAd6vVijVNj9E6MiCA5O7k6rY_BmauWYL9TbvL6l0BZ_iJuw1cein1QnZfSUNuuXcvp5wIVGldA.
 sTnimpze948zAjX.TntjLc3L1NIJCadE4wHghHx7HD7jDyWASCHSwNblMK7_SkOAfL43mmz5oks6
 AXVhBwZHWoEmVPKgdycX2REL7YlJGaF1_TzrjONx7.a_lY.FFuaMzs3TJgzAe7d7ABYP4K7n4kXc
 KD5uIvMjhgpAWkwai7QJw8U1tQDdht1AnG_QXlsk.gRJexUtQ82RrHw1o8rllS5t31IK9exNmUuI
 dAQ8K4AS5KRlEixf8WRpdW9GM2lpztsJrjMBQmTNHkdWx.loS0CHttr3x6mIkImIQRyabnTa.7HD
 9WZd9niMiZ9MYmRfjqS3wojN.EzHQsPUn6zn4ogno9tYvXSpp5iEeLcWiq4P4kDa.Z_nbkCXzTcL
 LMcaeuUo8g90caZtGYonxlB9hCCzVy2wbKPd1SmQJ9DFnc.mIY_I2Wj4CXXtNd7V0AfJOc81DAPT
 YAl0t9GrBX9ihP3Ze539ICZOgwLI2arGdLcHwuntcrL680c5n8BXhVE_LaeGjFI.IrvizYAFoH4o
 I6H9OcbK3G0K2oyUYnnbKJecHg81FLYiUzUw7haiB_P6neLt0VBa6DBx1NnaJeh.XeVJySew4nkS
 9nrEZ0rUT7F2U0Ynnbab6AYJWgnymeyDtAuYhQjPHy_7hNYM4NyJ9IAm_jdioZoFTHjgVh6dqsXl
 Zvxw9SQoekK2UHSu_jixvXqsgfIoImwdiIIhhBNkLkXpvt6EozrNmygxIP16Jo1gUZvhFtW0fn74
 _iiLB8WRIL1MkHXBS.FtS7HoLJJqxOKSWOLU13jXI.hpR71TaF_XgDYmFLkZ4ZqSXMlA1BCDaSvR
 JrztMtxOdLS5OCFZuYFpHV2IT6yW5Joy9NvRqseuRwe7vkZBpbC2Uzoe9Ly6O3n9wFZwe0MFHHeQ
 xjgOOtQh7Ip0w_A26cOwhGTHgvWMD9AFIBRT2a8XVGEP.5qpPxqr78OSaMFl21d.iG_N6Q38r9yv
 meg2fCj59ZCA.raSEGF3OsyPyEwd373hVJOQmoHIEBt1KdqrJNwCzcEdn0DD3oi6nWgA-
X-Sonic-MF: <serdeliuk@yahoo.com>
X-Sonic-ID: 06ccd97a-1e5a-4aae-86f1-788dad51b5c5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 29 Mar 2024 09:43:40 +0000
Received: by hermes--production-ir2-7bc88bfc75-fnx47 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID db49365c74ea4e99f33b0d4965486713;
          Fri, 29 Mar 2024 09:43:38 +0000 (UTC)
Message-ID: <532b9b28-da4c-4af4-8d66-edde58f4d6a3@yahoo.com>
Date: Fri, 29 Mar 2024 10:43:36 +0100
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

