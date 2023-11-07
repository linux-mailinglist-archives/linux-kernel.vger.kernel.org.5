Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E6B7E45CB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbjKGQTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344738AbjKGQT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:19:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657718A5F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699373478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fw4FStypu9syAQ3xa9mC4mwCaAdKKxAxHhWjdd8hiZw=;
        b=SyDEvhIRXGQuQfrAnnCwSiBx4GHa1JiPLg0N3qg2GCv6cKuuqWJBKKmucPSozkNDDtqzHk
        WNNpVE6hIgxZpWDJZbAsqIgVCI2kQHF9ra6bzCQm29xCSzo7HoF0cDtnFWIF7VEfs8OR7O
        vdJBSI4/GWyJnFqi6l2ziF6NQ8z9kbU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-lrgKAifVME-cjZoofwhGbA-1; Tue, 07 Nov 2023 11:11:14 -0500
X-MC-Unique: lrgKAifVME-cjZoofwhGbA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32f68d3b788so2967888f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 08:11:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699373473; x=1699978273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw4FStypu9syAQ3xa9mC4mwCaAdKKxAxHhWjdd8hiZw=;
        b=eveuhvTM59ibEirWcff9ms9MX4A5OrHBWz8ir2EKQn38gVAMtMn6doDWNaMhwDnT3m
         lrGk/BkwlcIL9aKzqjmw737p6qR/45CcQHmTqxJppA2h9YUdGXZm0cNGtLf2tq1vRbww
         6aqIDcpvUqfMp7t7X8lW3Yq8kTC9icAS1F/8wdf7yY7eR/VYvYxuyJV3gUll/Kwd8cY7
         auW0kBY1uzJBbdYNYwLpCcQDeWYWpYA/azui7FyQXdMvn3zqoWpmRew1vyeErO0Q0UCV
         mVkDMGkCOrruvl7CUiocxzcYr+nLwextSJflpNF6Oph30FKybKLptECi3l6gO+LRg1pQ
         RysA==
X-Gm-Message-State: AOJu0Yy6P4GqLS/2TRuanWeCPdJFZ2iR9I5EbMN8lNIbkZnCaLB/TKe8
        kkRv3l0kA4Ju6PoCgxPqQXbSnursthLWmiIbK4Bgfo7hIEIEog72vthWssuPht6VNd0UdL8p+Dm
        pvwee8L2uuvLUcXKAwZ7ZuhZG
X-Received: by 2002:a5d:4242:0:b0:32d:a910:6c2a with SMTP id s2-20020a5d4242000000b0032da9106c2amr20392842wrr.30.1699373473044;
        Tue, 07 Nov 2023 08:11:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgMckOifCcs2vvNetl9dhM/47Y7sLJxike1OKMQTMQ/IMLbHJBruMwhH1ayLRP/5336FfqBA==
X-Received: by 2002:a5d:4242:0:b0:32d:a910:6c2a with SMTP id s2-20020a5d4242000000b0032da9106c2amr20392827wrr.30.1699373472700;
        Tue, 07 Nov 2023 08:11:12 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f1:373a:140:63a8:a31c:ab2a])
        by smtp.gmail.com with ESMTPSA id u3-20020adfed43000000b003140f47224csm2739390wro.15.2023.11.07.08.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 08:11:11 -0800 (PST)
Date:   Tue, 7 Nov 2023 11:11:07 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Cindy Lu <lulu@redhat.com>, jasowang@redhat.com,
        yi.l.liu@intel.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107105718-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231107022847-mutt-send-email-mst@kernel.org>
 <20231107124902.GJ4488@nvidia.com>
 <20231107094818-mutt-send-email-mst@kernel.org>
 <20231107154848.GP4488@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107154848.GP4488@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 11:48:48AM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 07, 2023 at 09:55:26AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Nov 07, 2023 at 08:49:02AM -0400, Jason Gunthorpe wrote:
> > > IMHO, this patch series needs to spend more time internally to Red Hat
> > > before it is presented to the community.
> > 
> > Just to add an example why I think this "internal review" is a bad idea
> > I seem to recall that someone internal to nvidia at some point
> > attempted to implement this already. The only output from that
> > work we have is that "it's tough" - no pointers to what's tough,
> > no code to study even as a bad path to follow.
> > And while Red Hat might be big, the virt team is rather smaller.
> 
> I don't think Nicolin got to a presentable code point.
> 
> But you can start to see the issues even in this series, like
> simulator is complicated. mlx5 is complicated. Deciding to omit those
> is one path. Come with a proposal and justification to take it out,
> not a patch with an unexplained #ifdef.

Right. Simulator I don't think we need to support, or at least
not necessarily to get this merged - it does not really
benefit from any iommufd features.

