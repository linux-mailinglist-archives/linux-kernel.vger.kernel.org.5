Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D1F7F0A93
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 03:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjKTCg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 21:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjKTCg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 21:36:57 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F815D4D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 18:36:47 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc9b626a96so28098795ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 18:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700447807; x=1701052607; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Zq4RPXM6eCo+MpwtSfj3ACqp+KpQugLsNlxVZl0DlA=;
        b=EC+qeQww2Qbz1pVNrG7CDHkr29EqOhCoUDUtrGFLYnBSZtA7a6YnbWwkknY1qDfb8f
         m5A263wA3nuUQoZoNZU4ccXDVu3eyasp3WuEps5w0LDViM4avcuN66e7Wf7WmdlJN7kv
         +U2MoY58R2xf7k4IkuZnVigCINhxIpjCnqIGph9qMzNdYrrQt8dE/nm5xDeEtRJPSXws
         QBKzFCK/hMMU6Vj9hKpVM08Z6baaveeuC+TW5iZGo7XYiQAjIw5MOOh51qQHX5B8yA++
         xudu3M6K9zruEG8bJ2AtPOaBLn0iJI8OvdEoqJFAw1C5ctjQpXjSpTCcULUxoS0n4ZS/
         f98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700447807; x=1701052607;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Zq4RPXM6eCo+MpwtSfj3ACqp+KpQugLsNlxVZl0DlA=;
        b=n/VPG1JMQqDFxW/UT1LE1OekrTbHq7w8OxzmCYk37zxNrCgrwc8iJCvKS2AYAzCVYF
         ot5K1CPZDBVtlH/BP4vNU6N7IAK704FN4A8P6T+PeR0/vqs46PYjoaEp5/NxtKerhhSg
         IR43XafJVyVkFn3CHJndWmYUxt6JkFCxiJB4nNzA2Q1PugLmwHN8yY26QNWbvsmErOXx
         DWwnWDjjyX+W6S6vL/Kl6GDkLF1J0IOkAq+7F6UvZI5ALakbeLOb5dVVzP5qR2/YIB2a
         m8L6OHbv0hTRevwUd8CWh7gNXd9sM7WJ6YgYUU0928O8TCoqgv9ln6T5ChPai4zHzoHd
         3BiQ==
X-Gm-Message-State: AOJu0YyDxhHJsn+c65J6W2zJ2YmJRNMXJOWNl46gcKPe3SnaBzm+jY4Z
        Vtfg4jQQ5AdVSGUYC36SnyM64w==
X-Google-Smtp-Source: AGHT+IEKO8u8O27bTQGYqNJmwiQ/UY61Ih/6GCQAtHUfSm8QYLvQjd6X/hM7S5g2BeKD4AKKFk1lQw==
X-Received: by 2002:a17:902:a5c9:b0:1cc:60ca:8f24 with SMTP id t9-20020a170902a5c900b001cc60ca8f24mr4758601plq.45.1700447806758;
        Sun, 19 Nov 2023 18:36:46 -0800 (PST)
Received: from [192.168.244.11] ([49.216.222.216])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902eec600b001bb1f0605b2sm4939926plb.214.2023.11.19.18.36.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Nov 2023 18:36:46 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH 06/12] RISC-V: crypto: add accelerated AES-CBC/CTR/ECB/XTS
 implementations
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <CF7F714A-CAC1-41C4-A43A-DA1273111492@sifive.com>
Date:   Mon, 20 Nov 2023 10:36:19 +0800
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ardb@kernel.org, phoebe.chen@sifive.com,
        hongrong.hsu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B4290995-3983-41D8-991E-ABA2213656B1@sifive.com>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-7-jerry.shih@sifive.com>
 <20231109080549.GC1245@sol.localdomain>
 <CF7F714A-CAC1-41C4-A43A-DA1273111492@sifive.com>
To:     Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3445.9.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 10, 2023, at 12:06, Jerry Shih <jerry.shih@sifive.com> wrote:
> On Nov 9, 2023, at 16:05, Eric Biggers <ebiggers@kernel.org> wrote:
>> On Thu, Oct 26, 2023 at 02:36:38AM +0800, Jerry Shih wrote:
>>> +# prepare input data(v24), iv(v28), bit-reversed-iv(v16), =
bit-reversed-iv-multiplier(v20)
>>> +sub init_first_round {
>>> ....
>>> +    # Prepare GF(2^128) multiplier [1, x, x^2, x^3, ...] in v8.
>>> +    slli $T0, $LEN32, 2
>>> +    @{[vsetvli "zero", $T0, "e32", "m1", "ta", "ma"]}
>>> +    # v2: [`1`, `1`, `1`, `1`, ...]
>>> +    @{[vmv_v_i $V2, 1]}
>>> +    # v3: [`0`, `1`, `2`, `3`, ...]
>>> +    @{[vid_v $V3]}
>>> +    @{[vsetvli "zero", $T0, "e64", "m2", "ta", "ma"]}
>>> +    # v4: [`1`, 0, `1`, 0, `1`, 0, `1`, 0, ...]
>>> +    @{[vzext_vf2 $V4, $V2]}
>>> +    # v6: [`0`, 0, `1`, 0, `2`, 0, `3`, 0, ...]
>>> +    @{[vzext_vf2 $V6, $V3]}
>>> +    slli $T0, $LEN32, 1
>>> +    @{[vsetvli "zero", $T0, "e32", "m2", "ta", "ma"]}
>>> +    # v8: [1<<0=3D1, 0, 0, 0, 1<<1=3Dx, 0, 0, 0, 1<<2=3Dx^2, 0, 0, =
0, ...]
>>> +    @{[vwsll_vv $V8, $V4, $V6]}
>>=20
>> This code assumes that '1 << i' fits in 64 bits, for 0 <=3D i < vl.
>>=20
>> I think that works out to an implicit assumption that VLEN <=3D 2048. =
 I.e.,
>> AES-XTS encryption/decryption would produce the wrong result on =
RISC-V
>> implementations with VLEN > 2048.
>>=20
>> Perhaps it should be explicitly checked that VLEN <=3D 2048?
>>=20
>> - Eric
>=20
> Yes, we could just have the simple checking like:
>=20
>  riscv_vector_vlen() >=3D 128 || riscv_vector_vlen() <=3D2048
>=20
> We could also truncate the VL inside for VLEN>2048 case.
> Let me think more about these two approaches.=20
>=20
> -Jerry

I use the simplest solution. Setup the check for vlen:
	riscv_vector_vlen() >=3D 128 || riscv_vector_vlen() <=3D2048
It will have a situation that we will not enable accelerated aes-xts for =
`vlen>2048`.
I would like to make a `todo` task to fix that in the future.

-Jerry=
