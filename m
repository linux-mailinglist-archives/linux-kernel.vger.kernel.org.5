Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278CB774186
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbjHHRXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbjHHRWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:22:36 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6613D7D78E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:09:23 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686c06b806cso3945775b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206; t=1691510929; x=1692115729;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iitn5cuOhlQstNpnubJ9xUVqIDI2aiSTMtUo1rg4ji8=;
        b=UrZYxnPX6wJckLqe+jHS3YavknBWzDGsZVaSQcowb/6drHVG5WTFt/e2c+tnfwi9XI
         WSWbIvmK2HuHalP3bQO/ORywMviWjLTgM/fZLeeWonueuvPNciSz+q0DBP5t7QsKE0nC
         aU571hs+oXkjBZ5hGWq6QJOU7DICgyw4X2reQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510929; x=1692115729;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iitn5cuOhlQstNpnubJ9xUVqIDI2aiSTMtUo1rg4ji8=;
        b=QAYUALPQDMhV1BDR1jGc6HAMcDgdv++uo2LAF/JJbH1DNXl4esi4tPVqXJXhDiP9qQ
         XcwlrBCQwiGsHVaGqBADCFCVsSefPN5ICBZusSaVvW1G9A78O6XG2swfhfHEH29Bs48f
         6UBGffLjydATi3pwis4RfzXMiqyyY3axOL3vowyLJCmDbm0plOFlQRRCorKM0M7ZDJSt
         c7dLJVG6+UpPvoclT3tgRjQ1wpCtO9CCGG5u8fisCi3tSz/f7NDw10T5foA0wqQ8OSHl
         DtMU+s1Ya9CjeA3JGSwMfDP3QQmA3OEr6ck28wcmAh8Mv86Mrm2bCWhI7aiOaEH4U19+
         y2Qw==
X-Gm-Message-State: AOJu0YzWtfrXl9T8HLmK2x2Pq5z+lbfK6yaTgzkQO0e1CsCf+iAU0A1v
        8qoXk5rA0L3X1BIn4cDGGP5R2Q==
X-Google-Smtp-Source: AGHT+IH9xX8PBCYOqX2E3rrxg3GkW9lN4OG91y7i8oztvn0MuJt/DKC0is4yyOhgYYOSjd717Yd8Bw==
X-Received: by 2002:a05:6a20:8e0b:b0:13b:1482:261 with SMTP id y11-20020a056a208e0b00b0013b14820261mr13582306pzj.44.1691510929663;
        Tue, 08 Aug 2023 09:08:49 -0700 (PDT)
Received: from smtpclient.apple ([50.234.50.204])
        by smtp.gmail.com with ESMTPSA id n12-20020aa78a4c000000b00682af82a9desm8497446pfa.98.2023.08.08.09.08.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Aug 2023 09:08:49 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH bpf-next] riscv/bpf: Fix truncated immediate warning in
 rv_s_insn
From:   Luke Nelson <lukenels@cs.washington.edu>
In-Reply-To: <b85bcf1d-9467-4df6-da11-8f0b24165ada@huawei.com>
Date:   Tue, 8 Aug 2023 09:08:38 -0700
Cc:     bpf@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Xi Wang <xi.wang@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CC58CCF3-1994-4C50-B8FC-E1520ED743BF@cs.washington.edu>
References: <20230727024931.17156-1-luke.r.nels@gmail.com>
 <b85bcf1d-9467-4df6-da11-8f0b24165ada@huawei.com>
To:     Pu Lehui <pulehui@huawei.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>  static inline u32 rv_s_insn(u16 imm11_0, u8 rs2, u8 rs1, u8 funct3, =
u8 opcode)
>>  {
>> - u8 imm11_5 =3D imm11_0 >> 5, imm4_0 =3D imm11_0 & 0x1f;
>> + u32 imm11_5 =3D (imm11_0 >> 5) & 0x7f, imm4_0 =3D imm11_0 & 0x1f;
>=20
> Hi Luke,
>=20
> keep u8 and add 0x7f explicit mask should work. I ran the repro case =
and it can silence the warning.
>=20
>>=20
>>   return (imm11_5 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) =
|
>>   (imm4_0 << 7) | opcode;

That does fix the warning, but I think explicitly declaring imm11_5
as u32 is more clear here than the current code which relies on
implicit promotion of imm11_5 from u8 to signed int in the expression
(imm11_5 << 25).

Because of the promotion to signed int, (imm11_5 << 25) is technically
signed overflow and undefined behavior whenever the shift changes
the value in the sign bit. In practice, this isn't an issue; both
because the kernel is compiled with -fno-strict-overflow, but also
because GCC documentation explicitly states that "GCC does not use
the latitude given in C99 and C11 only to treat certain aspects of
signed '<<' as undefined" [1].

Though it may not be an issue in practice, since I'm touching this
line anyways to fix the warning, I think it makes sense to update
the type of imm11_5 to be u32 at the same time.

> Nit: maybe use "riscv, bpf" for the subject will look nice for the =
riscv-bpf git log tree.

Sure, I can send out a new revision with an updated subject line.

- Luke


[1]: https://gcc.gnu.org/onlinedocs/gcc/Integers-implementation.html
