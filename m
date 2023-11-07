Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3B87E4991
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbjKGUGp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Nov 2023 15:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbjKGUGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:06:43 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D84D128;
        Tue,  7 Nov 2023 12:06:41 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6d3099818c0so1055720a34.1;
        Tue, 07 Nov 2023 12:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699387600; x=1699992400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZw5tqmxq7VgnYfY6zL2IsaNDalLmKPoaBBV7NkvLCM=;
        b=JxLsHBMRJlenu6+LIYnn63SKU6V+ONtnHcQfQJOinUM83Is2NB7Ltcmk5h6QHH7iDA
         E4AInXiUlltepbMMoGajXWC3sBJRe5XxULKleZnlgdMV7I9DAMf1FCi4Wxa4WgsCMtUB
         1TVwXVSqECw5J4TigwykZUOafTL3WPYFBuotqLOK/nnNvmAtxnUofIzs5etZG/X29UBY
         VCMuTAD+kWZ/rbtWbBuvUR1wU2NmECSayMY7WnJiu+zjZqDcX99qKWR5ExTAirTf/B4X
         KjvAkwr4aS5qmdVlvUn84TGCJMeckhdLWMotR3lWXD7FygcgWEUUCwkmfar4KJrWC5VW
         PHkQ==
X-Gm-Message-State: AOJu0YyuhEurB5pwSuHqrg1Ec34vb1ZCKoxXloRSAyspHXxjRvK0/+Ub
        QAJ5sWYJe0bLlO/XN+Jdqnugz1M3BVZFfH+IwNPAWKiD
X-Google-Smtp-Source: AGHT+IG723ltJ7FYoddM4b61QT2grhVaN+CNQgLOdxY2AZIeolK3Np3Yjeba3Ln5G0oKERTLHpMLls0cSFiHHf8u+N0=
X-Received: by 2002:a4a:3454:0:b0:583:ec88:e0 with SMTP id n20-20020a4a3454000000b00583ec8800e0mr204761oof.0.1699387600642;
 Tue, 07 Nov 2023 12:06:40 -0800 (PST)
MIME-Version: 1.0
References: <4542595.LvFx2qVVIh@kreacher> <1987710.usQuhbGJ8B@kreacher> <ZUlfuWB9z1tlOGG7@kekkonen.localdomain>
In-Reply-To: <ZUlfuWB9z1tlOGG7@kekkonen.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Nov 2023 21:06:29 +0100
Message-ID: <CAJZ5v0hYDNaL3ydry12UWj6wLyTEfMSA0VGcZdQo00h+wexpNg@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] ACPI: scan: Extract MIPI DisCo for Imaging data
 into swnodes
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Mon, Nov 6, 2023 at 11:33 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Mon, Nov 06, 2023 at 05:27:26PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH] ACPI: scan: Extract MIPI DisCo for Imaging data into swnodes
> >
> > Add information extracted from the MIPI DisCo for Imaging device
> > properties to software nodes created during the CSI-2 connection graph
> > discovery.
> >
> > Link: https://www.mipi.org/specifications/mipi-disco-imaging
> > Co-developed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v2 -> v3:
> >    * Change the name of the new file to mipi-disco-img.c
> >    * "DiSco" -> "DisCo" in multiple places
> >    * Fix the link in the Link: tag
> >    * Change the number of data lanes limit and add a comment regarding it
> >    * Use ACPI_DEVICE_CSI2_DATA_LANES directly in several places instead
> >      of array sizes equal to it
>
> Thanks for the update. I've tested the set, so you can add:
>
> Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> with the following diff fixing mipi-img-lane-polarities parsing:
>
> diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
> index 3123180d9b54..92b45e792a07 100644
> --- a/drivers/acpi/mipi-disco-img.c
> +++ b/drivers/acpi/mipi-disco-img.c
> @@ -530,7 +530,12 @@ static void init_csi2_port(struct acpi_device *adev,
>         }
>
>         ret = fwnode_property_count_u8(port_fwnode, "mipi-img-lane-polarities");
> -       if (ret * BITS_PER_TYPE(u8) >= num_lanes + 1) {
> +       if (ret < 0) {
> +               acpi_handle_debug(handle, "Lane polarity bytes missing\n");
> +       } else if (ret * BITS_PER_TYPE(u8) < num_lanes + 1) {
> +               acpi_handle_info(handle, "Too few lane polarity bytes (%lu vs. %d)\n",
> +                                ret * BITS_PER_TYPE(u8), num_lanes + 1);
> +       } else {
>                 unsigned long mask = 0;
>                 int byte_count = ret;
>                 unsigned int i;
> @@ -543,15 +548,15 @@ static void init_csi2_port(struct acpi_device *adev,
>                  */
>                 BUILD_BUG_ON(BITS_PER_TYPE(unsigned long) <= ACPI_DEVICE_CSI2_DATA_LANES);
>
> -               if (byte_count > ACPI_DEVICE_CSI2_DATA_LANES) {
> +               if (byte_count > sizeof(mask)) {
>                         acpi_handle_info(handle, "Too many lane polarities: %d\n",
>                                          byte_count);
> -                       byte_count = ACPI_DEVICE_CSI2_DATA_LANES;
> +                       byte_count = sizeof(mask);
>                 }
>                 fwnode_property_read_u8_array(port_fwnode, "mipi-img-lane-polarities",
>                                               val, byte_count);
>
> -               for (i = 0; BITS_PER_TYPE(u8) * i <= num_lanes; i++)
> +               for (i = 0; i < byte_count; i++)
>                         mask |= (unsigned long)val[i] << BITS_PER_TYPE(u8) * i;
>
>                 for (i = 0; i <= num_lanes; i++)
> @@ -561,8 +566,6 @@ static void init_csi2_port(struct acpi_device *adev,
>                                 PROPERTY_ENTRY_U32_ARRAY_LEN("lane-polarities",
>                                                              port->lane_polarities,
>                                                              num_lanes + 1);
> -       } else {
> -               acpi_handle_info(handle, "Lane polarity bytes missing\n");
>         }
>
>         swnodes->nodes[ACPI_DEVICE_SWNODE_EP(port_index)] =
>
> --

Thanks for testing and the fix!

I have folded it into the original patch and sent an update.

Also I have updated the git branch by replacing the original commit
with the updated one and I've added the Tested-by: tag to the commits
in it.

Thank you!
