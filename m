Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E21D7780D0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjHJSzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjHJSzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:55:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7B926A6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691693662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zv9/3cLqMAeB4uq6/TkSvmMHMvpcyjy9pzEKVaxNpOU=;
        b=gs/MS+Q1jqNFFPL5hJzbwlSZJzPgnhHUTQhHvwagFSirN+N/HQQwm17TFgA3wdbPj2hUj5
        6uVzUf1yf7CWTmFXMiGXgfwnNp5pneNPmv7J64md7fxxAXFJqwI1tz+NNO+OcEHV45/daX
        joeXWvktWNdva+oMeF8cSCdoNHwfl1M=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-TCWuLv45PyK9P8tva086tw-1; Thu, 10 Aug 2023 14:54:21 -0400
X-MC-Unique: TCWuLv45PyK9P8tva086tw-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-34916ad5387so9790755ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691693660; x=1692298460;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zv9/3cLqMAeB4uq6/TkSvmMHMvpcyjy9pzEKVaxNpOU=;
        b=BpgbTKLMb7Aavw8LI3w8ng2DIne2UPapZN8tUfUB0RHOhhag4Bart88aNWkow9dkQ4
         zdiRbpSHJ7YSCKE2j+aX0ofz/YiCkSZbLZvTE2e8bei27/HY+owQcZLIFPWn1wYHDe7g
         ZfBzmeTW14WMiIUKM4bwRhwiPTqk/5mYrtPO3fMiiYoZo1wwIhKdmCr6+rC59QWp787M
         X0fEU7ZaeuXfJXVk1ht+GDbGttKt4qXfDLa9Q4UaROY28kfFDmrCWVVJdwPxvNyqJF+f
         uz1rcJDqsZyycZjZ7y2LTVyyCgXT63FwjXmbgqnKHX8ppWoIwTxUUE5uB225ugle/129
         qFFw==
X-Gm-Message-State: AOJu0YyLxHsTKzeC94Brw5guGCkcZ5F1AX/0yVwIfXkFrxqBhFKh7jDY
        4T49Sf0MpLoUNFnMmvVLUo0hY53GP/lI4s8TPfD8EQLR0oLGBx0ouQ8YvBXW7IHqV8howng/lrX
        N1erz30TuGkSJmhhttYZDh8Dq
X-Received: by 2002:a92:c267:0:b0:348:987a:fd8c with SMTP id h7-20020a92c267000000b00348987afd8cmr4692731ild.31.1691693660272;
        Thu, 10 Aug 2023 11:54:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbzY2EqSYeWCF+5cvIbdopooLmvaujmOP2ItJ+AwCpOpnAa7Vrrm5j2RnnNp1QwbRNhfmW7w==
X-Received: by 2002:a92:c267:0:b0:348:987a:fd8c with SMTP id h7-20020a92c267000000b00348987afd8cmr4692708ild.31.1691693659980;
        Thu, 10 Aug 2023 11:54:19 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id v4-20020a92cd44000000b003426356a35asm618682ilq.0.2023.08.10.11.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 11:54:19 -0700 (PDT)
Date:   Thu, 10 Aug 2023 12:54:18 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.auger@redhat.com
Subject: Re: [PATCH v2 0/2] PCI: Protect VPD and PME accesses from power
 management
Message-ID: <20230810125418.7621e078.alex.williamson@redhat.com>
In-Reply-To: <20230810182944.GA37564@bhelgaas>
References: <20230803171233.3810944-1-alex.williamson@redhat.com>
        <20230810182944.GA37564@bhelgaas>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 13:29:44 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Thu, Aug 03, 2023 at 11:12:31AM -0600, Alex Williamson wrote:
> > Since v5.19, vfio-pci makes use of runtime power management on devices.
> > This has the effect of potentially putting entire sub-hierarchies into
> > lower power states, which has exposed some gaps in the PCI subsystem
> > around power management support.
> > 
> > The first issue is that lspci accesses the VPD sysfs interface, which
> > does not provide the same power management wrappers as general config
> > space.
> > 
> > The next covers PME, where we attempt to skip devices based on their PCI
> > power state, but don't protect changes to that state or look at the
> > overall runtime power management state of the device.
> > 
> > This latter patch addresses the issue noted by Eric in the follow-ups to
> > v1 linked below.
> > 
> > These patches are logically independent, but only together resolve an
> > issue on Eric's system where a pair of endpoints bound to vfio-pci and
> > unused by userspace drivers trigger faults through lspci and PME
> > polling.  Thanks,
> > 
> > Alex 
> > 
> > v1: https://lore.kernel.org/all/20230707151044.1311544-1-alex.williamson@redhat.com/
> > 
> > Alex Williamson (2):
> >   PCI/VPD: Add runtime power management to sysfs interface
> >   PCI: Fix runtime PM race with PME polling
> > 
> >  drivers/pci/pci.c | 23 ++++++++++++++++-------
> >  drivers/pci/vpd.c | 34 ++++++++++++++++++++++++++++++++--
> >  2 files changed, 48 insertions(+), 9 deletions(-)  
> 
> Applied with the tweak below to pci/vpd for v6.6, thanks!  The idea is
> to match the pci_get_func0_dev() so the get/put balance is clear
> without having to analyze PCI_DEV_FLAGS_VPD_REF_F0 usage:
> 
> -       if (dev != vpd_dev)
> +       if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0)
> 

Looks good, thanks!

Alex

