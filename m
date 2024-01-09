Return-Path: <linux-kernel+bounces-21448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB089828F3A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2C31C23FDC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496F63DB9B;
	Tue,  9 Jan 2024 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWHQz/3w"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7A83DB89;
	Tue,  9 Jan 2024 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3e05abcaeso20750905ad.1;
        Tue, 09 Jan 2024 13:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704837089; x=1705441889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4XACuuvaxg6iNNy3U1OF2HVW2+gq8zC1xPatIaJOAU=;
        b=XWHQz/3wmsJ7wPuDR2XmqxB8Q1DKHeny5uPB2eaJjoAU49spZYThOdvtSMfvNG9hLp
         wkRGggFUZY7tcZJmzrPjx3kAhelkUbaaQh1IMwEap5F2h8nQpIY/fp7CHrlvoht+0jZd
         aEPQCJ/XgiTADe/IShczxqoMLb1jn1ZdNCJ4b38nqUc/45BoJlmZNbZyEfgaeHur7/IN
         qAEqaJdh/QlDGOnZoP7PLeu9d40t9u6MsmXEctZQdtm0lCAqIBMOEGTkw7GAbFAqQIde
         ZVdpUVwUgL/FCMvxEu6TlPR7UeWWnDJOmYeg/CRBZD73R4b10KfqurveWzDlf8ZAe7R+
         kHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704837089; x=1705441889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4XACuuvaxg6iNNy3U1OF2HVW2+gq8zC1xPatIaJOAU=;
        b=d9c7Cu3qJHE404AoyaXo36DNX61MQmNweVPsDEcUEINJJ1uNTt+RidoUvcffHVbySY
         UmgznPa8fDUZMzUTKzezOlFgRXvdGeJjJ7nNLh9KH8j8dPI/F6N5N4D6rQ3UinliTHWv
         U9+MhwcWgR+WH5nBpOC7rzEXFP9M5rVrj5+FpnSuKfj2IkKHkvG7LSgEMDJodZiLiSxs
         +1L/MN66XKKa1jmASn/E/VbZuZ+kThbZrM/AZuS1mVgrfhA0qxcDIu06awS68ZHTih64
         lkst4kdYr3zQQpbeJ5/D6JJ9iNzEQQyAHrlCexNuEOLapehBjgESXeZO3DNQ9SYFBmao
         eDPQ==
X-Gm-Message-State: AOJu0YywJ3b9YNlTIuQgDT/wBPN78L08m1NkqfMBfZRQ7iHB9im+sMw2
	X/goTwELosfPU/79CnxpElbZNFgmmxk=
X-Google-Smtp-Source: AGHT+IGQoepg3uVolJbpdyHgBEwX4/pMIRql3JTpVTXDgDIA1REodRjuLopMrrujNQWq4ChAhIRUcg==
X-Received: by 2002:a17:90a:d811:b0:285:b3a8:40ac with SMTP id a17-20020a17090ad81100b00285b3a840acmr2945010pjv.19.1704837088696;
        Tue, 09 Jan 2024 13:51:28 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:fd50])
        by smtp.gmail.com with ESMTPSA id o1-20020a17090aac0100b0028bd303dc58sm2472323pjq.11.2024.01.09.13.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 13:51:28 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 9 Jan 2024 11:51:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] kernfs: convert kernfs_idr_lock to an irq safe raw
 spinlock
Message-ID: <ZZ2_3n9rJnhcYmpk@slm.duckdns.org>
References: <20231229074916.53547-1-andrea.righi@canonical.com>
 <CAMuHMdV=AKt+mwY7svEq5gFPx41LoSQZ_USME5_MEdWQze13ww@mail.gmail.com>
 <ZZ18xVq4GtQsTC8Z@gpd>
 <ZZ2ZdoNyBhR7o83I@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ2ZdoNyBhR7o83I@slm.duckdns.org>

On Tue, Jan 09, 2024 at 09:07:34AM -1000, Tejun Heo wrote:
> On Tue, Jan 09, 2024 at 06:05:09PM +0100, Andrea Righi wrote:
> > On Tue, Jan 09, 2024 at 05:35:36PM +0100, Geert Uytterhoeven wrote:
> > > Reverting commit c312828c37a72fe2 fixes that.
> > > I have seen this issue on several Renesas arm32 and arm64 platforms.
> > > 
> > > Also, I am wondering if the issue fixed by commit c312828c37a72fe2
> > > can still be reproduced on v6.7-rc5 or later?
> > 
> > Yep, I can still reproduce it (this is with v6.7):
> ...
> > I'm wondering if using a regular spinlock instead of a raw spinlock
> > could be a reasonable compromise.
> 
> I don't think that'd work on RT as we can end up nesting mutex inside a raw
> spinlock.
> 
> > We have a GFP_ATOMIC allocation in __kernfs_new_node():
> > 
> > 	raw_spin_lock_irqsave(&kernfs_idr_lock, irqflags);
> > 	ret = idr_alloc_cyclic(&root->ino_idr, kn, 1, 0, GFP_ATOMIC);
> > 	...
> >         raw_spin_unlock_irqrestore(&kernfs_idr_lock, irqflags);
> > 
> > That should become valid using a
> > spin_lock_irqsave/spin_unlock_irqrestore(), right?
> 
> Yeah, this part should be fine. I think the right thing to do here is making
> the idr RCU safe so that lookup path doesn't depend on the lock.
> 
> Greg, can you please revert c312828c37a72fe2 for now?

I sent out a patchset to revert the commit and implement a different fix.

  http://lkml.kernel.org/r/20240109214828.252092-1-tj@kernel.org

Thanks.

-- 
tejun

