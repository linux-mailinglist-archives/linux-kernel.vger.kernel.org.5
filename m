Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649D27D8C1C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjJZXRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJZXRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:17:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC511AD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:17:36 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698362255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ji0rxsrrUJ/U9e1go4W2U1EcYfM74rww2vhMKnZSaYY=;
        b=zZeew86GlfyaUrKTsUEV8Tw0wcY4T2j4QK2UrK2yIEaeQJi80ZUmXSdX+suyCn9UHz9+VZ
        VTz3XL7nVMuxw83X46QgyFLlvQ3awd25jKj5rYTZeswj81GMXtSg6pLXMjkBlHTxOtAYyy
        KsRn9vVT3Gd8ma1cCSDFS+aHZpIZj63fL6on8Gr/JcACoiN8yW3ehQGlP05aqLkxls/W0K
        r5cfUZxIanVwM7pkf8D3+m6LAX87fApoVOQ7Vz3HVcd7GIEtdcsohEQs4NLfKwwr8l/Iha
        yvlZdQFHX/HvexKQ4cI4RyfuGueGc5baJeGWVNiX73ytu1RDsIh2dWqeU28MlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698362255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ji0rxsrrUJ/U9e1go4W2U1EcYfM74rww2vhMKnZSaYY=;
        b=waxRLRDT/+QlgX3bLjkj5z8GR+W2cbNcroPWuIxAWPOUkhJIT3p2I9l/fabXaL4v6S/7EA
        nCiMEpUDM01VbtBw==
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>
Cc:     Anup Patel <anup@brainfault.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH] genirq/matrix: Dynamic bitmap allocation
In-Reply-To: <87a5s5z44x.fsf@all.your.base.are.belong.to.us>
References: <20231026101957.320572-1-bjorn@kernel.org>
 <CAK9=C2Vcbq_ReGcK51uOYp+M2hakz=9=RNHaHFMbfxhth_4cnA@mail.gmail.com>
 <87a5s5z44x.fsf@all.your.base.are.belong.to.us>
Date:   Fri, 27 Oct 2023 01:17:34 +0200
Message-ID: <87fs1x3re9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26 2023 at 19:26, Bj=C3=B6rn T=C3=B6pel wrote:
> Note that the per-device domain support is already upstream, it's only
> the ARM cleanups that are not.
>
> IOW, there's no need to wait for the ARM cleanups. :-)

Correct. The &*@^@#%$ delayed ARM link was only meant as a reference on
how this is implemented and obviously as a reminder to the ARM folks to
get this finally done...

The main point is not to introduce new users of this failed programming
model and instead make them use the more future proof implementation
right away - which of course might to turn out to be completely wrong
5-10 years from now :)

Thanks,

        tglx


