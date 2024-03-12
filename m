Return-Path: <linux-kernel+bounces-100410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C10879715
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58EF7B226A2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282D57BB17;
	Tue, 12 Mar 2024 15:03:46 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252777BB04
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710255825; cv=none; b=XEyauJ4clHaMppqsefUo4XVmmkexzq4jD/xt4K4ivvkb53VdHCKantOjs6ZX7y9m68M9qH/vncr7POvR2mkt2rBFqhwOjCTHDRfe7MMhvj20PTLc0OQpr1GjS/qT+D/UBzvPn/kBRa7XRcXb1p2wAekdz4ngU3xqSBcL546H9nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710255825; c=relaxed/simple;
	bh=DdPKwpRi0VDYYvuq7yPFpvwVjwU1zF+taFqF1vSfFwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KCjUx5xKltCCJSlIh7mcOadr+GH9A6k1+MvgTelFoDF69KzhY8Jcrjdfd4qCWjhiubPIDUqCSVbmlFwtI81TUfin8XMrMeN3KsjAF1Y133El0/8ffzHzXjH1Ut3wrwMOmlDPO6ljcZUvVQ6N/5wJksdMy67gq+3+0P/E8DiB/4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TvGbw0g5Kz9xFm8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:43:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id B6B6F140F13
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 23:03:27 +0800 (CST)
Received: from [10.48.131.93] (unknown [10.48.131.93])
	by APP2 (Coremail) with SMTP id GxC2BwCHvSG3bvBl_NYqBA--.20885S2;
	Tue, 12 Mar 2024 16:03:27 +0100 (CET)
Message-ID: <dc48c7c6-1aa9-4bf3-9a0d-f5acd6574228@huaweicloud.com>
Date: Tue, 12 Mar 2024 16:03:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/entry: Use one cmpq in NMI entry to check RIP for
 nested NMIs
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "open list:X86 ENTRY CODE" <linux-kernel@vger.kernel.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
References: <20240229083711.721-1-petrtesarik@huaweicloud.com>
Content-Language: en-US
From: Petr Tesarik <petrtesarik@huaweicloud.com>
In-Reply-To: <20240229083711.721-1-petrtesarik@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwCHvSG3bvBl_NYqBA--.20885S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryxuF1fWrWUGFyUuw1xKrg_yoW8Wr17pF
	4fCwn5KF1ku34SqFn3K3Z2vFW2vF4SqF45uFWakrWYyayYq3yUKryI9r48J348Zrn3Gayf
	tF4jqrWrJ3Wjva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1a9aP
	UUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

On 2/29/2024 9:37 AM, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> 
> Optimize the check whether a nested NMI occurred between repeat_nmi and
> end_repeat_nmi. Although this is not a hot path, this is standard code to
> check whether a value is within a given range; it is slightly faster, takes
> up less bytes of code and saves one entry in the branch predictor.
> 
> This patch also removes the only relocation for end_repeat_nmi, removing
> the need for ANNOTATE_NOENDBR.

Any comment on this?

Kind regards
Petr T

> Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> ---
>  arch/x86/entry/entry_64.S | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 9bb485977629..cae40076e109 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1251,13 +1251,10 @@ SYM_CODE_START(asm_exc_nmi)
>  	 * the outer NMI.
>  	 */
>  
> -	movq	$repeat_nmi, %rdx
> -	cmpq	8(%rsp), %rdx
> -	ja	1f
> -	movq	$end_repeat_nmi, %rdx
> -	cmpq	8(%rsp), %rdx
> -	ja	nested_nmi_out
> -1:
> +	movq	8(%rsp), %rdx
> +	subq	$repeat_nmi, %rdx
> +	cmpq	$(end_repeat_nmi - repeat_nmi), %rdx
> +	jb	nested_nmi_out
>  
>  	/*
>  	 * Now check "NMI executing".  If it's set, then we're nested.
> @@ -1383,8 +1380,6 @@ repeat_nmi:
>  	.endr
>  	subq	$(5*8), %rsp
>  end_repeat_nmi:
> -	ANNOTATE_NOENDBR // this code
> -
>  	/*
>  	 * Everything below this point can be preempted by a nested NMI.
>  	 * If this happens, then the inner NMI will change the "iret"


