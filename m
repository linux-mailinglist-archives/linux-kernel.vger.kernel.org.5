Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8BC7AA188
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjIUVDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjIUVCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:02:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A636D7B975;
        Thu, 21 Sep 2023 10:37:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA92FC433CC;
        Thu, 21 Sep 2023 05:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695275878;
        bh=MLsGcIRXfwZgXJfU4dYy4+L26UPkpm/1q79i2tEWiLM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EB5CjlF/ICc3opR6zVvYCocFCSZN3miKYZKyOf7tbgYF9ef8NMm2Ay3yTw5JcEGgZ
         Zwcp4wH4x7VgPjuTyiIi+Jk7o9DoTc4KEBav3LIku1p6lTb7JS2xKqNaXvyHZDGkjh
         Y+bidq13Xm6DjQvYj12G1p+32CWlfVyi4ouhLeRrdZo9qgB/T1rws5VsAHxwABFlCU
         T0DlbhZBfCjfNZxueqrPQ4NGHuIq6C0hYPrJP+Wio/8KEBMwmFIQSPsBgEdeG9pLyP
         aPhX530k1r1ZTESvuEM99k6K3TPHmUpqoYAS0pRqYZ/EYGwLT3B9rrHDokUdfDVO5U
         WweMzZztMfNvw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
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
In-Reply-To: <ZQSieofQfDY5mTlI@ghost>
References: <20230912115728.172982-1-bjorn@kernel.org>
 <20230912115728.172982-7-bjorn@kernel.org> <ZQSieofQfDY5mTlI@ghost>
Date:   Thu, 21 Sep 2023 07:57:55 +0200
Message-ID: <87v8c4gja4.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Charlie Jenkins <charlie@rivosinc.com> writes:

>> +.macro VROR REG BITS TMPREG
>> +	vmv.v.v		\TMPREG, \REG
>> +	vsrl.vi		\REG, \REG, \BITS
>> +	vsll.vi		\TMPREG, \TMPREG, 32-\BITS
>> +	vor.vv		\REG, \REG, \TMPREG
>> +.endm
>
> This seems like it would be a good candidate to use the Zvkb extension
> that has vector rotate [1]. It would be a pain to use because you need
> two versions of the roundloop, but you could get away with 1 extra
> branch/nop and save 3 instructions per VROR which looks like it happens
> 8*10 times, so 239 fewer instructions.
>
> [1] https://github.com/riscv/riscv-crypto/releases

Indeed! Thanks!


Bj=C3=B6rn
