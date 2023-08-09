Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2244E77527E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjHIGFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjHIGFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:05:15 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCF2A0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 23:05:13 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bd0a96e63dso969993a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 23:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1691561113; x=1692165913;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cY5+9Nxr3hMpBIcVjJ2A1HxHHNO3+KvDHFWewPfKnaY=;
        b=jp0dxee+U3RXZvnECVOyxh2RjCyxB9djh4j2mgSb0QC1A9ADttg63b9ycQDXsTqnqS
         BDY8CPSxu4A+97tRTnz7XenlI9UyPlr0J4aibWlgKBhVfn8ZLQ8ZW49rbYV9F8znc6M2
         zErq4mu1m9ZBOI4SsheDBq16unV2QPkNXdA8CUtTRX+UE8O/zEQoyhPw6J+BVEXxSruO
         UbH7V4JQ+jDh8ACDojhD8cUH6d4SVV7RNoQWjfPrd5afEZkL7Lr9HBSJqnM+OmWFhgYj
         3hVEaOLGdRDiXm0i3QRNZizZxOreMm71oG0QbRqU+Z0VW6XAqBiVJ478NCPt6mZLEbsZ
         ee2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691561113; x=1692165913;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cY5+9Nxr3hMpBIcVjJ2A1HxHHNO3+KvDHFWewPfKnaY=;
        b=C41u1JoLQWfuOpDPRsv0vA8S3E9V9jXTgylVvcI/0wmCu2/6A8ahMzrfWK3aCxUogY
         nsERCbyOQIsoBPyz8mgr61Z9bHRJRsxQvae1gmbDZfm1NroxDtsKjMPFUJOM8sDXckqb
         9zDoXvJeo+WSQuC7DVG78QV3YWWnC5/iswS6feX0DnMpVN7MNj7zxrCe0PeGhhZgGFgV
         EwpdEzzjz/B7OPXbEf4pCS/AWqN17GLNZBjX36vxzVS7am6jYAPuzuJmFaZeeRphoIxu
         gHVLTa5frrLmqalgHbsV+6lM+S9KePE1KvsckKENF0X0TYrHsMkaAA+ZmwJkmf27XXTQ
         rwsg==
X-Gm-Message-State: AOJu0YwWThQ4yWf4blXDWvl/YPBwWBkY4AQ1JgQ0E54B6BJawJGTe4F7
        +fbmbfNZ4cYfG2mPc8LuGybGY2yGT+matkqpuwo=
X-Google-Smtp-Source: AGHT+IEUdB5DcsgWdt+hFTJoViDD+LvjFcHNIz6EXmTULjgjgtlX4VZ/p3u9kBuJeAetVGdlgcYW6Q==
X-Received: by 2002:a05:6358:4285:b0:139:e7db:3f3f with SMTP id s5-20020a056358428500b00139e7db3f3fmr1624901rwc.10.1691561112849;
        Tue, 08 Aug 2023 23:05:12 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id j14-20020a633c0e000000b00563826c66eesm7466161pga.61.2023.08.08.23.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 23:05:11 -0700 (PDT)
Date:   Tue, 08 Aug 2023 23:05:11 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Aug 2023 06:56:35 PDT (-0700)
Subject:     Re: [PATCH] riscv: Fix local irq restore when flags indicates irq disabled
In-Reply-To: <20230725070549.89810-1-luxu.kernel@bytedance.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        luxu.kernel@bytedance.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     luxu.kernel@bytedance.com
Message-ID: <mhng-a0239c56-385e-40a9-8a71-45d50e28b45d@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 00:05:49 PDT (-0700), luxu.kernel@bytedance.com wrote:
> When arch_local_irq_restore() is called with flags indicating irqs
> disabled, we need to clear SR_IE bit in CSR_STATUS, whereas current
> implementation based on csr_set() function only sets SR_IE bit of
> CSR_STATUS when SR_IE bit of flags is high and does nothing when
> SR_IE bit of flags is low.
>
> This commit supplies csr clear operation when calling irq restore
> function with flags indicating irq disabled.
>
> Fixes: 6d60b6ee0c97 ("RISC-V: Device, timer, IRQs, and the SBI")
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> ---
>  arch/riscv/include/asm/irqflags.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
> index 08d4d6a5b7e9..7c31fc3c3559 100644
> --- a/arch/riscv/include/asm/irqflags.h
> +++ b/arch/riscv/include/asm/irqflags.h
> @@ -49,7 +49,10 @@ static inline int arch_irqs_disabled(void)
>  /* set interrupt enabled status */
>  static inline void arch_local_irq_restore(unsigned long flags)
>  {
> -	csr_set(CSR_STATUS, flags & SR_IE);
> +	if (flags & SR_IE)
> +		csr_set(CSR_STATUS, SR_IE);
> +	else
> +		csr_clear(CSR_STATUS, SR_IE);

Unless I'm missing something, the original version is correct: 
local_irq_restore() must be paired with a local_irq_save(), so we can 
only get here with interrupts disabled.

>  }
>
>  #endif /* _ASM_RISCV_IRQFLAGS_H */
