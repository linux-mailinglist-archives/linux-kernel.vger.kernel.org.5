Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1352D8139B5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572982AbjLNSQL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Dec 2023 13:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235740AbjLNSQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:16:08 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC710A6;
        Thu, 14 Dec 2023 10:16:14 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b9fb227545so688621b6e.1;
        Thu, 14 Dec 2023 10:16:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577774; x=1703182574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fVrLLiv/CD23rD47e8kGnLhnnuQbRgVTt+cM3Cov5A=;
        b=ENG+GXthL/SA75mRfhxCaaWTQVIZcYD81czKsMwRHjHZij23ng/ehK6ulS+QSeLWjd
         mzOt2STAO69+23gZMUx2bkyrgQOQ2Maw0gse1VWFLI8geX6q/pO5pVnMHeC8v8tN3mvl
         E3b8nFiiTdwWoFrkz4QvATVkQ+P568fVqquODZdxdOd2aFLt7tKbQXGRPse+0yLw09dy
         1r22OU+Q8eDo8qCP32fOvReL+8KmK3DijBH+JACCYb2hANprogXvdUV+hldAzdXT6ktr
         dEPp4Z4GeNRU1mMvY9iVMcP6w2DV3hvlSrRuYGOoMoZzdsuE0afoogagvZe+g1tKCu01
         Oulw==
X-Gm-Message-State: AOJu0YzO+TDxeAIrWOBiBY8krLz4ZD434tAwBiNvBtxRT8fyh6eUs1xx
        aBwbTPoe7kQ3nbccH1QfOOxSNPaTAc8HaspvWOE=
X-Google-Smtp-Source: AGHT+IHJijZImnPNUIIOWv84OL2w1tGUmgZPvXQ1Drc8dHZAkuSK99fCqBUWsD+7YUkvDs3ihxHUMSQwP8kpLp8yZOg=
X-Received: by 2002:a05:6870:9a8a:b0:203:36fc:6c8a with SMTP id
 hp10-20020a0568709a8a00b0020336fc6c8amr4450470oab.4.1702577773953; Thu, 14
 Dec 2023 10:16:13 -0800 (PST)
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <E1rDOfs-00DvjY-HQ@rmk-PC.armlinux.org.uk>
 <20231214173241.0000260f@Huawei.com> <CAJZ5v0jymOtZ0y65K9wE8FJk+ZKwP+FoGm4AKHXcYVfQJL9MVw@mail.gmail.com>
 <ZXtFBYJEX2RrFrwj@shell.armlinux.org.uk>
In-Reply-To: <ZXtFBYJEX2RrFrwj@shell.armlinux.org.uk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Dec 2023 19:16:02 +0100
Message-ID: <CAJZ5v0h2Keyb-gFWFuPsKtwqjXvM2snyGpo6MMfFzaXKbfEpgw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 01/21] ACPI: Only enumerate enabled (or functional) devices
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
        linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 7:10 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Dec 14, 2023 at 06:47:00PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Dec 14, 2023 at 6:32 PM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Wed, 13 Dec 2023 12:49:16 +0000
> > > Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:
> > >
> > > > From: James Morse <james.morse@arm.com>
> > > >
> > > > Today the ACPI enumeration code 'visits' all devices that are present.
> > > >
> > > > This is a problem for arm64, where CPUs are always present, but not
> > > > always enabled. When a device-check occurs because the firmware-policy
> > > > has changed and a CPU is now enabled, the following error occurs:
> > > > | acpi ACPI0007:48: Enumeration failure
> > > >
> > > > This is ultimately because acpi_dev_ready_for_enumeration() returns
> > > > true for a device that is not enabled. The ACPI Processor driver
> > > > will not register such CPUs as they are not 'decoding their resources'.
> > > >
> > > > Change acpi_dev_ready_for_enumeration() to also check the enabled bit.
> > > > ACPI allows a device to be functional instead of maintaining the
> > > > present and enabled bit. Make this behaviour an explicit check with
> > > > a reference to the spec, and then check the present and enabled bits.
> > > > This is needed to avoid enumerating present && functional devices that
> > > > are not enabled.
> > > >
> > > > Signed-off-by: James Morse <james.morse@arm.com>
> > > > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > > > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > > > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > ---
> > > > If this change causes problems on deployed hardware, I suggest an
> > > > arch opt-in: ACPI_IGNORE_STA_ENABLED, that causes
> > > > acpi_dev_ready_for_enumeration() to only check the present bit.
> > >
> > > My gut feeling (having made ACPI 'fixes' in the past that ran into
> > > horribly broken firmware and had to be reverted) is reduce the blast
> > > radius preemptively from the start. I'd love to live in a world were
> > > that wasn't necessary but I don't trust all the generators of ACPI tables.
> > > I'll leave it to Rafael and other ACPI experts suggest how narrow we should
> > > make it though - arch opt in might be narrow enough.
> >
> > A chicken bit wouldn't help much IMO, especially in the cases when
> > working setups get broken.
> >
> > I would very much prefer to limit the scope of it, say to processors
> > only, in the first place.
>
> Thanks for the feedback and the idea.
>
> I guess we need something like:
>
>         if (device->status.present)
>                 return device->device_type != ACPI_BUS_TYPE_PROCESSOR ||
>                        device->status.enabled;
>         else
>                 return device->status.functional;
>
> so we only check device->status.enabled for processor-type devices?

Yes, something like this.
