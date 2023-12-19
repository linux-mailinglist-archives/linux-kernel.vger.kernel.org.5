Return-Path: <linux-kernel+bounces-5229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2AC81883B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26DF91C2163B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E4A1B274;
	Tue, 19 Dec 2023 13:04:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m25484.xmail.ntesmail.com (mail-m25484.xmail.ntesmail.com [103.129.254.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9551A71B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [10.9.0.234] (unknown [211.103.144.18])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 9ACE5260127;
	Tue, 19 Dec 2023 20:54:03 +0800 (CST)
Message-ID: <273284e8-7680-4f5f-8065-c5d780987e59@easystack.cn>
Date: Tue, 19 Dec 2023 20:54:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Content-Language: en-US
To: Yuntao Wang <ytcoode@gmail.com>
Cc: bhe@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, vgoyal@redhat.com
References: <3765549d-892e-4102-9b56-9add1d0a8089@easystack.cn>
 <20231219103928.98465-1-ytcoode@gmail.com>
From: fuqiang wang <fuqiang.wang@easystack.cn>
In-Reply-To: <20231219103928.98465-1-ytcoode@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQx1JVkwdTxkaGk1NThpNTFUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKSlVKS0hVSk9PVUpDWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8c8223f70b0276kunm9ace5260127
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OlE6Nyo5LzE#LwFPAwoqQy0O
	HzEKCS1VSlVKTEtJQkJLT09OT0tIVTMWGhIXVR0OChIaFRxVDBoVHDseGggCCA8aGBBVGBVFWVdZ
	EgtZQVlJSkpVSktIVUpPT1VKQ1lXWQgBWUFOS0hMNwY+

在 2023/12/19 18:39, Yuntao Wang 写道:

> On Tue, 19 Dec 2023 16:55:16 +0800, fuqiang wang <fuqiang.wang@easystack.cn> wrote:
>
>> Thank you very much for your patient comment. This change does indeed improve
>> readability. But as a combination of these two, how do you feel about moving
>> crash_setup_memmap_entries() behind vzalloc().
> I don't quite understand what you're trying to express.
Hi Yuntao,

I make the following changes based on your patch. This change can increase code
readability on one hand, On the other hand, if these functions return errors,
the rest process of crash_setup_memmap_entries() can be skipped.

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c92d88680dbf..67a974c041b9 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -285,6 +285,12 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
         cmem = vzalloc(struct_size(cmem, ranges, 1));
         if (!cmem)
                 return -ENOMEM;
+       cmem->max_nr_ranges = 1;
+
+       /* Exclude some ranges from crashk_res and add rest to memmap */
+       ret = memmap_exclude_ranges(image, cmem, crashk_res.start, crashk_res.end);
+       if (ret)
+               goto out;

         memset(&cmd, 0, sizeof(struct crash_memmap_data));
         cmd.params = params;
@@ -320,11 +326,6 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
                 add_e820_entry(params, &ei);
         }

-       /* Exclude some ranges from crashk_res and add rest to memmap */
-       ret = memmap_exclude_ranges(image, cmem, crashk_res.start, crashk_res.end);
-       if (ret)
-               goto out;
-
         for (i = 0; i < cmem->nr_ranges; i++) {
                 ei.size = cmem->ranges[i].end - cmem->ranges[i].start + 1;
>> The image->elf_load_addr is determined by arch_kexec_locate_mem_hole(), this
>> function can ensure that the value is within the range of [crashk_res.start,
>> crashk_res.end), but it seems that it cannot guarantee that its value will
>> always be equal to crashk_res.start. Perhaps I have some omissions, please
>> point them out.
> Because elfcorehdr is the first one and only one that allocates memory from the
> starting address of crashk_res, and the starting address of crashk_res meets
> the alignment requirement of elfcorehdr.
>
> elfcorehdr requires 4k alignment, and the starting address of crashk_res is
> 16M aligned.
>
> Therefore, image->elf_load_addr should be equal to crashk_res.start.
Yes! you read the code very carefully and I didn't notice that! However, the
location of elfheader in crashk_res.start is highly dependent on elfheader in
crashk_res memory allocation order and position. At present, x86 first allocate
the memory of elfheader. However, ppc64 doesn't seem to be like this (It first
executes load_backup_segment()). Although arm64 allocates elfheader first, it
sets kbuf.top_down to true in load_other_segments(). This will cause the
elfheader to be allocated near crashk_res.end. I debugged using crash on the
arm64 machine and the result is(Although the kernel version of the testing
machine may be a bit low, the process of allocating elfheaders is consistent
with upstream):

     crash> p crashk_res.start
     $6 = 1375731712
     crash> p crashk_res.end
     $7 = 2147483647
     crash> p kexec_crash_image.arch.elf_headers_mem
     $9 = 2147352576

So I think it's best to set cmem->max_nr_ranges to 2 for easy maintenance in
the future. What do you think about ?

