Return-Path: <linux-kernel+bounces-107509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB7687FD78
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B34283E30
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149807F7C8;
	Tue, 19 Mar 2024 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W727OLu4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D097F48A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710850917; cv=none; b=Y5+zztob8aO2KuyDhuE+tLY9N9VdoEtYH6TuhK14cTgY6Zu55jsUAx2gEo+SVcgqaR8++NoUlCDeD8jbVhouoJrhwL1uYorii7Ldc6siV7E9cA53TZ3g28DmYOFDkuhxM4V08Q+WS0Rk+mUheNc8952rfHRKg2Q/3zkcOeBHLqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710850917; c=relaxed/simple;
	bh=qjqkqT8pZjwVcGcPOjT8S/YwSWCuV7Rv8qOtJCVbWUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsy3a4lXoHPghjKMw7mXUw6MVY7OZ+jdSOaqDVAK/GJrlgMB8RpSn3yWPr97s1cW/4mXeAXW97OzANVfMNgfPH/OxvwCPZ1Q4++aQlJArHfbGrqPQ1dy5NBptMD8YH2WAghl411sLFJvmAB7V3mYvxShaKYLOhod5hxmuAHDhG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W727OLu4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710850914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fcURuON76N2jBOBvhQi/fRmFrRjaRgELhmNbazWraRw=;
	b=W727OLu4y/6TQo9Xn7668FoOZwcRclkuXkBRK8FrYpvQIQeDWUebgR4arJ//k/HCOqAgXF
	uWzi6iHES4OtcSUocon794rHtR978+rKdEs4IITrbKCzv78w8Y2Yv2k4edM+GqlmU3E5hA
	XAaMjTlRaLkFtwDJYTyv6ORRgvKazIo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-_2qNrA5oPMqFS5WFLhzuCw-1; Tue, 19 Mar 2024 08:21:53 -0400
X-MC-Unique: _2qNrA5oPMqFS5WFLhzuCw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5148eaa60acso1699670e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 05:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710850911; x=1711455711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcURuON76N2jBOBvhQi/fRmFrRjaRgELhmNbazWraRw=;
        b=VRKY0tTs/yjFkERI9ncooh4ofyTaCCZLypXHs7oHr1Hw7wXyWtq2MrdVuE3/byqT7T
         ZVaJ5gL/N/zTNx+hhplAXhwGaVmHm85GQFcgV3fKQL2CGbLGb4dFC885btjAu77MfndM
         WOx3HrJvDjic1ndaiOn4iOKmZRHkWaMMiJt6zzj5tax+QAsBIa4X+ElyMH3rCHHHUaXD
         dSavxBG9ZFxSihIuBm69/v3jLxJmq1dwWi5DwlaRinIriKJLaBXeZcm6NmAxVVRIeBKX
         b04xfqTa5PgnYkstYsuNtV6TOkZXS++Y7n8qPutukGCTz5lCZQAB2ShS2buuUH9pKyYV
         Kz8w==
X-Forwarded-Encrypted: i=1; AJvYcCUGJQqOQIscHgF4V5Brynu/AKNzd7VNfIJ+oN6gw/NT7dsW9S7WW1E3HTbHYrp2V4p4gndhtp95u/I8LAaf2jq5lSim58Xws74ObJu4
X-Gm-Message-State: AOJu0YyJMdGOlwi5erXudUm3C4A3/AtZAYXEBbPmZZNqvas8xLAFC9YZ
	GK1vBS21thq2USdsWRZH4MiHOBlBC/zZmro23RtNbtpOOKZldnVx6n/IlVZFVYbBch3qaTV0zXI
	i0xdTTnjP1sR13ge93VsisFrzLoAQCHWAd/0lnNUG2jUPyJqV593chgOPwwtQZg==
X-Received: by 2002:a05:6512:29c:b0:513:1e31:ddec with SMTP id j28-20020a056512029c00b005131e31ddecmr1778315lfp.40.1710850911473;
        Tue, 19 Mar 2024 05:21:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhc9xlMsZwNZSLJmLpjDngn3edaSnQJUFYnLMn1neznXIr75uSIGVCW6AHqadrgQY3NJEJYg==
X-Received: by 2002:a05:6512:29c:b0:513:1e31:ddec with SMTP id j28-20020a056512029c00b005131e31ddecmr1778292lfp.40.1710850910940;
        Tue, 19 Mar 2024 05:21:50 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id f2-20020a7bc8c2000000b00414041032casm442527wml.1.2024.03.19.05.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 05:21:50 -0700 (PDT)
Date: Tue, 19 Mar 2024 08:21:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, david.marchand@redhat.com,
	lulu@redhat.com
Subject: Re: [PATCH v7 0/3] vduse: add support for networking devices
Message-ID: <20240319081938-mutt-send-email-mst@kernel.org>
References: <20240109111025.1320976-1-maxime.coquelin@redhat.com>
 <f25f3c31-c793-4743-a587-0e2063dc2d65@redhat.com>
 <20240201033944-mutt-send-email-mst@kernel.org>
 <27d1fc65-14d2-4a1c-b1fa-c3250ac2356a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27d1fc65-14d2-4a1c-b1fa-c3250ac2356a@redhat.com>

On Thu, Feb 29, 2024 at 11:16:04AM +0100, Maxime Coquelin wrote:
> Hello Michael,
> 
> On 2/1/24 09:40, Michael S. Tsirkin wrote:
> > On Thu, Feb 01, 2024 at 09:34:11AM +0100, Maxime Coquelin wrote:
> > > Hi Jason,
> > > 
> > > It looks like all patches got acked by you.
> > > Any blocker to queue the series for next release?
> > > 
> > > Thanks,
> > > Maxime
> > 
> > I think it's good enough at this point. Will put it in
> > linux-next shortly.
> > 
> 
> I fetched linux-next and it seems the series is not in yet.
> Is there anything to be reworked on my side?
> 
> Thanks,
> Maxime

I am sorry I messed up. It was in a wrong branch and was not
pushed so of course it did not get tested and I kept wondering
why. I pushed it in my tree but it is too late to put it upstream
for this cycle. Assuming Linus merges my tree
with no drama, I will make an effort not to rebase my tree below them
so these patches will keep their hashes, you can use them already.

-- 
MST


