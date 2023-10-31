Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D527DCDB6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344527AbjJaNVp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 Oct 2023 09:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344449AbjJaNVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:21:44 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FACFDE;
        Tue, 31 Oct 2023 06:21:42 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5872c652a66so21147eaf.1;
        Tue, 31 Oct 2023 06:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698758501; x=1699363301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+r90o1CDouOKGHO6NRz2WLKIow4NkDrRiEkM6bVHFk=;
        b=Pz8rljtPlNL1V5GEtuv9BAqT24kpYwiPWjWclKMJ+BfXB6dprAJwUW+b4YNgZB+lLo
         sroGUoZg3ncgahm3JXBMr0TAtpsxL+SOoI6K0pUnZilOAX2ZTNkwsEtSmvDPqQgcc7Lm
         t9hxgBXEYjpE+wSgEe1bwwSYUsbctkBKKJUftyK7nhcU4UNINpDe57a/V3dV3brq9Usa
         FJkZvU2knUcFglT+k/VjTmmTk/+WaGwx6SHqwF/rzQmzrf9nhtWoLwcX4LG4Q8UJKInx
         XDtKuz7j5Ae21snYsKQQ0JNLvRmGRcLTI7sIAz64/6PSxthlL04OQIvV9XC6seOHDcbZ
         fPZA==
X-Gm-Message-State: AOJu0YyiENe3QbdnbYOaj0sl5SU/3GdKyhENshx+HypeFw/9hDpvH3GR
        EtabAZowmbsSXMflygd6ZPWXGY3okhidqpjcbOt4mIhh
X-Google-Smtp-Source: AGHT+IFtpOgXt3r7OSc5ucl8PMFuCYIhDhsFhXiCDEBbIiin6akd/2vmNz/H7/JvsovKs6MDlIKjFbiZH5tMqwbO8Vo=
X-Received: by 2002:a4a:dbd8:0:b0:583:ec88:e0 with SMTP id t24-20020a4adbd8000000b00583ec8800e0mr13645973oou.0.1698758501536;
 Tue, 31 Oct 2023 06:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <2187487.irdbgypaU6@kreacher> <ZUC-qvk_c3SXIhHC@kekkonen.localdomain>
In-Reply-To: <ZUC-qvk_c3SXIhHC@kekkonen.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 31 Oct 2023 14:21:30 +0100
Message-ID: <CAJZ5v0jteOR-tY91qUsXUmWvxWYCavUBBxa=zc_a2hN+Udn7pQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] ACPI: scan: MIPI DiSco for Imaging support
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Hi Sakari,

On Tue, Oct 31, 2023 at 11:33 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,

[cut]

> > The v2 addresses at least 3 issues found in the v1 by code inspection:
> >
> > * A port_count field incrementation was missing in acpi_mipi_scan_crs_csi2(),
> >   so its value for all of the devices having CSI2 resources in _CRS was always
> >   1 (and it should be equal to the number of valid CSI2 connection resources).
> >
> > * Some acpi_mipi_crs_csi2_list members could be freed prematurely, so they were
> >   inaccessible when extract_crs_csi2_conn_info() attempted to access them.
> >
> > * A check of remote_swnodes() against NULL was missing, which could result in
> >   a crash in a case when the swnodes memory could not be allocated for some
> >   acpi_mipi_crs_csi2_list entries.
> >
> > Apart from that, it rearranges the code somewhat to make it easier to follow
> > and to avoid premature freeing of memory in it in general and the new file
> > added by it is now called mipi-di.c (instead of mipi-disco-imaging.c) for
> > compactness.
> >
> > The series is based on current linux-next.
>
> Thanks for the update. I've tested this and I can confirm it works, to the
> extent implemented in the set. The rest can be implemented on top
> (mainly replicating properties).

Thanks for testing!

> I'll comment on a few patches in the set.
>
> Do you prefer to make the changes or shall I? I presume them to be fairly
> minor.

I can make the changes.
