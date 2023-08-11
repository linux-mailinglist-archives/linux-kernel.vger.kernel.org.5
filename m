Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828C7778F9A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbjHKMd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjHKMd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:33:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BF830C1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:33:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D866C67031
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 12:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65AEC433C7;
        Fri, 11 Aug 2023 12:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691757236;
        bh=1FHav62wGjkvJfOtUkSd7cOKVq97NsYIFXy+uWXuPQo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LHYfk427SN+8jcuF4CGk2ctHNHJrOyNVbxrKiyAnLNkdP8HSx8OAFvXv5wAo92046
         R/q+eDvY+nJpxiPoTGYLEOzMPqipfJEi1VedDPSTfsauAK29sLPTgD/3seErq/9zrL
         R+2ts+V9OJZl6OM0Gwb3AVOSQBwP8/uRIFPJgzyuwpK/XKTg1M18WwTmGWFGb/3Nd7
         5bpp1y38+bQBDnORdZhVikVDAlzEJAFJYSPMOpI/X6umIIXpeHGd8WRRlTe7jBouA7
         DAoYTFfeKQHEGBQKzI7pxIdhuTEnxMeSRhBe4+IrlRXI25vHOSfNwNdLR7I+RNJSiv
         GqzwqbnkjCftg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Alexandre Ghiti <alex@ghiti.fr>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alan Kao <alankao@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Bo YU <tsu.yubo@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH -fixes] riscv: uaccess: Return the number of bytes
 effectively copied
In-Reply-To: <dff5c443-bebf-9bd9-af1c-85ebfb7c2aec@ghiti.fr>
References: <20230811110304.1613032-1-alexghiti@rivosinc.com>
 <dff5c443-bebf-9bd9-af1c-85ebfb7c2aec@ghiti.fr>
Date:   Fri, 11 Aug 2023 14:33:53 +0200
Message-ID: <87r0o9ahce.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Ghiti <alex@ghiti.fr> writes:

> On 11/08/2023 13:03, Alexandre Ghiti wrote:
>> It was reported that the riscv kernel hangs while executing the test
>> in [1].
>>
>> Indeed, the test hangs when trying to write a buffer to a file. The
>> problem is that the riscv implementation of raw_copy_from_user() does not
>> return the number of bytes written when an exception happens and is fixed
>> up.
>
>
> I'll respin another version as the changelog and the title are=20
> incorrect: the uaccess routines should not return the number of bytes=20
> copied but actually the number of bytes not copied (this is what this=20
> patch implements).
>
> I'll wait for feedbacks before doing so!

Yikes! Nice catch.

Functions like fault_in_readable() will fail horribly w/o this. I wonder
why we haven't seen this problem more?

Feel free to add my RB to your next spin!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

