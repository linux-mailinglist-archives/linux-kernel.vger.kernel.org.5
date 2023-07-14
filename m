Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE85F754020
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbjGNRDc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jul 2023 13:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbjGNRDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:03:30 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5093510EA;
        Fri, 14 Jul 2023 10:03:29 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-94ea38c90ccso58901166b.1;
        Fri, 14 Jul 2023 10:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689354208; x=1691946208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+w920JXIkybPetWi046ZRPSw5JR8m5DRlgdvfm2InwE=;
        b=H0zynSgGU/bMGzV/Rh8XzKo/pCD/njfFU4id4Eb3kgjs5kPjYLzHYU9Iei7aAY9/2H
         nICoekjfUzlHTDG/vBvVb9EH5KbkfLlrd+/Y34FBPyMvONRcbekOBNvrKNRAEczw0jwv
         Lv0Rxijb8+uH/TizRt7BIg5aEnGD+ClnI8ivRbaCLtZvhGqJU+pVud7nMA7LBNsbP8LH
         yTv54FeYi/S8aEf9p+rcKc7nENAVumAyMMCLpi8nou9Pcl3J6K54ZuyZbjiIX29uAdE3
         W/onUSlOn6kjwMPLrxtoFt6izSgB/J6KoQqwshGF3mHwIdMAN+uNXKNxYCipLFil2tNY
         gsaw==
X-Gm-Message-State: ABy/qLZwrx1h3CJ0qH0VnAEK0buKI9Mhbn6XE3H7MCGucFX8wEuzGy3v
        wkOuGrN26fKN1inkGWAWPgwtOvQEkG14+F8z1pL2qjYG
X-Google-Smtp-Source: APBJJlFWCHKgeuKLMNl7eaHbz8gcf8jN858tJqH96sfgN3uW24NsbLp55ZfNoLGMu2IWNlOHM84r5nnzzB7FaGfF4vI=
X-Received: by 2002:a17:906:de:b0:993:d5e7:80f8 with SMTP id
 30-20020a17090600de00b00993d5e780f8mr4216969eji.7.1689354207604; Fri, 14 Jul
 2023 10:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230703080252.2899090-1-michal.wilczynski@intel.com>
In-Reply-To: <20230703080252.2899090-1-michal.wilczynski@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jul 2023 19:03:16 +0200
Message-ID: <CAJZ5v0gGoMOwWbEzMTkX3ShQU2_iq8fn6OwQ2GJu+YJ2Q=u9uw@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] Remove .notify callback in acpi_device_ops
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        lenb@kernel.org, dave.jiang@intel.com, ira.weiny@intel.com,
        rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 10:03 AM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> *** IMPORTANT ***
> This is part 1 - only drivers in acpi directory to ease up review
> process. Rest of the drivers will be handled in separate patchsets.
>
> Currently drivers support ACPI event handlers by defining .notify
> callback in acpi_device_ops. This solution is suboptimal as event
> handler installer installs intermediary function acpi_notify_device as a
> handler in every driver. Also this approach requires extra variable
> 'flags' for specifying event types that the driver want to subscribe to.
> Additionally this is a pre-work required to align acpi_driver with
> platform_driver and eventually replace acpi_driver with platform_driver.
>
> Remove .notify callback from the acpi_device_ops. Replace it with each
> driver installing and removing it's event handlers.
>
> This is part 1 - only drivers in acpi directory to ease up review
> process.
>
> v7:
>  - fix warning by declaring acpi_nfit_remove_notify_handler() as static
>
> v6:
>  - fixed unnecessary RCT in all drivers, as it's not a purpose of
>    this patch series
>  - changed error label names to simplify them
>  - dropped commit that remove a comma
>  - squashed commit moving code for nfit
>  - improved nfit driver to use devm instead of .remove()
>  - re-based as Rafael changes [1] are merged already
>
> v5:
>  - rebased on top of Rafael changes [1], they're not merged yet
>  - fixed rollback in multiple drivers so they don't leak resources on
>    failure
>  - made this part 1, meaning only drivers in acpi directory, rest of
>    the drivers will be handled in separate patchsets to ease up review
>
> v4:
>  - added one commit for previously missed driver sony-laptop,
>    refactored return statements, added NULL check for event installer
> v3:
>  - lkp still reported some failures for eeepc, fujitsu and
>    toshiba_bluetooth, fix those
> v2:
>  - fix compilation errors for drivers
>
> [1]: https://lore.kernel.org/linux-acpi/1847933.atdPhlSkOF@kreacher/
>
> Michal Wilczynski (9):
>   acpi/bus: Introduce wrappers for ACPICA event handler install/remove
>   acpi/bus: Set driver_data to NULL every time .add() fails
>   acpi/ac: Move handler installing logic to driver
>   acpi/video: Move handler installing logic to driver
>   acpi/battery: Move handler installing logic to driver
>   acpi/hed: Move handler installing logic to driver
>   acpi/nfit: Move handler installing logic to driver
>   acpi/nfit: Remove unnecessary .remove callback
>   acpi/thermal: Move handler installing logic to driver

Dan hasn't spoken up yet, but I went ahead and queued up the patches
(with some modifications) for 6.6.

I've edited the subjects and rewritten the changelogs and I've
adjusted some white space around function calls (nothing major).

Thanks!
