Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33EC78BE4C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjH2GPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjH2GPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:15:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117A1184
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:15:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 962C464650
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAA0C433C7;
        Tue, 29 Aug 2023 06:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693289703;
        bh=gIxemUSIKJzGZWcSfXn7/bdFzIZY6pI3I0pN2YzbB4c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=h+rqRw1+EoGuYV+vv4Cvq+nEP4PHWResOIPyy6NOkbKuhMjXuZUSFdpEqpbmbWPKR
         ohie393l7Jzb46trWZELJ/TJ72tGDWBbNLqd8Ul81l3aNfqx9B2WB9SEXlAb1n+LD7
         bcIqK5eyyxfOJTRwvCV5nKFOZp9C9X9NUIdRrZK51AwC1FHt7K9cZz4MhoFqvdPNQZ
         wURwfQJJqhI/DF0CA7IzokgJ0lcpmtZYsaznrmZK6oUqJ0scnDUltOfIkkcXSURdUb
         SA5WtnBarA4NNgdRasn++zv2UoCZCV/fzOXg5pL8YCeZ+h2S7UJxcQTwlj38Z+bJWd
         /ybS8ZTI22wiQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Nam Cao <namcaov@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@kernel.org
Subject: Re: [PATCH] riscv: provide riscv-specific is_trap_insn()
In-Reply-To: <ZOymDqhE9STgx4Mm@nam-dell>
References: <20230827205641.46836-1-namcaov@gmail.com>
 <874jkjl4e1.fsf@all.your.base.are.belong.to.us>
 <ZOyhozSq3S36eRSq@nam-dell> <ZOymDqhE9STgx4Mm@nam-dell>
Date:   Tue, 29 Aug 2023 08:14:59 +0200
Message-ID: <87edjmz864.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Nam Cao <namcaov@gmail.com> writes:

> On Mon, Aug 28, 2023 at 03:31:15PM +0200, Nam Cao wrote:
>> On Mon, Aug 28, 2023 at 02:48:06PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> > Nam Cao <namcaov@gmail.com> writes:
>> >=20
>> > > uprobes expects is_trap_insn() to return true for any trap instructi=
ons,
>> > > not just the one used for installing uprobe. The current default
>> > > implementation only returns true for 16-bit c.ebreak if C extension =
is
>> > > enabled. This can confuse uprobes if a 32-bit ebreak generates a trap
>> > > exception from userspace: uprobes asks is_trap_insn() who says there=
 is no
>> > > trap, so uprobes assume a probe was there before but has been remove=
d, and
>> > > return to the trap instruction. This cause an infinite loop of enter=
ing
>> > > and exiting trap handler.
>> > >
>> > > Instead of using the default implementation, implement this function
>> > > speficially for riscv which checks for both ebreak and c.ebreak.
>> >=20
>> > I took this for a spin, and it indeed fixes this new hang! Nice!
>>=20
>> Great! Thanks for testing it.
>>=20=20
>> > However, when I tried setting an uprobe on the ebreak instruction
>> > (offset 0x118) from your example [1], the probe does not show up in the
>> > trace buffer.
>> >=20
>> > Any ideas?
>>=20
>> >From my understanding, both uprobes and kprobes refuse to install break=
 points
>> into existing trap instructions. Otherwise, we may conflict with somethi=
ng else
>> that is also using trap instructions.
>
> I just realize you probably ask this because uprobe can still be installe=
d before
> applying the patch. But I think that is another bug that my patch also
> accidentally fix: uprobes should not install breakpoint into ebreak instr=
uctions,
> but it incorrectly does so because it does not even know about the existe=
nce of
> 32-bit ebreak.

FWIW, I can still install the uprobe at an ebreak with you patch. It's
not hit, but succeeds to install.
