Return-Path: <linux-kernel+bounces-120430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B58CA88D736
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581D11F28C33
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4AF2D048;
	Wed, 27 Mar 2024 07:27:40 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC952C1AF;
	Wed, 27 Mar 2024 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711524460; cv=none; b=bz5V5TI30CGeVoCoE3oS2TNqqr6KytCsU1l8klMz3uCYOOlekx/xb/GeNsvK2o9qray7WMGd/q+9IEVpqOq03wj1iUO7ptc06slSsF1aljzfU48kT34SsltLLpGHeHzVfKDNgmihcnD4C+A6KvveMP1SXUhotQbnB23uUBZn+Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711524460; c=relaxed/simple;
	bh=k2DBItz6TsmKTwIZ4LkXLDh9x03pq5n9MnOxRHRy+9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=rK6P8NH4agubqNEeLlJJYpcxsB938UHorj740jPQmfEQ9t8WLx42o05k3OctUHalwX16CjYX3K2m8FJ0YUbpTc6VreSh9GueD7cvd9B2T/nFHDI2c0T6Ix9jc9FR9p4j9njfdPXRjKV4n60D+UTxKrCDOdTVV9WbQmMhtdDwbDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V4JCg2FB8z4f3knj;
	Wed, 27 Mar 2024 15:27:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 850071A0568;
	Wed, 27 Mar 2024 15:27:33 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP3 (Coremail) with SMTP id _Ch0CgAn555jygNmnhRfIA--.55082S2;
	Wed, 27 Mar 2024 15:27:33 +0800 (CST)
Message-ID: <cea8a4c6-0614-451f-b878-4f9af62cf209@huaweicloud.com>
Date: Wed, 27 Mar 2024 15:27:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] bpf,riscv: Implement PROBE_MEM32 pseudo
 instructions
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>
References: <20240326224943.86912-1-puranjay12@gmail.com>
 <20240326224943.86912-2-puranjay12@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>,
 Xi Wang <xi.wang@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20240326224943.86912-2-puranjay12@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAn555jygNmnhRfIA--.55082S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1xCw1kuFWDWFyxCryfJFb_yoW8JFWDpa
	1jga1xX3s0qrs2yFyDJry2va4rAw4UCFnrWFy3tw18XrWaqrs3KF1UtF1ak3WYy3s3Z3y5
	JF4xurZFy3srWrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/3/27 6:49, Puranjay Mohan wrote:
> Add support for [LDX | STX | ST], PROBE_MEM32, [B | H | W | DW]
[SNIP]
>   	if (WARN_ON_ONCE(ctx->nexentries >= ctx->prog->aux->num_exentries))
> @@ -1539,6 +1547,11 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   	case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
>   	case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
>   	case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
> +	/* LDX | PROBE_MEM32: dst = *(unsigned size *)(src + S7 + off)*/

still some nits. please align, change S7 here to reg_arena.

> +	case BPF_LDX | BPF_PROBE_MEM32 | BPF_B:
> +	case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
> +	case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
> +	case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
[SNIP]
> +
> +		switch (BPF_SIZE(code)) {
> +		case BPF_B:
> +			if (is_12b_int(off)) {
> +				insns_start = ctx->ninsns;
> +				emit(rv_sb(rd, off, RV_REG_T1), ctx);
> +				insn_len = ctx->ninsns - insns_start;
> +				break;
> +			}
> +
> +			emit_imm(RV_REG_T2, off, ctx);
> +			emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
> +			insns_start = ctx->ninsns;
> +			emit(rv_sb(RV_REG_T2, 0, RV_REG_T1), ctx);
> +			insn_len = ctx->ninsns - insns_start;
> +
redundant blank.
> +			break;
> +
ditto.

Others, looks good to me.

Reviewed-by: Pu Lehui <pulehui@huawei.com>
Tested-by: Pu Lehui <pulehui@huawei.com>


