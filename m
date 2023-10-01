Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4C07B4866
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 17:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbjJAP1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 11:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjJAP1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 11:27:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AF499;
        Sun,  1 Oct 2023 08:27:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A124EC433C7;
        Sun,  1 Oct 2023 15:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696174021;
        bh=OP680lsN8lk0ineFcZVgu79J8KnTHUp5BT9RfTao+vk=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=aUZj+oZx53xM+0Adszz/WePNjpsIy9M65UpjURU/NxSen1aEW+VD0g4cNi4O582tX
         UdrVpyJrd0PnH8FSU4/PEfoCjVJLUwFMm83B7Ua7uaewX4UNOsO5EngyqnK8FLGyuk
         Y+RdmiJPNpfVEh0V4Mg4EzU6j+5te3R8+zzqWLXFrswKW0yEntKN2nzWYc2vwW+88x
         GDzfgx4kadbk+mgqoFA4GsZnG7h1JZdeHKVFv74F1iodxlTaCv1Y1p/P4vIpb4jNGN
         mSJsW0vdj3syiTjlkdFdIHXGHSYrFPEnkXRLFQteTbYwaaettWQvWoAYA+q4gHrOXc
         HibQudUhLOPHA==
Date:   Sun, 01 Oct 2023 08:26:56 -0700
From:   Kees Cook <kees@kernel.org>
To:     Julia Lawall <julia.lawall@inria.fr>,
        Kees Cook <keescook@chromium.org>
CC:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] comedi: Annotate struct comedi_lrange with __counted_by
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.DEB.2.22.394.2310010945130.3166@hadrien>
References: <5c3b7459b820e22e2ac6ce892d4aadcc119cc919.1696065263.git.christophe.jaillet@wanadoo.fr> <202309301342.5B5BED40A1@keescook> <alpine.DEB.2.22.394.2310010945130.3166@hadrien>
Message-ID: <90E2BBA5-8A2D-42DE-B36A-CD37BABBB433@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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

On October 1, 2023 12:45:41 AM PDT, Julia Lawall <julia=2Elawall@inria=2Efr=
> wrote:
>
>
>On Sat, 30 Sep 2023, Kees Cook wrote:
>
>> On Sat, Sep 30, 2023 at 11:14:47AM +0200, Christophe JAILLET wrote:
>> > Prepare for the coming implementation by GCC and Clang of the __count=
ed_by
>> > attribute=2E Flexible array members annotated with __counted_by can h=
ave
>> > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_B=
OUNDS
>> > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-fam=
ily
>> > functions)=2E
>> >
>> > Signed-off-by: Christophe JAILLET <christophe=2Ejaillet@wanadoo=2Efr>
>> > ---
>> > This patch is part of a work done in parallel of what is currently wo=
rked
>> > on by Kees Cook=2E
>> >
>> > My patches are only related to corner cases that do NOT match the
>> > semantic of his Coccinelle script[1]=2E
>>
>> Nice!
>>
>> struct comedi_lrange {
>>         int length;
>>         struct comedi_krange range[];
>> };
>> =2E=2E=2E
>> static const struct comedi_lrange range_rti800_ai_10_bipolar =3D {
>>         4, {
>>                 BIP_RANGE(10),
>>                 BIP_RANGE(1),
>>                 BIP_RANGE(0=2E1),
>>                 BIP_RANGE(0=2E02)
>>         }
>> };
>>
>> I'm struggling to come up with a way for Coccinelle to find this kind o=
f
>> thing in other places=2E=2E=2E
>
>Kees, what exactly are you trying to match?  Static allocations?

I need to count the number of initialized elements in the flexible array t=
hat is the last member and see if it matches a value set in another member=
=2E

E=2Eg=2E the above sets 4 values for the last array member and then sets a=
nother member to 4=2E

-Kees


--=20
Kees Cook
