Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7FC78F1BA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343903AbjHaRSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjHaRSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:18:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FDED1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:18:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a21b6d105cso126498966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693502309; x=1694107109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/PFtjw8ywCWYRYwEbyQ3M+f6bU7Fthi2CVpLFrWSdk=;
        b=HrB0BFAr86hwxXdM+Eh3TpNG+Pd73LThLvS0r5cDgU9HlHtriHHhn9fqfYWzdcw8eg
         aUqd7X6nuX/+wZQKYFzd1W3rGkBYr/ek7hfoyKJnknkgmuQNbe6BKZVSf4NSoMxGuzaJ
         gJjdYmMYIH0AuhOW4yBwdnqKAUf0KkYfOMZKB4fNbI3PBseLBW5+VSBIRhR6d8K/z01q
         V8icKu1veD66HchjGINh3tDw1fv3cY6T9j5Yw8Hpbf/v6aLhD5w7hN5Y3P/Nl/hImI3f
         3WsdjPNnCRgwvFUAaYQ0z1cBK8prB9/LRH06TrY1tRgsNSUImljzSty0fkTo5upiIzO+
         Nb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693502309; x=1694107109;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a/PFtjw8ywCWYRYwEbyQ3M+f6bU7Fthi2CVpLFrWSdk=;
        b=kIAjqR4asFvUwvknyhhPN3jhNu+S2iq9h6dnv9aRMJgkh/a83I6fCSO1nrAQdevceR
         Zl6h4hm5VEDvpnYyFYkKu6Rx9Jvq7buNKYXsRtgNUgMsdZtIRaWCX+IUeDuq0TmwEkcY
         7rOPNSpTqT+LDkW22iZtFkAiYtJjTu94jAmeAmbnFcv/Fc96tx34GIj8wW0cmNtKhzWT
         ceH+XGNlF2x+sVH8jPnFzMw8P6o6jEn2g0YP/pdkHJfAzKMoqCRF68heMB2If+DhIVrr
         gx5X0bFdALuoxknEIYfXIc/g6z+oEkOnbBNtoIqznXSM2WfOL0YH2CewjQkx586QdCS1
         ZvIA==
X-Gm-Message-State: AOJu0Yx/ZNQM6/JNWhBW6ShONqqQ4CYmY9gsrnBbLlPmNtW4q6wOZ7R3
        b47ht/kYQK7gJf2Hd0qV7R8=
X-Google-Smtp-Source: AGHT+IGzlkM35B7LBqs6TbuegHGsGHszuf6Xhif70TmtERB7ioqoD/Xsg/ukYduSJkVqHM/1iLFv8w==
X-Received: by 2002:a17:906:3d22:b0:99b:4a29:fb6a with SMTP id l2-20020a1709063d2200b0099b4a29fb6amr4920090ejf.59.1693502308571;
        Thu, 31 Aug 2023 10:18:28 -0700 (PDT)
Received: from shift (p200300d5ff160300aaa159fffeeb01f1.dip0.t-ipconnect.de. [2003:d5:ff16:300:aaa1:59ff:feeb:1f1])
        by smtp.gmail.com with ESMTPSA id mc24-20020a170906eb5800b009829d2e892csm979984ejb.15.2023.08.31.10.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 10:18:28 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
        by shift with esmtp (Exim 4.96)
        (envelope-from <chunkeey@gmail.com>)
        id 1qblJL-000MJJ-1l;
        Thu, 31 Aug 2023 19:18:27 +0200
Message-ID: <89fad050-e074-463e-8c27-a72b89de620c@gmail.com>
Date:   Thu, 31 Aug 2023 19:18:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-DE, en-US
From:   Christian Lamparter <chunkeey@gmail.com>
Subject: Missing L3 linesize on AMD Ryzen 7940HS chip causes crash in
 amd_cpuid4.
To:     vbox-dev@virtualbox.org, open list <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

a PhD-Student complained that his virtualbox-supported linux VM wouldn't start
on his brand new laptop... And I took the bait. (Note: I helped him installing
Linux Mint 21.1 on the same Laptop and it worked without issues). But as
soon as he tried porting his virtualbox VMs he got the following panic during
the early boot:

---

| divide error: 0000 [#1] PREEMPT SMP NOPTI | CPU: 0 PID: 19 Comm: cpuhp/0 Not tainted 5.19.0-46-generic #47~22.04.1-Ubuntu | Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006 | RIP: 0010:amd_cpuid4+0x195/0x2f0 | Code: c1 e0 0a 81 e3 ff 03 00 00 81 e2 ff 0f 00 00 48 8b 7d b0 c1 e3 0c 09 d3 89 f2 81 e6 ff 03 00 00 c1 e2 16 83 c6 01 09 d3 31 d2 <f7> f1 41 89 1f 31 d2 f7 f6 83 e8 01 89 07 48 8b 45 d0 65 48 2b 04 | RSP: 0018:ffffbb78800a3ce8 EFLAGS: 00010246 | RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 0000000000000000 | RDX: 0000000000000000 RSI: 0000000000000400 RDI: ffffbb78800a3d60 | RBP: ffffbb78800a3d48 R08: 0000000000000000 R09: 0000000000000000 | R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003 | R13: ffffbb78800a3d08 R14: ffffbb78800a3d58 R15: ffffbb78800a3d5c | FS: 0000000000000000(0000) GS:ffffa05759a00000(0000) 
knlGS:0000000000000000 | CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 | CR2: 00007f2946fc1e24 CR3: 0000000108010000 CR4: 00000000000506f0 | Call Trace: |  <TASK> | cpuid4_cache_lookup_regs+0x14d/0x160 | populate_cache_leaves+0x180/0x200 | cacheinfo_cpu_online+0xc1/0x1c0 | cache_add_dev+0x420/0x420 | [...]

---

looking at amd_cpuid4() function in arch/x86/kernel/cpu/cacheinfo.c, it reads the cpuid values for 0x80000005 and 0x80000006. I convinced the student to run "cpuid -1 -r" and received the these:

| 0x80000005 0x00: eax=0xff48ff40 ebx=0xff48ff40 ecx=0x20080140 edx=0x20080140 | 0x80000006 0x00: eax=0x5c002200 ebx=0x6c004200 ecx=0x04006140 >> edx=0x00009000 <<

(The 0x80000006 edx=0x00009000 is the important bit)

Plugging these values into the amd_cpuid4 function() causes an division by zero
in line 297:
| ecx <https://elixir.bootlin.com/linux/v5.19.10/C/ident/ecx>->split <https://elixir.bootlin.com/linux/v5.19.10/C/ident/split>.number_of_sets <https://elixir.bootlin.com/linux/v5.19.10/C/ident/number_of_sets> = (size_in_kb <https://elixir.bootlin.com/linux/v5.19.10/C/ident/size_in_kb> * 1024) / line_size <https://elixir.bootlin.com/linux/v5.19.10/C/ident/line_size> /
|                                                    (ebx <https://elixir.bootlin.com/linux/v5.19.10/C/ident/ebx>->split <https://elixir.bootlin.com/linux/v5.19.10/C/ident/split>.ways_of_associativity <https://elixir.bootlin.com/linux/v5.19.10/C/ident/ways_of_associativity> + 1) - 1;

This is because L3 cache's line_size is "0" (this is coming from the 80000006 edx
value of 0x00009000).

This can't be right... or? Well, digging around. I found the following explanation
in AMD's community forum:
<https://community.amd.com/t5/processors/ryzen-7-3700x-cpuid-function-id-0x80000006-returns-wrong-number/td-p/376937>
So there's an issue with "wonky L3 values" that happens even earlier with the
AMD 3700X. In this forum post, the author talks about the
"L3 cache associativity (bits 12-15) is 0x9".

And the same is happening with both AMD 7950X and 7940HS.
The kicker is: this value of "9" means:
"Please look at CPUID.8000_001D".

Which I think boils down to implementing X86_FEATURE_TOPOEXT
for virtualbox to get over this issue?

Now, is there something I'm missing? I don't know if qemu is be affected.
Or if there's another way around it.

Regards,
Christian Lamparter

Note:

For now with Virtualbox. The problem can be mitigated by running | vboxmanage setextradata $VM VBoxInternal/CPUM/HostCPUID/80000006/edx 0x02009140

(The value 0x02009140 is coming from an AMD Ryzen 7950X. While also "wonky", this allowed the Virtualbox VMs to boot).

