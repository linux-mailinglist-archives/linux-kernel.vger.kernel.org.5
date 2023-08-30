Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B2778DEFA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242220AbjH3TL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242236AbjH3Hct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:32:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6938DCC9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:32:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07B7C62584
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E721AC433C8;
        Wed, 30 Aug 2023 07:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693380765;
        bh=MNdLlpmsuMBurHZF+Un6RDif17HZyEPH4RFqN/Wu58Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LwJNGWglZNtVFL2hiU39ixbHdn+xn2No5KphPWRiGWMEBIoD2qOS7xcuKx7GjLg6G
         7Vus2xgqpIZBTufZVy0QR2ybkcIbWFYmURDGmyhkfI8+3grx3/MEG5w8Dr1Kc/kNC3
         MEdVP7R79J/zvQjSbe0HQGmUsJDfPlK7tYMA+Xvdi1wEWUs6Y+9TWkRaCYtC+apjaT
         QiwTODnJpEHyFoEkD0Ch/1KNXKRiDVJg6AJELI2fAc8m8f8urYCOt7HlnWC2F/ifJO
         L9pjpvllQkwGVu1nJIK/pYMuvkugrFtJ1MsNY/RBIxmbjzEOnjcUH/VLblKnYuEtcF
         zZGxruNXunOiA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Nam Cao <namcaov@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@kernel.org
Subject: Re: [PATCH] riscv: provide riscv-specific is_trap_insn()
In-Reply-To: <ZO4+/P9B29Bpb0Yz@nam-dell>
References: <20230827205641.46836-1-namcaov@gmail.com>
 <874jkjl4e1.fsf@all.your.base.are.belong.to.us>
 <ZOyhozSq3S36eRSq@nam-dell> <ZOymDqhE9STgx4Mm@nam-dell>
 <87edjmz864.fsf@all.your.base.are.belong.to.us>
 <ZO4+/P9B29Bpb0Yz@nam-dell>
Date:   Wed, 30 Aug 2023 09:32:42 +0200
Message-ID: <87il8xm1d1.fsf@all.your.base.are.belong.to.us>
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

> On Tue, Aug 29, 2023 at 08:14:59AM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> Nam Cao <namcaov@gmail.com> writes:
>>=20
>> > On Mon, Aug 28, 2023 at 03:31:15PM +0200, Nam Cao wrote:
>> >> On Mon, Aug 28, 2023 at 02:48:06PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> >> > Nam Cao <namcaov@gmail.com> writes:
>> >> >=20
>> >> > > uprobes expects is_trap_insn() to return true for any trap instru=
ctions,
>> >> > > not just the one used for installing uprobe. The current default
>> >> > > implementation only returns true for 16-bit c.ebreak if C extensi=
on is
>> >> > > enabled. This can confuse uprobes if a 32-bit ebreak generates a =
trap
>> >> > > exception from userspace: uprobes asks is_trap_insn() who says th=
ere is no
>> >> > > trap, so uprobes assume a probe was there before but has been rem=
oved, and
>> >> > > return to the trap instruction. This cause an infinite loop of en=
tering
>> >> > > and exiting trap handler.
>> >> > >
>> >> > > Instead of using the default implementation, implement this funct=
ion
>> >> > > speficially for riscv which checks for both ebreak and c.ebreak.
>> >> >=20
>> >> > I took this for a spin, and it indeed fixes this new hang! Nice!
>> >>=20
>> >> Great! Thanks for testing it.
>> >>=20=20
>> >> > However, when I tried setting an uprobe on the ebreak instruction
>> >> > (offset 0x118) from your example [1], the probe does not show up in=
 the
>> >> > trace buffer.
>> >> >=20
>> >> > Any ideas?
>> >>=20
>> >> >From my understanding, both uprobes and kprobes refuse to install br=
eak points
>> >> into existing trap instructions. Otherwise, we may conflict with some=
thing else
>> >> that is also using trap instructions.
>> >
>> > I just realize you probably ask this because uprobe can still be insta=
lled before
>> > applying the patch. But I think that is another bug that my patch also
>> > accidentally fix: uprobes should not install breakpoint into ebreak in=
structions,
>> > but it incorrectly does so because it does not even know about the exi=
stence of
>> > 32-bit ebreak.
>>=20
>> FWIW, I can still install the uprobe at an ebreak with you patch. It's
>> not hit, but succeeds to install.
>
> It seems uprobes install failures are completely silent (see uprobe_mmap(=
) in
> kernel/events/uprobes.c). So I think although uprobes install seems fine,=
 it
> actually is not.

Huh, so there's no check if the instruction is a valid one at event
register point?
