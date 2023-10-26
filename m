Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EB17D878C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345093AbjJZR0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjJZR0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:26:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44BA194
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:26:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF22CC433C7;
        Thu, 26 Oct 2023 17:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698341201;
        bh=7BAeAfW71dln/XhU+dLMLgzw3nnXeBMswiuhD606WIo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=s3db95fI/eHkyzmx5IJp8Fd/n3POMb+po5Nmw5rzw1WR2hsZBiEn5HHKb6TsoPlom
         S7irqxF2d/EQl6eTpQMMaKPyV9tani0dtK9imvy/yCvLOAienXTZImKk8Ku1f/aRa0
         Nw4OnLdjX6eJHzclFXGU6FCZzwTa9MoSlDhE9bveYUqYAMA42vm2RmryvohRVjMdEH
         jL5GuQ7vv9OD8IOSQqdbALt5ei7+tNzMoXqtNLmLN2I9gU9pRL4YOSLikvvoOmXIil
         SrHMQxGhCZLAVtBGIS97p3/jSbnlyvlcnmmTHRRFuHA0wow7gHnrcXDn3/uAkx18l9
         U7J00d24d6eJQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Anup Patel <anup@brainfault.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [RFC PATCH] genirq/matrix: Dynamic bitmap allocation
In-Reply-To: <CAK9=C2Vcbq_ReGcK51uOYp+M2hakz=9=RNHaHFMbfxhth_4cnA@mail.gmail.com>
References: <20231026101957.320572-1-bjorn@kernel.org>
 <CAK9=C2Vcbq_ReGcK51uOYp+M2hakz=9=RNHaHFMbfxhth_4cnA@mail.gmail.com>
Date:   Thu, 26 Oct 2023 19:26:38 +0200
Message-ID: <87a5s5z44x.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anup Patel <apatel@ventanamicro.com> writes:

> On Thu, Oct 26, 2023 at 3:50=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>
>> Some (future) users of the irq matrix allocator, do not know the size
>> of the matrix bitmaps at compile time.
>>
>> To avoid wasting memory on unnecessary large bitmaps, size the bitmap
>> at matrix allocation time.
>>
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>> Here's a cleaned up, boot tested, proper patch.
>>
>> Thomas, this is just FYI/RFC. This change would only make sense, if
>> the RISC-V AIA series starts using the IRQ matrix allocator.
>
> I have dropped "multi-MSI" support from the AIA v12 series
> and also integrated the IRQ matrix allocator. This patch is
> included in the AIA v12 series.

Ok!

> For reference, look at riscv_aia_v12 branch at:
> https://github.com/avpatel/linux.git
>
> I still need to rebase this upon device MSI domain support
> from Thomas.

Note that the per-device domain support is already upstream, it's only
the ARM cleanups that are not.

IOW, there's no need to wait for the ARM cleanups. :-)


Bj=C3=B6rn
