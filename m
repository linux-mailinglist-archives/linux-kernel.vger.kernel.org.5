Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C8D7DCDF7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344594AbjJaNga convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 Oct 2023 09:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344559AbjJaNg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:36:29 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C048EA;
        Tue, 31 Oct 2023 06:36:27 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-582050ce2d8so519718eaf.0;
        Tue, 31 Oct 2023 06:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698759386; x=1699364186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2DPIqLf9ppE5aYoET2sqf9FsTqUrjaMI7dfyLVVvGw=;
        b=hpvRc3rmA8HgHczB8eEkKytss1nVN//SQE6z5HUBTsJWh/CVbGXeCZhdBAEb549ag5
         /pnwdhXw32HybVfxlgXeIPLpCHC/WRBxCSdXI3csejP/woQM7WQ1tf5A6iVBvxKQqtfk
         rNb133R2ekCs0WICv/g/57PFGbORky1Y0ODr8v7VC39DBFTsV7Gs67wRolxPKTnglH26
         exp31X4oXWJXXwQNs5+d5/+GQyOccJsUMTxb0vdHY63drIMqfEV993svP2YDBCVGVdRO
         AAv5WRGG+11OqplQRXM9RL+zYObglYNoiosx4pe/KQ82HwACs1kih1NuF6z0NZvECThn
         iFAw==
X-Gm-Message-State: AOJu0YzGsn7cavGojbN1Mwhtjk9zgYfe+hKEpU1UiLewtluYQ+rPpF+o
        LSDtOJ/2TCxY5i20Is+Zms9dL05ZKnhhr88pVHo+Z98x
X-Google-Smtp-Source: AGHT+IHyWX7iQIrLlNrkTqu8Ropcb4uUFbHxDP3LQP3YU8t9Sdk1i+/KGWF/2sSew4NT5LYEqgAJmpQUTkuRQVblH8U=
X-Received: by 2002:a4a:4184:0:b0:57c:6e35:251e with SMTP id
 x126-20020a4a4184000000b0057c6e35251emr13200504ooa.1.1698759386437; Tue, 31
 Oct 2023 06:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <2187487.irdbgypaU6@kreacher> <3288922.44csPzL39Z@kreacher> <ZUC_OQwk_dwNYU_N@kekkonen.localdomain>
In-Reply-To: <ZUC_OQwk_dwNYU_N@kekkonen.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 31 Oct 2023 14:36:15 +0100
Message-ID: <CAJZ5v0gU10X67sa74gqmK9MHVi-uBFGjEGHRySXL5LwWUF5o9g@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] ACPI: scan: Extract CSI-2 connection graph from _CRS
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
>
> On Fri, Oct 20, 2023 at 04:36:28PM +0200, Rafael J. Wysocki wrote:
> > +#define NO_CSI2_PORT (UINT_MAX - 1)
> > +
> > +static void alloc_crs_csi2_swnodes(struct crs_csi2 *csi2)
> > +{
> > +     size_t port_count = csi2->port_count;
> > +     struct acpi_device_software_nodes *swnodes;
> > +     size_t alloc_size;
> > +     unsigned int i;
> > +
> > +     /*
> > +      * Allocate memory for ports, node pointers (number of nodes +
> > +      * 1 (guardian), nodes (root + number of ports * 2 (because for
> > +      * every port there is an endpoint)).
> > +      */
> > +     if (check_mul_overflow(sizeof(*swnodes->ports) +
> > +                            sizeof(*swnodes->nodes) * 2 +
> > +                            sizeof(*swnodes->nodeptrs) * 2,
> > +                            port_count, &alloc_size))
> > +             goto overflow;
> > +
> > +     if (check_add_overflow(sizeof(*swnodes) +
> > +                            sizeof(*swnodes->nodes) +
> > +                            sizeof(*swnodes->nodeptrs) * 2,
> > +                            alloc_size, &alloc_size))
> > +             goto overflow;
> > +
> > +     swnodes = kmalloc(alloc_size, GFP_KERNEL);
> > +     if (!swnodes)
> > +             return;
> > +
> > +     swnodes->ports = (struct acpi_device_software_node_port *)(swnodes + 1);
> > +     swnodes->nodes = (struct software_node *)(swnodes->ports + port_count);
> > +     swnodes->nodeptrs = (const struct software_node **)(swnodes->nodes + 1 +
> > +                             2 * port_count);
> > +     swnodes->num_ports = port_count;
> > +
> > +     for (i = 0; i < 2 * port_count + 1; i++)
> > +             swnodes->nodeptrs[i] = &swnodes->nodes[i];
> > +
> > +     swnodes->nodeptrs[i] = NULL;
> > +
> > +     for (i = 0; i < port_count; i++)
> > +             swnodes->ports[i].port_nr = NO_CSI2_PORT;
> > +
> > +     csi2->swnodes = swnodes;
> > +     return;
> > +
> > +overflow:
> > +     acpi_handle_info(csi2->handle, "too many _CRS CSI-2 resource handles (%zu)",
> > +                      port_count);
>
> I'd move this to where the conditions are, they can be merged.

No problem.
