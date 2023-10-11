Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE507C499B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344244AbjJKGFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343606AbjJKGFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:05:07 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EC798
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:05:02 -0700 (PDT)
X-QQ-mid: bizesmtp77t1697004242t663iany
Received: from [10.4.6.71] ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 11 Oct 2023 14:03:59 +0800 (CST)
X-QQ-SSF: 00200000000000B0B000000A0000000
X-QQ-FEAT: B8vEhG33zUS8CZi4+yfGHudp18It4vkViVUG73gJwa2ggDYO8PSAgFTFwoLPr
        7xUvP23JdvjOuoEuNxs/WBhhr2yuWb7Z+DVRPbdL48FI3phuSY/GIkS0KEZ7dHYY0YA11W8
        Apx0WEzjB8/CgM0GZ6aBmBbHEneTCFjw24YLwB0yhCFiA+x/joE05EDLvEmMlpJ0+Z8IU0f
        GJFEnP7Ba2JiDbh2UcZxj2g/+fXK5kkuG88T7A3QIMp2ZYF7s4qpuADOi+cFL8h7GTB4dLZ
        7sy4NtjWDdBJfFp4G+/6b/CMkrjYAp2S5N+DPRP//XDpI9OQnnWtLMXPBnWqabmdc0KdDQz
        CrIKP7eE4t7ySZNTm5D6q2p1jndR5g/wa7AOus6MkLQEdukTFMxIzuYHE6fgQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13477319505604453870
Message-ID: <22EFF2C197DC5C5A+f82966f5-90cf-09a5-214e-4b0e87bc6064@tinylab.org>
Date:   Wed, 11 Oct 2023 14:03:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/2] riscv: kexec_file: Support loading Image binary file
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, lihuafei1@huawei.com,
        conor.dooley@microchip.com, liaochang1@huawei.com,
        ajones@ventanamicro.com, alexghiti@rivosinc.com, evan@rivosinc.com,
        sunilvl@ventanamicro.com, xianting.tian@linux.alibaba.com,
        samitolvanen@google.com, masahiroy@kernel.org,
        apatel@ventanamicro.com, jszhang@kernel.org, duwe@suse.de,
        eric.devolder@oracle.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230914020044.1397356-1-songshuaishuai@tinylab.org>
 <20230914020044.1397356-3-songshuaishuai@tinylab.org>
 <CAJM55Z8D3yJREg0+UtecW3wpgrGKxZYP73Pvbi2oaQfsZf4Gfw@mail.gmail.com>
From:   Song Shuai <songshuaishuai@tinylab.org>
In-Reply-To: <CAJM55Z8D3yJREg0+UtecW3wpgrGKxZYP73Pvbi2oaQfsZf4Gfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/14 16:37, Emil Renner Berthing 写道:
> Song Shuai wrote:
>> This patch creates image_kexec_ops to load Image binary file
>> for kexec_file_load() syscall.
>>
>> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
>> ---
>>   arch/riscv/include/asm/image.h         |  2 +
>>   arch/riscv/include/asm/kexec.h         |  1 +
>>   arch/riscv/kernel/Makefile             |  2 +-
>>   arch/riscv/kernel/kexec_image.c        | 97 ++++++++++++++++++++++++++
>>   arch/riscv/kernel/machine_kexec_file.c |  1 +
>>   5 files changed, 102 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/riscv/kernel/kexec_image.c
>>
>> diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
>> index e0b319af3681..8927a6ea1127 100644
>> --- a/arch/riscv/include/asm/image.h
>> +++ b/arch/riscv/include/asm/image.h
>> @@ -30,6 +30,8 @@
>>   			      RISCV_HEADER_VERSION_MINOR)
>>
>>   #ifndef __ASSEMBLY__
>> +#define riscv_image_flag_field(flags, field)\
>> +			       (((flags) >> field##_SHIFT) & field##_MASK)
> 
> Hi Song,
> 
> This macro is almost FIELD_GET from linux/bitfield.h ..
> 
>>   /**
>>    * struct riscv_image_header - riscv kernel image header
>>    * @code0:		Executable code
>> diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
>> index 518825fe4160..b9ee8346cc8c 100644
>> --- a/arch/riscv/include/asm/kexec.h
>> +++ b/arch/riscv/include/asm/kexec.h
>> @@ -56,6 +56,7 @@ extern riscv_kexec_method riscv_kexec_norelocate;
>>
>>   #ifdef CONFIG_KEXEC_FILE
>>   extern const struct kexec_file_ops elf_kexec_ops;
>> +extern const struct kexec_file_ops image_kexec_ops;
>>
>>   struct purgatory_info;
>>   int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>> index 1c62c639e875..9ecba3231a36 100644
>> --- a/arch/riscv/kernel/Makefile
>> +++ b/arch/riscv/kernel/Makefile
>> @@ -86,7 +86,7 @@ endif
>>   obj-$(CONFIG_HOTPLUG_CPU)	+= cpu-hotplug.o
>>   obj-$(CONFIG_KGDB)		+= kgdb.o
>>   obj-$(CONFIG_KEXEC_CORE)	+= kexec_relocate.o crash_save_regs.o machine_kexec.o
>> -obj-$(CONFIG_KEXEC_FILE)	+= kexec_elf.o machine_kexec_file.o
>> +obj-$(CONFIG_KEXEC_FILE)	+= kexec_elf.o kexec_image.o machine_kexec_file.o
>>   obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
>>   obj-$(CONFIG_CRASH_CORE)	+= crash_core.o
>>
>> diff --git a/arch/riscv/kernel/kexec_image.c b/arch/riscv/kernel/kexec_image.c
>> new file mode 100644
>> index 000000000000..b6aa7f59bd53
>> --- /dev/null
>> +++ b/arch/riscv/kernel/kexec_image.c
>> @@ -0,0 +1,97 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * RISC-V Kexec image loader
>> + *
>> + */
>> +
>> +#define pr_fmt(fmt)	"kexec_file(Image): " fmt
>> +
>> +#include <linux/err.h>
>> +#include <linux/errno.h>
>> +#include <linux/kernel.h>
>> +#include <linux/kexec.h>
>> +#include <linux/pe.h>
>> +#include <linux/string.h>
>> +#include <asm/byteorder.h>
>> +#include <asm/image.h>
>> +
>> +static int image_probe(const char *kernel_buf, unsigned long kernel_len)
>> +{
>> +	const struct riscv_image_header *h =
>> +		(const struct riscv_image_header *)(kernel_buf);
>> +
>> +	if (!h || (kernel_len < sizeof(*h)))
>> +		return -EINVAL;
>> +
>> +	/* According to Documentation/riscv/boot-image-header.rst,
>> +	 * use "magic2" field to check when version >= 0.2.
>> +	 */
>> +
>> +	if (h->version >= RISCV_HEADER_VERSION &&
>> +	    memcmp(&h->magic2, RISCV_IMAGE_MAGIC2, sizeof(h->magic2)))
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static void *image_load(struct kimage *image,
>> +				char *kernel, unsigned long kernel_len,
>> +				char *initrd, unsigned long initrd_len,
>> +				char *cmdline, unsigned long cmdline_len)
>> +{
>> +	struct riscv_image_header *h;
>> +	u64 flags;
>> +	bool be_image, be_kernel;
>> +	struct kexec_buf kbuf;
>> +	int ret;
>> +
>> +	/* Check Image header */
>> +	h = (struct riscv_image_header *)kernel;
>> +	if (!h->image_size) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	/* Check endianness */
>> +	flags = le64_to_cpu(h->flags);
>> +	be_image = riscv_image_flag_field(flags, RISCV_IMAGE_FLAG_BE);
> 
> ..but here you're just testing a single bit, so since be_image is a bool it
> could just be
> 	be_image = flags & RISCV_IMAGE_FLAG_BE_MASK;
> 
> /Emil
Hi Emil,

Sorry for the delayed response,

The `flags` field currently only has bit-0 to indicate the kenrel 
endianness, your comment looks good in this case.

While considering the future extension of the `flags` feild, the 
riscv_image_flag_field() is neccessiry to make callers to require the 
bits they want.

So I prefer to keep this snippet.
> 
>> +	be_kernel = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
>> +	if (be_image != be_kernel) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	/* Load the kernel image */
>> +	kbuf.image = image;
>> +	kbuf.buf_min = 0;
>> +	kbuf.buf_max = ULONG_MAX;
>> +	kbuf.top_down = false;
>> +
>> +	kbuf.buffer = kernel;
>> +	kbuf.bufsz = kernel_len;
>> +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> +	kbuf.memsz = le64_to_cpu(h->image_size);
>> +	kbuf.buf_align = le64_to_cpu(h->text_offset);
>> +
>> +	ret = kexec_add_buffer(&kbuf);
>> +	if (ret) {
>> +		pr_err("Error add kernel image ret=%d\n", ret);
>> +		goto out;
>> +	}
>> +
>> +	image->start = kbuf.mem;
>> +
>> +	pr_info("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>> +				kbuf.mem, kbuf.bufsz, kbuf.memsz);
>> +
>> +	ret = load_extra_segments(image, kbuf.mem, kbuf.memsz,
>> +				  initrd, initrd_len, cmdline, cmdline_len);
>> +
>> +out:
>> +	return ret ? ERR_PTR(ret) : NULL;
>> +}
>> +
>> +const struct kexec_file_ops image_kexec_ops = {
>> +	.probe = image_probe,
>> +	.load = image_load,
>> +};
>> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
>> index aedb8c16a283..5dc700834f1e 100644
>> --- a/arch/riscv/kernel/machine_kexec_file.c
>> +++ b/arch/riscv/kernel/machine_kexec_file.c
>> @@ -17,6 +17,7 @@
>>
>>   const struct kexec_file_ops * const kexec_file_loaders[] = {
>>   	&elf_kexec_ops,
>> +	&image_kexec_ops,
>>   	NULL
>>   };
>>
>> --
>> 2.20.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

-- 
Thanks
Song Shuai

