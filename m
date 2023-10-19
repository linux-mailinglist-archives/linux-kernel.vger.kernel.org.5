Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3E97D0256
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345972AbjJSTQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjJSTP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:15:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC1BBE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:15:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44054C43391;
        Thu, 19 Oct 2023 19:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697742957;
        bh=czcO7pul0pidk9X5haDsczOJ7Z/4f1Lehio1PveG3/o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BCGTwJVb38aVHGQ6jIWqezw8ESZczOnhpdBcnCLqhiHM7FY0ZjWcbdgszxbVYEKxa
         602a1McW7vib3FMLaasVsj5Yx3t2jY4YM67lvjiD5Q1j03rpIawNYo4+uSVSv521b/
         1o0L5ePmESFgFgyYdOxZrPUqzft4TctM1t1p8lfgcUNnAAKCwwTeCmBn9WKCMDqHEY
         lAkVgxgBFBdRQ3D2rtiyvrTD4grU3ZKXStkkuA/fAyV4hfYmxJk98dBvEiPv6xsc+/
         zRTqLvY9yF9InhrDv/LL5MSkoLS+73mb5RHujiniGlKWuEYFeALFk8gkvst8zma+nM
         Mis0QQBtozfPA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-507b18cf2e1so6151494e87.3;
        Thu, 19 Oct 2023 12:15:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YyYfdQ2B/J/AETjAaBVGwY2F79Q5yOJGQURNU1k7qnp9e5Q/CXp
        szwWxR3B223LqajaK0uWI0oxzDOtrc17aEFlRA==
X-Google-Smtp-Source: AGHT+IHaK3/fQu58LwNVXyEcMTjvuZkQtps1qGk5hQ/5nVuxeS7lpPPatdI4JWkX1iBzto62YR0/Tk8NJlhYkkCMeFc=
X-Received: by 2002:a19:380a:0:b0:507:a624:3f35 with SMTP id
 f10-20020a19380a000000b00507a6243f35mr1957100lfa.41.1697742955464; Thu, 19
 Oct 2023 12:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231006145732.3419115-1-andriy.shevchenko@linux.intel.com>
 <169756785858.2487391.2620832432762980006.robh@kernel.org> <ZS7VrxX6If8Afl5R@smile.fi.intel.com>
In-Reply-To: <ZS7VrxX6If8Afl5R@smile.fi.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 19 Oct 2023 14:15:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLsdjiAYupw-U-voLWGaJoiUTW49PJJYXAhG1podivP5w@mail.gmail.com>
Message-ID: <CAL_JsqLsdjiAYupw-U-voLWGaJoiUTW49PJJYXAhG1podivP5w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] amba: bus: balance firmware node reference counting
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peng Fan <peng.fan@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 1:43=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Oct 17, 2023 at 01:37:43PM -0500, Rob Herring wrote:
> > On Fri, 06 Oct 2023 17:57:31 +0300, Andy Shevchenko wrote:
>
> ...
>
> > Applied, thanks!
>
> Thanks, I hope w.o. patch 2 as it seems it can't be enabled on non-ARM
> platforms due to some strange MM APIs.

Yes, just patch 1. Isn't it just the driver with the error that can't
be enabled, not all ARM_AMBA. I suspect there's a more portable
variant of what was causing the error, but didn't investigate more.

Rob
