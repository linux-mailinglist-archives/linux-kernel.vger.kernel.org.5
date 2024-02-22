Return-Path: <linux-kernel+bounces-77320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A648603AC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795171C24986
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06E171743;
	Thu, 22 Feb 2024 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0hXCybI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6BD3B287
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633896; cv=none; b=PrFG3mNktHjT/YvcTJUsN8X7GE4FfaMLfrPrbI6M7toB0IzgTLa8XqFiZJ0WAOzqDzYmU0+hGRtUF4jjqsy1aBBlvDsQRK8STWyp5Gnmu+zrv1ykwzrf+AYQjTybufwN651xXn0TMrdk5E7AeUBRUPomqjA5HZbgK2BhXTWWauY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633896; c=relaxed/simple;
	bh=frCw0vw8Hnz0wsAVXoXZBwpSJ02lJS7FmLNaWilu4gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fk2TPZ3Usnq+lyLdRreTS1nEuvMMkqQwTXTsHBlFKdYn/JsVLJrV/pr3NlTcpsWHszVAmtWSVuXu9BOpFmVIhB3rnvrAGBetp5SGAmYVUA55h2k+ivjtN9F6BnkHhbt4s4wA2GuyBnQxXdIHRQesBqT/H0OS7ov6XiDUWilINDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0hXCybI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708633894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ml62MscfXMtib2J91KWEJozUo6pIGfLxBFp+YKWAR2g=;
	b=M0hXCybIr9+UYyuHYWGuXrEvGRc/ujldFcdsPMFEKI4ALXBDqdGKkpJnXM/+NyZY1yD6Ul
	TAvp5NWSHr2dXMo2Lw2pjBImCIsslTuXvxsUkhzKru+DiVfP0tCbdR5/woe7Ija4Yu0UUj
	cI1d4SUGSM8tHoeEZPNjt5qrcd6ZFNE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330--HrSEjiSM8akjnNIrwS0WQ-1; Thu, 22 Feb 2024 15:31:32 -0500
X-MC-Unique: -HrSEjiSM8akjnNIrwS0WQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41290780cafso608385e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:31:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708633891; x=1709238691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ml62MscfXMtib2J91KWEJozUo6pIGfLxBFp+YKWAR2g=;
        b=KIjKxOhYvUHj/0fDHR8ahfOzGnHN8Uc7wE0N9icrlm0x+mFWrlKaYOR0xzKmlrXF5i
         yi0lFtIqIYYb+oTepsGSRkNa7cZqKHuw2sflXkIJ0PajjzQfzGL59665RlHyQSCAjz7M
         abFoBuioTsIFC48vNPzoOj96DMjfwabn8phqPRMyKb6u2Py8HsMD1NEcJYMSqXlaybTv
         Nh30n2x2cluuTsHoDVD24qsqruR1vymeewBqLeDn2ansFniB9xdeUdLbFLlNvZrvViQY
         m0qEErydXFIPTL98dQYXh1AC0Y9B/HW29344Gg9ECjiK/Fa3T/fnUi1UGoNSXzULSr+i
         czSw==
X-Forwarded-Encrypted: i=1; AJvYcCUxPfLULCDOQbgKBN8895Ui1sQtftsXwraSjGru1+wnEHUEF+LcUdWNHypWt57ZMY+N1qxyUtwHFwQ2HsBfVqszWCAiguDgBpyWLXoi
X-Gm-Message-State: AOJu0YxfY3EtMk+CXJANzg8aROMd4Jmf38xhx1nr0T8pvYscUKxGQeEW
	x4Ov8L34FJiqiFOD7X9zrMaleiN4tXJd190C5+7EY5c8HaDrvcDT0I6ZKjn8dByheFcUrtfv2lv
	liSwAcJRAxxYnQcLIPvITSUuKnjWUth0Yeu/8Ge3MzRMlyye54TVpkwem9cBijw==
X-Received: by 2002:a05:600c:3790:b0:40f:cf69:3e1a with SMTP id o16-20020a05600c379000b0040fcf693e1amr15985745wmr.39.1708633891744;
        Thu, 22 Feb 2024 12:31:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3FdHXFce+xg3CWNOl2GOEfrJH/lTzsntzdD95OUI8gjyeZM+JSJT1saB9k7R5eAvOpdv2jQ==
X-Received: by 2002:a05:600c:3790:b0:40f:cf69:3e1a with SMTP id o16-20020a05600c379000b0040fcf693e1amr15985739wmr.39.1708633891400;
        Thu, 22 Feb 2024 12:31:31 -0800 (PST)
Received: from redhat.com ([172.93.237.99])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c298100b0041069adbd87sm7218365wmd.21.2024.02.22.12.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:31:30 -0800 (PST)
Date: Thu, 22 Feb 2024 15:31:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Halil Pasic <pasic@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: virtcrypto_dataq_callback calls crypto_finalize_request() from
 irq context
Message-ID: <20240222153106-mutt-send-email-mst@kernel.org>
References: <20230922154546.4f7447ce.pasic@linux.ibm.com>
 <ed47fb73ad634ca395bd6c8e979dda8e@huawei.com>
 <20230924193941.6a02237f.pasic@linux.ibm.com>
 <20231101092521-mutt-send-email-mst@kernel.org>
 <5d9ebbdb042845009b47e6a9ee149231@huawei.com>
 <20231102091548-mutt-send-email-mst@kernel.org>
 <6e1792a31c1646f4a301faf1a1b42cc1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e1792a31c1646f4a301faf1a1b42cc1@huawei.com>

On Thu, Nov 02, 2023 at 01:25:31PM +0000, Gonglei (Arei) wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Thursday, November 2, 2023 9:17 PM
> > To: Gonglei (Arei) <arei.gonglei@huawei.com>
> > Cc: Halil Pasic <pasic@linux.ibm.com>; Herbert Xu
> > <herbert@gondor.apana.org.au>; Jason Wang <jasowang@redhat.com>;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > linux-crypto@vger.kernel.org; Marc Hartmayer <mhartmay@linux.ibm.com>
> > Subject: Re: virtcrypto_dataq_callback calls crypto_finalize_request() from irq
> > context
> > 
> > On Thu, Nov 02, 2023 at 01:04:07PM +0000, Gonglei (Arei) wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > > > Sent: Wednesday, November 1, 2023 9:26 PM
> > > > To: Halil Pasic <pasic@linux.ibm.com>
> > > > Cc: Gonglei (Arei) <arei.gonglei@huawei.com>; Herbert Xu
> > > > <herbert@gondor.apana.org.au>; Jason Wang <jasowang@redhat.com>;
> > > > virtualization@lists.linux-foundation.org;
> > > > linux-kernel@vger.kernel.org; linux-crypto@vger.kernel.org; Marc
> > > > Hartmayer <mhartmay@linux.ibm.com>
> > > > Subject: Re: virtcrypto_dataq_callback calls
> > > > crypto_finalize_request() from irq context
> > > >
> > > > On Sun, Sep 24, 2023 at 07:39:41PM +0200, Halil Pasic wrote:
> > > > > On Sun, 24 Sep 2023 11:56:25 +0000 "Gonglei (Arei)"
> > > > > <arei.gonglei@huawei.com> wrote:
> > > > >
> > > > > > Hi Halil,
> > > > > >
> > > > > > Commit 4058cf08945 introduced a check for detecting crypto
> > > > > > completion function called with enable BH, and indeed the
> > > > > > virtio-crypto driver didn't disable BH, which needs a patch to fix it.
> > > > > >
> > > > > > P.S.:
> > > > > > https://lore.kernel.org/lkml/20220221120833.2618733-5-clabbe@bay
> > > > > > libr
> > > > > > e.com/T/
> > > > > >
> > > > > > Regards,
> > > > > > -Gonglei
> > > > >
> > > > > Thanks Gonglei!
> > > > >
> > > > > Thanks! I would be glad to test that fix on s390x. Are you about
> > > > > to send one?
> > > > >
> > > > > Regards,
> > > > > Halil
> > > >
> > > >
> > > > Gonglei did you intend to send a fix?
> > >
> > > Actually I sent a patch a month ago, pls see another thread.
> > >
> > >
> > > Regards,
> > > -Gonglei
> > 
> > And I think there was an issue with that patch that you wanted to fix?
> > config changed callback got fixed but this still didn't.
> > 
> Now my concern is whether or not the judgement (commit 4058cf08945c1) is reasonable.
> 
> Regards,
> -Gonglei

So what is the plan to deal with the issue?

-- 
MST


