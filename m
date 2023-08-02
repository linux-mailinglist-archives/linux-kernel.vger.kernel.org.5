Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45BD76D917
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjHBU73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHBU72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:59:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928D5E57;
        Wed,  2 Aug 2023 13:59:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2779461B07;
        Wed,  2 Aug 2023 20:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE3AC433C8;
        Wed,  2 Aug 2023 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691009965;
        bh=nmkOzzBtFOlR8DFxoWtwW9LZ+hvtWnT7U9XNNbK44zs=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=mq5WI9NJKx4ot/fCX8urwyDmjDYxKzJ/KxXHIauxGNMqx+Wn5E6rCeWejmb1+uvPu
         2sXo1C7LxMcElPtGGXkI7IhP7dbMYxBd4Rbm1BOI8f+xbAPOS2669DZdz2NpgrelaL
         OBW8EcwJlyz+Hg+099ccKwzdtQ2m8SwyZaawbdbGwdVXdHnjHWVdK+QIfKDki89yFJ
         ePhMHIaQxen3fGEoxnjavTGdFAq2J/mI25pI3/uZbtY+1nj8le5+zUSmt3j6cdgVAI
         IwmBY7ztrTn+6dmuZfFLVGIXJMsZcYlP9LNg9W68X9KEJF7GQ/SbQi54Pkj4C7h7AD
         KgMPCWGiYpMwQ==
Date:   Wed, 02 Aug 2023 13:59:23 -0700
From:   Kees Cook <kees@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>, keescook@chromium.org
CC:     justinstitt@google.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] RISC-V: cpu: refactor deprecated strncpy
User-Agent: K-9 Mail for Android
In-Reply-To: <mhng-724de287-da99-4f58-af50-5d728a28d4ab@palmer-ri-x1c9>
References: <mhng-724de287-da99-4f58-af50-5d728a28d4ab@palmer-ri-x1c9>
Message-ID: <6A03714C-8C92-4E05-8FAD-D2C5A4745E7D@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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

On August 2, 2023 1:47:14 PM PDT, Palmer Dabbelt <palmer@dabbelt=2Ecom> wro=
te:
>On Wed, 02 Aug 2023 13:41:52 PDT (-0700), Palmer Dabbelt wrote:
>> On Wed, 02 Aug 2023 13:36:03 PDT (-0700), keescook@chromium=2Eorg wrote=
:
>>> On Wed, Aug 02, 2023 at 12:21:58AM +0000, Justin Stitt wrote:
>>>> `strncpy` is deprecated for use on NUL-terminated destination strings=
 [1]=2E
>>>>
>>>> Favor not copying strings onto stack and instead use strings directly=
=2E
>>>> This avoids hard-coding sizes and buffer lengths all together=2E
>>>>
>>>> Link: https://github=2Ecom/KSPP/linux/issues/90
>>>> Cc: linux-hardening@vger=2Ekernel=2Eorg
>>>> Suggested-by: Kees Cook <keescook@chromium=2Eorg>
>>>> Signed-off-by: Justin Stitt <justinstitt@google=2Ecom>
>>>
>>> I like it! ;)
>>>
>>> Reviewed-by: Kees Cook <keescook@chromium=2Eorg>
>>
>> Thanks, I just queue it up for fixes (might take a bit to build test,
>> I'm a bit backed up)=2E
>>
>> Reviewed-by: Palmer Dabbelt <palmer@rivosinc=2Ecom>
>> Acked-by: Palmer Dabbelt <palmer@rivosinc=2Ecom>
>>=20
>> If you wanted to take it for some hardening thing, though -- otherwise
>> it'll likely end up on my fixes later today=2E
>
>Sorry this is for-next as it's not a fix, I was just looking at other=20
>fixes=2E  It's queued up aimed at for-next=2E

Awesome; thank you! :)


--=20
Kees Cook
