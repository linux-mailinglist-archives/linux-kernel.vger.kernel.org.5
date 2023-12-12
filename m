Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDC480F770
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376781AbjLLUFY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 15:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjLLUFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:05:20 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C201AF;
        Tue, 12 Dec 2023 12:05:26 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5907b9c3fd6so533792eaf.0;
        Tue, 12 Dec 2023 12:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702411525; x=1703016325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BOtCilKMUNbBasgq0UMjLFqZa8aCDvdPUV0gfbYhOc=;
        b=sVUXX4IxtcwSB5JASMrBQk41fA6hU8d6vJjrJaMjfDUalK6IIKDBO5evbIbulOYgJ6
         7lIch6sZnUkZmcfmOgvq/4DwqHLxcHT52VQOx7q0uXFYADlxGqfuv47bFGIoSPRwKrGF
         zWW8iVQOUnTn5N8mUYTG6866YHG5be/VCYejuXJ2zFufPZile5qZvfnzEwiEHp7KtzUh
         JiW1oaTMRNoPMhYOFvGdEkY+VKh/xvFRBfmgP5mC/z0k+D/nHhDEGzfM66rQ1a9NCPUg
         O+kh82HzDbAeE6jH4z9VhBooVOliu3L4JA/kgHPwLF+2ndsIAWWWSfO3YoU7o9P5jUnM
         sAeg==
X-Gm-Message-State: AOJu0YwLcLwa0cCT7iEzeA9QsU/kIcRm6KwBQ6LlWQGQi6/U1vMQmpQD
        VVB7nQwJHpZzajXux2+msNTc/BZ5y5LRyNbUYNs=
X-Google-Smtp-Source: AGHT+IG/zOKPoXX+KUgHRd1YwPymLrSadLIsRID5FYaIOT9/r8DyzvG7YUYiYl28l7KFo0FotJK25IwKa9Ys4XqQUjg=
X-Received: by 2002:a05:6820:220d:b0:58d:5302:5b18 with SMTP id
 cj13-20020a056820220d00b0058d53025b18mr13982416oob.1.1702411525380; Tue, 12
 Dec 2023 12:05:25 -0800 (PST)
MIME-Version: 1.0
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk> <CAJZ5v0j-73_+9U3ngDAf9w1ADDhBTKctJdWboqUk-okH2TQGyg@mail.gmail.com>
 <ZW4ZBkj2oCmxv55T@shell.armlinux.org.uk> <ZXi7do4mVfdsz/k0@shell.armlinux.org.uk>
In-Reply-To: <ZXi7do4mVfdsz/k0@shell.armlinux.org.uk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Dec 2023 21:05:14 +0100
Message-ID: <CAJZ5v0jOU4Re2g5QtxpG0RjP3MYBxqz5Z+TtfXq2dz8HTq9A0A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/39] ACPI/arm64: add support for virtual cpuhotplug
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 8:58 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Dec 04, 2023 at 06:23:02PM +0000, Russell King (Oracle) wrote:
> > On Tue, Oct 24, 2023 at 08:26:58PM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Oct 24, 2023 at 5:15 PM Russell King (Oracle)
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I'm posting James' patch set updated with most of the review comments
> > > > from his RFC v2 series back in September. Individual patches have a
> > > > changelog attached at the bottom of the commit message. Those which
> > > > I have finished updating have my S-o-b on them, those which still have
> > > > outstanding review comments from RFC v2 do not. In some of these cases
> > > > I've asked questions and am waiting for responses.
> > > >
> > > > I'm posting this as RFC v3 because there's still some unaddressed
> > > > comments and it's clearly not ready for merging. Even if it was ready
> > > > to be merged, it is too late in this development cycle to be taking
> > > > this change in, so there would be little point posting it non-RFC.
> > > > Also James stated that he's waiting for confirmation from the
> > > > Kubernetes/Kata folk - I have no idea what the status is there.
> > > >
> > > > I will be sending each patch individually to a wider audience
> > > > appropriate for that patch - apologies to those missing out on this
> > > > cover message. I have added more mailing lists to the series with the
> > > > exception of the acpica list in a hope of this cover message also
> > > > reaching those folk.
> > > >
> > > > The changes that aren't included are:
> > > >
> > > > 1. Updates for my patch that was merged via Thomas (thanks!):
> > > >    c4dd854f740c cpu-hotplug: Provide prototypes for arch CPU registration
> > > >    rather than having this change spread through James' patches.
> > > >
> > > > 2. New patch - simplification of PA-RISC's smp_prepare_boot_cpu()
> > > >
> > > > 3. Moved "ACPI: Use the acpi_device_is_present() helper in more places"
> > > >    and "ACPI: Rename acpi_scan_device_not_present() to be about
> > > >    enumeration" to the beginning of the series - these two patches are
> > > >    already queued up for merging into 6.7.
> > > >
> > > > 4. Moved "arm64, irqchip/gic-v3, ACPI: Move MADT GICC enabled check into
> > > >    a helper" to the beginning of the series, which has been submitted,
> > > >    but as yet the fate of that posting isn't known.
> > > >
> > > > The first four patches in this series are provided for completness only.
> > > >
> > > > There is an additional patch in James' git tree that isn't in the set
> > > > of patches that James posted: "ACPI: processor: Only call
> > > > arch_unregister_cpu() if HOTPLUG_CPU is selected" which looks to me to
> > > > be a workaround for arch_unregister_cpu() being under the ifdef. I've
> > > > commented on this on the RFC v2 posting making a suggestion, but as yet
> > > > haven't had any response.
> > > >
> > > > I've included almost all of James' original covering body below the
> > > > diffstat.
> > > >
> > > > The reason that I'm doing this is to help move this code forward so
> > > > hopefully it can be merged - which is why I have been keen to dig out
> > > > from James' patches anything that can be merged and submit it
> > > > separately, since this is a feature for which some users have a
> > > > definite need for.
> > >
> > > I've gone through the series and there is at least one thing in it
> > > that concerns me a lot and some others that at least appear to be
> > > really questionable.
> > >
> > > I need more time to send comments which I'm not going to do before the
> > > 6.7 merge window (sorry), but from what I can say right now, this is
> > > not looking good.
> >
> > Hi Rafael,
> >
> > Will you be able to send your comments, so that we can find out what
> > your other concerns are please? I'm getting questions from interested
> > parties who want to know what your concerns are.
> >
> > Nothing much has changed to the ACPI changes, so I think it's still
> > valid to have the comments back for this.
>
> Hi Rafael,
>
> Another gentle prod on this...

There was a selection of the patches in the series sent separately and
I believe that some of them have been applied already.

Can you please send the remaining patches again so it is clear what's
still outstanding?
