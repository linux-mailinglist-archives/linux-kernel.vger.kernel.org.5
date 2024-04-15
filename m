Return-Path: <linux-kernel+bounces-145897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0908A5C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10D11C20B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7FA15696D;
	Mon, 15 Apr 2024 20:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gQCqc/hc"
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4717315686C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713214483; cv=none; b=Lrnc4Hoqn7BZtSXn0OWGpJFB3GJn5ILqWjrtOQALduNLDWjt5P1lMOtKrwxvK89NF6bGuf5+qZuM6LAXLU9D1tZWx6FlKCi0b9rRvpG4JeSn2vUzNnhB5jr++oqofCcRyDKzociXKhVlwn+tUZOkF3OmvUoPivn5aocIdb7cG9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713214483; c=relaxed/simple;
	bh=n4Fx+ssCiuxhhFxKS9csni+On7FVOW6BuvYHUoh2UvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjDGtyc5ujinAlLDsIV5oOexzqOmkLbKrJ8Zx8bbN49T30EgsutmVdyIVnOVrwND+8htYCxvwfcaMQmv+NTa9dlZFXu7bT2C55BrbtTVaLCR7aZt76L5DOdcxLU/1aVrlx8BcBADg1xbzgwDN+gKAzxmusiOdx1GDV/QiVpMvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=gQCqc/hc; arc=none smtp.client-ip=66.163.184.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1713214475; bh=9hINy0MK3H0eWIvxUePCdR2aKRfDeohnVqc03JMMlJE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=gQCqc/hcItPrjd4viR1so9xMr1MXfINl9FteZWBHpUPk1eba+5VXTZo5l4vzDzVSrkGoc6HNlsQu6Me9XmcgoB7m/5L5QPETEVNRFJ9nbGuG9fGChjZxnCRiUoqHIIYoW9cu0UAN4gqTgmEvc6nUt/csGghglOuj/OloGOoFE7Odo+jBWr4hjuW6mMGn+3fDMzl5M0p9DFwRdhZg8xP1Dzx141a7tqISTpqBLV5l8yzEPIOMjOwjg1jzF5IxFNeORAuGE0X6gMYawjxU68ty26AbZPLIgujEPuhueUGn6hEv/ozKb7i3PWPFA+Q2oNE5/HIl2tmCqRe3qYljW7dJFQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1713214475; bh=pijNMeZ6B6rONii1q181kuHGT+Z1/jL2WVAbZfCkn17=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=mh/SMA7BaLfiJe0RZk/s2KGu1TFxz8TVOumE8U8FY3AiTEeT+qNjSE8b7y+o3IyOclW1CAxWoUD418KYt8sqDsJWQV4OTl+Qsrw0xgXEB9iia9yXLBxFJnjJMkn3mFX5kpvP+XcJPwAq3K6bNkx7bKs33GxFF8S2j14MzGEwhM8ArwtWU8mDpS21zcV+nKboh/glcchTAeltLoDvxmNNj5l13hQJQc/Xf73JMo1wtfDdL1L9YPRgIdtvuMDNUXU3njNH9KicWo3MQkSo20Aq0i6vSLYlUSnf/twTjdcxqGUKw2gL9Xgntzl/sO+PLBsIeZ2+y8uqS/uNxK3qOg2QTg==
X-YMail-OSG: zYQj_J8VM1kfZRg6d0wwa5iSsJg_sLNmXQF8SdegZVsAYea.M5tzPQP14DPgmo3
 63FXOfa5WZf3tcjECRi3bqElBsubWokAIkfJ0ehJx9f1hjeyp4UTH_54Y9TMAJ.ozdizarXodkmC
 F3QdaYKQBBLkWfYuJYG.9oqRKvI6pDCUNEtPlVJD8MkEWkmb8Ovi_6jb74tDnLFSgElapvLxIZLT
 oe9LBr_ZEEeZkJT2g9RY9WGbaQqCJpZcoUkF46E2Ixvkq82..dyQm4zHey1dvjILmgzbU_PdBrJl
 Zu0qYLLbVmvw_ly5.eJJuDOJW0ZwiNYhPEUm.voFISAXJ53.vAn3cUppi_6SD45J3BfHEBxxjwrZ
 LbcTEAHD2kizxDHAcAtkkKUZC1SW3289kkMHCLFIIj4vErYKUxIdtAD7LY8YXbIfr1fZDWp4uO9V
 zc7IlBxpYuyhtQ5zP.LHBUbkBOy6RNmwmOH53uwTqdszD3HsxgE.4nGKq2FmuYtgyeA.IBrswwy5
 qRkTT6myZ7ZGV07tArsyOlZNiglE0Il7kwywtvTky95TbbCU2Ns_1gbanlkLb6GW_v3aA.pnA8W9
 JZ84hGneuJ7E.d5PYtYPIpYhF9GdRPEYKS249DAncrtky4eMeuwkx7ex5gzx_yJHrcxP3_R4zkg.
 8nqmgBZBbmF8yqi6z6HiP3Z8jjeqY0rB7EsIBKPEhQDKpDr9Gl1uItaCEFvjfS2xZA_8.Fv8Q25.
 5BgvU3lGAKKUOsqyDeUOcA0vP0ov8A2Nl5JBm7JurTn.A0nF_3A2208YZr425FmjQ906VMJrxwMP
 HqYFGCmJHVpyEbM0b649exDAFoTFCkBGsLvkQxq.KG0pDCXT9pgwBrndP554wtLuXv20RZVJD8ke
 qgbGBMPZxsrNS1OcWrchHu7WAHxy5aEP0G.CMlO18CNekhElLtR9FzI8LEjKEv.I9Zt8fj3I1DVE
 P2JLqcg4Vazei7_KL4m2l_Zg2uxI12yft6AVJXkP9lZtlvxafmx0E9nC8CrK5Ger7M4c9Lg2xHaO
 jozbU2mpLb5ypaFqN5PXL0VxvQZFl6ID5D_6vk77NtjTYLt_pQY9BNT03IYtxbPmUJ4L3SN7ecyy
 8_0VnohIge0j42qvrLEdGY5gs6DjMkwNbuA87IBYgq.vtGVgiIydHZgeFzhQ3mevr3g4jvHIt1HH
 xNpKYJHSiFg68sQXomdn8TGleoS3HsVnnTmgdfgvEMdTvhjQuUZhtc5wCKH1SObnvvp7lvU3OxNy
 TGwLFYLwlMStft7BvBV56K.2S4mktVxXrXXTHpePViqHX5XgTURObLb53L0V4hY0JdxESUztAWrM
 EnafS5Qji.9iK_VeGF25E7TYTu9xAdErxuOEhtDnXORi8cNEj8cob8wKumwkjdc99M.1gfjsAR3x
 I5tNyEPkOpSjBUY8oc81c_f300Hvda6gU2.8xqj2vkYPXqAk0KYBuQG6vC8PsPeJzY4o7a47wCIj
 oqPHxv4slp1XZ7X_vLp54YrccRw_ilwgObzZv3SEFVQD60iCpukm5TBuzTReMbLrzOow3ojZ6qPZ
 kdiWBX1c0.uA8SX0lcjFk81P_kXzSIp.Rix8Q0wcwYIcIz8OHfSNBO2FDWGhsB0Zy_B1wwF4HiFk
 _E.Pn12g8GdSb2ADiE_FGjUjRBAOpROyLXGl1T_Z9uVILEuQoQiFyq57kLQ2oCPgSaMgi2XCpLfH
 0n.9XhCLbpZdfScvIdbAdTywCNfxPDuTTM3ccBYCs9.4OT9QFSzgpko7Xo7jPFnw9ceN74degbBg
 xacKfcghf0k3.R3rVjYDX1LVNsBKMXithGQwwn4To2Hc6d6u50NcxFOVj4vtW5uLvXpNm61TW1Jb
 T7Byd83h5VmhQUl4ZXlzrcWS7XZqynu.GR_sz08WwM37sfOBiI1nRxaeYXfXq5coa03lITZ6yB1n
 .VMQmwnJbXIrbdw5Of9g4slnyOYHX.FWPNI11FPqhaNJJOyVKw4FumWsgS_EnuNa47yY1XGJGLPS
 s8TlCTQwAlXdGJD86oQaujaweWJjkIR6eKfSGZy87C3W1ddXKXk27fbGK.PMeF141Cpx4x.BmY3W
 2BbAxPZnWdMzqfFyvLzCwWo38LqOYZxkPHkfmAOuPcr_Izvbe53KMZfR9A4sD0lkl8q_Sp0YO54X
 qYppfANZDYoZ5KQ.Erd9AjbIEqv7b_q8EMDDLRntrwXoE4CaJTBaslBFbJqpeA3DfaOzQ2vIG78b
 cXpPpyxvGXnXeoPS1ew6Dv4C46bj4tKFGMcXZsHKxI.BXpLWbOwM9ALuHhFC0y3TZQUaR1MQN88f
 e8qE0CSU-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a6b5c97b-0382-413a-8f94-f77017c737c4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Mon, 15 Apr 2024 20:54:35 +0000
Received: by hermes--production-gq1-59c575df44-xmm9l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0417134207761be6f6a7f5a554c0ea68;
          Mon, 15 Apr 2024 20:54:30 +0000 (UTC)
Message-ID: <0a4ebcd2-7772-4832-885d-221e0c6f6c04@schaufler-ca.com>
Date: Mon, 15 Apr 2024 13:54:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kpsingh:static_calls] [security] 9e15595ed0:
 Kernel_panic-not_syncing:lsm_static_call_init-Ran_out_of_static_slots
To: KP Singh <kpsingh@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Kees Cook <keescook@chromium.org>,
 Song Liu <song@kernel.org>, Tetsuo Handa
 <penguin-kernel@i-love.sakura.ne.jp>,
 kernel test robot <oliver.sang@intel.com>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, lkp@intel.com,
 oe-lkp@lists.linux.dev, Casey Schaufler <casey@schaufler-ca.com>
References: <202404151225.ce542e38-lkp@intel.com>
 <757538DA-07A4-4332-BAFA-B864BFD06A76@kernel.org>
 <30876b80-c437-4916-b982-97c1a95c0747@I-love.SAKURA.ne.jp>
 <CAHC9VhS=hQuvv+Sw6cc2HwzcLApO7Rc3dAnqHytyzBpC1rokFA@mail.gmail.com>
 <CACYkzJ4G7hO0DNSBy4wpJG1PSgNkifuYcfOeTTpyVBtBtWvQSg@mail.gmail.com>
 <A9568514-FCB3-4715-9794-696383B2B7E8@kernel.org>
 <CD57788C-C9D6-4BA8-8352-90EBB6600D39@kernel.org>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CD57788C-C9D6-4BA8-8352-90EBB6600D39@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22205 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/15/2024 1:42 PM, KP Singh wrote:
>
>> On 15 Apr 2024, at 17:47, KP Singh <kpsingh@kernel.org> wrote:
>>
>>
> [...]
>
>>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>> On 2024/04/15 17:26, KP Singh wrote:
>>>>> This seems like an odd config which does not enable STATIC_CALL, I am going to
>>>>> make CONFIG_SECURITY depend on CONFIG_STATIC_CALL and make the dependency explicit.
>>>> If CONFIG_SECURITY depends on CONFIG_STATIC_CALL, architectures which do not
>>>> support CONFIG_STATIC_CALL can no longer use LSM ? That sounds a bad dependency.
>>> Agreed.  If the arch doesn't support static calls we need a fallback
>>> solution for the LSM that is no worse than what we have now, and
>>> preferably would still solve the issue of the BPF hooks active even
>>> where this is no BPF program attached.
>> Actually I take it back, when CONFIG_STATIC_CALL is not available, the implementation falls back to an indirect call. This crash is unrelated, I will debug further and post back.
>  Apparently, when I smoke tested, I had CONFIG_IMA disabled so did not hit the bug. Well, now IMA is an LSM, so the following fixes it:

You'll want CONFIG_EVM as well, I bet.


