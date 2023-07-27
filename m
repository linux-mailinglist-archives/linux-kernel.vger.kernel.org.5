Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA45765B64
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjG0Scl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjG0Sci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:32:38 -0400
X-Greylist: delayed 545 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Jul 2023 11:32:33 PDT
Received: from out-64.mta0.migadu.com (out-64.mta0.migadu.com [91.218.175.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D9130ED
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:32:33 -0700 (PDT)
Message-ID: <87f58a7c-2dee-9dcd-156f-edc41bfea38a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690482204; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b60kJCPabQJkT35gIDAP++RJPy/QBXfwHhrngXV1+Vc=;
        b=GBhnp40h4N+JLjjgkG9rLrjy4DKQ8eDs0BN68hfpHZaFaR+Poz24P0kYDbLohuxNntmJNJ
        E8V24Gz7GyY1dlGCsmeZN3qlwJIh+3PeNy2yarxDcxpeMoOpIWrDRZa2QRDf3VXkY5V/AN
        +boFxJEgSkofonb0zzFEv9qyws+IfcU=
Date:   Thu, 27 Jul 2023 11:23:21 -0700
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH] libbpf: fix warnings "'pad_type' 'pad_bits' 'new_off' may
 be used uninitialized"
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>,
        Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230727082536.1974154-1-xiangyu.chen@eng.windriver.com>
 <ZMJOl5uLrK9rucXB@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZMJOl5uLrK9rucXB@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/23 4:01 AM, Jiri Olsa wrote:
> On Thu, Jul 27, 2023 at 04:25:36PM +0800, Xiangyu Chen wrote:
>> From: Xiangyu Chen <xiangyu.chen@windriver.com>
>>
>> When turn on the yocto DEBUG_BUILD flag, the build options for gcc would enable maybe-uninitialized,
>> and following warnings would be reported as below:
> 
> curious, what's the gcc version? I can't reproduce that,
> and we already have all warnings enabled:
> 
>    CFLAGS += -Werror -Wall
> 
> they seem like false warnings also, because ARRAY_SIZE(pads)
> will be always > 0

Agree. This definitely a false positive.
In kernel top Makefile, we have

# Enabled with W=2, disabled by default as noisy
ifdef CONFIG_CC_IS_GCC
KBUILD_CFLAGS += -Wno-maybe-uninitialized
endif

That means gcc -maybe-uninitialized is very noisy.

> 
> jirka
> 
>>
>> | btf_dump.c: In function 'btf_dump_emit_bit_padding':
>> | btf_dump.c:916:4: error: 'pad_type' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>> |   916 |    btf_dump_printf(d, "\n%s%s: %d;", pfx(lvl), pad_type,
>> |       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> |   917 |      in_bitfield ? new_off - cur_off : 0);
>> |       |      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> | btf_dump.c:929:6: error: 'pad_bits' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>> |   929 |   if (bits == pad_bits) {
>> |       |      ^
>> | btf_dump.c:913:28: error: 'new_off' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>> |   913 |       (new_off == next_off && roundup(cur_off, next_align * 8) != new_off) ||
>> |       |       ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> |   HOSTLD  scripts/mod/modpost
>>
>> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
>> ---
>>   tools/lib/bpf/btf_dump.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
>> index 4d9f30bf7f01..79923c3b8777 100644
>> --- a/tools/lib/bpf/btf_dump.c
>> +++ b/tools/lib/bpf/btf_dump.c
>> @@ -867,8 +867,8 @@ static void btf_dump_emit_bit_padding(const struct btf_dump *d,
>>   	} pads[] = {
>>   		{"long", d->ptr_sz * 8}, {"int", 32}, {"short", 16}, {"char", 8}
>>   	};
>> -	int new_off, pad_bits, bits, i;
>> -	const char *pad_type;
>> +	int new_off = 0, pad_bits = 0, bits, i;
>> +	const char *pad_type = NULL;
>>   
>>   	if (cur_off >= next_off)
>>   		return; /* no gap */
>> -- 
>> 2.34.1
>>
>>
> 
