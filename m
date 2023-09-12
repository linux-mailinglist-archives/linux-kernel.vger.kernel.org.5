Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8895579C79E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjILHFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjILHFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:05:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1404E7F;
        Tue, 12 Sep 2023 00:05:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBFBC433CD;
        Tue, 12 Sep 2023 07:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694502305;
        bh=rdbAnWDmqOY+gzQ808fleTCy7T0WdyZbioJ9M88erQU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P6prl/wEd//9SPT1qY531EGJqgOTlVEuToz0Mba3enuHKZdwa0Zn14U1WyxDlbewb
         xRYsvNK0wwYNtjbh+TENHqzl00MaFXcMnYnUhyYsasFuiRnB20xh4Xg7sAojnRMEdR
         dkAaN6ajP1N0jqDy1cxDvM7GCR2d44tvjbu1RfucNguC7f+YjEAyx/uHlL+WWW+sf0
         ayHULCrsxopO5VAf/LbmDLfgtLWAtMpjNH8nnrLaxMFhxUCNiDYCUQXhs0e6k5sTkw
         ZQ0TVGUXd9Ogp02cOsb0N9K8XQP093EMEOGwAeL0O+t+teE1s4D3PedDnXbT5WBExy
         0it5naf4/Go8w==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2bccda76fb1so89617691fa.2;
        Tue, 12 Sep 2023 00:05:05 -0700 (PDT)
X-Gm-Message-State: AOJu0YyUHms7jwNIzzwMsC0HglZ2WT98APCK2kL3SgmqTcUtnYoVtk1I
        AOpJJhamt8NX6ULDbxfpVHERvX4pmi/+GfvYCas=
X-Google-Smtp-Source: AGHT+IHM2Q2GsUNR0wFWv4DEN2NdeYOxUGS5UgSXcN6uPWiGfeXVUbGdMGi/1xpRAr+xFot6bo4EPLs1rpqpexJAWUI=
X-Received: by 2002:a2e:9197:0:b0:2bc:c11c:4471 with SMTP id
 f23-20020a2e9197000000b002bcc11c4471mr10402795ljg.21.1694502303650; Tue, 12
 Sep 2023 00:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230711153743.1970625-1-heiko@sntech.de> <20230711153743.1970625-11-heiko@sntech.de>
 <20230721054036.GD847@sol.localdomain> <CCA32056-CCE2-4FB5-8CFC-62444CDDA89F@sifive.com>
In-Reply-To: <CCA32056-CCE2-4FB5-8CFC-62444CDDA89F@sifive.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 12 Sep 2023 09:04:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEGnZC6nge42WeBML9Vx6K6Lezt8Cc1faP+3gN=TzFgvA@mail.gmail.com>
Message-ID: <CAMj1kXEGnZC6nge42WeBML9Vx6K6Lezt8Cc1faP+3gN=TzFgvA@mail.gmail.com>
Subject: Re: [PATCH v4 10/12] RISC-V: crypto: add Zvkned accelerated AES
 encryption implementation
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sept 2023 at 00:50, Jerry Shih <jerry.shih@sifive.com> wrote:
>
> On Jul 21, 2023, at 13:40, Eric Biggers <ebiggers@kernel.org> wrote:
>
> > I'm looking forward to having direct support for these AES modes, especially the
> > modes needed for storage encryption: XTS, and CBC or CTS!  None of these AES
> > modes is actually implemented in this patch yet, though, so they can't be
> > claimed in the kconfig help text yet.  This patch is just a starting point, as
> > it just adds support for the bare AES block cipher ("aes" in the crypto API).
> >
> > (BTW, I'm much more interested in, say, AES-XTS support than SM4 support, which
> > this patchset does include.  SM4 is a "national pride cipher" which is somewhat
> > of a niche thing.  I suppose there are already people pushing it for RISC-V
> > though, as they are everywhere else, so that's to be expected...)
> >
>
> We have further optimization for RISC-V platform in OpenSSL PR[1]. It will include
> AES with CBC, CTR, and XTS mode. Comparing to the generic AES implementation,
> the specialized AES-XTS one have about 3X performance improvement using
> OpenSSL benchmark tool. If OpenSSL accepts that PR, we will create the
> corresponding patch for Linux kernel.
>
> [1]
> https://github.com/openssl/openssl/pull/21923
>

This pull request doesn't appear to contain any XTS code at all, only CBC.
