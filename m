Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1227C4E49
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345779AbjJKJMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345567AbjJKJM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:12:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A12E94;
        Wed, 11 Oct 2023 02:12:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697015545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8mHTnG4MfEd2WInpkSaCyoIk5Nbax8kxNBig7AwLSEU=;
        b=l5sh4dOzDZ2X5HB7Xi84ttICGEA/Gzkkha41sxLmx8M1qkMsMpYCG0Xnyt/vGoVR0Dbdjy
        ucI9k/OtsU/Er7zqcw00spV0cvJPo8qfx2tD3YPpBhY0FsWc5l8QHCRzkkJmx1fffCitpK
        p3KWoVHzp++qoCf8dlfDVFuEtfML3i0rNKwNitl84UoRHNZN9AAmKlVTliBtrwQaQZlHcc
        +UrlmjwOIV/vAWWxlbAC1SBwNYR5Gymwi67+BIgiBXfjMjMllp22y0hZga4sAYbDkS36Fo
        sJnENvRXJ20gGfmlw9LvJsEEA5EcKGm5czz2PAlXomLE/TJQXC7jLHM8Xrnp8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697015545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8mHTnG4MfEd2WInpkSaCyoIk5Nbax8kxNBig7AwLSEU=;
        b=QxJnYCZjXLEtyBI07eDRRe9WPqv1ZDHIwowp2BRGFJbN8R4Ajg6bj5fwV7Th8ozoNOCQOJ
        iYr4BRUAc4t+t+Cw==
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.au@gmail.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v2] alarmtimer: Fix rebind failure
In-Reply-To: <TYCPR01MB112693065867ACA9C42370B9F86CCA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20230922081208.26334-1-biju.das.jz@bp.renesas.com>
 <87il7fq1al.ffs@tglx>
 <TYCPR01MB112697A5D4B57101CDE27C88D86CEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <87fs2jpznr.ffs@tglx>
 <TYCPR01MB11269C6BF3934F9AAC44F855186CEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <87bkd7pic3.ffs@tglx>
 <TYCPR01MB11269FF2DBFDC96B9C12D2E5E86CDA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <87o7h6o6d1.ffs@tglx>
 <CAMuHMdVJnqkF7xmjfOyoxE_Lq=AO85CDD85qu3O+xcSr-3BLTQ@mail.gmail.com>
 <TYCPR01MB112693065867ACA9C42370B9F86CCA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Date:   Wed, 11 Oct 2023 11:12:25 +0200
Message-ID: <87r0m1ldza.ffs@tglx>
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

On Wed, Oct 11 2023 at 06:58, Biju Das wrote:
>> On Tue, Oct 10, 2023 at 5:16=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
.de> wrote:
>>=20
>> The "if (alarmtimer_get_rtcdev()) { ... }" you pointed out in the probe
>> function  seems to be rather fragile, as it depends on probe order. And
>> both CHARGER_MANAGER and RTC_DRV_88PM860X can be modular.
>
> Does it mean that current patch is fine?  On normal scenario, no one
> will remove RTC device, so nothing to worry about battery charger. On
> exceptional cases if anyone wants to remove RTC driver, this patch
> will help(for eg: checking resource leak remove/unbind followed by
> modprobe/bind).

Did you actually read what I wrote?

Allowing removal of a registered RTC alarm device is a user space
visible change as it violates the assumption that an armed alarm timer
is actually functional.

So unless you provide a proper analysis why this does not matter, this
is going nowhere.

Thanks,

        tglx
