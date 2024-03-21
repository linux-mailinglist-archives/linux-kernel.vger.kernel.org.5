Return-Path: <linux-kernel+bounces-109559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCE4881AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D023C1F21994
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4E15684;
	Thu, 21 Mar 2024 02:00:48 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7405F187F;
	Thu, 21 Mar 2024 02:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710986448; cv=none; b=Qm1UJ0Rom42ZNaAniVlcVlP47wGDLhJi5B3VlWbrJgLMRGb881FiyUaSm5kyKZJW4sLmfX6uy3Q0LLpKCwx8ycacGSGEJObjMFjJz5RF8fS1z3CkaVdKPLIt93QqFEFXBLYr9OIigJOztff59RKdvth+e5qX5/Gw8gJl4Wyidf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710986448; c=relaxed/simple;
	bh=4XNZOZhuU588jqDg6qXSd3S65FNa9UbFKh0DmUDjSXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QCMuMGS1+8yYzXKvbrEIl8bJcFHl8WY2a+eywxYaQCPnoKKpoPGCX+CMWIAlxmVSN/YDvi8AVNciO27A5BjLezg2vDyyYPWyaMyzZdLdg7kOjq4g4MHFIuqp8LP6cFICSxwZqw9/c3cTx7WxDjq3Jwzwr5489nEiXBGn5+6M0X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V0TBL2QRLz2BgLp;
	Thu, 21 Mar 2024 09:58:02 +0800 (CST)
Received: from kwepemd100012.china.huawei.com (unknown [7.221.188.214])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F6541A016C;
	Thu, 21 Mar 2024 10:00:36 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemd100012.china.huawei.com (7.221.188.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 21 Mar 2024 10:00:35 +0800
Message-ID: <0c011cbb-0528-40de-8037-6a76120014fe@huawei.com>
Date: Thu, 21 Mar 2024 10:00:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] arm64: bpf: zero upper bits after rev32
Content-Language: en-US
To: Xi Wang <xi.wang@gmail.com>, Artem Savkov <asavkov@redhat.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240313140205.3191564-1-asavkov@redhat.com>
 <CAKU6vyZ1LOUtJz-XeQz8i8f9nyvN+TZxOMfEf6JP1Tfuwneiqw@mail.gmail.com>
From: Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <CAKU6vyZ1LOUtJz-XeQz8i8f9nyvN+TZxOMfEf6JP1Tfuwneiqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100012.china.huawei.com (7.221.188.214)

On 3/21/2024 12:15 AM, Xi Wang wrote:
> On Wed, Mar 13, 2024 at 7:02 AM Artem Savkov <asavkov@redhat.com> wrote:
>> Commit d63903bbc30c7 ("arm64: bpf: fix endianness conversion bugs")
>> added upper bits zeroing to byteswap operations, but it assumes they
>> will be already zeroed after rev32, which is not the case on some
>> systems at least:
>>
>> [ 9757.262607] test_bpf: #312 BSWAP 16: 0x0123456789abcdef -> 0xefcd jited:1 8 PASS
>> [ 9757.264435] test_bpf: #313 BSWAP 32: 0x0123456789abcdef -> 0xefcdab89 jited:1 ret 1460850314 != -271733879 (0x5712ce8a != 0xefcdab89)FAIL (1 times)
>> [ 9757.266260] test_bpf: #314 BSWAP 64: 0x0123456789abcdef -> 0x67452301 jited:1 8 PASS
>> [ 9757.268000] test_bpf: #315 BSWAP 64: 0x0123456789abcdef >> 32 -> 0xefcdab89 jited:1 8 PASS
>> [ 9757.269686] test_bpf: #316 BSWAP 16: 0xfedcba9876543210 -> 0x1032 jited:1 8 PASS
>> [ 9757.271380] test_bpf: #317 BSWAP 32: 0xfedcba9876543210 -> 0x10325476 jited:1 ret -1460850316 != 271733878 (0xa8ed3174 != 0x10325476)FAIL (1 times)
>> [ 9757.273022] test_bpf: #318 BSWAP 64: 0xfedcba9876543210 -> 0x98badcfe jited:1 7 PASS
>> [ 9757.274721] test_bpf: #319 BSWAP 64: 0xfedcba9876543210 >> 32 -> 0x10325476 jited:1 9 PASS
>>
>> Fixes: d63903bbc30c7 ("arm64: bpf: fix endianness conversion bugs")
> 
> This tag is not right.  It's unlikely that the bug has been around for 9 years.
> 
> Maybe you meant 1104247f3f979 ("bpf, arm64: Support unconditional bswap")?
>

Agree, thanks for pointing it out.

>> Signed-off-by: Artem Savkov <asavkov@redhat.com>
>> ---
>>   arch/arm64/net/bpf_jit_comp.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index c5b461dda4385..e86e5ba74dca2 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>> @@ -944,7 +944,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>>                          break;
>>                  case 32:
>>                          emit(A64_REV32(is64, dst, dst), ctx);
>> -                       /* upper 32 bits already cleared */
>> +                       /* zero-extend 32 bits into 64 bits */
>> +                       emit(A64_UXTW(is64, dst, dst), ctx);
> 
> The fix can pass the tests, but emitting an extra instruction is
> unnecessary as the bug applies only to unconditional bswap.
> 
>>                          break;
>>                  case 64:
>>                          emit(A64_REV64(dst, dst), ctx);
>> --
>> 2.44.0
>>
> 


