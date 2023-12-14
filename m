Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3584681390B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjLNRrH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Dec 2023 12:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNRrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:47:05 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615CE99;
        Thu, 14 Dec 2023 09:47:12 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1fae54afb66so923835fac.1;
        Thu, 14 Dec 2023 09:47:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702576031; x=1703180831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCI4p6q1rK4WR6fVDr3BUQoNcZe5c1Ddy3SGZDHoC9U=;
        b=Klmfcn32AMwhAyeLRHSA/v31GZ7LSYOARxntno271KwzKolZnOYCBgPyKOw91vpk3z
         08sj+xjNNC+RkqbjYKu0IgwVyN2uRiuOENE5NFsuWJDHrqTXWgKTMrrNoA5KtKZVvhCK
         qWtHNpjNtxzhEKkSB19DSykQD1AYqtKRUgRGNzorf5m8QqSikdaT6FreaKu/vmlHCK54
         MBG50p3WpZcvVU91e4Yf2LJcRpj9is408onXplxIO1RXTjfhfjPjkC86mllW2BZc81xU
         PQ8+8Fj64wuKSwHvd8FB72JVUQra5ag2D2/0l93JVBaK6sEbBqPqPXhaSks+C5AB+RVo
         uXvw==
X-Gm-Message-State: AOJu0Ywm0hQGEi5Rlwgs0uwkSW+kkUpoyzjZYW+btPQpXnWWJWO/QgC3
        uUoRV3Tf7hqWbYoyZRsKHGkGWpze9Xly9I1Wi2o=
X-Google-Smtp-Source: AGHT+IGurc+SThWqv6P5Uf59nE4Wm9v4g9qg7EdGZTjEpgesMiWT90sz1j7aRR9N4IauQQSUFNdIYafJpqeTsCWmoDQ=
X-Received: by 2002:a05:6870:20b:b0:203:5389:5afd with SMTP id
 j11-20020a056870020b00b0020353895afdmr1641660oad.5.1702576031481; Thu, 14 Dec
 2023 09:47:11 -0800 (PST)
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <E1rDOfs-00DvjY-HQ@rmk-PC.armlinux.org.uk>
 <20231214173241.0000260f@Huawei.com>
In-Reply-To: <20231214173241.0000260f@Huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Dec 2023 18:47:00 +0100
Message-ID: <CAJZ5v0jymOtZ0y65K9wE8FJk+ZKwP+FoGm4AKHXcYVfQJL9MVw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 01/21] ACPI: Only enumerate enabled (or functional) devices
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
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

On Thu, Dec 14, 2023 at 6:32 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 13 Dec 2023 12:49:16 +0000
> Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:
>
> > From: James Morse <james.morse@arm.com>
> >
> > Today the ACPI enumeration code 'visits' all devices that are present.
> >
> > This is a problem for arm64, where CPUs are always present, but not
> > always enabled. When a device-check occurs because the firmware-policy
> > has changed and a CPU is now enabled, the following error occurs:
> > | acpi ACPI0007:48: Enumeration failure
> >
> > This is ultimately because acpi_dev_ready_for_enumeration() returns
> > true for a device that is not enabled. The ACPI Processor driver
> > will not register such CPUs as they are not 'decoding their resources'.
> >
> > Change acpi_dev_ready_for_enumeration() to also check the enabled bit.
> > ACPI allows a device to be functional instead of maintaining the
> > present and enabled bit. Make this behaviour an explicit check with
> > a reference to the spec, and then check the present and enabled bits.
> > This is needed to avoid enumerating present && functional devices that
> > are not enabled.
> >
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> > If this change causes problems on deployed hardware, I suggest an
> > arch opt-in: ACPI_IGNORE_STA_ENABLED, that causes
> > acpi_dev_ready_for_enumeration() to only check the present bit.
>
> My gut feeling (having made ACPI 'fixes' in the past that ran into
> horribly broken firmware and had to be reverted) is reduce the blast
> radius preemptively from the start. I'd love to live in a world were
> that wasn't necessary but I don't trust all the generators of ACPI tables.
> I'll leave it to Rafael and other ACPI experts suggest how narrow we should
> make it though - arch opt in might be narrow enough.

A chicken bit wouldn't help much IMO, especially in the cases when
working setups get broken.

I would very much prefer to limit the scope of it, say to processors
only, in the first place.
