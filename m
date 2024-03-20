Return-Path: <linux-kernel+bounces-108865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF3F881114
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7BB282A4F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF3E3F8D6;
	Wed, 20 Mar 2024 11:34:54 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BAB3D984;
	Wed, 20 Mar 2024 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934494; cv=none; b=UcEsjR0Qd6uxDh8kldtMDh4asbTazAwXDkBKiUYzyBZJywHuTTXAHSpD3OiqDQlc3lJR1t3idQE0JHaSSyFH2lF4T7aTyvvNu6LOvr11++F/kSjsXBXVXU4Yk1zpaxWrhG9zC3s7pMKbzZbW4SkCAW0/7jAUZTJtBU1blK6V5cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934494; c=relaxed/simple;
	bh=3WaKxkbQWcDCF2kXtI2Am05e+yUdzZw2ITQ8GoPRoSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rp56XkgJ4EQVOks4Ul9jdvN+mvxQ0PterGaHzowWqWpzFTOpVZcyOny/XRV0vwI8inNTTZaczUbIpjkUjoEl6Km1peZV6DFQQXPWl3qbmOVAOcJNQQrvKlLS5EldPAHoKyzPu8fC56zooQXd8eBd99GBAclk3v+vOen5tdYuc7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V062D0XMZz4f3l89;
	Wed, 20 Mar 2024 19:34:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E87C31A0AAE;
	Wed, 20 Mar 2024 19:34:47 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgCX6GrWyfplm5SjHg--.34463S2;
	Wed, 20 Mar 2024 19:34:47 +0800 (CST)
Message-ID: <ab5e6307-8d80-4751-940f-4faa5bc41d82@huaweicloud.com>
Date: Wed, 20 Mar 2024 19:34:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] arm64: bpf: zero upper bits after rev32
Content-Language: en-US
To: Artem Savkov <asavkov@redhat.com>, Xi Wang <xi.wang@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240313140205.3191564-1-asavkov@redhat.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20240313140205.3191564-1-asavkov@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCX6GrWyfplm5SjHg--.34463S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyxZF1kur1UJFykAw4Dtwb_yoW8try8pr
	4ayrZakr4UWr17Aa4FganrJr1vkay2y3yUtryDWrWSka9Yv34kXryfKrW2939IvrW0vw4Y
	9FyjyF93X3s2v3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/13/2024 10:02 PM, Artem Savkov wrote:
> Commit d63903bbc30c7 ("arm64: bpf: fix endianness conversion bugs")
> added upper bits zeroing to byteswap operations, but it assumes they
> will be already zeroed after rev32, which is not the case on some
> systems at least:
> 
> [ 9757.262607] test_bpf: #312 BSWAP 16: 0x0123456789abcdef -> 0xefcd jited:1 8 PASS
> [ 9757.264435] test_bpf: #313 BSWAP 32: 0x0123456789abcdef -> 0xefcdab89 jited:1 ret 1460850314 != -271733879 (0x5712ce8a != 0xefcdab89)FAIL (1 times)
> [ 9757.266260] test_bpf: #314 BSWAP 64: 0x0123456789abcdef -> 0x67452301 jited:1 8 PASS
> [ 9757.268000] test_bpf: #315 BSWAP 64: 0x0123456789abcdef >> 32 -> 0xefcdab89 jited:1 8 PASS
> [ 9757.269686] test_bpf: #316 BSWAP 16: 0xfedcba9876543210 -> 0x1032 jited:1 8 PASS
> [ 9757.271380] test_bpf: #317 BSWAP 32: 0xfedcba9876543210 -> 0x10325476 jited:1 ret -1460850316 != 271733878 (0xa8ed3174 != 0x10325476)FAIL (1 times)
> [ 9757.273022] test_bpf: #318 BSWAP 64: 0xfedcba9876543210 -> 0x98badcfe jited:1 7 PASS
> [ 9757.274721] test_bpf: #319 BSWAP 64: 0xfedcba9876543210 >> 32 -> 0x10325476 jited:1 9 PASS
> 
> Fixes: d63903bbc30c7 ("arm64: bpf: fix endianness conversion bugs")
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index c5b461dda4385..e86e5ba74dca2 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -944,7 +944,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>   			break;
>   		case 32:
>   			emit(A64_REV32(is64, dst, dst), ctx);
> -			/* upper 32 bits already cleared */
> +			/* zero-extend 32 bits into 64 bits */
> +			emit(A64_UXTW(is64, dst, dst), ctx);

I think the problem only occurs when is64 == 1. In this case, the generated rev32
insn reverses byte order in both high and low 32-bit word. To fix it, we could just
set the first arg to 0 for A64_REV32:

emit(A64_REV32(0, dst, dst), ctx);

No need to add an extra uxtw isnn.

>   			break;
>   		case 64:
>   			emit(A64_REV64(dst, dst), ctx);


