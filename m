Return-Path: <linux-kernel+bounces-33945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F18283707B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5B91C26DCD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D70B65BC4;
	Mon, 22 Jan 2024 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bGSoKINB"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B12764CFC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946922; cv=none; b=Bdi4OYKtgeCi3/HCtiNnvT+ejuZxOTvQ/8mZBacVl22Sb3duL5nIMsLndboza+98SktjUZSh3v7uX3EFtrgf1h4BN/D2EH+//kiUJUMV3ZasWHspFzDiqeKAV8AA4FjO185jDWd1tF4TSIwpwSiBiyCYBGcxX9/q+qH/LcUdhL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946922; c=relaxed/simple;
	bh=glO4E1CBWn+E1r18Fj5DimTfsEQJ3OpiF6I6I20ue/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDuVzD1XPiroBsAgDcMGTrwCnRHO1Iyk8jss9LhC0xMEH4EC8AQocazDGwcHwCB9XO/mn1HpLMOLoaFgYXRGxZiIXYuMhNhWVhBVBn3u+C1VEq0kD5yPu+LnSotrn7OyZ7RiMMwbEZ7Ib8ZF3cuqyXnkzEahqdJdnFe/ag2jCyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bGSoKINB; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6dc1f02090fso195589b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705946920; x=1706551720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HNbdTgv8LALJmYPGcQM74cnTmy4haJi+ExYqF4VhU+o=;
        b=bGSoKINBJZbmm4FeuAZrN2E/uj2/UWMwlhM+og66luboHQl+CWiaollyGBKHPJ1vHZ
         HzHqKu6QcgwA/mZaXxmTXIncBpcmz1r6UipG1vQkOKeOl1GNkXyMm1Z3n6dR7DkQsB6C
         Ym/z83T2k3Y02xV3hMDmq/nQQScGreDiNlC+mxRRpw1zdgfHdxHO6Nfwxbu+MoKQU6JJ
         EdPLCUCd/oc39C43I5B0EIc3MhsXiwoRE1EoffzmHguG4ISbkNbHbJ52kwaBONcX9Wkf
         d3/Ax+osTLw6C6e+RmR/QUoo8QCzDU1Mg2xcI1E3Tnje6iv5xG7AERrsb1cOo4U5ubxL
         9ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705946920; x=1706551720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNbdTgv8LALJmYPGcQM74cnTmy4haJi+ExYqF4VhU+o=;
        b=QLIOAM2jBoInaSzo8bGnPcZx2YRGqDCIAmxXVD8WDfrgycOJp4SaBaM3qcvnUmGmBy
         gfT6raC2PXwHV5rRYD2xiKWQ4YI6DwBddeb7DoR/P7uX6dnk1GjbKPamN/w1ZM1EoZXz
         LhUUiphUYhFp5MjygIEGw26SU7x7jCKNyvzAV6kEPfPWHJk2QMsxdAloWnC2Bq3KEGJ3
         Q921JpC/T5xIfrZIerEHw1+YJ1/TIUav473CLrId5pvIByrDcYJ3SiMI/VudcfUULPY/
         kecZbbWiJGFOirJ4WGhczUw2eB2aSGaT/xXh7Fd4TCY8s1JvZgelDWv6LahLI0NCders
         oaag==
X-Gm-Message-State: AOJu0YwPFWxFK/zk6VEqPSAgKBGWnNrnGR0XGtLlcGooK5uNMn6I2qRv
	+gR7WCQ6Wuuhr39NpY7l12WidKJ8AK7/e+pU7Hnmp5oUuMp0qFhlpYB9oqOiWg==
X-Google-Smtp-Source: AGHT+IGj+eRpJnGrLAJVCgoUSeqyFZJsTXXsbxwvvTWCl2VM75IJiFFpnDKw3znEa402JqO96TgRuw==
X-Received: by 2002:a05:6a00:2d24:b0:6db:e166:2e8c with SMTP id fa36-20020a056a002d2400b006dbe1662e8cmr2231267pfb.23.1705946919601;
        Mon, 22 Jan 2024 10:08:39 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id g22-20020a056a0023d600b006da14f68ac1sm9884357pfc.198.2024.01.22.10.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:08:39 -0800 (PST)
Date: Mon, 22 Jan 2024 18:08:36 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Sherry Yang <sherryy@android.com>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 05/28] binder: fix unused alloc->free_async_space
Message-ID: <Za6vJC1o83xSwab3@google.com>
References: <20231201172212.1813387-1-cmllamas@google.com>
 <20231201172212.1813387-6-cmllamas@google.com>
 <Zal9HFZcC3rFjogI@google.com>
 <2024011955-quotation-zone-7f20@gregkh>
 <Zaqw9k4x7IUh6ys-@google.com>
 <2024012203-expedited-job-1d79@gregkh>
 <2024012214-ideology-curvature-febb@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024012214-ideology-curvature-febb@gregkh>

On Mon, Jan 22, 2024 at 07:05:29AM -0800, Greg Kroah-Hartman wrote:
> On Mon, Jan 22, 2024 at 07:04:20AM -0800, Greg Kroah-Hartman wrote:
> > On Fri, Jan 19, 2024 at 05:27:18PM +0000, Carlos Llamas wrote:
> > > On Fri, Jan 19, 2024 at 06:49:00AM +0100, Greg Kroah-Hartman wrote:
> > > > On Thu, Jan 18, 2024 at 07:33:48PM +0000, Carlos Llamas wrote:
> > > > > On Fri, Dec 01, 2023 at 05:21:34PM +0000, Carlos Llamas wrote:
> > > > > > Each transaction is associated with a 'struct binder_buffer' that stores
> > > > > > the metadata about its buffer area. Since commit 74310e06be4d ("android:
> > > > > > binder: Move buffer out of area shared with user space") this struct is
> > > > > > no longer embedded within the buffer itself but is instead allocated on
> > > > > > the heap to prevent userspace access to this driver-exclusive info.
> > > > > > 
> > > > > > Unfortunately, the space of this struct is still being accounted for in
> > > > > > the total buffer size calculation, specifically for async transactions.
> > > > > > This results in an additional 104 bytes added to every async buffer
> > > > > > request, and this area is never used.
> > > > > > 
> > > > > > This wasted space can be substantial. If we consider the maximum mmap
> > > > > > buffer space of SZ_4M, the driver will reserve half of it for async
> > > > > > transactions, or 0x200000. This area should, in theory, accommodate up
> > > > > > to 262,144 buffers of the minimum 8-byte size. However, after adding
> > > > > > the extra 'sizeof(struct binder_buffer)', the total number of buffers
> > > > > > drops to only 18,724, which is a sad 7.14% of the actual capacity.
> > > > > > 
> > > > > > This patch fixes the buffer size calculation to enable the utilization
> > > > > > of the entire async buffer space. This is expected to reduce the number
> > > > > > of -ENOSPC errors that are seen on the field.
> > > > > > 
> > > > > > Fixes: 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
> > > > > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > > > > ---
> > > > > 
> > > > > Sorry, I forgot to Cc: stable@vger.kernel.org.
> > > > 
> > > > 
> > > > <formletter>
> > > > 
> > > > This is not the correct way to submit patches for inclusion in the
> > > > stable kernel tree.  Please read:
> > > >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > > > for how to do this properly.
> > > > 
> > > > </formletter>
> > > 
> > > Oops, here is the complete info:
> > > 
> > > Commit ID: c6d05e0762ab276102246d24affd1e116a46aa0c
> > > Subject:   "binder: fix unused alloc->free_async_space"
> > > Reason:    Fixes an incorrect calculation of available space.
> > > Versions:  v4.19+
> > > 
> > > Note this patch will also have trivial conflicts in v4.19 and v5.4
> > > kernels as commit 261e7818f06e is missing there. Please let me know and
> > > I can send the corresponding patches separately.
> > 
> > It doesn't even apply to 6.7.y either, so we need backports for all
> > affected trees, thanks.
> 
> Now I got it to apply, but we need backports for 5.4.y and 4.19.y,
> thanks.
> 
> greg k-h

Backports sent.

linux-4.19.y:
https://lore.kernel.org/all/20240122174250.2123854-2-cmllamas@google.com/

linux-5.4.y:
https://lore.kernel.org/all/20240122175751.2214176-2-cmllamas@google.com/

Thanks,
Carlos Llamas

