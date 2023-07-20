Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FDB75B203
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjGTPGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjGTPGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:06:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A452426BB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:06:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21CC761B23
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9ABC433C9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689865586;
        bh=NwVY/LiiggaGme0jWI+ZcS1i0Dbn9MG9/E1CJbQ8P08=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XzXvymy8m9SUHmSMziFhB91k8ukfkATqIdIigv9ENMpUo004JPU243e87dnxwLERL
         pnjAjbKW0vp3xAjIQTsp/A4HDEvdHcz0rmYup8Zb2if7yeJvj+V+2T73/o8fp7PfFT
         SFvtAgZjDlFp+kSvr2k/zoAQc0kV7pU3uRs6naTN5oiO0o2xF4q/G/PYlP6VVDhExH
         auHKCAL5fQDRgy9tSoTBNglXldzOVi6/qNHln2m3HpSnyCWUBDZwuUTI0LaaYdI/zv
         u/12td66yghWaM4ePFsniXExQ4q7yCyQqaSEoOzFev0QNw37rirWIduq7dv/M8O94P
         nO4mmze9tv/IA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so1397652e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:06:26 -0700 (PDT)
X-Gm-Message-State: ABy/qLY2CmEM3DADUX4ur2YCbN+31nfG/b6dyJQKEKfvCT3c2c+kx5Qw
        8fujxp4qBSRdm/ORizgd+Y0Aw+Kzu+2+ZCyYNeM=
X-Google-Smtp-Source: APBJJlEckaUxLkBuMQTgllpd9gH5FY9afzhqu0sFHpFK92iGmfjgIY25B7mru0vF0W0Pki+6KsZfrsX3/oC1tuLhW8s=
X-Received: by 2002:a05:6512:2525:b0:4f8:58ae:8ea8 with SMTP id
 be37-20020a056512252500b004f858ae8ea8mr2845132lfb.58.1689865584515; Thu, 20
 Jul 2023 08:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221124094845.1907443-1-debug@rivosinc.com> <20230720001852.GA572618@google.com>
In-Reply-To: <20230720001852.GA572618@google.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 20 Jul 2023 23:06:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRFvSvEvQeDugdp73o7w4ArdtQ99JScEbLkaLnFcftVcA@mail.gmail.com>
Message-ID: <CAJF2gTRFvSvEvQeDugdp73o7w4ArdtQ99JScEbLkaLnFcftVcA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: VMAP_STACK overflow detection thread-safe
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Deepak Gupta <debug@rivosinc.com>, palmer@dabbelt.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Jisheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 8:19=E2=80=AFAM Sami Tolvanen <samitolvanen@google.=
com> wrote:
>
> Hi Deepak,
>
> On Thu, Nov 24, 2022 at 01:48:45AM -0800, Deepak Gupta wrote:
> > commit 31da94c25aea ("riscv: add VMAP_STACK overflow detection") added
> > support for CONFIG_VMAP_STACK. If overflow is detected, CPU switches to
> > `shadow_stack` temporarily before switching finally to per-cpu
> > `overflow_stack`.
> >
> > If two CPUs/harts are racing and end up in over flowing kernel stack, o=
ne
> > or both will end up corrupting each other state because `shadow_stack` =
is
> > not per-cpu. This patch optimizes per-cpu overflow stack switch by
> > directly picking per-cpu `overflow_stack` and gets rid of `shadow_stack=
`.
>
> Are you planning on resending this patch? I see it didn't gain much
> traction last time, but this looks like a much cleaner solution for
> selecting the overflow stack than having a `shadow_stack` and calling
> to C to compute the per-CPU offset. The asm_per_cpu macro also would
> come in handy when implementing CONFIG_SHADOW_CALL_STACK, which we'd
> like to have on RISC-V too.
I remember we ended up with an atomic lock mechanism instead of percpu
offset, so what's the benefit of percpu style in overflow_stack path?

>
> Sami



--=20
Best Regards
 Guo Ren
