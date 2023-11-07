Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642FB7E3502
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjKGF5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 00:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKGF5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 00:57:48 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65189DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 21:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1699336664;
        bh=WLSmH2YPB6ObGHIHtgDYQTqiAIGZxZwcz5obGeCszlA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Phtdf1Fhfq/erjjW2irSLi9DfgpGK3jtR86PifRopkpQ7EorydzfZltVCcBlW+oNr
         4tlI4jOopCn9HgMgvZ/AFrRpHLQ8l3KSZwzYlq+rD70c8btUhG8k9qNbLDcfCkuXlh
         dTeGNoM/yBJWPmBqXJ5z9kkiHgyxEQkn7INidyhIt4i/jXSDpJVhc7Hi8eKEnwCjF4
         VnyS+Xf1E0IFSOqVSyXozXRMIjmMGQwGM1XVfLpgihoQ9YjlVe02p+3T0qmJ+RlP84
         j2sc5y7RhEO95k4iGNaISatDNllYL42OHEKZkP9d/GUm1T8i45x5e7LjP12eUdIws/
         hRAO81FEAEpCA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SPcvC5Yfbz4x7q;
        Tue,  7 Nov 2023 16:57:43 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] powerpc: Fix signature of pfn_to_kaddr()
In-Reply-To: <20231106-virt-to-pfn-fix-ppc-v1-1-93197a7ccab4@linaro.org>
References: <20231106-virt-to-pfn-fix-ppc-v1-1-93197a7ccab4@linaro.org>
Date:   Tue, 07 Nov 2023 16:57:40 +1100
Message-ID: <87ttpyw1ez.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> writes:
> There is a const in the returned value from pfn_to_kaddr()
> but there are consumers that want to modify the result
> and the generic function pfn_to_virt() in <asm-generic/page.h>
> does allow this, so let's relax this requirement and do not
> make the returned value const.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311061940.4pBrm44u-lkp@i=
ntel.com/
=20
I'm struggling to connect the removal of const with those bug reports.
It looks like all those warnings are about 0xc000000000000000 being
outside the range of unsigned long when building 32-bit.

Is it the right bug report link?

The current signature of:

  static inline const void *pfn_to_kaddr(unsigned long pfn) ...

seems OK to me.

It allows code like:

  const void *p =3D pfn_to_kaddr(pfn);
  p++;

But errors for:

  const void *p =3D pfn_to_kaddr(pfn);
  unsigned long *q =3D p;
  *q =3D 0;

  error: initialization discards =E2=80=98const=E2=80=99 qualifier from poi=
nter target type


Having said that it looks like almost every caller of pfn_to_kaddr()
casts the result to unsigned long, so possibly that would be the better
return type in terms of the actual usage. Although that would conflict
with __va() which returns void * :/

cheers
