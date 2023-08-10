Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE340777E37
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbjHJQ1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbjHJQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:27:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653802133
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691684810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=acHZo3S8mxknkeKry3g5QD8BVmAzgZ4je+m7mvgsQl0=;
        b=SDPoLUTVJRTIDyDOimKCrof00yX/1hn+UxDnDKkUPu1/e5NjHwXssKa7DuK4H8y9tlv45P
        f/gn6FZybGgOnJnqljFxJgnVDD0CA0rU+FuFjTMUO8IuVJm3WL9JoUuO5ptKLYB1VpQftF
        GFvoADgEkRzi5c96m3C86U1xm8XpShE=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-k1a-z1hiMHayRMvCqr-ksw-1; Thu, 10 Aug 2023 12:26:49 -0400
X-MC-Unique: k1a-z1hiMHayRMvCqr-ksw-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-34996089076so3514195ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691684807; x=1692289607;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=acHZo3S8mxknkeKry3g5QD8BVmAzgZ4je+m7mvgsQl0=;
        b=az5YcTrVZpsxSEKZNxyyBqJACUOr/8Du3llUHatkGqKx/WV1LlYGn95TAjR9KS0LJS
         RkKZZEsl6XsekwGs/+FZY66oBBzY4pDaeGy4aUhOlEPKhfxv0M0bid2YGCFLRkeqRBwH
         0KLHa7T9Gy8ajQ91ok+NsimhCqiBLbAaCoG5MFRuSGKEYo0Vh8XL9TKnIXqm42tCfwAb
         q7aXBiUmhSsvnBQgOMIJEgOKk5HB+0Y0yLaDJIWj2HpHz+UFXIqXyjmJa1HSDDjnMQcG
         /Zk0ymLhpEBRmm8yyQaDc77K8RpB3Le6+/SL+oZURjPylZOwt7DmMLp3D7KnIXv6hRh/
         yXNg==
X-Gm-Message-State: AOJu0YzLYtC1CZiDb+ZBv582ZqZQ1kIGbknTrIGszGt/ssmO0L/91ntx
        STKd3sNI9npx4P0bbMykbWVWmXqFBDfYgO4G//+qq5QRJHP5ktmumQmu1fs8p2mJwhBovpbmfnv
        gyUBN/+qLegOnWdpuhiuIcLkn
X-Received: by 2002:a05:6e02:219d:b0:347:223f:92f4 with SMTP id j29-20020a056e02219d00b00347223f92f4mr4153206ila.24.1691684807573;
        Thu, 10 Aug 2023 09:26:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf+TRkKU0Yfz9iUT32WKpZitpCfURyjqrRVywn3kpTIKvO2nNzUxnFsq4P02M3hkSik2fIUw==
X-Received: by 2002:a05:6e02:219d:b0:347:223f:92f4 with SMTP id j29-20020a056e02219d00b00347223f92f4mr4153188ila.24.1691684807318;
        Thu, 10 Aug 2023 09:26:47 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id q4-20020a02a304000000b0042b255d46c1sm493435jai.11.2023.08.10.09.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:26:46 -0700 (PDT)
Date:   Thu, 10 Aug 2023 10:26:44 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.auger@redhat.com
Subject: Re: [PATCH v2 1/2] PCI/VPD: Add runtime power management to sysfs
 interface
Message-ID: <20230810102644.40dfce6e.alex.williamson@redhat.com>
In-Reply-To: <20230810155926.GA32250@bhelgaas>
References: <20230803171233.3810944-2-alex.williamson@redhat.com>
        <20230810155926.GA32250@bhelgaas>
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

On Thu, 10 Aug 2023 10:59:26 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Thu, Aug 03, 2023 at 11:12:32AM -0600, Alex Williamson wrote:
> > Unlike default access to config space through sysfs, the vpd read and
> > write function don't actively manage the runtime power management state
> > of the device during access.  Since commit 7ab5e10eda02 ("vfio/pci: Move
> > the unused device into low power state with runtime PM"), the vfio-pci
> > driver will use runtime power management and release unused devices to
> > make use of low power states.  Attempting to access VPD information in
> > this low power state can result in incorrect information or kernel
> > crashes depending on the system behavior.
> > 
> > Wrap the vpd read/write bin attribute handlers in runtime PM and take
> > into account the potential quirk to select the correct device to wake.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  drivers/pci/vpd.c | 34 ++++++++++++++++++++++++++++++++--
> >  1 file changed, 32 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> > index a4fc4d0690fe..81217dd4789f 100644
> > --- a/drivers/pci/vpd.c
> > +++ b/drivers/pci/vpd.c
> > @@ -275,8 +275,23 @@ static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
> >  			size_t count)
> >  {
> >  	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
> > +	struct pci_dev *vpd_dev = dev;
> > +	ssize_t ret;
> > +
> > +	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
> > +		vpd_dev = pci_get_func0_dev(dev);
> > +		if (!vpd_dev)
> > +			return -ENODEV;
> > +	}
> > +
> > +	pci_config_pm_runtime_get(vpd_dev);
> > +	ret = pci_read_vpd(vpd_dev, off, count, buf);
> > +	pci_config_pm_runtime_put(vpd_dev);
> > +
> > +	if (dev != vpd_dev)
> > +		pci_dev_put(vpd_dev);  
> 
> I first thought this would leak a reference if dev was func0 and had
> PCI_DEV_FLAGS_VPD_REF_F0 set, because in that case vpd_dev would be
> the same as dev.
> 
> But I think that case can't happen because quirk_f0_vpd_link() does
> nothing for func0 devices, so PCI_DEV_FLAGS_VPD_REF_F0 should never be
> set for func0.  But it seems like this might be easier to analyze as:
> 
>   if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0)
>     pci_dev_put(vpd_dev);
> 
> Or am I missing something?

Nope, your analysis is correct, it doesn't make any sense to have a
flag on func0 redirecting VPD access to func0 so vpd_dev can only be
different on non-zero functions.  The alternative test is equally
valid so if you think it's more intuitive, let's use it.  Thanks,

Alex

