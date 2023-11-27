Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517267F9F36
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjK0MCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjK0MCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:02:31 -0500
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF48B136
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oiUGDw2y++Y7rWGXL3QA8/CPDFWAWAcUNYH71lKYLeg=; b=Tm1nbDltBr80zIQ/vPbDSSVNbd
        1U3HWKPCGkYluv40bsDdUcP55ja1tlFgFbtQarha5EbMJ4UqUbBx2NYWRXCLxhYw86tXvvwgFnfxE
        oMVieG+RgUFpiQ9KZFWkexrujK0l+C8+qs1hO7eAIbwsF6sDBwiEYjDDKNguHyEnuZu0szoIV5Y+n
        FVA2wD40i9FtxxSWrLq5Uz3Eyw+BJqndiSqD39rEE3orDiEylxWRT8vz7aZEXbZKEzMpo8oEtEIcq
        ESdkSUQWzAm88zbK8lPw72GL7Z86MVbQ2zWCamD94UHTikzjJJLpnmFJkB63O2reZlFho6wJd3Ifn
        yOmu5Unw==;
Received: from [167.98.27.226] (helo=[10.35.4.236])
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1r7aJo-007UWj-1R; Mon, 27 Nov 2023 12:02:28 +0000
Message-ID: <b4ee0ab3-9772-439c-bc9c-474f6f2862ba@codethink.co.uk>
Date:   Mon, 27 Nov 2023 12:02:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: fix incorrect use of __user pointer
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        kernel test robot <lkp@intel.com>
References: <20231124113803.165431-1-cleger@rivosinc.com>
Content-Language: en-GB
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20231124113803.165431-1-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: ben.dooks@codethink.co.uk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2023 11:38, Clément Léger wrote:
> These warnings were reported by sparse and were due to lack of __user
> annotation as well as dereferencing such pointer:
> 
> arch/riscv/kernel/traps_misaligned.c:361:21: warning: dereference of noderef expression
> arch/riscv/kernel/traps_misaligned.c:373:21: warning: dereference of noderef expression
> arch/riscv/kernel/traps_misaligned.c:381:21: warning: dereference of noderef expression
> arch/riscv/kernel/traps_misaligned.c:322:24: warning: incorrect type in initializer (different address spaces)
> arch/riscv/kernel/traps_misaligned.c:322:24:    expected unsigned char const [noderef] __user *__gu_ptr
> arch/riscv/kernel/traps_misaligned.c:322:24:    got unsigned char const [usertype] *addr
> arch/riscv/kernel/traps_misaligned.c:361:21: warning: dereference of noderef expression
> arch/riscv/kernel/traps_misaligned.c:373:21: warning: dereference of noderef expression
> arch/riscv/kernel/traps_misaligned.c:381:21: warning: dereference of noderef expression
> arch/riscv/kernel/traps_misaligned.c:332:24: warning: incorrect type in initializer (different address spaces)
> arch/riscv/kernel/traps_misaligned.c:332:24:    expected unsigned char [noderef] __user *__gu_ptr
> arch/riscv/kernel/traps_misaligned.c:332:24:    got unsigned char [usertype] *addr
> 
> As suggested by Christoph Hellwig, casting pointers from an address
> space to another is not a good idea and we should rather cast the
> untyped unsigned long to their final address space. Fix the ones in
> load_u8()/store_u8()/__read_insn() by passing a unsigned long and then
> casting it to the appropriate type (__user of not) depending if used in
> kernel/ user mode. Also remove unneeded else construct in store_u8()/
> load_u8().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311160606.obGOOwB3-lkp@intel.com/
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>   arch/riscv/kernel/traps_misaligned.c | 55 +++++++++++++---------------
>   1 file changed, 25 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index 5eba37147caa..a92b88af855a 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -265,19 +265,19 @@ static unsigned long get_f32_rs(unsigned long insn, u8 fp_reg_offset,
>   #define GET_F32_RS2S(insn, regs) (get_f32_rs(RVC_RS2S(insn), 0, regs))
>   
>   #ifdef CONFIG_RISCV_M_MODE
> -static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
> +static inline int load_u8(struct pt_regs *regs, const unsigned long addr, u8 *r_val)
>   {
>   	u8 val;
>   
> -	asm volatile("lbu %0, %1" : "=&r" (val) : "m" (*addr));
> +	asm volatile("lbu %0, %1" : "=&r" (val) : "m" (*(const u8 *)addr));
>   	*r_val = val;
>   
>   	return 0;
>   }
>   
> -static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
> +static inline int store_u8(struct pt_regs *regs, unsigned long addr, u8 val)
>   {
> -	asm volatile ("sb %0, %1\n" : : "r" (val), "m" (*addr));
> +	asm volatile ("sb %0, %1\n" : : "r" (val), "m" (*(u8 *)addr));
>   
>   	return 0;
>   }
> @@ -316,34 +316,32 @@ static inline int get_insn(struct pt_regs *regs, ulong mepc, ulong *r_insn)
>   	return 0;
>   }
>   #else
> -static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
> +static inline int load_u8(struct pt_regs *regs, const unsigned long addr, u8 *r_val)
>   {
> -	if (user_mode(regs)) {
> -		return __get_user(*r_val, addr);
> -	} else {
> -		*r_val = *addr;
> -		return 0;
> -	}
> +	if (user_mode(regs))
> +		return __get_user(*r_val, (u8 __user *)addr);
> +
> +	*r_val = *(const u8 *)addr;
> +	return 0;
>   }
>   
> -static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
> +static inline int store_u8(struct pt_regs *regs, unsigned long addr, u8 val)
>   {
> -	if (user_mode(regs)) {
> -		return __put_user(val, addr);
> -	} else {
> -		*addr = val;
> -		return 0;
> -	}
> +	if (user_mode(regs))
> +		return __put_user(val, (u8 __user *)addr);
> +
> +	*(u8 *)addr = val;
> +	return 0;
>   }
>   
> -#define __read_insn(regs, insn, insn_addr)		\
> +#define __read_insn(regs, insn, insn_addr, type)	\
>   ({							\
>   	int __ret;					\
>   							\
>   	if (user_mode(regs)) {				\
> -		__ret = __get_user(insn, insn_addr);	\
> +		__ret = __get_user(insn, (type __user *) insn_addr); \
>   	} else {					\
> -		insn = *insn_addr;			\
> +		insn = *(type *)insn_addr;		\
>   		__ret = 0;				\
>   	}						\
>   							\
> @@ -356,9 +354,8 @@ static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
>   
>   	if (epc & 0x2) {
>   		ulong tmp = 0;
> -		u16 __user *insn_addr = (u16 __user *)epc;
>   
> -		if (__read_insn(regs, insn, insn_addr))
> +		if (__read_insn(regs, insn, epc, u16))
>   			return -EFAULT;
>   		/* __get_user() uses regular "lw" which sign extend the loaded
>   		 * value make sure to clear higher order bits in case we "or" it
> @@ -369,16 +366,14 @@ static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
>   			*r_insn = insn;
>   			return 0;
>   		}
> -		insn_addr++;
> -		if (__read_insn(regs, tmp, insn_addr))
> +		epc += sizeof(u16);
> +		if (__read_insn(regs, tmp, epc, u16))
>   			return -EFAULT;
>   		*r_insn = (tmp << 16) | insn;
>   
>   		return 0;
>   	} else {
> -		u32 __user *insn_addr = (u32 __user *)epc;
> -
> -		if (__read_insn(regs, insn, insn_addr))
> +		if (__read_insn(regs, insn, epc, u32))
>   			return -EFAULT;
>   		if ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) {
>   			*r_insn = insn;
> @@ -491,7 +486,7 @@ int handle_misaligned_load(struct pt_regs *regs)
>   
>   	val.data_u64 = 0;
>   	for (i = 0; i < len; i++) {
> -		if (load_u8(regs, (void *)(addr + i), &val.data_bytes[i]))
> +		if (load_u8(regs, addr + i, &val.data_bytes[i]))
>   			return -1;
>   	}
>   
> @@ -589,7 +584,7 @@ int handle_misaligned_store(struct pt_regs *regs)
>   		return -EOPNOTSUPP;
>   
>   	for (i = 0; i < len; i++) {
> -		if (store_u8(regs, (void *)(addr + i), val.data_bytes[i]))
> +		if (store_u8(regs, addr + i, val.data_bytes[i]))
>

Would it not be easier to have a switch here for memcpy or copy_to_user?

    			return -1;
>   	}
>   

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

