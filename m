Return-Path: <linux-kernel+bounces-118329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB0D88B83B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A0C1C39925
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B6A128833;
	Tue, 26 Mar 2024 03:15:56 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEDF128823;
	Tue, 26 Mar 2024 03:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711422955; cv=none; b=rllRXCpXxYXymD8z4UDzWwipoB4LW64XpnZUuyU9tYInfJdpHBdb5MVdlJ+Ug18g2o9O//Af5Z8JnrQlccXbkRsAJrMwYyc+LV69FYz2K4nIttKmrxR2UbjQtfOrPfrjR3TjVS2SVgkc0yhRTfeVGTD7X0Z29A4HinvKlnqjd68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711422955; c=relaxed/simple;
	bh=EOWWbZppdu13obubPqYzcvbmSD4F3oSk31MDSLafIrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=oWzBat+C8gDZY+h66iLEGGcXECGlBmxMQUyaK9zrLdzyzFAh7+4bZ+fI3CqErf4XOEE7nhMdQJGKLxjaxOySXnOtEx3CQfqINaBs8iJmyf/GMf3bqki48wqHHPFnGVWl+65pCeH/YCwL6ZDXiEuQA2PeUKpzAi7JvoTVlxC9n8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V3Zgf2YW1z4f3kj1;
	Tue, 26 Mar 2024 11:15:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8454E1A0172;
	Tue, 26 Mar 2024 11:15:48 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP1 (Coremail) with SMTP id cCh0CgCHoQrjPQJm5oFlIA--.21954S2;
	Tue, 26 Mar 2024 11:15:48 +0800 (CST)
Message-ID: <6936ff0c-d9bd-4136-a5ed-8df377d2206b@huaweicloud.com>
Date: Tue, 26 Mar 2024 11:15:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf,riscv: Implement PROBE_MEM32 pseudo
 instructions
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>
References: <20240325155434.65589-1-puranjay12@gmail.com>
 <20240325155434.65589-2-puranjay12@gmail.com>
 <875xxafe33.fsf@all.your.base.are.belong.to.us> <mb61ple66mdvc.fsf@gmail.com>
From: Pu Lehui <pulehui@huaweicloud.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>,
 Xi Wang <xi.wang@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <mb61ple66mdvc.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCHoQrjPQJm5oFlIA--.21954S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4kXw43WFWDtw4rGFW3Wrg_yoWfZr4rp3
	4UKF4fArWqqr4I9FyqgF12g3WFyr48CFnrWr1ft34fJasIqr4fG3W5Kr1a9ry5Ary8ZrWU
	JF4jk39I9asxGrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2024/3/26 1:15, Puranjay Mohan wrote:
> Björn Töpel <bjorn@kernel.org> writes:
> 
>> Puranjay Mohan <puranjay12@gmail.com> writes:
>>
>>> Add support for [LDX | STX | ST], PROBE_MEM32, [B | H | W | DW]
>>> instructions.  They are similar to PROBE_MEM instructions with the
>>> following differences:
>>> - PROBE_MEM32 supports store.
>>> - PROBE_MEM32 relies on the verifier to clear upper 32-bit of the
>>>    src/dst register
>>> - PROBE_MEM32 adds 64-bit kern_vm_start address (which is stored in S7
>>>    in the prologue). Due to bpf_arena constructions such S7 + reg +
>>>    off16 access is guaranteed to be within arena virtual range, so no
>>>    address check at run-time.
>>> - S7 is a free callee-saved register, so it is used to store kern_vm_start
>>> - PROBE_MEM32 allows STX and ST. If they fault the store is a nop. When
>>>    LDX faults the destination register is zeroed.
>>>
>>> To support these on riscv, we do tmp = S7 + src/dst reg and then use
>>> tmp2 as the new src/dst register. This allows us to reuse most of the
>>> code for normal [LDX | STX | ST].
>>
>> Cool to see the RV BPF JIT keeping up with x86 features! ;-) Nice work!
> 
> It is my self proclaimed duty to make sure that all 64-bit JITs have
> feature parity. :D
> 
>>
>> A couple of minor comments below.
>>
>>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>>> ---
>>>   arch/riscv/net/bpf_jit.h        |   1 +
>>>   arch/riscv/net/bpf_jit_comp64.c | 193 +++++++++++++++++++++++++++++++-
>>>   arch/riscv/net/bpf_jit_core.c   |   1 +
>>>   3 files changed, 192 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>>> index f4b6b3b9edda..8a47da08dd9c 100644
>>> --- a/arch/riscv/net/bpf_jit.h
>>> +++ b/arch/riscv/net/bpf_jit.h
>>> @@ -81,6 +81,7 @@ struct rv_jit_context {
>>>   	int nexentries;
>>>   	unsigned long flags;
>>>   	int stack_size;
>>> +	u64 arena_vm_start;
>>>   };
>>>   
>>>   /* Convert from ninsns to bytes. */
>>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>>> index 1adf2f39ce59..0c0588e327af 100644
>>> --- a/arch/riscv/net/bpf_jit_comp64.c
>>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>>> @@ -255,6 +255,10 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
>>>   		emit_ld(RV_REG_S6, store_offset, RV_REG_SP, ctx);
>>>   		store_offset -= 8;
>>>   	}
>>> +	if (ctx->arena_vm_start) {
>>> +		emit_ld(RV_REG_S7, store_offset, RV_REG_SP, ctx);
>>> +		store_offset -= 8;
>>> +	}

As RV_REG_S7 is only for bpf arena, how about define this register as 
bellow, like RV_REG_TCC

#define RV_REG_ARENA RV_REG_S7

>>>   
>>>   	emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
>>>   	/* Set return value. */
>>> @@ -548,6 +552,7 @@ static void emit_atomic(u8 rd, u8 rs, s16 off, s32 imm, bool is64,
>>>   
>>>   #define BPF_FIXUP_OFFSET_MASK   GENMASK(26, 0)
>>>   #define BPF_FIXUP_REG_MASK      GENMASK(31, 27)
>>> +#define DONT_CLEAR		17	/* RV_REG_A7 unused in pt_regmap */
>>
>> Hmm, so this is just a a sentinel node, right? Isn't it more robust to
>> use, say REG_ZERO which will never be used? Maybe REG_DONT_CLEAR_MARKER
>> or smth, so it's obvious how it's used?
> 
> Yes, I agree, RV_REG_ZERO would be the best thing to use here.
> 
>>
>>
>>>   bool ex_handler_bpf(const struct exception_table_entry *ex,
>>>   		    struct pt_regs *regs)
>>> @@ -555,7 +560,8 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
>>>   	off_t offset = FIELD_GET(BPF_FIXUP_OFFSET_MASK, ex->fixup);
>>>   	int regs_offset = FIELD_GET(BPF_FIXUP_REG_MASK, ex->fixup);
>>>   
>>> -	*(unsigned long *)((void *)regs + pt_regmap[regs_offset]) = 0;
>>> +	if (regs_offset != DONT_CLEAR)
>>> +		*(unsigned long *)((void *)regs + pt_regmap[regs_offset]) = 0;
>>>   	regs->epc = (unsigned long)&ex->fixup - offset;
>>>   
>>>   	return true;
>>> @@ -572,7 +578,8 @@ static int add_exception_handler(const struct bpf_insn *insn,
>>>   	off_t fixup_offset;
>>>   
>>>   	if (!ctx->insns || !ctx->ro_insns || !ctx->prog->aux->extable ||
>>> -	    (BPF_MODE(insn->code) != BPF_PROBE_MEM && BPF_MODE(insn->code) != BPF_PROBE_MEMSX))
>>> +	    (BPF_MODE(insn->code) != BPF_PROBE_MEM && BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
>>> +	     BPF_MODE(insn->code) != BPF_PROBE_MEM32))
>>>   		return 0;
>>>   
>>>   	if (WARN_ON_ONCE(ctx->nexentries >= ctx->prog->aux->num_exentries))
>>> @@ -622,6 +629,9 @@ static int add_exception_handler(const struct bpf_insn *insn,
>>>   
>>>   	ex->insn = ins_offset;
>>>   
>>> +	if (BPF_CLASS(insn->code) != BPF_LDX)
>>> +		dst_reg = DONT_CLEAR;
>>> +
>>
>> Instead of having a side-effect, and passing a dummy dst_reg for the
>> probe_mem32, just explicitly add DONT_CLEAR when calling
>> add_exception_handler(). It's more obvious to me at least.
> 
> Sure, will do that in the next version.
> 
>>
>>>   	ex->fixup = FIELD_PREP(BPF_FIXUP_OFFSET_MASK, fixup_offset) |
>>>   		FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
>>>   	ex->type = EX_TYPE_BPF;
>>> @@ -1063,7 +1073,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>>>   		    BPF_CLASS(insn->code) == BPF_JMP;
>>>   	int s, e, rvoff, ret, i = insn - ctx->prog->insnsi;
>>>   	struct bpf_prog_aux *aux = ctx->prog->aux;
>>> -	u8 rd = -1, rs = -1, code = insn->code;
>>> +	u8 rd = -1, rs = -1, code = insn->code, reg_arena_vm_start = RV_REG_S7;
>>>   	s16 off = insn->off;
>>>   	s32 imm = insn->imm;
>>>   
>>> @@ -1539,6 +1549,11 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>>>   	case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
>>>   	case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
>>>   	case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
>>> +	/* LDX | PROBE_MEM32: dst = *(unsigned size *)(src + S7 + off)*/
>>> +	case BPF_LDX | BPF_PROBE_MEM32 | BPF_B:
>>> +	case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
>>> +	case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
>>> +	case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
>>>   	{
>>>   		int insn_len, insns_start;
>>>   		bool sign_ext;
>>> @@ -1546,6 +1561,11 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>>>   		sign_ext = BPF_MODE(insn->code) == BPF_MEMSX ||
>>>   			   BPF_MODE(insn->code) == BPF_PROBE_MEMSX;
>>>   
>>> +		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
>>> +			emit_add(RV_REG_T2, rs, reg_arena_vm_start, ctx);
>>> +			rs = RV_REG_T2;
>>> +		}
>>> +
>>>   		switch (BPF_SIZE(code)) {
>>>   		case BPF_B:
>>>   			if (is_12b_int(off)) {
>>> @@ -1682,6 +1702,87 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>>>   		emit_sd(RV_REG_T2, 0, RV_REG_T1, ctx);
>>>   		break;
>>>   
>>> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
>>> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
>>> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
>>> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
>>> +	{
>>> +		int insn_len, insns_start;
>>> +
>>> +		emit_add(RV_REG_T3, rd, reg_arena_vm_start, ctx);
>>> +		rd = RV_REG_T3;
>>> +
>>> +		/* Load imm to a register then store it */
>>> +		emit_imm(RV_REG_T1, imm, ctx);
>>> +
>>> +		switch (BPF_SIZE(code)) {
>>> +		case BPF_B:
>>> +			if (is_12b_int(off)) {
>>> +				insns_start = ctx->ninsns;
>>> +				emit(rv_sb(rd, off, RV_REG_T1), ctx);
>>> +				insn_len = ctx->ninsns - insns_start;
>>> +				break;
>>> +			}
>>> +
>>> +			emit_imm(RV_REG_T2, off, ctx);
>>> +			emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
>>> +			insns_start = ctx->ninsns;
>>> +			emit(rv_sb(RV_REG_T2, 0, RV_REG_T1), ctx);
>>> +			insn_len = ctx->ninsns - insns_start;
>>> +
>>> +			break;
>>> +
>>> +		case BPF_H:
>>> +			if (is_12b_int(off)) {
>>> +				insns_start = ctx->ninsns;
>>> +				emit(rv_sh(rd, off, RV_REG_T1), ctx);
>>> +				insn_len = ctx->ninsns - insns_start;
>>> +				break;
>>> +			}
>>> +
>>> +			emit_imm(RV_REG_T2, off, ctx);
>>> +			emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
>>> +			insns_start = ctx->ninsns;
>>> +			emit(rv_sh(RV_REG_T2, 0, RV_REG_T1), ctx);
>>> +			insn_len = ctx->ninsns - insns_start;
>>> +			break;
>>> +		case BPF_W:
>>> +			if (is_12b_int(off)) {
>>> +				insns_start = ctx->ninsns;
>>> +				emit_sw(rd, off, RV_REG_T1, ctx);
>>> +				insn_len = ctx->ninsns - insns_start;
>>> +				break;
>>> +			}
>>> +
>>> +			emit_imm(RV_REG_T2, off, ctx);
>>> +			emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
>>> +			insns_start = ctx->ninsns;
>>> +			emit_sw(RV_REG_T2, 0, RV_REG_T1, ctx);
>>> +			insn_len = ctx->ninsns - insns_start;
>>> +			break;
>>> +		case BPF_DW:
>>> +			if (is_12b_int(off)) {
>>> +				insns_start = ctx->ninsns;
>>> +				emit_sd(rd, off, RV_REG_T1, ctx);
>>> +				insn_len = ctx->ninsns - insns_start;
>>> +				break;
>>> +			}
>>> +
>>> +			emit_imm(RV_REG_T2, off, ctx);
>>> +			emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
>>> +			insns_start = ctx->ninsns;
>>> +			emit_sd(RV_REG_T2, 0, RV_REG_T1, ctx);
>>> +			insn_len = ctx->ninsns - insns_start;
>>> +			break;
>>> +		}
>>
>> A lot of similar code, with emit of different sizes. Possible to move
>> move out to a function, and wrap the emits? The main loop is hard read
>> already!
> 
> I thought about this as well. My plan is to refactor the whole thing in a
> seperate patch. I did not do it with this feature as it will cause a lot
> of unrelated code churn.

Yeah, I think we could do that factor out for LDX, ST, STX, while I had 
done it before another riscv bpf arena. BUT, looking forword to your 
implementation.😄

> 
> Thanks,
> Puranjay


