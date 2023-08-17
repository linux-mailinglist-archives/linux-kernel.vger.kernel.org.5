Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D4D77F207
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348850AbjHQIYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbjHQIYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:24:13 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B8A273C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:24:12 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3175f17a7baso6192655f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692260651; x=1692865451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHsD7c/QF0ePInwcDmMHhFZY69gdO9z9rXTXoYzHVCI=;
        b=lr8w5VkvPcCfBoy7LCTlpwGmQxof97HkBqgFQZftmfiHg9+MhTl08oNkvUSah2azdy
         fzJXUBjFT8E7v671+gCUEZqr2SnUvo7tyK2aWBWnyndbQDa2MqJqJI4oxWRgGBxmEgJ5
         I28APSwnQk/wmB0t/it8mOksGxuf1A0LSo95Yjh93AGhIwZhdKeBltOgahyd8STe1d5Z
         7ZzCIDCPdn85Pzyy+S+XcCpRLyDs87vko57ZSQAT6Ophj4yjZmFzg5QmXXFdOsCe+KGm
         9PuYnPDFNsAGYAQu3ONdzyZ3mBK7F6SnNSKmWhYoF+2lxwYBbDEWip7gWtjqF+ELCeRE
         r1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692260651; x=1692865451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHsD7c/QF0ePInwcDmMHhFZY69gdO9z9rXTXoYzHVCI=;
        b=Pv4ymr1YPSxsBw7DaZT98/eW/7zhJml/jbCQg+/J5NK9PxlZ9cQcdJn44acnWD9e+w
         1hyREv121wQ2WwlZ6QCNc933aOC3r2wAJjDdTtAjAa1Q6jWWS+sT65MOj9VEedWHaIkd
         wiFp9NESSSBEtS9Jw68m+LjSwmFBhbkwhMgwzDncDLiqG1iZJhLVYzVmXILUJ64qEU5Q
         v3XZ9vjWCGS6s62fXFaRhEcrt4G2MZKWETLnn/yp/I80oReypWElssqFDPt5YHAwjDZP
         NENhhDvv3acseJdWxFZ6JvYbHhvlfDR/wKHLlBbUdESVMSn/GVvQaif9ByEv1F2WhtmT
         pkww==
X-Gm-Message-State: AOJu0YyD9VBKdIicS0Jg7Mg48YLsj45rLgxHjzjHwjjMMr+EMEnuY5p3
        flpOiHtTSiTIbyMtu5m/RX6Ro9L1HS3BDel35ZyVSw==
X-Google-Smtp-Source: AGHT+IFSX3sJrVRBaVxg8X+3Xw+j2/M3SsmQbpjPaHp7usUDL4glZ/nHbwzfEferrc1Arhz3/d/+MZUDg1FpNnLEnm4=
X-Received: by 2002:adf:e7c4:0:b0:317:f70b:3156 with SMTP id
 e4-20020adfe7c4000000b00317f70b3156mr3131091wrn.28.1692260650973; Thu, 17 Aug
 2023 01:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230329082950.726-1-cuiyunhui@bytedance.com> <87v8dfqays.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87v8dfqays.fsf@all.your.base.are.belong.to.us>
From:   yunhui cui <cuiyunhui@bytedance.com>
Date:   Thu, 17 Aug 2023 16:23:59 +0800
Message-ID: <CAEEQ3w=MgH82+BMpwmUHnUevMJsJUqgeBRWSZnU_iizMLK37UQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] riscv: Dump user opcode bytes on fatal faults
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     conor.dooley@microchip.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, peterz@infradead.org,
        mpe@ellerman.id.au, jpoimboe@kernel.org, mark.rutland@arm.com,
        svens@linux.ibm.com, guoren@kernel.org, jszhang@kernel.org,
        ebiederm@xmission.com, bjorn@rivosinc.com, heiko@sntech.de,
        xianting.tian@linux.alibaba.com, mnissler@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bj=C3=B6rn,

On Wed, Aug 16, 2023 at 11:11=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
>
> Hi Yunhui,
>
> Waking up the dead! ;-)
>

>
> X86's show_opcodes() is used both for kernel oops:es, and userland
> unhandled signals. On RISC-V there's dump_kernel_instr() added in commit
> eb165bfa8eaf ("riscv: Add instruction dump to RISC-V splats").
>
> Wdyt about reworking that function, so that it works for userland epc as
> well? I think it's useful to have the surrounding instruction context,
> and not just on instruction.

Okay,  Based on your suggestion, I'm going to rename dump_kernel_instr
to dump_instr. Like:
static void dump_instr(const char *loglvl, struct pt_regs *regs)
{
...
                if (user_mode(regs))
                        bad =3D get_user_nofault(val, &insns[i]);
                else
                        bad =3D get_kernel_nofault(val, &insns[i]);
...
}

What do you think?

Thanks,
Yunhui
