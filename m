Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261B3787B68
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243871AbjHXWTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243870AbjHXWTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:19:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADE31BEB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:19:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2340966E23
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887ABC433CA;
        Thu, 24 Aug 2023 22:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692915560;
        bh=zvH8ONOUJWk9e87genF3KmOMumc0b+2p11O9YN0uraU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Py9k2pBynJepls2T4y1A5dYXBOUBsYr/oyTG5rN13nfoKhzOnEbkTwRrwOK2xB3DQ
         HnW2YN/npJ4d/FGrPv/gKh+QrBMHxiQynYBsdTGeooDkT1Ie/gqToTtxp/N08YM17A
         y6sQKI+4bcu6DHawsCXgMj2cqrZ6rOfpfryt+o1eKtQpjkkph8hy6wohB84935sg3J
         scMMKMtNGoH+BYelFpIuU0TIiX7CvrA89okXXS40NhKYliU1OABTbfReE1sFfwPZfy
         F7in4L+LE5k6Z5S2kizXOX77M9c+aAh6Hi8lp4ktXuYtpgp5ar2EJ30z/Zcu/k6kem
         l5oeLOEydkqMw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4ffa01fc987so1637936e87.1;
        Thu, 24 Aug 2023 15:19:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YxX8vXxqytWKg3sAFGsFmdkuiwK5aKBp0LZQ/iU99A8GuoY3g5G
        tO1QWT2WqpIZ7erPIq8qYCbewDs1D1opnVGbSYY=
X-Google-Smtp-Source: AGHT+IF2/zODRPW5Xo9uTDOdjogrYYoQqdmXIyi7fsgZ23qeHth2bWzkXZpzsrjdMEfTmPWdilSHUZJb7Eond9KK2Y8=
X-Received: by 2002:a05:6512:1193:b0:500:9a50:8970 with SMTP id
 g19-20020a056512119300b005009a508970mr2066629lfr.31.1692915558581; Thu, 24
 Aug 2023 15:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230824133135.1176709-1-puranjay12@gmail.com> <20230824133135.1176709-4-puranjay12@gmail.com>
In-Reply-To: <20230824133135.1176709-4-puranjay12@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 24 Aug 2023 15:19:06 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4hfBMvB9DzM=ZCnq5Bz-bpFTP1gBujyEN7NxdsXnnceA@mail.gmail.com>
Message-ID: <CAPhsuW4hfBMvB9DzM=ZCnq5Bz-bpFTP1gBujyEN7NxdsXnnceA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf, riscv: use prog pack allocator in
 the BPF JIT
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, pulehui@huawei.com,
        conor.dooley@microchip.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, yhs@fb.com,
        kpsingh@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 6:31=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> Use bpf_jit_binary_pack_alloc() for memory management of JIT binaries in
> RISCV BPF JIT. The bpf_jit_binary_pack_alloc creates a pair of RW and RX
> buffers. The JIT writes the program into the RW buffer. When the JIT is
> done, the program is copied to the final RX buffer with
> bpf_jit_binary_pack_finalize.
>
> Implement bpf_arch_text_copy() and bpf_arch_text_invalidate() for RISCV
> JIT as these functions are required by bpf_jit_binary_pack allocator.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

LGTM.

Reviewed-by: Song Liu <song@kernel.org>

[...]
