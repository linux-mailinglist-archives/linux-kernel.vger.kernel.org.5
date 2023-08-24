Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D5078648A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 03:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbjHXBR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 21:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239003AbjHXBRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 21:17:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6411510E4;
        Wed, 23 Aug 2023 18:17:23 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RWQ8B1qzzzNn3Y;
        Thu, 24 Aug 2023 09:13:46 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 24 Aug 2023 09:17:20 +0800
Message-ID: <490126e3-b5da-4523-11af-62a2a3c33514@huawei.com>
Date:   Thu, 24 Aug 2023 09:17:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf-next 3/7] riscv, bpf: Support sign-extension mov insns
Content-Language: en-US
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Pu Lehui <pulehui@huaweicloud.com>,
        <linux-riscv@lists.infradead.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Xu Kuohai <xukuohai@huawei.com>,
        Puranjay Mohan <puranjay12@gmail.com>
References: <20230823231059.3363698-1-pulehui@huaweicloud.com>
 <20230823231059.3363698-4-pulehui@huaweicloud.com>
 <87pm3dlj80.fsf@all.your.base.are.belong.to.us>
From:   Pu Lehui <pulehui@huawei.com>
In-Reply-To: <87pm3dlj80.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/24 2:14, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Add support sign-extension mov instructions for RV64.
>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   arch/riscv/net/bpf_jit_comp64.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index fd36cb17101a..d1497182cacf 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -1047,7 +1047,19 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>>   			emit_zext_32(rd, ctx);
>>   			break;
>>   		}
>> -		emit_mv(rd, rs, ctx);
>> +		switch (insn->off) {
>> +		case 0:
>> +			emit_mv(rd, rs, ctx);
>> +			break;
>> +		case 8:
>> +		case 16:
>> +			emit_slli(rs, rs, 64 - insn->off, ctx);
>> +			emit_srai(rd, rs, 64 - insn->off, ctx);
> 
> You're clobbering the source register (rs) here, which is correct.

alright, will fix it

> 
> (Side note: Maybe it's time to add Zbb support to the JIT soon! ;-))
> 
> 
> Björn
