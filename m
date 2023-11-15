Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9267EBB12
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 03:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjKOCF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 21:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKOCF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 21:05:56 -0500
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCADE3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 18:05:51 -0800 (PST)
X-ASG-Debug-ID: 1700013947-1eb14e538c15560001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id GQIH352o3onlTOcI (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 15 Nov 2023 10:05:47 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 15 Nov
 2023 10:05:47 +0800
Received: from [192.168.1.204] (125.76.214.122) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 15 Nov
 2023 10:05:44 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Message-ID: <d35ce933-db49-4ec8-82ba-eb850e8e3c67@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 192.168.1.204
Date:   Wed, 15 Nov 2023 10:05:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: x86/sm2 -add Zhaoxin SM2 algorithm implementation
To:     Dave Hansen <dave.hansen@intel.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <seanjc@google.com>, <kim.phillips@amd.com>,
        <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <jiaxi.chen@linux.intel.com>, <jmattson@google.com>,
        <pawan.kumar.gupta@linux.intel.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-ASG-Orig-Subj: Re: [PATCH] crypto: x86/sm2 -add Zhaoxin SM2 algorithm implementation
CC:     <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>,
        <YunShen@zhaoxin.com>, <Leoliu@zhaoxin.com>
References: <20231109094744.545887-1-LeoLiu-oc@zhaoxin.com>
 <14bf7ab4-f770-4b3b-ad10-aa1d29d4f219@intel.com>
From:   LeoLiu-oc <leoliu-oc@zhaoxin.com>
In-Reply-To: <14bf7ab4-f770-4b3b-ad10-aa1d29d4f219@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [125.76.214.122]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1700013947
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 12458
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.116760
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/11/9 23:00, Dave Hansen 写道:
> On 11/9/23 01:47, LeoLiu-oc wrote:
> ...
>> diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
>> index 9bbfd01cfa2f..a771a9da2abd 100644
>> --- a/arch/x86/crypto/Kconfig
>> +++ b/arch/x86/crypto/Kconfig
>> @@ -519,4 +519,15 @@ config CRYPTO_CRCT10DIF_PCLMUL
>>   	  Architecture: x86_64 using:
>>   	  - PCLMULQDQ (carry-less multiplication)
>>   
>> +config CRYPTO_SM2_ZHAOXIN_GMI
>> +	tristate "SM2 Cipher algorithm (Zhaoxin GMI Instruction)"
>> +	depends on X86
> 
> Why does this not have "depends on CPU_SUP_ZHAOXIN"?
> 
Thank you for your suggestion. It is indeed necessary to add a
dependency on CPU_SUP_ZHAOXIN here, which will be updated in the next
version.

> Also, the assembly in here looks suspiciously like x86_64 assembly.
> How, exactly, does this build when !X86_64?
> 
The assembly code will be modified to be embedded in the .c file in the
next version, which will be compatible with !X86_64.

>> +	select CRYPTO_AKCIPHER
>> +	select CRYPTO_MANAGER
>> +	help
>> +	  SM2 (ShangMi 2) public key algorithm by Zhaoxin GMI Instruction
>> +
>> +	  Published by State Encryption Management Bureau, China,
>> +	  as specified by OSCCA GM/T 0003.1-2012 -- 0003.5-2012.
>> +
>>   endmenu
>> diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
>> index 9aa46093c91b..c23b328a3ecd 100644
>> --- a/arch/x86/crypto/Makefile
>> +++ b/arch/x86/crypto/Makefile
>> @@ -109,6 +109,9 @@ aria-aesni-avx2-x86_64-y := aria-aesni-avx2-asm_64.o aria_aesni_avx2_glue.o
>>   obj-$(CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64) += aria-gfni-avx512-x86_64.o
>>   aria-gfni-avx512-x86_64-y := aria-gfni-avx512-asm_64.o aria_gfni_avx512_glue.o
>>   
>> +obj-$(CONFIG_CRYPTO_SM2_ZHAOXIN_GMI) += sm2-zhaoxin-gmi.o
>> +sm2-zhaoxin-gmi-y := sm2-zhaoxin-gmi_asm.o sm2-zhaoxin-gmi_glue.o
>> +
>>   quiet_cmd_perlasm = PERLASM $@
>>         cmd_perlasm = $(PERL) $< > $@
>>   $(obj)/%.S: $(src)/%.pl FORCE
>> diff --git a/arch/x86/crypto/sm2-zhaoxin-gmi_asm.S b/arch/x86/crypto/sm2-zhaoxin-gmi_asm.S
>> new file mode 100644
>> index 000000000000..4ee5194557a0
>> --- /dev/null
>> +++ b/arch/x86/crypto/sm2-zhaoxin-gmi_asm.S
>> @@ -0,0 +1,59 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Zhaoxin GMI implementation of a SM2 function
>> + *
>> + * Copyright(c) 2023 Zhaoxin Semiconductor LTD.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of version 2 of the GNU General Public License as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + *
>> + * Contact Information:
>> + *  YunShen <YunShen@zhaoxin.com>
>> + */
> 
> I thought we were using SPDX instead of blown-up license text now.  Why
> does this need the GPLv2 blurb?
> 
Thank you for your reminder. I will remove it in the subsequent version.

>> +#include <linux/linkage.h>
>> +
>> +#define KEY_PTR     %rdi /* 1st arg */
>> +#define HASH_PTR    %rsi /* 2nd arg */
>> +#define SIG_PTR     %rdx /* 3rd arg */
>> +#define SCRATCH_PTR %rcx /* 4rd arg */
>> +#define VER_RESULT  %rax /* ret     */
>> +
>> +.text
>> +.align 32
>> +###############################################################################
>> +# int zhaoxin_gmi_sm2_verify (
>> +#         unsigned char *key, /*key*/
>> +#         unsigned char *hash, /*hash*/
>> +#         unsigned char *sig, /*signature*/
>> +#         unsigned char *scratch /*8 kbytes scratch space*/
>> +#     );
>> +###############################################################################
> 
> This comment is just a waste of space.  The types here are completely
> uninformative and the comments:
> 
> 	unsigned char *key, /*key*/
> 
> are, um, equally uninformative considering the #defines above.
> 
The assembly code here will be abandoned in the next version and will be
modified to be embedded in the C language code. There will be no such
problem in the future.

>> +SYM_FUNC_START(zhaoxin_gmi_sm2_verify)
>> +	push %r12
>> +	push %rbx
> 
> Please mention that these are callee-saved registers that the
> instruction will clobber.
> 
As mentioned above.

>> +	mov HASH_PTR, %rax
>> +	mov KEY_PTR, %rbx
>> +	mov SIG_PTR, %r12
>> +	mov $8, %rdx
>> +	mov SCRATCH_PTR, %rsi
>> +	mov %r12, %rdi
>> +
>> +	.byte 0XF2
>> +	.byte 0X0F
>> +	.byte 0XA6
>> +	.byte 0XC0
> 
> Please look around the codebase and see what folks do with assembly for
> instructions that might not be supported in the assembler.  There's an
> existing standard here.
> 
As mentioned above.

>> +	mov %rcx, %rax
>> +
>> +	pop %rbx
>> +	pop %r12
>> +
>> +	RET
>> +SYM_FUNC_END(zhaoxin_gmi_sm2_verify)
>> diff --git a/arch/x86/crypto/sm2-zhaoxin-gmi_glue.c b/arch/x86/crypto/sm2-zhaoxin-gmi_glue.c
>> new file mode 100644
>> index 000000000000..4d0d18f68266
>> --- /dev/null
>> +++ b/arch/x86/crypto/sm2-zhaoxin-gmi_glue.c
>> @@ -0,0 +1,145 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * SM2 asymmetric public-key algorithm
>> + * as specified by OSCCA GM/T 0003.1-2012 -- 0003.5-2012 SM2 and
>> + * described at https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02
>> + *
>> + * Copyright (c) 2023 Shanghai Zhaoxin Semiconductor LTD.
>> + * Authors: YunShen <yunshen@zhaoxin.com>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/mpi.h>
>> +#include <crypto/internal/akcipher.h>
>> +#include <crypto/akcipher.h>
>> +#include <crypto/sm2.h>
>> +#include <asm/cpufeature.h>
>> +#include <asm/processor.h>
>> +#include <asm/cpu_device_id.h>
>> +
>> +#define SCRATCH_SIZE (4 * 2048)
>> +
>> +asmlinkage int zhaoxin_gmi_sm2_verify(unsigned char *key, unsigned char *hash, unsigned char *sig,
>> +				unsigned char *scratch);
>> +
>> +struct sm2_cipher_data {
>> +	u8 pub_key[65]; /* public key */
>> +};
>> +
>> +/* Load supported features of the CPU to see if the SM2 is available. */
>> +static int zhaoxin_gmi_available(void)
>> +{
>> +	if (!boot_cpu_has(X86_FEATURE_SM2_EN)) {
>> +		pr_err("can't enable hardware SM2 if Zhaoxin GMI SM2 is not enabled\n");
>> +		return -ENODEV;
>> +	}
>> +	return 0;
>> +}
> 
> How can this code even be reached if X86_FEATURE_SM2_EN is clear?  How
> will the cipher even get registered?
> 
SM2 has two macro definitions, one representing the existence of SM2
functionality; the other SM2_EN represents that the functionality is
enabled and can be modified in the firmware.
In the initialization function, the detection of X86_FEATURE_SM2 will be
performed to verify if SM2 functionality is supported.
This is the detection of X86_FEATURE_SM2_EN to verify whether the SM2
function is enabled in the firmware.

>> +/* Zhaoxin sm2 verify function */
>> +static int _zhaoxin_sm2_verify(struct sm2_cipher_data *ec, unsigned char *hash, unsigned char *sig)
>> +{
>> +	int ret = -EKEYREJECTED;
>> +	uint64_t f_ok = 0;
> 
> This is an odd type choice since this is far from a user/kernel ABI and
> also the zhaoxin_gmi_sm2_verify() declared return type is 'int'.
> 
Yes, it will be modified in the next version.

>> +	unsigned char *scratch = kzalloc(SCRATCH_SIZE, GFP_KERNEL);
>> +
>> +	f_ok = zhaoxin_gmi_sm2_verify(ec->pub_key, hash, sig, scratch);
>> +	if (f_ok == 1)
>> +		ret = 0;
>> +
>> +	kfree(scratch);
>> +
>> +	return ret;
>> +}
>> +
>> +static int zhaoxin_sm2_verify(struct akcipher_request *req)
>> +{
>> +	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
>> +	struct sm2_cipher_data *ec = akcipher_tfm_ctx(tfm);
>> +	unsigned char *buffer;
>> +	int ret;
>> +
>> +	buffer = kmalloc(req->src_len + req->dst_len, GFP_KERNEL);
>> +	if (!buffer)
>> +		return -ENOMEM;
>> +
>> +	sg_pcopy_to_buffer(req->src, sg_nents_for_len(req->src, req->src_len + req->dst_len),
>> +		buffer, req->src_len + req->dst_len, 0);
> 
> While sg_pcopy_to_buffer() calls in general seem
> readablility-challenged, this one in particular is pretty bad.  Please
> break this up logically (one line per argument seems commonplace) or use
> some helper intermediate variables.  I do notice that 'req->src_len +
> req->dst_len' is repeated quite a few times in this function, for instance.
> 
Yes, this change will make the code clearer, and will be modified in the
next version as you suggested.

>> +	ret = _zhaoxin_sm2_verify(ec, buffer + req->src_len, buffer);
>> +	kfree(buffer);
>> +
>> +	return ret;
>> +}
>> +
>> +static int zhaoxin_sm2_set_pub_key(struct crypto_akcipher *tfm, const void *key,
>> +				unsigned int keylen)
>> +{
>> +	struct sm2_cipher_data *ec = akcipher_tfm_ctx(tfm);
>> +
>> +	memcpy(ec->pub_key, key, keylen);
>> +
>> +	return 0;
>> +}
>> +
>> +static unsigned int zhaoxin_sm2_max_size(struct crypto_akcipher *tfm)
>> +{
>> +	/* Unlimited max size */
>> +	return PAGE_SIZE;
>> +}
> 
> I don't know the crypto API well, but does this mean that for every 4k
> of data that this code deals with, it needs to kmalloc()/kfree() 8k?
> 
The return value of the zhaoxin_sm2_max_size function is the maximum
length of the algorithm's output buffer.Generally,the length of the
output data of the SM2 algorithm is not greater than PAGE_SIZE.
In addition, it also references the setting of the software-implemented
SM2 algorithm in the kernel.

>> +static int zhaoxin_sm2_init_tfm(struct crypto_akcipher *tfm)
>> +{
>> +	return zhaoxin_gmi_available();
>> +}
>> +
>> +static void zhaoxin_sm2_exit_tfm(struct crypto_akcipher *tfm)
>> +{
>> +	struct sm2_cipher_data *ec = akcipher_tfm_ctx(tfm);
>> +
>> +	memset(ec, 0, sizeof(*ec));
>> +}
>> +
>> +static struct akcipher_alg zhaoxin_sm2 = {
>> +	.verify = zhaoxin_sm2_verify,
>> +	.set_pub_key = zhaoxin_sm2_set_pub_key,
>> +	.max_size = zhaoxin_sm2_max_size,
>> +	.init = zhaoxin_sm2_init_tfm,
>> +	.exit = zhaoxin_sm2_exit_tfm,
>> +	.base = {
>> +		.cra_name = "sm2",
>> +		.cra_driver_name = "zhaoxin-gmi-sm2",
>> +		.cra_priority = 150,
>> +		.cra_module = THIS_MODULE,
>> +		.cra_ctxsize = sizeof(struct sm2_cipher_data),
>> +	},
>> +};
>> +
>> +static const struct x86_cpu_id zhaoxin_sm2_cpu_ids[] = {
>> +	X86_MATCH_FEATURE(X86_FEATURE_SM2, NULL),
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(x86cpu, zhaoxin_sm2_cpu_ids);
>> +
>> +static int __init zhaoxin_sm2_init(void)
>> +{
>> +	if (!x86_match_cpu(zhaoxin_sm2_cpu_ids)) {
>> +		pr_err("The CPU isn't support hardware SM2.\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	return crypto_register_akcipher(&zhaoxin_sm2);
>> +}
> 
> Again, please look around the code base.  There are a bunch of crypto
> drivers that do checks like this.  *None* have a pr_err().  Few spew any
> spam to dmesg.  Why does this one?
> 
OK, The pr_err statement here will be removed in the next version.

>> +static void __exit zhaoxin_sm2_exit(void)
>> +{
>> +	crypto_unregister_akcipher(&zhaoxin_sm2);
>> +}
>> +
>> +module_init(zhaoxin_sm2_init);
>> +module_exit(zhaoxin_sm2_exit);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("YunShen <yunshen@zhaoxin.com>");
>> +MODULE_DESCRIPTION("SM2 Zhaoxin GMI Algorithm");
>> +MODULE_ALIAS_CRYPTO("zhaoxin-gmi-sm2");
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index 4af140cf5719..07a78ec83bed 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -146,6 +146,8 @@
>>   #define X86_FEATURE_HYPERVISOR		( 4*32+31) /* Running on a hypervisor */
>>   
>>   /* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5 */
>> +#define X86_FEATURE_SM2			(5*32 + 0) /* SM2 ZhaoXin GMI present */
>> +#define X86_FEATURE_SM2_EN			(5*32 + 1) /* SM2 ZhaoXin GMI enabled */
> 
> Ahh, so I actually misread the two CPUID flags that got checked earlier.
> 
> What does it take to get "GMI enabled"?  How can it be present but not
> enabled?
> 
As mentioned earlier, SM2 and SM2_EN represent the existence and
enablement of SM2 functionality, respectively. SM2_EN can be turned on
or off in the firmware.

Best Regards
LeoLiu-oc
