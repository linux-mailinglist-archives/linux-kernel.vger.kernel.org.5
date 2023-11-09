Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566BC7E754B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 00:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345415AbjKIXto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 18:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjKIXtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 18:49:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26653A9E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 15:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699573736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3SxbBnBy8wcp+DFoAqPelvZA1LQU0OFFn4SXuqEY8lc=;
        b=J4fu2dXKN6mpOWvYDtuUWYWqnqiAhGlso4OHerB5TI0O8saXl6k7LIarnVBNkL7P3uEf2K
        468CezVxqnM4k4LHi2IVjgWs1hE0xvS8wBerK2hG9V068n42+A2nikyYo//8aLqcARd66k
        t0DJojIJGRns9ZvvjLAD1vGPf5kNg3M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-BH1ICWvdPSeOxq6Wd0r6YQ-1; Thu, 09 Nov 2023 18:48:53 -0500
X-MC-Unique: BH1ICWvdPSeOxq6Wd0r6YQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ddae43f3f7so111945766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 15:48:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699573732; x=1700178532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SxbBnBy8wcp+DFoAqPelvZA1LQU0OFFn4SXuqEY8lc=;
        b=PrdstiG+LbWnf1D2uyZJIXbCFitQGv8z7swiPxdOLH0PBfkxejyiKGIhtI7egINfO4
         6YWbsbAJJ9Etcwge5iDQX4ltqAy58r3Ay83OK0mwbUWcxfmrXlDkYoVuQZrPt/y/KTWP
         ihBWL+oiL11ZvQQxDyU7AcYexzC1EFgpUpH3sKycJTYduDtsgoCjK/wVlcMA0FDUJrPn
         E0K8wrba5ebzPcdhvMFl462C+ImFOeyrmPHzZebnyUfGJKqXhPhu6rCBaRw/RYq6/xcA
         fQTH8lTWuTx8UZl9nsPc7D6Yd2ayVQpdq1pjq7LfrWKMTP/dZsGaO3hHQOeepniYeihc
         MysA==
X-Gm-Message-State: AOJu0YyrmDw7fy9JSIfYWUJl2l9Q2nAZeeNo6NmhkAUZ485Nh099AbNE
        gmOEXkkCG4vNsX6jSbB0pgi9wVivARkZ8Cbjy7qZ5UyWwQNRbuI8afPXMAHY6wvvMPWd9+nOyUF
        JcHjBXVTL3Wz1cq/inPD6V2vi
X-Received: by 2002:a17:907:25c4:b0:9e1:1996:f3d6 with SMTP id ae4-20020a17090725c400b009e11996f3d6mr6251180ejc.76.1699573732744;
        Thu, 09 Nov 2023 15:48:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKFgKEEunbjt3marXxbZibLU1JXnSLXyCS7/ojjJiN6MLuJ2Aa5uQPqet3dxVKkQKsLVJ/dA==
X-Received: by 2002:a17:907:25c4:b0:9e1:1996:f3d6 with SMTP id ae4-20020a17090725c400b009e11996f3d6mr6251167ejc.76.1699573732476;
        Thu, 09 Nov 2023 15:48:52 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:2044:be5a:328c:4b98:1420])
        by smtp.gmail.com with ESMTPSA id j17-20020a170906255100b009737b8d47b6sm3126661ejb.203.2023.11.09.15.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 15:48:51 -0800 (PST)
Date:   Thu, 9 Nov 2023 18:48:46 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Cindy Lu <lulu@redhat.com>, jasowang@redhat.com,
        yi.l.liu@intel.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231109183407-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231107022847-mutt-send-email-mst@kernel.org>
 <20231107124902.GJ4488@nvidia.com>
 <20231107082343-mutt-send-email-mst@kernel.org>
 <20231107141237.GO4488@nvidia.com>
 <20231107092551-mutt-send-email-mst@kernel.org>
 <20231107155217.GQ4488@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107155217.GQ4488@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 11:52:17AM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 07, 2023 at 09:30:21AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Nov 07, 2023 at 10:12:37AM -0400, Jason Gunthorpe wrote:
> > > Big company's should take the responsibility to train and provide
> > > skill development for their own staff.
> > 
> > That would result in a beautiful cathedral of a patch. I know this is
> > how some companies work. We are doing more of a bazaar thing here,
> > though. In a bunch of subsystems it seems that you don't get the
> > necessary skills until you have been publically shouted at by
> > maintainers - better to start early ;). Not a nice environment for
> > novices, for sure.
> 
> In my view the "shouting from maintainers" is harmful to the people
> buidling skills and it is an unkind thing to dump employees into that
> kind of situation.
> 
> They should have help to establish the basic level of competence where
> they may do the wrong thing, but all the process and presentation of
> the wrong thing is top notch. You get a much better reception.
> 
> Jason

What - like e.g. mechanically fixing checkpatch warnings without
understanding? I actually very much dislike it when people take a bad
patch and just polish the presentation
- it is easier for me if I can judge patch quality quickly from the
presentation. Matter of taste I guess.

-- 
MST

