Return-Path: <linux-kernel+bounces-109793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE638855C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF75D1C21004
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE0043AC1;
	Thu, 21 Mar 2024 08:32:56 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE81200BA;
	Thu, 21 Mar 2024 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009975; cv=none; b=UQZ2bCH0jTrHZ/RWlAuLm0Wt7WQ6t1VUPKPelczORBVI4FK4H7b1KI9bRZQwLr0UvCv3dN0r4QYd2ObmpNb3H/HxKqdtu7N2qq42G4AzW338AqNFLjFXIdEdIP8RUQTOPItE3xShyeUKgmFJN4DjDY7aHnLiMLHcQs+QuzwRYm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009975; c=relaxed/simple;
	bh=JQe2hA73NUK4BTZbJZTGWFApkIPtA+TtSzkxkKSsioU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQuv85h6z0nWddQbqwDCbAxaqmkUpFM9l5OePm0nRZFAiff/87BP+KluYLYxGxyn5gouS78CAQit2lBBd1V39c7Vd+TgbLUq5KwBvTnMeUALJEiG+70xPkAlPSMb8eiuaeIOJlmEyJplyE05rTiqBBYgSilrqDd7JpiXskn77GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V0dxl4zyTz4f3kFP;
	Thu, 21 Mar 2024 16:32:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B383E1A0172;
	Thu, 21 Mar 2024 16:32:49 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgDH05uw8PtlnGQCHg--.7682S2;
	Thu, 21 Mar 2024 16:32:49 +0800 (CST)
Message-ID: <dec82e88-6961-4bf6-92b7-9acc753aaad4@huaweicloud.com>
Date: Thu, 21 Mar 2024 16:32:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] arm64: bpf: fix 32bit unconditional bswap
Content-Language: en-US
To: Artem Savkov <asavkov@redhat.com>, Xi Wang <xi.wang@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 Puranjay Mohan <puranjay12@gmail.com>
References: <20240313140205.3191564-1-asavkov@redhat.com>
 <20240321081809.158803-1-asavkov@redhat.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20240321081809.158803-1-asavkov@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgDH05uw8PtlnGQCHg--.7682S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry3KF1fKF1DKF45CF1ftFb_yoW8ur1fpr
	43trsakrWUKF17Jay0gws7Ar1fAFWvy34UAr90qrW3ta90yw1DWr1rK3y29rsxtrWvvw45
	uFyjyF93C3Z7tw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/21/2024 4:18 PM, Artem Savkov wrote:
> In case when is64 == 1 in emit(A64_REV32(is64, dst, dst), ctx) the
> generated insn reverses byte order for both high and low 32-bit words,
> resuling in an incorrect swap as indicated by the jit test:
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
> Fix this by forcing 32bit variant of rev32.
> 
> Fixes: 1104247f3f979 ("bpf, arm64: Support unconditional bswap")
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> Tested-by: Puranjay Mohan <puranjay12@gmail.com>
> Acked-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index c5b461dda4385..c3ededd23cbf6 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -943,7 +943,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>   			emit(A64_UXTH(is64, dst, dst), ctx);
>   			break;
>   		case 32:
> -			emit(A64_REV32(is64, dst, dst), ctx);
> +			emit(A64_REV32(0, dst, dst), ctx);
>   			/* upper 32 bits already cleared */
>   			break;
>   		case 64:

Acked-by: Xu Kuohai <xukuohai@huawei.com>


