Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B8B7A2147
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbjIOOoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbjIOOox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:44:53 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6141BC7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 07:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=H8PZLMZCU0PDXbXjCCzMXnQDN3Es4h4xOXOxp4F6e+E=;
        t=1694789088; x=1695998688; b=ZtV/87QKtQxLhG4H9Mz0AgxT7PP2R4NplvZrYu+YC2zEsRz
        +Jhfc6OgKf8okjhwk97T5PVoncGOZok/Kf00ioBv7E+os2y11To0j44MQmLDi6SRqjo9fH/AjIuHc
        M8lFTHrKZHTzO6ouxUv//GBp390qc6l0tcs2oEFyr5QREp9Pbg6mG/MKgWkdksP1tx5gAVdjEohSM
        YY5cj4zWJvHZEFzvLFw6+ygpxzSvwR8CFwJ1Q9gV5xkop9fwRlYYnzFV6YpiSJjNH5BQa5xGvdYy6
        T00XqTqUFNjQ2a+IlD8gtbkhTA3Au34TCooRbqm80pLG3QbY60LghLNYzw0swgBg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qhA39-001WIR-0N;
        Fri, 15 Sep 2023 16:44:03 +0200
Message-ID: <115822422e97aac5ccd651681d74a2a4ae3cff89.camel@sipsolutions.net>
Subject: Re: [PATCH v2] x86: Fix build of UML with KASAN
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ingo Molnar <mingo@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel@axis.com
Date:   Fri, 15 Sep 2023 16:44:01 +0200
In-Reply-To: <ZQQkthfNuV3dOhZe@gmail.com>
References: <20230915-uml-kasan-v2-1-ef3f3ff4f144@axis.com>
         <ZQQkthfNuV3dOhZe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-09-15 at 11:32 +0200, Ingo Molnar wrote:
>=20
> >  ld: mm/kasan/shadow.o: in function `memset':
> >  shadow.c:(.text+0x40): multiple definition of `memset';
> >  arch/x86/lib/memset_64.o:(.noinstr.text+0x0): first defined here
> >  ld: mm/kasan/shadow.o: in function `memmove':
> >  shadow.c:(.text+0x90): multiple definition of `memmove';
> >  arch/x86/lib/memmove_64.o:(.noinstr.text+0x0): first defined here
> >  ld: mm/kasan/shadow.o: in function `memcpy':
> >  shadow.c:(.text+0x110): multiple definition of `memcpy';
> >  arch/x86/lib/memcpy_64.o:(.noinstr.text+0x0): first defined here
>=20
> So the breakage was ~9 months ago, and apparently nobody build-tested UML=
?

Well, first of all, it's only with KASAN, and then I think we probably
all did and applied a similar fix or this one ... I have a in my tree
that simplies marks the three symbols as weak again, for instance,
dating back to March 27th. Didn't publish it at the time, it probably
got lost in the shuffle, don't remember.


Also, a variant of this patch has been around for three months too.

> Does UML boot with the fix?

Sure, works fine as long as the symbols are marked weak _somehow_.

johannes
