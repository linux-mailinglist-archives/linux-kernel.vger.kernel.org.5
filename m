Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74A177BB31
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjHNOLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjHNOKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:10:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFED810DD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:10:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F143614F0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D20C433C7;
        Mon, 14 Aug 2023 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692022254;
        bh=wIRU+TKzPDX43UA4ILBFZUuV1O5dayyLhaNRehSdSh4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ijde4UN2V3AV/c24wpWM5FOL39Qn01/lNwOuvLp8ohbBcp1tBpLAGyQafEPrMdxaM
         QgHY7AHFFdwwVt0O+lIHb+biM7vOoZl66UAcllbgPjrUDobrEioI9RtPknBmraXZhU
         o0jb/TnoAH+I5tYWfshb8xa/klZ6wAYktAwC63q6m6A7FMODQ07ZlLQO7oqPl4/we3
         8NI5uALn3hGTr7rmgdiBtmiF8SAwWFpGz8nJThXHvIHVsfAYiUfTWd2bPdgRi0JSs2
         smYo2Y6+UcPLyIiTno2f5M/ulsBvlgx5XzQO3zQVozn5n/eyUn/39iHMFIJkZ1wHh6
         lTkY0IMQFWadQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Nam Cao <namcaov@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: test code for kprobe
In-Reply-To: <ZNoxGXcK9QOfAfbW@nam-dell>
References: <cover.1690704360.git.namcaov@gmail.com>
 <fc71730b9350026427fe1c2bdbce9b993d8bc6f5.1690704360.git.namcaov@gmail.com>
 <87il9hg65g.fsf@all.your.base.are.belong.to.us>
 <ZNoxGXcK9QOfAfbW@nam-dell>
Date:   Mon, 14 Aug 2023 16:10:51 +0200
Message-ID: <87a5utg1ec.fsf@all.your.base.are.belong.to.us>
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

> On Mon, Aug 14, 2023 at 02:28:11PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> Nam Cao <namcaov@gmail.com> writes:
>>=20
>> A RISC-V specific kprobes test -- much welcome!
>>=20
>> Please add a proper commit message here.
>>=20
>> > ---
>> >  drivers/test_kprobe/Makefile      |   3 +
>> >  drivers/test_kprobe/test_kprobe.c | 265 ++++++++++++++++++++++++++++++
>> >  2 files changed, 268 insertions(+)
>> >  create mode 100644 drivers/test_kprobe/Makefile
>> >  create mode 100644 drivers/test_kprobe/test_kprobe.c
>> >
>> > diff --git a/drivers/test_kprobe/Makefile b/drivers/test_kprobe/Makefi=
le
>>=20
>> Architecture specific test code usually reside in "arch/$ARCH"
>> (arch/riscv), and is part of Kconfig.debug.
>>=20
>> Have a look at:
>> * grep for ARM_KPROBES_TEST in arch/arm
>> * grep for KPROBES_SANITY_TEST, and in arch/powerpc grep
>>   test_emulate_step
>> * grep S390_KPROBES_SANITY_TEST
>
> Sorry that I wasn't clear with this: I just wanted to show how testing wa=
s done.
> This is not meant to be merged.
>
> I do have plans to clean this up and send upstream in the future, but not=
 with
> this patch series.

Please do! A RISC-V specific kprobes test would be nice.


Bj=C3=B6rn
