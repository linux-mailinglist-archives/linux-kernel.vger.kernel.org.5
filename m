Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95774793DB0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbjIFNb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240294AbjIFNbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:31:23 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E762410F5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 06:31:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c1ff5b741cso28653035ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 06:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1694007077; x=1694611877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFiIToPJJ6FCujPCd0yAiudON8W0oAyn/p/xhdheEPI=;
        b=TcJBJqViJQH0WUoGZHr2CeYzr6j2F49y85Irz2yRGUj62rcq3qhEISpjxEtMmnTRor
         ssFeCKpBJqcxEInoJyJ9Ye0nO/xCQqHKQOTHI0YF+figRCwMN67HO53l8oqzjmSgXmoF
         AvRSd4rmZ/83T0c9d4LgxWP2Gl0Yb9xaPZLwL8Vn0BHE2L+n5vWP4rdku0BQ4z+/F+qr
         WKVTa9hDPEBCrJCtcLK983/aNFNJ6qXIPahtelLHQ7ZVGMozvJrCVOHqGZcHS5kqidpu
         8heGV735cVM75WnBER7HQQTQxf1/dB2oyuoR7q0PiGH1P6fR++pMSQ8+Zk2R1kI6Bg50
         Lj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694007077; x=1694611877;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFiIToPJJ6FCujPCd0yAiudON8W0oAyn/p/xhdheEPI=;
        b=MM+51T1ZdkGZ1dnt1PctrJb4Y5DEZkFuiZH6gv5Qv1BZQrEufZaWcaEPJc979HfJwS
         Xhb5/TbOg8rxpMTEtk0hLCkkCibBHrCnASDXNc8E3+M7BcUxfMrRm5a/rBTylY0MGC0o
         FUYALeRX/xiVEFrbSvTQltfthBZum9xAaLuikvqFJvDKJB42b6MEy3dbee/NMWRADQvt
         6g6qA2LVge9A2+oMfYYabeULbQ87WJb776KMskNV+XKYL0crgesm3+DBU9Q4kmLngEqx
         2WPIpcunWC5OgYS5HMrfKLDaR5ph7HQuREgC21AOgbQixipPFlPUbnipDe7eubVdENkO
         SCTg==
X-Gm-Message-State: AOJu0YxvmO0yOd+V2boxdOI2Tjd/YBPi/lNYRGbXPUPz4oHXRIe0GS9A
        xzfU1ZivJXVNV+UAQBkvcbM/Rw==
X-Google-Smtp-Source: AGHT+IFwZpFgYNDB0gtie9f9xZT1VXEyo52isr74Zc0CNOQ3PnFA6lS5vlwt+yMD++Tx1IPK+2iobg==
X-Received: by 2002:a17:90b:1e4e:b0:268:46fb:df32 with SMTP id pi14-20020a17090b1e4e00b0026846fbdf32mr14983572pjb.34.1694007077128;
        Wed, 06 Sep 2023 06:31:17 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id j5-20020a17090aeb0500b0026b4d215627sm10973520pjz.21.2023.09.06.06.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:31:16 -0700 (PDT)
Date:   Wed, 06 Sep 2023 06:31:16 -0700 (PDT)
X-Google-Original-Date: Wed, 06 Sep 2023 06:31:13 PDT (-0700)
Subject:     Re: [PATCH bpf-next v4 0/4] bpf, riscv: use BPF prog pack allocator in BPF JIT
In-Reply-To: <169396862749.1987.4994366714692856707.git-patchwork-notify@kernel.org>
CC:     puranjay12@gmail.com, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, pulehui@huawei.com,
        Conor Dooley <conor.dooley@microchip.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, bjorn@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     patchwork-bot+linux-riscv@kernel.org
Message-ID: <mhng-b249bbd6-f716-44d4-88b9-2aa1e058641d@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Sep 2023 19:50:27 PDT (-0700), patchwork-bot+linux-riscv@kernel.org wrote:
> Hello:
>
> This series was applied to riscv/linux.git (for-next)
> by Palmer Dabbelt <palmer@rivosinc.com>:
>
> On Thu, 31 Aug 2023 13:12:25 +0000 you wrote:
>> Changes in v3 -> v4:
>> 1. Add Acked-by:, Tested-by:, etc.
>> 2. Add the core BPF patch[3] which was earlier sent with ARM64 series to
>>    this series so it can go with this.
>>
>> Changes in v2 -> v3:
>> 1. Fix maximum width of code in patches from 80 to 100. [All patches]
>> 2. Add checks for ctx->ro_insns == NULL. [Patch 3]
>> 3. Fix check for edge condition where amount of text to set > 2 * pagesize
>>    [Patch 1 and 2]
>> 4. Add reviewed-by in patches.
>> 5. Adding results of selftest here:
>>    Using the command: ./test_progs on qemu
>>    Without the series: Summary: 336/3162 PASSED, 56 SKIPPED, 90 FAILED
>>    With this series: Summary: 336/3162 PASSED, 56 SKIPPED, 90 FAILED
>>
>> [...]
>
> Here is the summary with links:
>   - [bpf-next,v4,1/4] bpf: make bpf_prog_pack allocator portable
>     https://git.kernel.org/riscv/c/063119d90a06
>   - [bpf-next,v4,2/4] riscv: extend patch_text_nosync() for multiple pages
>     https://git.kernel.org/riscv/c/fb81d562ed1f
>   - [bpf-next,v4,3/4] riscv: implement a memset like function for text
>     https://git.kernel.org/riscv/c/f071fe652d73
>   - [bpf-next,v4,4/4] bpf, riscv: use prog pack allocator in the BPF JIT
>     https://git.kernel.org/riscv/c/19ea9d201008
>
> You are awesome, thank you!

Looks like I screwed up the merge a bit here, so these hashes have 
changed a bit.
