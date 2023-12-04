Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E561F803A54
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344706AbjLDQcs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 11:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjLDQcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:32:47 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25CE99;
        Mon,  4 Dec 2023 08:32:53 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6d7ea8b4581so492351a34.1;
        Mon, 04 Dec 2023 08:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701707573; x=1702312373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yn4pD1gA2GtmA9HlH0C0U9ulVAJ/43nKIwnaRGSr6IQ=;
        b=V75jmcQJiNVacjtVlHzbh9Q8YhtAXXD0Z3B1ez9f4FXhu+XOsKGi1OFAY5GMUSAoO7
         69BryOzOR+M2N28knJj9y8xOlHNl4/wcXkBj0iXu31SXiqjwQb+yt4NaMwESqD8XC6pX
         yf6C7SohNyo+Ig1H5+kz39Qr5VcmvKWbvfAtvXDagkyjxKM5egrCbVckQ0jYbDq08SZX
         pxyktez0P7fvY55LwNYntRcly3Vy0cwojQFJRJ9F1Fjfrfici9lJuLnnrrsOVkGK3+qh
         KYTUZKacTGOa3DKpfIWiSWqkiJgd9YT5p6sgJ6Sh8pcDDyP1ikQ2tYdM6wPDuxhOk0b2
         LBwg==
X-Gm-Message-State: AOJu0Yxwvro5KyJU4FVW4B9TTsr38xmx6V0MGMNp9Upa8RHUAHCxZs9c
        ZojFvUCyOOIwe0rspUWP1ImX1eB+wHfidwt9mlg=
X-Google-Smtp-Source: AGHT+IG6HzJNK+5zbjAVWt3hnnTgEX1LXL/Hj5C1l5v8CgJzaA0RFK6zejwqjK5B0wbjpLqeH/kjVGFBKb900kCTFBI=
X-Received: by 2002:a05:6871:528a:b0:1fa:f404:b958 with SMTP id
 hu10-20020a056871528a00b001faf404b958mr12686542oac.3.1701707572969; Mon, 04
 Dec 2023 08:32:52 -0800 (PST)
MIME-Version: 1.0
References: <3281896.aeNJFYEL58@kreacher> <61ef73e6-e633-47e1-b599-ee66aa179227@redhat.com>
In-Reply-To: <61ef73e6-e633-47e1-b599-ee66aa179227@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Dec 2023 17:32:41 +0100
Message-ID: <CAJZ5v0j1fHebN0w0oYFv0CapkF1XvQ-0xWtQtuLtx0So50hzsw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] ACPI: OSL: acpi_os_execute() improvements
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
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

Hi Hans,

On Sat, Dec 2, 2023 at 3:31 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 11/29/23 14:45, Rafael J. Wysocki wrote:
> > Hi Everyone,
> >
> > This series improves acpi_os_execute() on top of
> >
> > https://patchwork.kernel.org/project/linux-acpi/patch/5745568.DvuYhMxLoT@kreacher/
> >
> > but only the last patch really depends on it.
> >
> > The first two patches clean up the code somewhat and the third one modifies
> > the function to allow Notify () handlers to run on all CPUs (not on CPU0 only).
> >
> > The last patch changes it to use GFP_KERNEL for memory allocations, as it does
> > not run in interrupt context any more after the change linked above.
>
> I have added this series, as well as the preceding
> "ACPI: OSL: Use a threaded interrupt handler for SCI"
> patch to my personal tree now, so that it will get tested on various
> devices when I run my personal tree on them.
>
> I'll let you know if I hit any issues caused by this series.

As stated here

https://lore.kernel.org/linux-acpi/CAJZ5v0jkHLGa2XxB4TMqzrBBdZYXY79+sh1Z0ZF6keYdLDyfkg@mail.gmail.com/

the last patch in this series is not really a good idea just yet, so
please drop it.

Thanks!
