Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991F8775E43
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjHILzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjHILzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:55:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E9110FB;
        Wed,  9 Aug 2023 04:55:29 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bed101b70so956150666b.3;
        Wed, 09 Aug 2023 04:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1691582128; x=1692186928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mrc6cmkmGaChKSAYZ8Q3zXcccZpH6vRqxl3OlV6QCs0=;
        b=RKyeXaNQSjRs8/0e4puwBQr75AUjORRDOVLKRQUzAm5waSeOjA+h0dnNN5BASr7fNz
         LlGKbAjThmqciVysiNls/c+35MKi1IIGkpgZvH3RsXcWhBKQ7uOD51lpeP1nQXa7alOW
         P8uPUDq8VophelQAd5+xA+AF7EhXqSX0mPcSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691582128; x=1692186928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrc6cmkmGaChKSAYZ8Q3zXcccZpH6vRqxl3OlV6QCs0=;
        b=ZI9mU00KW50zpxMfnchLpFg3tCD8EKI4qCrl2aKjUTkZNcmC/+MVTV0/xdjB3JabcY
         IkjOG/YjaCJkrS+24tx8Bhx+PKzCUiepxLHIHrCfhTLC7WajA5cn7Zo3waOLueuaRIiW
         8Td2jC7cdJkL99NI7YS/ZZpUMXlw3/vr3R0Jlg1Eia6rsU6zXMPpHvue5EoAx+HuyFQU
         RLV1l7dlH0x5K27PZ6IN3oImDGigwShcrIJfujxn4x+ojXGFqldBkxmh4cfswu7ixOt2
         IYJwxSjkzLTxeRK12qDiNTMNrF3UIZlDd5JlpfcNSWDOSH3RCLcn4zxaS+dnj3XbbyFK
         nrsw==
X-Gm-Message-State: AOJu0YxaFUjM+6qdEyItSA5J/lN8dtiqbsK8o/DpoId02JHMUQEW9Ip0
        bCuedCJkG9VYa3xZrd6FwcDyQqONn2f7aVAfhUc=
X-Google-Smtp-Source: AGHT+IFivghoAwZc8kjVLEGpMxJBD8L+DFrQ1lXYr7vaaa6QvA5tlwYr4PErpIrO6GxXbxiyJssWA8XWiIPs0QfRLeI=
X-Received: by 2002:a17:907:7841:b0:99b:dd1d:bc58 with SMTP id
 lb1-20020a170907784100b0099bdd1dbc58mr1916571ejc.41.1691582128028; Wed, 09
 Aug 2023 04:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230612195657.245125-1-eajames@linux.ibm.com>
 <20230612195657.245125-12-eajames@linux.ibm.com> <CACPK8Xe1OmLtLrONZmqib6BhDyPHzj+HcOd15MXyK0QVHPTOEg@mail.gmail.com>
In-Reply-To: <CACPK8Xe1OmLtLrONZmqib6BhDyPHzj+HcOd15MXyK0QVHPTOEg@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 9 Aug 2023 11:55:15 +0000
Message-ID: <CACPK8XcAeiLRKZJi0ceekwVeDBX2EVw4kmMsvQWT3DfFpxJXng@mail.gmail.com>
Subject: Re: [PATCH 11/14] fsi: Improve master indexing
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jk@ozlabs.org, alistair@popple.id.au, andrew@aj.id.au,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED,URIBL_CSS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 at 07:08, Joel Stanley <joel@jms.id.au> wrote:
>
> On Mon, 12 Jun 2023 at 19:57, Eddie James <eajames@linux.ibm.com> wrote:
> >
> > Master indexing is problematic if a hub is rescanned while the
> > root master is being rescanned. Move the IDA free below the device
> > unregistration, lock the scan mutex in the probe function, and
> > request a specific idx in the hub driver.
>
> I've applied this series, but taking a closer look at this patch I
> think it can be improved. If you resend, just send this patch.

On hardware, it did this at FSI scan time:

 WARNING: CPU: 0 PID: 761 at /lib/idr.c:525 ida_free+0x140/0x154
 ida_free called for id=1 which is not allocated.
 CPU: 0 PID: 761 Comm: openpower-proc- Not tainted 6.1.34-d42f59e #1
 Hardware name: Generic DT based system
  unwind_backtrace from show_stack+0x18/0x1c
  show_stack from dump_stack_lvl+0x24/0x2c
  dump_stack_lvl from __warn+0x74/0xf0
  __warn from warn_slowpath_fmt+0x9c/0xd8
  warn_slowpath_fmt from ida_free+0x140/0x154
  ida_free from fsi_master_register+0xd0/0xf0
  fsi_master_register from hub_master_probe+0x11c/0x358
  hub_master_probe from really_probe+0xd4/0x3f0
  really_probe from driver_probe_device+0x38/0xd0
  driver_probe_device from __device_attach_driver+0xc8/0x148
  __device_attach_driver from bus_for_each_drv+0x90/0xdc
  bus_for_each_drv from __device_attach+0x114/0x1a4
  __device_attach from bus_probe_device+0x8c/0x94
  bus_probe_device from device_add+0x3a8/0x7fc
  device_add from fsi_master_scan+0x4e0/0x950
  fsi_master_scan from fsi_master_rescan+0x38/0x88
  fsi_master_rescan from master_rescan_store+0x14/0x20
  master_rescan_store from kernfs_fop_write_iter+0x114/0x200
  kernfs_fop_write_iter from vfs_write+0x1d0/0x374
  vfs_write from ksys_write+0x78/0x100
  ksys_write from ret_fast_syscall+0x0/0x54
 Exception stack(0x9fc51fa8 to 0x9fc51ff0)
 1fa0:                   00000001 01a01c78 00000003 01a01c78 00000001 00000001
 1fc0: 00000001 01a01c78 00000001 00000004 7eeb4ab0 7eeb4b3c 7eeb4ab4 7eeb499c
 1fe0: 76985abc 7eeb4928 76848af8 766f176c


>
> >
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > ---
> >  drivers/fsi/fsi-core.c       | 41 ++++++++++++++++++++++--------------
> >  drivers/fsi/fsi-master-hub.c |  2 ++
> >  2 files changed, 27 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> > index ec4d02264391..503061a6740b 100644
> > --- a/drivers/fsi/fsi-core.c
> > +++ b/drivers/fsi/fsi-core.c
> > @@ -1327,46 +1327,55 @@ static struct class fsi_master_class = {
> >  int fsi_master_register(struct fsi_master *master)
> >  {
> >         int rc;
> > -       struct device_node *np;
> >
> >         mutex_init(&master->scan_lock);
> > -       master->idx = ida_alloc(&master_ida, GFP_KERNEL);
> > +
> > +       if (master->idx) {
>
> Why do we allocate a new idx if there's already one?
>
> > +               master->idx = ida_alloc_range(&master_ida, master->idx,
> > +                                             master->idx, GFP_KERNEL);
>
> If we can't get one in the range we want, we ask for any? Should this
> print a warning?
>
> > +               if (master->idx < 0)
> > +                       master->idx = ida_alloc(&master_ida, GFP_KERNEL);
> > +       } else {
>
> If ixd was zero, we create one. This is the "normal" case?
>
> > +               master->idx = ida_alloc(&master_ida, GFP_KERNEL);
> > +       }
> > +
>
> We check the same error condition again.
>
> >         if (master->idx < 0)
> >                 return master->idx;
>
> >
> > -       dev_set_name(&master->dev, "fsi%d", master->idx);
> > +       if (!dev_name(&master->dev))
> > +               dev_set_name(&master->dev, "fsi%d", master->idx);
> > +
> >         master->dev.class = &fsi_master_class;
> >
> > +       mutex_lock(&master->scan_lock);
> >         rc = device_register(&master->dev);
> >         if (rc) {
> >                 ida_free(&master_ida, master->idx);
> > -               return rc;
> > -       }
> > +       } else {
> > +               struct device_node *np = dev_of_node(&master->dev);
>
> This change looks a bit different to the idx changes. What's happening here?
> >
> > -       np = dev_of_node(&master->dev);
> > -       if (!of_property_read_bool(np, "no-scan-on-init")) {
> > -               mutex_lock(&master->scan_lock);
> > -               fsi_master_scan(master);
> > -               mutex_unlock(&master->scan_lock);
> > +               if (!of_property_read_bool(np, "no-scan-on-init"))
> > +                       fsi_master_scan(master);
> >         }
> >
> > -       return 0;
> > +       mutex_unlock(&master->scan_lock);
> > +       return rc;
> >  }
> >  EXPORT_SYMBOL_GPL(fsi_master_register);
> >
> >  void fsi_master_unregister(struct fsi_master *master)
> >  {
> > -       trace_fsi_master_unregister(master);
> > +       int idx = master->idx;
> >
> > -       if (master->idx >= 0) {
> > -               ida_free(&master_ida, master->idx);
> > -               master->idx = -1;
> > -       }
> > +       trace_fsi_master_unregister(master);
> >
> >         mutex_lock(&master->scan_lock);
> >         fsi_master_unscan(master);
> > +       master->n_links = 0;
> >         mutex_unlock(&master->scan_lock);
> > +
> >         device_unregister(&master->dev);
> > +       ida_free(&master_ida, idx);
> >  }
> >  EXPORT_SYMBOL_GPL(fsi_master_unregister);
> >
> > diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
> > index 6d8b6e8854e5..36da643b3201 100644
> > --- a/drivers/fsi/fsi-master-hub.c
> > +++ b/drivers/fsi/fsi-master-hub.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/slab.h>
> >
> >  #include "fsi-master.h"
> > +#include "fsi-slave.h"
> >
> >  #define FSI_ENGID_HUB_MASTER           0x1c
> >
> > @@ -229,6 +230,7 @@ static int hub_master_probe(struct device *dev)
> >         hub->master.dev.release = hub_master_release;
> >         hub->master.dev.of_node = of_node_get(dev_of_node(dev));
> >
> > +       hub->master.idx = fsi_dev->slave->link + 1;
> >         hub->master.n_links = links;
> >         hub->master.read = hub_master_read;
> >         hub->master.write = hub_master_write;
> > --
> > 2.31.1
> >
