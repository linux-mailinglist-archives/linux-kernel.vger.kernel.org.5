Return-Path: <linux-kernel+bounces-58385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34AF84E58F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B5ECB23540
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9CA8002C;
	Thu,  8 Feb 2024 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/V4bG9s"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954F97EF1C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411302; cv=none; b=hP3kRpZziDN0G9yzB06nRzryUfPIYwDRpowrCGvwK6X8+JUnNU+4JoZTJVDOo4f+z3zxgb/9/43Qp5Ew92bkZN0PrGLPsZuxgFth63bWXMT93LWEzglr535Xrgi8y99c+g6jTGSE1X8r53NgQ/exzr7hljnYz4WOXCcZdIN1Bhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411302; c=relaxed/simple;
	bh=Hqdzk76SRqhICM3GB7WDS80yEJOio9cExmmNYlYFQUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiFdm6z4yOHZ3kgoinfu360DmqALSf83cJpcKu4FIQt2OBLIVX9AhCqQy7w251ucxzQyngEXfKf6uKq06IKZGQgXd8s5NHqXoMl8OF11kGiXpdoocwuoN1EpH31hodA2dv/2ar4Z9JPqR1YI060I18wfKC9gudipNfQvy0zKn2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/V4bG9s; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d7431e702dso18936035ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 08:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707411300; x=1708016100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3u9szKpYPyrNy5jvkhk/rgkbDNkIR1zBJBDv2G3wdo=;
        b=Y/V4bG9sGcyHophT92ysw4HNPrL6uPLwyAX7sVSdAaHllV4D3RdbEU9Muv4IfOBPJW
         ZniDfRDPHGlLxRfs1fqo00f87MhZ2Xe+6DiZy5jAU7/7CynZSgCiPD9AtA4WJNf1+q4x
         bFDD4/0jbEkmQZiXhTCNL+Png9yUtxGWfRA0Uif+y3hQ8O4sV0HpnRxevpLvNS7qIBH0
         SIdZL/ptvnoqhqjuINPgUHYKVV99ewkkm6mLC4xdXV+WC+IZM6504JkeozKvkKWz1Nri
         06OJd9AHg7yTdv6YGIoQ69/Hr0f4kfpjeOJTAdErg7kPKqJvdei2OBwT1KX7WTpZ4XEi
         0wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707411300; x=1708016100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3u9szKpYPyrNy5jvkhk/rgkbDNkIR1zBJBDv2G3wdo=;
        b=YcIUK6NjIyf7le8PGMf//sNMHNZRI5kaynettuKY02piU3Cxf6UbozupEq1hdwgntY
         21rgc2b+sJakXl/xC9rdtruBot+mYGO6SxOeXnpDM/ZDru7TeQR9AYDT4ONF+upd6sKw
         yWcIGNUYQdWUmMqpk6INeAJ80k+RbeUHaUas0H7o03ImbMrjYbpQGmKhsmhC463U6oRR
         rTJ2uYbeLUeXKRX1nhOdzQiD20yS/pQow3+1YloKgeon/EOhb5idKJHE4W94/YWyq1Tu
         gAipA0LaBVn3Sd4Ek6Rx86YO7hBvS7XFXJjUPH03ibstIm02+TYesfw/ifoKVoNmU+JZ
         ElXg==
X-Gm-Message-State: AOJu0Yx9n2g9j2hvvzaENKjsShUSGMKlzQkfNGMxsrp3qpU/Nq/e2Kv/
	2tva9mtI0eQ1y5RsBIm4BHfRnsORbHo8ZdE6V/eerLeoUu/96VG6
X-Google-Smtp-Source: AGHT+IGMDDzANQUpMfYrvvrzjjjc9FmFqTvvx3R0LudbSNzyR3yiriLO7OFgHW0EpK8uOTSy1kTI7Q==
X-Received: by 2002:a17:90a:bc98:b0:296:37c7:3b6b with SMTP id x24-20020a17090abc9800b0029637c73b6bmr6699576pjr.2.1707411299696;
        Thu, 08 Feb 2024 08:54:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWOpiHuSHXd5vHT7dR5LB7rPYpA8jr2dieWyLxEPQG+sXmvwLnpToPg8HdpmytruGF7PrWShMcvpLIxNrLFh3CuxDlIMPhmy2p371QjYz5Y6lhj0uSz8hqhYDZ2yXusPG8CPEniooKonwhRWFgoTHXhCuHQ8WNC
Received: from localhost ([2620:10d:c090:400::4:3c45])
        by smtp.gmail.com with ESMTPSA id nb16-20020a17090b35d000b002970410a047sm392036pjb.24.2024.02.08.08.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:54:59 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 8 Feb 2024 06:54:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: make wq_subsys const
Message-ID: <ZcUHYUVnVTwb_ZSF@slm.duckdns.org>
References: <20240206-bus_cleanup-workqueue-v1-1-72b10d282d58@marliere.net>
 <2024020752-tannery-frozen-04ea@gregkh>
 <ZcOxE2nznfq7dcNh@slm.duckdns.org>
 <2024020813-wool-haste-fe6d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024020813-wool-haste-fe6d@gregkh>

On Thu, Feb 08, 2024 at 10:10:56AM +0000, Greg Kroah-Hartman wrote:
> On Wed, Feb 07, 2024 at 06:34:27AM -1000, Tejun Heo wrote:
> > On Wed, Feb 07, 2024 at 10:12:34AM +0000, Greg Kroah-Hartman wrote:
> > > On Tue, Feb 06, 2024 at 03:05:06PM -0300, Ricardo B. Marliere wrote:
> > > > Now that the driver core can properly handle constant struct bus_type,
> > > > move the wq_subsys variable to be a constant structure as well,
> > > > placing it into read-only memory which can not be modified at runtime.
> > > > 
> > > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > > > ---
> > > > The maintainer asked [1] for this patch to be received through the
> > > > driver-core tree.
> > > > [1]: https://lore.kernel.org/all/ZcEeOueCbrltxr_b@slm.duckdns.org/
> > > 
> > > There is no cross-tree dependency at all, but hey, I'll take it, no
> > > worries...
> > 
> > Ah, my bad. I branched out wq/for-6.9 before rc1 and was assuming the
> > dependent commit was still in the driver core branch. I should have just
> > pulled linus#master.
> 
> The dependent changes are in 6.4, so before -rc1 would have been ok as
> well :)

Hmmm....

 > git log -1 --oneline 32f78abe59c7
 32f78abe59c7 driver core: bus: constantify subsys_register() calls
 > git describe --contains 32f78abe59c7
 v6.8-rc1~61^2~10

-- 
tejun

