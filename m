Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5766C7F4980
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343880AbjKVO4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbjKVO4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:56:45 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9955992
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:56:41 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5cb8440a23cso21851397b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700665000; x=1701269800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlRpn0YExbwmZYTM470D32GCVHZUUU3U4GDP0MEdp30=;
        b=R1gSCxG635L3tmxoUHRdp5rXmgsQ/CbMt8l9I2pK/qrWMssJ1GqLiByJW4+GmSdPZU
         1xBfEfPr+dOX2dLJyJIh8GaDea7MvKJirgsAyuGPokRgcnEGdqZfr5ngvnCnS2q9qp/R
         XRGsQkehfDjXLEUxaNwmlAbcGfr3WRhMdYDrv4dATMXlwN2P7DRALUtIdCZNgwDEhJkf
         IwkcHxyGyFPV92Jm9MUzt9Wi7HU0AWeg7ZYpQMFYXS5E9ujrXkU7a6twQyAv8ec+aXQs
         RIJ27P1/u+9F1KcWawzX9CpxZbyH91UbsEc96vfrayk4Prdevwl1UHaJCnJ2tF2uUOHZ
         xIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700665000; x=1701269800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlRpn0YExbwmZYTM470D32GCVHZUUU3U4GDP0MEdp30=;
        b=uMW+ee+nEdVXZQ3slFCCg2echCTJRfFahrv/RsubHcMBkJpsAIInlQU3WRLGiKYhrk
         AGOOxXdElJbATEaWoomskEZj1br7eCEvBcf551AXsN8hvov7ZB8LXr/LOVBrCv4Ve948
         Xs3etVAJrRU77JvFUWlsvLXnTbysirtTtbQqWv0HLOoXbgiaRRStegM5x6DY0edmxVNW
         KlRi471XAIfQpsBdfA56FD7jCAxnDOuo2N9Omxd+xvhCFmkk2xeSyli8IcUciuejM0ye
         CkAWl28izqoodGMIw3YltDUxgcSxvOtHPatyxVu/Vi6EeyInFQUT71SDEsZW+x/JX29+
         OEkg==
X-Gm-Message-State: AOJu0YyuKjGsCxkaLR+dxOxgdQ9QbucaqhjGn2cthDxyyyy1EG0kUzdm
        bH8wEPTmUuCPweMHz6doGc1CCZGUbObzgLePUuNx9A==
X-Google-Smtp-Source: AGHT+IETkyDkyc+qmERQdITDeir1SD3U7sHru8ZIboVSSWeeQw5dcf2O6tuEhcqqPh/BIaHsLICfH+aUOCCIoZE93wc=
X-Received: by 2002:a0d:d692:0:b0:5c9:e98c:a6ae with SMTP id
 y140-20020a0dd692000000b005c9e98ca6aemr2364566ywd.4.1700665000626; Wed, 22
 Nov 2023 06:56:40 -0800 (PST)
MIME-Version: 1.0
References: <170060515641.2447486.11798332619205301829.stgit@djiang5-mobl3>
In-Reply-To: <170060515641.2447486.11798332619205301829.stgit@djiang5-mobl3>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 22 Nov 2023 15:56:28 +0100
Message-ID: <CACRpkda-YFDH6JB=V5n4QXMAHyHc22pfhUfW97hj7WaHX7-mpg@mail.gmail.com>
Subject: Re: [PATCH v2] acpi: Fix ARM32 platforms compile issue introduced by
 fw_table changes
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     rafael@kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, lenb@kernel.org,
        robert.moore@intel.com, Jonathan.Cameron@huawei.com,
        dan.j.williams@intel.com, guohanjun@huawei.com, arnd@arndb.de,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        cfsworks@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:19=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> =
wrote:

> Linus reported that:
> After commit a103f46633fd the kernel stopped compiling for
> several ARM32 platforms that I am building with a bare metal
> compiler. Bare metal compilers (arm-none-eabi-) don't
> define __linux__.
>
> This is because the header <acpi/platform/acenv.h> is now
> in the include path for <linux/irq.h>:
>
>   CC      arch/arm/kernel/irq.o
>   CC      kernel/sysctl.o
>   CC      crypto/api.o
> In file included from ../include/acpi/acpi.h:22,
>                  from ../include/linux/fw_table.h:29,
>                  from ../include/linux/acpi.h:18,
>                  from ../include/linux/irqchip.h:14,
>                  from ../arch/arm/kernel/irq.c:25:
> ../include/acpi/platform/acenv.h:218:2: error: #error Unknown target envi=
ronment
>   218 | #error Unknown target environment
>       |  ^~~~~
>
> The issue is caused by the introducing of splitting out the ACPI code to
> support the new generic fw_table code.
>
> Rafael suggested [1] moving the fw_table.h include in linux/acpi.h to bel=
ow
> the linux/mutex.h. Remove the two includes in fw_table.h. Add include of
> linux/acpi.h in fw_table.c before the fw_table.h include.
>
> Link: https://lore.kernel.org/linux-acpi/CAJZ5v0idWdJq3JSqQWLG5q+b+b=3Dzk=
EdWR55rGYEoxh7R6N8kFQ@mail.gmail.com/
> Fixes: a103f46633fd ("acpi: Move common tables helper functions to common=
 lib")
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

This works fine on my end.
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
