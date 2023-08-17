Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0B577FCFA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353975AbjHQR0F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Aug 2023 13:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353985AbjHQRZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:25:42 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAFEEE;
        Thu, 17 Aug 2023 10:25:33 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-56d75fb64a6so18721eaf.0;
        Thu, 17 Aug 2023 10:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692293133; x=1692897933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A36LRx4XTTz3n4cTZbeogTMejC4BF62bm081VCkHowc=;
        b=PWX4741Rnd5kVTy8C8qMSjmzAexpruMeus3dncsnmc4DYlsaSPuSssj/kEY7GFpYlf
         H3jEJZCVC0lBjBSKBlOLGxDVm7Mhs/peT3PvjBHXoBqIGG5rbKGKnG25Xuyqu/2KAi3U
         U2CkLJONaQ7Cbv2rvZBJESUC5xW5p11t8XtxD+87LUTWX3SkvjO8bFXlFrS+urXaeRrV
         1plNWQVBRLL5yYmxLjN/cQxjNl4lJdeQ95LHSidqkzw1Ghou4oh5fyBb4KhTNVL8lubF
         Fc1g2ciFvJBgm6L7Y2QyXYgdYKmyl3gsxvmKbhIRmj6kbi/D+cKUPO22MJe0UHt3gLM8
         L/ZA==
X-Gm-Message-State: AOJu0Ywiypcioxi7xXOLwi7XsRbUbXehs8giRUhmU/7VbovRt2GOOw0O
        Itt3iVc4LkZX4oN7AAVVykmCpK3kItb8AZhitPk=
X-Google-Smtp-Source: AGHT+IGOV0JcHjjD61B6Pdd/EW6EyK8QOLONrs11HFvXUA1F5+YJFT0lvK/tnktA3hzr6nD5Pm2ZUkWthnK0HLU/kfA=
X-Received: by 2002:a4a:eb1a:0:b0:560:b01a:653d with SMTP id
 f26-20020a4aeb1a000000b00560b01a653dmr475257ooj.0.1692293133055; Thu, 17 Aug
 2023 10:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230721152143.3108017-1-kai.heng.feng@canonical.com>
 <CAJZ5v0j=ohJ_oUpCY-F_joty9qq3Mz2Bigqa3dHaFaWP2k6ONQ@mail.gmail.com> <8d71e258-0bfd-a0d0-868f-a3299864de5b@redhat.com>
In-Reply-To: <8d71e258-0bfd-a0d0-868f-a3299864de5b@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Aug 2023 19:25:22 +0200
Message-ID: <CAJZ5v0gQGM91XW4AyL1qxGedBZaYJj6UXpVyRJwMossYny9N5g@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: video: Put ACPI video and its child devices to
 D0 at boot
To:     Hans de Goede <hdegoede@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 10:39 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 7/21/23 17:45, Rafael J. Wysocki wrote:
> > Thanks for the update!
> >
> > On Fri, Jul 21, 2023 at 5:22 PM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> >>
> >> Screen brightness can only be changed once on HP ZBook Fury 16 G10.
> >>
> >> Vendor identified the root cause as Linux doesn't invoke _PS0 at boot
> >> for all ACPI devices:
> >>
> >>     Scope (\_SB.PC00.GFX0)
> >>     {
> >>         Scope (DD1F)
> >>         {
> >>             Method (_PS0, 0, Serialized)  // _PS0: Power State 0
> >>             {
> >>                 If (CondRefOf (\_SB.PC00.LPCB.EC0.SSBC))
> >>                 {
> >>                     \_SB.PC00.LPCB.EC0.SSBC ()
> >>                 }
> >>             }
> >>             ...
> >>         }
> >>         ...
> >>     }
> >>
> >> The \_SB.PC00.GFX0.DD1F is the panel device, and its _PS0 needs to be
> >> executed to make the brightness control work properly.
> >>
> >> _PS0 doesn't get invoked for this device because _PSC is missing,
> >> which violates ACPI spec 6.3, section 7.3.6. Commit 7cd8407d53ef
> >> ("ACPI / PM: Do not execute _PS0 for devices without _PSC during
> >> initialization") tried to workaround missing _PSC on defective
> >> firmwares, but got reverted because of regression.
> >>
> >> So the safest approach is to use acpi_device_fix_up_power_extended() to
> >> put ACPI video and its child devices to D0 to workaround the issue.
> >>
> >> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217683
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >
> > Hans, what do you think?
>
> I believe most (almost all?) child devices of the GFX0 (and other
> acpi-video) ACPI device will not have a _PS0. So wrt child-devices
> this should mostly be a no-op.
>
> However the GFX0 ACPI device is the ACPI companion for the PCI
> device for the GPU, so this will also execute _PS0 on the GPU,
> we do that every suspend/resume cycle so this should be fine.
>
> But if we do see regressions then we may need to rework this
> to skip the _PS0 on the GPU itself.
>
> With that caveat this looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

So I've edited the subject (slightly) and the changelog of this patch
and applied it as 6.6 material, thanks!
