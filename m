Return-Path: <linux-kernel+bounces-154008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8276A8AD60F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E911F21D75
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97F21BC43;
	Mon, 22 Apr 2024 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXAy8v6j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992081B949
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818798; cv=none; b=AJRDwk5gRWiBCpQCxLYMf8B1dxJKcPkZPGUvtx6v8QFO0kOJQ/WaF87cbmSLkoBCeOS56fJGsz+MmDMCKzr3prcG40h394JxHXBeeE26+uHTIw3r6s9AaeNBf8WzvChyMBy5/iDT4mA2qoQfCdhVim0GKSFhOGSSRtIPQYiN3Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818798; c=relaxed/simple;
	bh=H5Z6SiEa1LqyRln+jIweBVprBsLnwz9LlvdBu4wlfaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpkeHmPCJuLd6T981E1DZfHH3yu/SJQqaUb/lXpypvlBvo3K2AjFxjNxOOAvLwz5A28ub4TbLkaWuUKIwz5rt7eFfKzt+QYmzcGWqWzHPtFK17Kc4/AK1v7bBlNDMD9AaFoJU4lk+MO1xvGEkAYQxM8Pz13wb9EC0mDDKgNnnYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXAy8v6j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713818795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=40uoZHa8ePOa3oDdTa1uyiavWWTsYBTV5XVebqO3igA=;
	b=hXAy8v6jnOVayZQyr2nlZkwpOXnR8jr7+n4zSfbb0DtyPjVMOuVcWVaBsyH/fU0wP86YT5
	VXEC4vnlsp3+eaZaEKsTsRCXYXKizMtHqic7IOsc7QLNGScvoJg+EZX6gOCPPGTyBMty1v
	/lo+wqZwv2HRAVUeBrPTyiRlz5+XWNw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-ZJ_fgruIMaWicsIoLhr7qw-1; Mon, 22 Apr 2024 16:46:34 -0400
X-MC-Unique: ZJ_fgruIMaWicsIoLhr7qw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34b08e09bc4so1083764f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713818793; x=1714423593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40uoZHa8ePOa3oDdTa1uyiavWWTsYBTV5XVebqO3igA=;
        b=I5EzCrB42EKjGzGq9dlXjGxm5VcS3ijsfR0qSHtN/8izfRv2t4fLy3XPy212yghhoq
         DYRiW4qIIZR8gsIEvz4We88fafUOlvikr9ITHI65y16cQKwT+fHK1y09HVRburyNmlCo
         91g27pxpOTsZoh/iTFhFHMswIZSGyZZc81H70hG42BVcHfXyC/3AX/uLfa/TLFoqPhnV
         Z9uLCd3QaQSIxfZFF83kJE9P5J/uCQKQoDmSZ0/rgIu2UGyWPhKCEcrJ4KF93xLFEbCZ
         2YG9ROAYsBSepeBafoDqxs00j1ELmBNNtJ11xUypiw89R7S89sRHqT2EQytlmAPcYGA7
         UI1A==
X-Forwarded-Encrypted: i=1; AJvYcCVIb/o1oxg510WITUIPUORM00JjSmXaQe5RUGvRBrZN+vgolP2mdfDsFqNyib1a8TIkegIoH3awXu76tO8RyxLjxz38PrzjcPb8qwXn
X-Gm-Message-State: AOJu0YydQlmA2WJrEtuNNntGBDAkpx5Tr09QIJPX3PggpxIvfLuWzywD
	lD1SyMj8cpPxGIUMynRguNfQDcsx7ONTHF11I7+oODK6+0W4f74r1bMkppUvHHhIuhQNFLRttNP
	fYLEvQhrV2vtj3qyVS5tPJSu7Ga68BUyZNpV0OQ8Tac+QSpkRkP3CGCN1nn1msQ==
X-Received: by 2002:a05:6000:137c:b0:343:eb28:58e9 with SMTP id q28-20020a056000137c00b00343eb2858e9mr8901391wrz.28.1713818792831;
        Mon, 22 Apr 2024 13:46:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwYrlNmXHqbs7mfM2hI9V4wigQlkwDYkE8MhG563Lcf1QV1RtyFe6oM1hW5UppmVzOzcuESA==
X-Received: by 2002:a05:6000:137c:b0:343:eb28:58e9 with SMTP id q28-20020a056000137c00b00343eb2858e9mr8901360wrz.28.1713818792250;
        Mon, 22 Apr 2024 13:46:32 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id z18-20020a5d6412000000b00347ec0469b2sm12878687wru.46.2024.04.22.13.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:46:31 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:46:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, will@kernel.org, davem@davemloft.net,
	stefanha@redhat.com, sgarzare@redhat.com, keirf@google.com,
	yihyu@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v3 3/3] vhost: Improve vhost_get_avail_idx() with
 smp_rmb()
Message-ID: <20240422164613-mutt-send-email-mst@kernel.org>
References: <20240328002149.1141302-1-gshan@redhat.com>
 <20240328002149.1141302-4-gshan@redhat.com>
 <20240328052814-mutt-send-email-mst@kernel.org>
 <8faa07aa-d330-4e3f-95b7-26437d448beb@redhat.com>
 <b41d65de-dc43-45f6-ba6c-ae722fbb70a8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b41d65de-dc43-45f6-ba6c-ae722fbb70a8@redhat.com>

On Mon, Apr 08, 2024 at 02:15:24PM +1000, Gavin Shan wrote:
> Hi Michael,
> 
> On 3/30/24 19:02, Gavin Shan wrote:
> > On 3/28/24 19:31, Michael S. Tsirkin wrote:
> > > On Thu, Mar 28, 2024 at 10:21:49AM +1000, Gavin Shan wrote:
> > > > All the callers of vhost_get_avail_idx() are concerned to the memory
> > > > barrier, imposed by smp_rmb() to ensure the order of the available
> > > > ring entry read and avail_idx read.
> > > > 
> > > > Improve vhost_get_avail_idx() so that smp_rmb() is executed when
> > > > the avail_idx is advanced. With it, the callers needn't to worry
> > > > about the memory barrier.
> > > > 
> > > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > > 
> > > Previous patches are ok. This one I feel needs more work -
> > > first more code such as sanity checking should go into
> > > this function, second there's actually a difference
> > > between comparing to last_avail_idx and just comparing
> > > to the previous value of avail_idx.
> > > I will pick patches 1-2 and post a cleanup on top so you can
> > > take a look, ok?
> > > 
> > 
> > Thanks, Michael. It's fine to me.
> > 
> 
> A kindly ping.
> 
> If it's ok to you, could you please merge PATCH[1-2]? Our downstream
> 9.4 need the fixes, especially for NVidia's grace-hopper and grace-grace
> platforms.
> 
> For PATCH[3], I also can help with the improvement if you don't have time
> for it. Please let me know.
> 
> Thanks,
> Gavin

1-2 are upstream go ahead and post the cleanup.

-- 
MST


