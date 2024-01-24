Return-Path: <linux-kernel+bounces-37431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7077083B033
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D4FB2BE02
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0372385C72;
	Wed, 24 Jan 2024 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYt2OUOW"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE4F85C4B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117439; cv=none; b=nqTnexV+XGGPVoz/Ijy9AndvC9ZV+Kg/+Mq3P6vPBpagZA8ZA+pD1lVVnfEbozc+dYQS20y2qqkJVVFhXskI2Irf1AtMkbbxsxXbd8ej/XINshEtowBRnp9BzoOS4p1Rq0RX6bHT6aSimeBM2HJ4rkYPj2Xs6DNGyGi+vapr8ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117439; c=relaxed/simple;
	bh=iH0MchTyiKSEd6BXJ2oEXudcHoxwgVYZCOiKge+w8Mk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fi80ulTAERYj++viS36+zcZDrI+UsXIyjXDOqzI3EjqcFblehLE5vWTUxxnZGQIQ8ded8y8UttvfSNSdDMX6OBQizjQe4hjzThCl9VP289T7Ya/pLu/L+eXqQn06geXUzu38KcTAzmE1q2RThvGiSrAwbZX88bvHviD5uSRYk9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oYt2OUOW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf1c3816a3so6778468276.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706117437; x=1706722237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4XBmMUxfyNNPeoo/A2vYJ+fv7wX+k30y8Lmqm0OE8QM=;
        b=oYt2OUOW6FA1ivx95OvEAr4D7Z4iZTw3ir34MJho2zhXUXT0CwMHwGJ5dS0n9PVHM6
         tuyMapWiXFE/mbW/ni18+5sn4emQtEwSkcyXuwVr6P8YxP1YglO0bBAT4f3HKJnrxHmt
         ggq4eBN/c8fPRze8r3w8VRiv5YyjaSwYgo4m4HU020V8HUQiS0/Osxrgf4IbqZ1rpFb2
         fYAeBoNBmQF8HMPmtbFOY8jR6JG9xojEVG5Bl6KG8RWH6K7f2AH51anj3VWahmDzGkuz
         XPNsed6VuPGl/Xktw9TySeCjprXLJ9uMTkILTMQc8pOT9uTWo/TjNR+YgzWlypggqFm+
         zHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706117437; x=1706722237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4XBmMUxfyNNPeoo/A2vYJ+fv7wX+k30y8Lmqm0OE8QM=;
        b=X1fDI4sT3n5N3VkgJTdVFpg/hd31huHElOcJ3Ol01W5A6psXKHP4QFoHI34ckfZqzQ
         t5Wse0v7o53PKVa65NwnGxPBO1fF6f0D7kbRE0oIz9FC+Otu+nPkVk0hgdn+iSEtOXI2
         JxmAK/W3JOjY5I98fHk637x/S8DIWgznUDJcc9YwN8MdK6gwu1+qxIF/WAn6LAZ0AuZs
         a8qeoERk48H63/gBBVD8spBPdHcT06oKCdDfluXaZQZBvLxEDc5HG1t109FYIYpfOIrS
         oAzMpLY6xL+zJdN+6Up2bPLWiGIn9G8IeMHWpjcSfXJeANqJQcAh6OI9VnBOyxAo2IGu
         OIJg==
X-Gm-Message-State: AOJu0YwiYtKiU4pi87Rb7T8xZLafZAefc14PtmngCMoSAfKGz10j2dWE
	GqDzBl664VLeb9iyU4yh+Q1vtoLJalKLG/pk5O20DIXsHip1VMADFlRLPcyfClT0Du6eETd1NFv
	Bfw==
X-Google-Smtp-Source: AGHT+IGEWXyawuzyp81/wDfi3Iy9A571RkMiRToyJDanBsf/3shix6eGHoFXOR8E1W1QHA6QBXUB2ddk3kw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1786:b0:dc2:3a02:4fc8 with SMTP id
 ca6-20020a056902178600b00dc23a024fc8mr66666ybb.6.1706117436822; Wed, 24 Jan
 2024 09:30:36 -0800 (PST)
Date: Wed, 24 Jan 2024 09:30:35 -0800
In-Reply-To: <20240122193605.7riyd7q5rs2i4xez@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240117010644.1534332-1-seanjc@google.com> <20240122193605.7riyd7q5rs2i4xez@amd.com>
Message-ID: <ZbFJOyGb21UX6qXn@google.com>
Subject: Re: [ANNOUNCE] PUCK Agenda - 2024.01.17 - TDP MMU for IOMMU
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	David Matlack <dmatlack@google.com>, pbonzini@redhat.com, isaku.yamahata@intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 22, 2024, Michael Roth wrote:
> On Tue, Jan 16, 2024 at 05:06:44PM -0800, Sean Christopherson wrote:
> > Tomorrow's PUCK topic is utilizing KVM's TDP MMU for IOMMU page tables.
> > 
> > FYI, I am currently without my normal internet (hooray tethering), and we're
> > supposed to get a healthy dose of freezing rain tonight, i.e. I might lose power
> > too.  I expect to be able to join even if that happens, but I apologize in
> > advance if I end up being a no-show.
> > 
> > https://lore.kernel.org/all/20231202091211.13376-1-yan.y.zhao@intel.com
> > 
> > Time:     6am PDT
> > Video:    https://meet.google.com/vdb-aeqo-knk
> > Phone:    https://tel.meet/vdb-aeqo-knk?pin=3003112178656
> > 
> > Calendar: https://calendar.google.com/calendar/u/0?cid=Y182MWE1YjFmNjQ0NzM5YmY1YmVkN2U1ZWE1ZmMzNjY5Y2UzMmEyNTQ0YzVkYjFjN2M4OTE3MDJjYTUwOTBjN2Q1QGdyb3VwLmNhbGVuZGFyLmdvb2dsZS5jb20
> > Drive:    https://drive.google.com/drive/folders/1aTqCrvTsQI9T4qLhhLs_l986SngGlhPH?resourcekey=0-FDy0ykM3RerZedI8R-zj4A&usp=drive_link
> > 
> > Future Schedule:
> > January 24th - Memtypes for non-coherent DMA
> > January 31st - Available!
> 
> Hi Sean,
> 
> I'd like to propose the following topic for the next available slot:
> 
>   "Finalizing internal guest_memfd APIs needed for SNP (TDX?) upstreaming"
> 
> There's 2 existing interfaces, gmem_prepare, gmem_invalidate, that are
> needed by the current SNP patches, and there's some additional background
> about the design decisions here:
> 
>   https://lore.kernel.org/kvm/20231016115028.996656-1-michael.roth@amd.com/
> 
> There's also another gmem interface that you recently proposed for handling
> setting up the initial launch image of SNP guests here that seems like it
> would have a lot of potential overlap with how gmem_prepare is implemented:
> 
>   https://lore.kernel.org/lkml/ZZ67oJwzAsSvui5U@google.com/
> 
> I'd like to try to get some clarity on what these should look like in order
> to be considered acceptable for upstreaming of SNP, and potentially any
> considerations that need to be taken into account for other users like
> TDX/pKVM/etc.

I penciled this in for the 31st, let me know if that works for you.

