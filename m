Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877267E3603
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjKGHmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKGHl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:41:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBC5FD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 23:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699342872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1/lx1rypKszE80C3svlF1BPeyS2bMagooOeOTmeIu3k=;
        b=IVUuW5804zR2ByxGjv/zRqZrUm5Vys9I3jS7wCzXcueRtfE1IjhSAHV6vAvANho5uUqYTU
        bHW8EaJ1kM0AGj3OwR2n8IXGIn0Dn0oH1m5UWGhgOGiEwcFDUdgBv6657gZuEJHebKtxoO
        iucUhfP8V6OnVamlw3liL8SdPYG6obs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-g0ek8r0KN7u39RVuLGoPaQ-1; Tue, 07 Nov 2023 02:30:40 -0500
X-MC-Unique: g0ek8r0KN7u39RVuLGoPaQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40855a91314so34724285e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 23:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699342239; x=1699947039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/lx1rypKszE80C3svlF1BPeyS2bMagooOeOTmeIu3k=;
        b=MVthN/+Pq/KW+djVSo55MvUkkkVks2X0IDyD7iISxa4ay8zTlSNF4m6QD7QsdTJ2DC
         92XjmBcfkiJ1mKRxYVXhSBTRZGkguzrZ9vTEejQ0dLdRqimhUj8tw6gRUCd2T7VFjnSH
         c9QifnlzJdd54R9m6hUbgDxgH13tWw/jU1EtXLV7OL4caH7VJeWqHhb5Rl3cXIfaaZxC
         SkhF3nzK80MkkPQ3350STWUaPw4A42fGW929GI+B0TWWl1fnvF+abJ6oyhJJTn+vJJpA
         ukuWyqP0SCZet0XMGydJZI9cBGGyV1wL/UULgT1XIHMnxIQ1Y1uZXdv4TpMeggu+SWhe
         SP1w==
X-Gm-Message-State: AOJu0YxcxTG5hbOdfIw0ePo3LNsPIP3Iz7a5skI8k7yPTq8Qg0CZvErA
        7+d91iapZKl1URfFqmYgnigO/c0y36VMbqwipcLMPvUDdv/eO8shCFPlpjjlmD2FYzm+Ft0CSJF
        GUFkMzwEpbXWgoioj8ZRVfHlA
X-Received: by 2002:a05:600c:1c06:b0:405:3ab3:e640 with SMTP id j6-20020a05600c1c0600b004053ab3e640mr1563993wms.20.1699342239048;
        Mon, 06 Nov 2023 23:30:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKOvrGmXKbiJ4vIeoxB/aU3PS4p7CWdE7g1MzeenXV0fuHrqF0EyczH4kRYvPFqPW5dbKFQg==
X-Received: by 2002:a05:600c:1c06:b0:405:3ab3:e640 with SMTP id j6-20020a05600c1c0600b004053ab3e640mr1563976wms.20.1699342238687;
        Mon, 06 Nov 2023 23:30:38 -0800 (PST)
Received: from redhat.com ([2.55.5.143])
        by smtp.gmail.com with ESMTPSA id e12-20020adffd0c000000b0032d893d8dc8sm1555331wrr.2.2023.11.06.23.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 23:30:38 -0800 (PST)
Date:   Tue, 7 Nov 2023 02:30:34 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cindy Lu <lulu@redhat.com>
Cc:     jasowang@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107022847-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103171641.1703146-1-lulu@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 01:16:33AM +0800, Cindy Lu wrote:
> 
> Hi All
> This code provides the iommufd support for vdpa device
> This code fixes the bugs from the last version and also add the asid support. rebase on kernel
> v6,6-rc3
> Test passed in the physical device (vp_vdpa), but  there are still some problems in the emulated device (vdpa_sim_net), 

What kind of problems? Understanding that will make it easier
to figure out whether this is worth reviewing.

> I will continue working on it
> 
> The kernel code is
> https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC_v1
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Please also Cc iommufd maintainers:

Jason Gunthorpe <jgg@ziepe.ca> (maintainer:IOMMUFD)
Kevin Tian <kevin.tian@intel.com> (maintainer:IOMMUFD)
Joerg Roedel <joro@8bytes.org> (maintainer:IOMMU SUBSYSTEM)
Will Deacon <will@kernel.org> (maintainer:IOMMU SUBSYSTEM)
Robin Murphy <robin.murphy@arm.com> (reviewer:IOMMU SUBSYSTEM)
iommu@lists.linux.dev (open list:IOMMUFD)
linux-kernel@vger.kernel.org (open list)

-- 
MST

