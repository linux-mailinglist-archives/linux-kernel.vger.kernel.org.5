Return-Path: <linux-kernel+bounces-95094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC39874929
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6501C285FA5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E576312B;
	Thu,  7 Mar 2024 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igid1crV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A04E1BF2B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709798290; cv=none; b=pyj+zfazwqaZVlvEv6qg8y8TjIBpV+TqJHbkKyBOGNgnFKJe3suAGgxRWq3C2lal1ctvFpyvQXhcvDDP8ovyqAWvjIHMmPtBiwunvBd3utCcG515UndNJC52gPn1SuTNPDjnVKcls+Doaz/U7/BDIYTkbVDRDrJmnvpg4oYlN1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709798290; c=relaxed/simple;
	bh=5q8ILiR/B/YGYbR4tJPxFTddYlCq8fpKSl/xT/O5moQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOHxiv+/i7QuhCui2NoH23WPpQ7hKgdqKziItJwJNKkho50c/oPYKm49io8QjYwkt0OWONgo+zWOSdYDCtgc6wXYz9DRQfECddag+9MvnqUkID61l8s8vdRBr+vz87oEOKriG9irIPq9j0JUZWC/kAGfruFjWPCYAjzzEnos/xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=igid1crV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709798287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vmPrVN1PM8DjuYX2o9oiGqtSt2B0QfJxmhazoqC2L+4=;
	b=igid1crVOI3/ct6sTM53Mf+U1Ah+ltxZ3k39V4OTZgVaMB/NZ5PFL4Ly1BVVlYhCj8XqBT
	U/GxJSoCXsDi20v3/gRTOnCRNPB1qsMdMOSZ3eqALHw2wHrEZxCKs1/dPbkpIwZ2MMGcH/
	BKe4BEPFr6m0+byf3fLcqcZL/tQ8Q1I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-iUg8xKiqM_e6tHWkpL_POw-1; Thu, 07 Mar 2024 02:58:06 -0500
X-MC-Unique: iUg8xKiqM_e6tHWkpL_POw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a45b4f09107so47418466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 23:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709798285; x=1710403085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vmPrVN1PM8DjuYX2o9oiGqtSt2B0QfJxmhazoqC2L+4=;
        b=uOufUEeQdJ1NpRgBq/HA/FGMF/wV09qpeUqenRn66SNHzbI9Qa0fysVmX0b31ia2Qi
         JKhTH4rSQkntyCMBtoH9Q28ZXFOZacjxGxzumw9mvmuEWHXU22JIh7n+siQ+sJ9chXxo
         Z0vSBFijXER1Ce7merrVlIXjz0+LiAodsUynfD1/+RRICOaqEay1WQwNhN0NVP+eYgXB
         E81fj8+R09iTgFGHPtYmvpBuKgK6ytbYGEsAb/OBaNvhALRFvg9alHp6z7SBlGwvZ8D9
         OZ9DB9+y+aj4PR65hxrD3EBCUmvrO7J1KCt3o2EU5gVL7U51UVmqYnCLZsQSozlDsrMh
         EToQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyDf7bqqxOsmyAfdbqYIAFDG4JSkOA61UlWvUjHHavEF5WiEIG6vEN71qeaWievodXQ1Q8bEFOuZqB/HJ5WBjc3iUaMMM15cfueRZJ
X-Gm-Message-State: AOJu0YwUxn1ELBvM1nizmwOA7ajxq21GxodgftnGu4ozHlGWz2r7eCWG
	DsgEMBiEGkqrSUGrDsEWGI5Zj0dos/3gO44JTkOowIDKf6SETlEfjprgipYdJjqJ3NKAqsXReUD
	/vkpbgIo+rCGBk7Vu7pqngxehRCpOZjrYSYCwjit+5RyJ+rqoUl4X5k6nb6xOag==
X-Received: by 2002:aa7:c856:0:b0:566:b4e0:9aaf with SMTP id g22-20020aa7c856000000b00566b4e09aafmr14131980edt.29.1709798284817;
        Wed, 06 Mar 2024 23:58:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFmx5uJHUmIQofQHdNsFo6cs2iVEB7l1hyJqFM9vSNed5236E0w6PGD1Uf7zd+y99Cmk6a/g==
X-Received: by 2002:aa7:c856:0:b0:566:b4e0:9aaf with SMTP id g22-20020aa7c856000000b00566b4e09aafmr14131955edt.29.1709798284154;
        Wed, 06 Mar 2024 23:58:04 -0800 (PST)
Received: from redhat.com ([2a02:14f:17a:39e3:52e3:e0:982c:2b29])
        by smtp.gmail.com with ESMTPSA id es14-20020a056402380e00b00566d9c8e6cesm6548762edb.21.2024.03.06.23.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 23:58:03 -0800 (PST)
Date: Thu, 7 Mar 2024 02:58:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, xieyongji@bytedance.com,
	linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
Subject: Re: [PATCH v4 5/5] Documentation: Add reconnect process for VDUSE
Message-ID: <20240307025709-mutt-send-email-mst@kernel.org>
References: <20240207054701.616094-1-lulu@redhat.com>
 <20240207054701.616094-6-lulu@redhat.com>
 <CACGkMEuGwVwstzCGyYs90YjtE-QZGs1ztDKF4-gqFM_JZhSjmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuGwVwstzCGyYs90YjtE-QZGs1ztDKF4-gqFM_JZhSjmQ@mail.gmail.com>

On Mon, Mar 04, 2024 at 01:11:02PM +0800, Jason Wang wrote:
> On Wed, Feb 7, 2024 at 1:47 PM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add a document explaining the reconnect process, including what the
> > Userspace App needs to do and how it works with the kernel.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  Documentation/userspace-api/vduse.rst | 32 +++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
> > index bdb880e01132..a2be85e0e516 100644
> > --- a/Documentation/userspace-api/vduse.rst
> > +++ b/Documentation/userspace-api/vduse.rst
> > @@ -231,3 +231,35 @@ able to start the dataplane processing as follows:
> >     after the used ring is filled.
> >
> >  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> > +
> > +HOW VDUSE devices reconnectoin works
> 
> Typos, let's use a spell checker.
> 
> > +----------------
> > +0. Userspace APP checks if the device /dev/vduse/vduse_name exists.
> > +   If it does not exist, need to create the instance.goto step 1
> > +   If it does exist, it means this is a reconnect and goto step 3.
> > +
> > +1. Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
> > +   /dev/vduse/control.
> > +
> > +2. When the ioctl(VDUSE_CREATE_DEV) function is called, the kernel allocates memory
> > +   to save the reconnect information.
> > +
> > +3. Userspace App need to mmap the pages to userspace
> 
> Need to describe what kind of pages need to be mapped. And what's more:
> 
> Does this require cooperation from the disconnected application? If
> yes, how to distinguish from the one that is not cooperative (doesn't
> support reconnection)?
> 
> > +   Userspace App need to map Pages 0 to vq_number for vq status,
> > +   Users can define the structure for saving the reconnect information themselves
> > +   in the userspace.
> > +
> > +4. Check if the infomatin sutiable for reconnect
> 
> Typos again.
> 
> > +   If this is reconnect:
> > +   Before attempting to reconnect, The userspace application need to the
> > +   ioctl VDUSE_DEV_GET_CONFIG,VDUSE_DEV_GET_STATUS,VDUSE_DEV_GET_FEATURES...
> 
> "..." is not good, let's describe the steps in detail.
> 
> > +   to get the and confirm if these information are suitable for reconnecting.
> > +
> > +5. Start the userspace App.
> 
> I had a hard time understanding this, does it mean the application
> needs to restart itself?
> 
> > +   While running, the application should store the relevant information about
> > +   reconnections in mapped pages.
> > +   When calling ioctl VDUSE_VQ_GET_INFO from the userspace APP
> 
> Abbrev is not good here. Let's use "application" for consistency.
> 
> > to get vq information, it is necessary
> > +   to check if this is a reconnection.
> 
> How to check whether or not it is reconnected?
> 
> > If a reconnection has occurred, the vq-related information
> > +   must be get from the mapped pages.
> > +
> > +6. When the Userspace App exits, it is necessary to unmap all the reconnect pages.
> > --
> > 2.43.0
> >
> 
> Thanks

Are comments only on patch 5? Ack the rest?

-- 
MST


