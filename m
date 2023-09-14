Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1BB7A049E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbjINM5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238507AbjINM5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:57:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480B11FD4;
        Thu, 14 Sep 2023 05:57:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8AFC433C9;
        Thu, 14 Sep 2023 12:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694696262;
        bh=bEWpEOswiPbLYKfV+TIbeO5QDeJGZGbGxZIpsvQY95c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WHxEWxZl9dQszH48IbDchUBVOe7U/R31FkcnrCnum0FQinJN68j1w1IcKWic7ccP5
         q9IaR5YCTJ0DxuDmf5fUKN82xJZPpndj/3SndgZIcxlYhnvnDfFUE8ekk3cUUFaOlZ
         3n8LuTKgU30m9QujKdLBlmYBDarHnC1fgbrSDhGWOgqq7A3tdBsdK9C//X7lndby1p
         XQ1wGamDUKfod/AMzihUOGx4Ed7NORIA+w4LQLeX59RQkX4bNL7uIAUpt0yD4e3v0n
         p8G3HPh3pB5ZCufOrhswVpPTNYrz4nH1qnCKxu07ijZID4dOYC6BgWmF0WMPwPvmoe
         AFkftxKmmblKg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Andy Chiu <andy.chiu@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>,
        =?utf-8?B?QmrDtnJu?= =?utf-8?B?IFTDtnBlbA==?= 
        <bjorn@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] riscv: Add BLAKE2s V implementation
In-Reply-To: <20230914-charting-detector-3d2b615393b9@wendy>
References: <20230912115728.172982-1-bjorn@kernel.org>
 <20230912115728.172982-7-bjorn@kernel.org>
 <20230914-charting-detector-3d2b615393b9@wendy>
Date:   Thu, 14 Sep 2023 14:57:39 +0200
Message-ID: <87ttrwap4s.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley <conor.dooley@microchip.com> writes:

> On Tue, Sep 12, 2023 at 01:57:28PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>=20
>> BLAKE2s is used in various places, most notably in Wireguard, and as
>> of v5.17 in drivers/char/random.
>>=20
>> Add a BLAKE2s implementation using the V-extension. This is a
>> translation of the x86-64 AVX512 variant
>> (arch/x86/crypto/blake2s-core.S) to the RISC-V V-extension.
>>=20
>> The AVX512 variant requires registers >=3D 256b (ymm*), and hence this
>> implementation requires a VLEN of >=3D256.
>>=20
>> The implementation passes the kernel BLAKE2s selftest, and has been
>> tested on spike and qemu.
>>=20
>> Instruction-wise, the V-variant uses 60% less instructions than the
>> generic, C-based, implementation.
>>=20
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
>>  arch/riscv/crypto/blake2s-v.S    | 164 +++++++++++++++++++++++++++++++
>
>
> This file is currently being built for !RISCV_ISA_V, leading to build err=
ors
> for obvious reasons. Eg:
> ../arch/riscv/crypto/blake2s-v.S:62:2: error: instruction requires the
> following: 'V' (Vector Extension for Application Processors), 'Zve32x'
> or 'Zve64x' (Vector Extensions for Embedded Processors)

Thanks, noted for the next rev!
