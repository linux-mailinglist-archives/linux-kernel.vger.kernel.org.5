Return-Path: <linux-kernel+bounces-111555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9E2886DA2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B66286BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041AA5FEE8;
	Fri, 22 Mar 2024 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePXycGfH"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FFE45BFF;
	Fri, 22 Mar 2024 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114629; cv=none; b=a8EzuOVOIjWovfc3YPmMQ19sr7kI1+ntFhtgYpwyyG7mLTKwyTIEKnp3rvRS4rYpzFkx0DfSk/Y+k8ONKugwnm/msRE6Zjs0/pUEefiwbhFhFLERTH5DNDgIqkDWjXAZEVIzO+rOkg32OyF7VeLi/cdJi63EnAEgnXBojAir4mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114629; c=relaxed/simple;
	bh=zWiE+XEo6fLJK8Uz6M2Us9666B3kXGXD4OrLzuZTikk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLYFZAh/Rtw3Mu02YdzQFlR7AY9tfg+gwK7BbIb1dcg6RuxcLa6026Cd0Ns80QTr5nkjx1YtiZlJewOR5nG7I4bbnc7l4KjENqfYwnFsSPvsjkIDtddPajQl4MsbPpOykQ0JQLpkyph8Bv1EcITiazJEv8YjJIDF2p5TbQgqy2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePXycGfH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1de0f92e649so14143125ad.0;
        Fri, 22 Mar 2024 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711114627; x=1711719427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4Wtkfs6BPfblQoCnXQVgHKXsh4zcNEQpSQfGx0qDPE=;
        b=ePXycGfH40j9C0mOKgsmgaMrgOKYMNvN4K6ZY1ZehoQZLyPKGSEUprPPUgy0CJkokr
         TgQW2xr3wTZQ/IC0LGSgfRsyMedy8Tn488imWQAiLplrMn918vcYLTBcz0vpYUhMIZAH
         e7foDqGIEhSOIzi7vFf+oFHhLOKBD1DTa7sZkVW3dyg5pkJLToe0gJ8a2+QaPWKWkxue
         ZchpRIEa9jTtK/cTmN2mkACCt/WaVdDdHg20beI0axknmlg+9dWB0qvKcm6EsK3mL4j1
         EuHt0ibrgAcXF6hj35sMUNtRsDmmrZAq6FyyFsREf123wUTgJLgq3RQrXA4rA8yPoSqb
         Wchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711114627; x=1711719427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y4Wtkfs6BPfblQoCnXQVgHKXsh4zcNEQpSQfGx0qDPE=;
        b=JUYnsamS6QnQEAypCKAKpKBPh5EXuK5P/DLyx0wdZbs+gdyMK29S0lDKo0cKPEQ3le
         643v6FaK5LuWdkQwcZR/wy0Z9hXlJFDGpU3XZHq6BPS6E+d5e3SXXleVbAvN3/hvTfQ4
         ERp9BlY4Ks2IRdz5id1hZwixQxBcextt9l6l3bcAtVhsm3wNat9En7lBaXyMD3LDf/wx
         qkuyq6K+AVR3fkDrHOzrohS4wsD/wohikTIaG5jzCEg9zhqrYlAHrQdBYS8jTbUHk9vR
         t0AkRx11cd/8LnO13f827gjADIPzQDakIYPrZfnZbkMtFQCmKUkDIUXutiOQp/Sg3IP0
         RkBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6s0f6w91TZcd9IONn4IQp/QaNoCMX/MhY+9vZJxnhNmxc2HpYwFh+e7IDn+EUcYk2eSeiXol6U3VVbrcsejet2RIl0U7z5dIXCz+x/c/c7+dMExVkyAza9tlUgPDn9Xe7
X-Gm-Message-State: AOJu0YycRyLSKruzMC6jqDY8Wovv8+n2Iv3dmqMcbJUtLVmhHJz8MRXc
	trG80fkojDhV9XC0w5qFbQ+ebRS/dNkRxe6AT7Dp+jKVC7nmDQpq
X-Google-Smtp-Source: AGHT+IGnTO5/Hf/Y3NnWgtBdzOnCpX6KAq/m5DFy8zLliheuM/z6MK2l2CsxQWCMgg79lwdRIofjcA==
X-Received: by 2002:a17:902:c406:b0:1e0:b0d:5b7d with SMTP id k6-20020a170902c40600b001e00b0d5b7dmr3130944plk.36.1711114626249;
        Fri, 22 Mar 2024 06:37:06 -0700 (PDT)
Received: from [192.168.0.106] ([117.147.31.37])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b001dc3c4e7a12sm1903304plf.14.2024.03.22.06.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 06:37:05 -0700 (PDT)
Message-ID: <f5fe3709-bfc8-4906-a0cc-5fe9b388be6b@gmail.com>
Date: Fri, 22 Mar 2024 21:36:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libbpf: add specific btf name info when do core
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240321170444.388225-1-chen.dylane@gmail.com>
 <CAEf4BzYJeEViQaRJb6u06GJSLa6uBmykRZa4JnWJ9VXw+WoX2g@mail.gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <CAEf4BzYJeEViQaRJb6u06GJSLa6uBmykRZa4JnWJ9VXw+WoX2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Nakryiko, thank you for your reply. I try to familiarize with core 
in libbpf， the debug info is really helpful for me. But i use the old 
kernel btf, so origion debuginfo like:
  struct task_struct___x: found target candidate [130] struct 
task_struct in [vmlinux]
I think it may be more clear, if we print btf name when we use old 
kernel btf like:
  struct task_struct___x: found target candidate [130] struct 
task_struct in [/boot/***.btf]
The patch just solve debug info show for newbies above.

在 2024/3/22 上午2:52, Andrii Nakryiko 写道:
> On Thu, Mar 21, 2024 at 10:04 AM Tao Chen <chen.dylane@gmail.com> wrote:
>>
>> No logic changed, just add specific btf name when core info
>> print, maybe it seems more understandable.
>>
>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>> ---
>>   tools/lib/bpf/libbpf.c | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
> 
> Can you elaborate on what problem you are trying to solve?
> Conceptually libbpf does look for types in vmlinux (meaning main
> kernel BTF), even if user overrides BTF location (presumably because
> of old kernel). So even when we emit "vmlinux" in logs, it seems
> correct.
> 
> pw-bot: cr
> 
> 
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index afd09571c482..b32154288b4a 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -5653,7 +5653,8 @@ static int load_module_btfs(struct bpf_object *obj)
>>   }
>>
>>   static struct bpf_core_cand_list *
>> -bpf_core_find_cands(struct bpf_object *obj, const struct btf *local_btf, __u32 local_type_id)
>> +bpf_core_find_cands(struct bpf_object *obj, const struct btf *local_btf, __u32 local_type_id,
>> +                   const char *targ_btf_path)
>>   {
>>          struct bpf_core_cand local_cand = {};
>>          struct bpf_core_cand_list *cands;
>> @@ -5680,7 +5681,8 @@ bpf_core_find_cands(struct bpf_object *obj, const struct btf *local_btf, __u32 l
>>
>>          /* Attempt to find target candidates in vmlinux BTF first */
>>          main_btf = obj->btf_vmlinux_override ?: obj->btf_vmlinux;
>> -       err = bpf_core_add_cands(&local_cand, local_essent_len, main_btf, "vmlinux", 1, cands);
>> +       err = bpf_core_add_cands(&local_cand, local_essent_len, main_btf,
>> +                                targ_btf_path ?: "vmlinux", 1, cands);
>>          if (err)
>>                  goto err_out;
>>
>> @@ -5793,7 +5795,8 @@ static int bpf_core_resolve_relo(struct bpf_program *prog,
>>                                   int relo_idx,
>>                                   const struct btf *local_btf,
>>                                   struct hashmap *cand_cache,
>> -                                struct bpf_core_relo_res *targ_res)
>> +                                struct bpf_core_relo_res *targ_res,
>> +                                const char *targ_btf_path)
>>   {
>>          struct bpf_core_spec specs_scratch[3] = {};
>>          struct bpf_core_cand_list *cands = NULL;
>> @@ -5813,7 +5816,7 @@ static int bpf_core_resolve_relo(struct bpf_program *prog,
>>
>>          if (relo->kind != BPF_CORE_TYPE_ID_LOCAL &&
>>              !hashmap__find(cand_cache, local_id, &cands)) {
>> -               cands = bpf_core_find_cands(prog->obj, local_btf, local_id);
>> +               cands = bpf_core_find_cands(prog->obj, local_btf, local_id, targ_btf_path);
>>                  if (IS_ERR(cands)) {
>>                          pr_warn("prog '%s': relo #%d: target candidate search failed for [%d] %s %s: %ld\n",
>>                                  prog_name, relo_idx, local_id, btf_kind_str(local_type),
>> @@ -5920,7 +5923,8 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
>>                          if (prog->obj->gen_loader)
>>                                  continue;
>>
>> -                       err = bpf_core_resolve_relo(prog, rec, i, obj->btf, cand_cache, &targ_res);
>> +                       err = bpf_core_resolve_relo(prog, rec, i, obj->btf, cand_cache, &targ_res,
>> +                                                   targ_btf_path);
>>                          if (err) {
>>                                  pr_warn("prog '%s': relo #%d: failed to relocate: %d\n",
>>                                          prog->name, i, err);
>> --
>> 2.34.1
>>

