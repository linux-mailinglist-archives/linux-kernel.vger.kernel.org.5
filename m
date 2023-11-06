Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6787E2A3D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjKFQrp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Nov 2023 11:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjKFQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:47:44 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC7BD7B;
        Mon,  6 Nov 2023 08:47:40 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-587310758ccso303237eaf.0;
        Mon, 06 Nov 2023 08:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699289259; x=1699894059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuXeInvy8TGXX3AV6oVtebaCgSp6dmA0Oof7bIAl6Ow=;
        b=wJ4Ne2y4HDst2CUpJCPmZ1tngNRQgktAq78iiWorfV5SabAarOQGGbeTCjRPukROR5
         dRJeIk5AZIhPNE8aUURFLS9DrVtwlYEWcMLTZGyRe72+1lG+SetKUPW0uE5MWPL/TU4v
         Cv7Urx0uyxE1IsuWg+NkGclq137WYS/D/NC8Lox2f1ju1MsLjK27Ib+fmAqGia1f6VTm
         jcUYZEcuUmcGAOx+0UpgUBmPfGATgdfxWa6UGtZ2po/dMPUq6Zp8U8/FEWsvfkii4K6c
         dIX+cjrzmKaJHeFmgq3+1Dk/0nmTOf/VlGsTY4rVxhUc208t82/Dr9dIvIHOhUe5Sn6l
         Kg+w==
X-Gm-Message-State: AOJu0Yw1Np+ESXPtS+wK5Hb8lQwBU9Zq4v6ZLfReIws0xdUUYaKMzPts
        7cWLSOdCTwdnhYGSoAtGz+UWaG+l7mPMz6ygxEDVEDdp
X-Google-Smtp-Source: AGHT+IE2Y7/J4aSKcPe3LhkLglxB7LdL3VoxnA1zaMlJTPUdA5T3jSswFF0VEcy3NJAL/YNF3E1/Pv8b1XF/xwW30/g=
X-Received: by 2002:a05:6820:1899:b0:581:e7b8:dd77 with SMTP id
 bm25-20020a056820189900b00581e7b8dd77mr33946399oob.1.1699289259115; Mon, 06
 Nov 2023 08:47:39 -0800 (PST)
MIME-Version: 1.0
References: <4542595.LvFx2qVVIh@kreacher>
In-Reply-To: <4542595.LvFx2qVVIh@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Nov 2023 17:47:28 +0100
Message-ID: <CAJZ5v0isSbMdOC2V24m2CNaxNtu83DfRbCeX66Mkm9W9dtz1VQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] ACPI: scan: MIPI DisCo for Imaging support
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 5:34 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi Folks,
>
> This is a new revision of
>
> https://lore.kernel.org/linux-acpi/2187487.irdbgypaU6@kreacher/
>
> addressing comments from Sakari and adding one more patch (also from
> Sakari).
>
> The main points from the original cover letter are still valid:
>
> > The general idea is the same - CSI-2 resource descriptors, introduced in
> > ACPI 6.4 and defined by
> >
> > https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#camera-serial-i
> > nterface-csi-2-connection-resource-descriptor
> >
> > are found and used for creating a set of software nodes that represent the
> > CSI-2 connection graph.
> >
> > These software nodes need to be available before any scan handlers or ACPI
> > drivers are bound to any struct acpi_device objects, so all of that is done
> > at the early stage of ACPI device enumeration, but unnecessary ACPI
> > namespace walks are avoided.
> >
> > The CSI-2 software nodes are populated with data extracted from the CSI-2
> > resource descriptors themselves and from device properties defined by the
> > MIPI DisCo for Imaging specification (see
> > https://www.mipi.org/specifications/mipi-disco-imaging).
> >
> > Patches [4,6/6] come from the original series directly, but the other
> > patches have been changes substantially, so I've decided to re-start patch
> > series versioning from scratch.
>
> The series is based on the current mainline.

And now it is available in the acpi-mipi-disco-img branch of
linux-pm.git, for easier access.

Thanks!
