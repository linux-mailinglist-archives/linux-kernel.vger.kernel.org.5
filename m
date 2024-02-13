Return-Path: <linux-kernel+bounces-63364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3174C852E33
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72AB2822F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208AB24B54;
	Tue, 13 Feb 2024 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QU3TuR4g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6802249F1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820919; cv=none; b=GzFCsUQwlYG2U4nHfErNrOYjChCYYvIA0SMSE5QHytTmLbunpkaxUEqLGYOMBrX4P7pc/bxb/2AKJU9s79RwTWvn8c89VzZGKroWMiuFrC6Jk81xvE09GMR9ur82sOn5rcE6VvtDmtsRShblbjRgPT+aDQx1KveYlrZEf2ojL2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820919; c=relaxed/simple;
	bh=Q93G79Tao3pLIvEj6a4nLHaQ5klHJL2n89mFn5i/fzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kM5FntIGKcWksJ2xIJrF3zvBKo89Px/zZNoIOF+mRLq+KiVBa1IrnFOZGGDfTeWAQLJPxQMbGvaBFBYwOpNWH+TVkVRmjb1lvZuvVvC4fVD7anpylPDXX7m3Mhn6KEPjltFu6R+caW/Wn+MdcIr6TwYyxGkCjNj7viWzXLp4cUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QU3TuR4g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707820916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QsoNRIF3L7kvrCoMqs1E08h8SDLvR/qCRkFJ0CP0gQI=;
	b=QU3TuR4gEo6Tq7VFCsPQig8ma2ANDgwnf0dXdrwSguteKc3FAP2ubkaRiFkb7HuKLKnfCx
	+dJcWqXxPJgkvsBV8RzHepmFy5lMw3COYX8i2d9x16sURxTm1Ay4RitwOPrJCK3cRlTQBF
	CbTJYpFx5l0bJGpmSG3+hNNHbznXiTM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-LywSgzdPOWGtGvVu5_08Ig-1; Tue, 13 Feb 2024 05:41:55 -0500
X-MC-Unique: LywSgzdPOWGtGvVu5_08Ig-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a3cfc0287faso24044866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 02:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707820914; x=1708425714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsoNRIF3L7kvrCoMqs1E08h8SDLvR/qCRkFJ0CP0gQI=;
        b=EMiEo1pq9cJTdaHpprJegRysDhyUXQcGQ/psAdTafF2YQClKpb5cjD3oHw9ivLwtNM
         EvB5JVw4smB7nAERS+9Ex0WeHKMIYMY0WytDTlWBXFK5WUCDEe2+dPDXVVcYHR5JIodF
         V8oQs3nXzXCIZtc6oOYqUIn/qOdgqh6aDM/Hpm60A29ay594+GzBIEF0pkBpckF/vERX
         rSptYnDyKvo7Ee0hZYOERk0hRPauy1QmSrPAbmGy56ki4F91jrcsyGTJ7sGp2ehaS4TU
         h4CgGu/m7IPDyAQbDyhMgwsBi7ChSaZ3rI0ySVofOr1WphpnjDWSUHzIwfF1Rfpme0SK
         N2hw==
X-Forwarded-Encrypted: i=1; AJvYcCUOLeKBpCKfegwoob67YIhBY9yADPvDspHXN0QhqsRRrvxDGk7mDgdwl+hbtMMqFMBGt+sKR33cHG0A8YcOVD2sV7BC+KNP9RQjCahc
X-Gm-Message-State: AOJu0YyerMWNOQfBu67JV5ZTcFsfshZ93RiE0lvCE5M/Y7yNqbn0ATsp
	CnpjL3OEXVOfSFIs57cQNnS7XVfTpVY7neaUNQDiTbq9WexZkDDUFSFgdJ21vmW7TFLxmyHHUCR
	p4DcA2JqmJ8ZKEYQ+QoRK5K5q+bvx+g+Hpr/vlPvwRbCJAYo/68TqN+iKcQJBxQ==
X-Received: by 2002:a17:906:4113:b0:a3d:1fb:7880 with SMTP id j19-20020a170906411300b00a3d01fb7880mr752605ejk.77.1707820914037;
        Tue, 13 Feb 2024 02:41:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHD2Zj5imivfoqN2m9u3C8juOSCP3Eec5blZ8cs0/lr3cIZCQH5iHFiu4+VZiaU9oKVtA9gzw==
X-Received: by 2002:a17:906:4113:b0:a3d:1fb:7880 with SMTP id j19-20020a170906411300b00a3d01fb7880mr752592ejk.77.1707820913706;
        Tue, 13 Feb 2024 02:41:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmwfx8d90GwfR4fuw4MPJJ9UViLlbZP20pI3k5k5qN0BthJrltGNKHdcQAh65x859WkjxkGMcyYquvB7c76kQT50pobnsxjciLx9ATokNodvjrUg4JbVQNCL8GzJTLrq79bYUzu8o+BPBoIecYdZPaihATa3dhDsDOcicrKba2AEGuQ/jC2hGTsQUAxeHb
Received: from redhat.com ([2.52.146.238])
        by smtp.gmail.com with ESMTPSA id vb1-20020a170907d04100b00a3cfe376116sm541362ejc.57.2024.02.13.02.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 02:41:52 -0800 (PST)
Date: Tue, 13 Feb 2024 05:41:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Zhangjin Wu <falcon@tinylab.org>, Willy Tarreau <w@1wt.eu>,
	Yuan Tan <tanyuan@tinylab.org>
Subject: Re: [PATCH RFC] misc/pvpanic: add support for normal shutdowns
Message-ID: <20240213053953-mutt-send-email-mst@kernel.org>
References: <20231104-pvpanic-shutdown-v1-1-5ee7c9b3e301@weissschuh.net>
 <2023110407-unselect-uptight-b96d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023110407-unselect-uptight-b96d@gregkh>

On Sat, Nov 04, 2023 at 02:05:02PM +0100, Greg Kroah-Hartman wrote:
> > diff --git a/include/uapi/misc/pvpanic.h b/include/uapi/misc/pvpanic.h
> > index 54b7485390d3..82fc618bfbcf 100644
> > --- a/include/uapi/misc/pvpanic.h
> > +++ b/include/uapi/misc/pvpanic.h
> > @@ -5,5 +5,6 @@
> >  
> >  #define PVPANIC_PANICKED	(1 << 0)
> >  #define PVPANIC_CRASH_LOADED	(1 << 1)
> > +#define PVPANIC_SHUTDOWN	(1 << 2)
> 
> Why are these in a uapi file?
> 
> And if they need to be here, why not use the proper BIT() macro for it?
> 
> thanks,
> 
> greg k-h

This is interface with hypervisor not userspace, but for PV historically
we do this since the compatibility implications are about the same,
hypervisors (e.g. QEMU) are mostly userspace and so it is convenient for
them to reuse the same machinery to export the headers.

Let's stick to that, cleaner than duplicating everything I think.

-- 
MST


