Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821377D9EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 19:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjJ0R3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 13:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJ0R33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 13:29:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6050CAB;
        Fri, 27 Oct 2023 10:29:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698427765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZQTIy/VXqCsK5xasPzFtCtU95N0L5Rqr8uD6BbwtUKU=;
        b=0guiRZJYY6+hb0/4VKs4gKCcYi6GHtBdM+Pg4XqYn3VXHkd/K0EMCaZn8sCAwsguTL15sb
        76SnCELLX5a2fyzD23VBJH8ebO/OeP1DB9UieMxXNhi9xD9izzPk2Bfuh7jcfD/t+rOxAe
        X9fh+Ztpv7z1sHulzexQtihJzl+gIMAAhKmIEFIW7IMb48I2s5f5uLwr+bU8c8qM4/f9Ny
        OMjVS9XAk/cx+odr/YNVDuq1+W88ID7Hu++ZITmOh6DApJRU3IhUtbz07OUW7KuZxUjPRe
        rcdAwJdtzbPWJ7Vez6FVvWAVMBeOukYUtjvB93bJ4vIsgiRlbWAcGIm6a7wWEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698427765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZQTIy/VXqCsK5xasPzFtCtU95N0L5Rqr8uD6BbwtUKU=;
        b=ElMFqiF1XbQ/OhDxN3fBBKcOErxBAl3iqamWSWv5E6dUxWwwdHQELFu7BJvvYuvaLKSnWh
        5Q2jYoGRLKRu2QCA==
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/3] of: property: Add fw_devlink support for msi-parent
In-Reply-To: <CAK9=C2VRNJGySLT8_oN=U9Pe9C9mOdPjOUr24ugXciT0Hx9pqA@mail.gmail.com>
References: <20231025142820.390238-1-apatel@ventanamicro.com>
 <20231025142820.390238-3-apatel@ventanamicro.com> <871qdg4hvm.ffs@tglx>
 <CAK9=C2VRNJGySLT8_oN=U9Pe9C9mOdPjOUr24ugXciT0Hx9pqA@mail.gmail.com>
Date:   Fri, 27 Oct 2023 19:29:24 +0200
Message-ID: <87msw42cuj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27 2023 at 21:01, Anup Patel wrote:
> On Fri, Oct 27, 2023 at 1:27=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>>
>> On Wed, Oct 25 2023 at 19:58, Anup Patel wrote:
>> > This allows fw_devlink to create device links between consumers of
>> > a MSI and the supplier of the MSI.
>>
>> How is this related to the two fixes in this series?
>
> The first three patches of the v11 RISC-V AIA series are all
> fixes hence I sent them separately for the 6.7 merge window.
> (https://lore.kernel.org/lkml/20231023172800.315343-1-apatel@ventanamicro=
.com/)
>
> All three fixes are unrelated to each other and were discovered
> during AIA driver development.
>
> This patch fixes the probing order for platform devices having
> inter-dependency based on "msi-parent" DT property.
> For example, the AIA APLIC (wired-to-MSI bridge) platform
> device depends on the AIA IMSIC (MSI controller) platform
> device.

Well, the changelog should tell that it is a fix and not make the
illusion that this is pure enablement....

> Are you okay with this patch going through the RISC-V tree ?

Fine with me.
