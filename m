Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C8D7750F5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 04:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjHICcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 22:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjHICco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 22:32:44 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A651980;
        Tue,  8 Aug 2023 19:32:42 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RLDZn1H2pz1GDfP;
        Wed,  9 Aug 2023 10:31:29 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 10:32:39 +0800
Message-ID: <721de7d4-2802-7399-c2d4-2631cfb20515@huawei.com>
Date:   Wed, 9 Aug 2023 10:32:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf-next] riscv/bpf: Fix truncated immediate warning in
 rv_s_insn
To:     Luke Nelson <lukenels@cs.washington.edu>
CC:     <bpf@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        Xi Wang <xi.wang@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230727024931.17156-1-luke.r.nels@gmail.com>
 <b85bcf1d-9467-4df6-da11-8f0b24165ada@huawei.com>
 <CC58CCF3-1994-4C50-B8FC-E1520ED743BF@cs.washington.edu>
Content-Language: en-US
From:   Pu Lehui <pulehui@huawei.com>
In-Reply-To: <CC58CCF3-1994-4C50-B8FC-E1520ED743BF@cs.washington.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/9 0:08, Luke Nelson wrote:
> 
>>>   static inline u32 rv_s_insn(u16 imm11_0, u8 rs2, u8 rs1, u8 funct3, u8 opcode)
>>>   {
>>> - u8 imm11_5 = imm11_0 >> 5, imm4_0 = imm11_0 & 0x1f;
>>> + u32 imm11_5 = (imm11_0 >> 5) & 0x7f, imm4_0 = imm11_0 & 0x1f;
>>
>> Hi Luke,
>>
>> keep u8 and add 0x7f explicit mask should work. I ran the repro case and it can silence the warning.
>>
>>>
>>>    return (imm11_5 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) |
>>>    (imm4_0 << 7) | opcode;
> 

Hi Luke,

Thank for more detailed explanation.

> That does fix the warning, but I think explicitly declaring imm11_5
> as u32 is more clear here than the current code which relies on
> implicit promotion of imm11_5 from u8 to signed int in the expression
> (imm11_5 << 25).
> 
> Because of the promotion to signed int, (imm11_5 << 25) is technically
> signed overflow and undefined behavior whenever the shift changes
> the value in the sign bit. In practice, this isn't an issue; both
> because the kernel is compiled with -fno-strict-overflow, but also
> because GCC documentation explicitly states that "GCC does not use
> the latitude given in C99 and C11 only to treat certain aspects of
> signed '<<' as undefined" [1].
> 
> Though it may not be an issue in practice, since I'm touching this
> line anyways to fix the warning, I think it makes sense to update
> the type of imm11_5 to be u32 at the same time.
> 

Agree. But this inconsistency looks weird, i.e. imm11_5 change to u32 
while rs2, rs1 and funct3 still u8. Anyway, our primary goal is to 
silence the sparse warning, and the current patch looks good to me. 
Let's go ahead.

Feel free to add:
Reviewed-by: Pu Lehui <pulehui@huawei.com>

>> Nit: maybe use "riscv, bpf" for the subject will look nice for the riscv-bpf git log tree.
> 
> Sure, I can send out a new revision with an updated subject line.
> 
> - Luke
> 
> 
> [1]: https://gcc.gnu.org/onlinedocs/gcc/Integers-implementation.html
