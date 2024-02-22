Return-Path: <linux-kernel+bounces-77253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC7986029D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFA91C24938
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F846AF81;
	Thu, 22 Feb 2024 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIBwBhIh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08177548E4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629829; cv=none; b=gpM/Rebv7jZOSKZehKItZ3TwR+xr3R9dkw7z5CTFmlmUdSaN/jXv2m6RqApESQLruzFPR1oeTZ/SMsgQEGqMB8DKQe5M1S3sc/2Q7bJYTSvjyhxihHNGNoXWH6XfYr8DQzY63nxJQsg+EYI3iSHGREFIv3F4W+W3vMv3j2A9Izs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629829; c=relaxed/simple;
	bh=cq3Cnk+GZrsQGPtsY4OcFojjqqyL9ctq/cxxaE9pID4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmjDWp1PI8/L6++hgVlZ/t7a7jlJXoi8UhuvIp9oYhvg3qm7qC3YUQqHFocdCfeceWYaSqWcPQ85UFjv3vdltZ0vulp1sAnzb4ASAs0Dh2Upml0wyxGoIlSj4osXs0CBJi280/pX2vpG/g25mrUDQQiO7ytr+e9W+NIpuQKTiL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OIBwBhIh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708629827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nZ+RDIdGnhU5lg6jFGeCqCjJlhqa8k7CnALV244t9Yw=;
	b=OIBwBhIhS2r/I+/oeNfPlj3uvErLzJKBvwRTj2SyC9ZDDmxOA/0bCkGeJBgSUEtvfJn8hZ
	D2ykKI6THH4Psgb+Eu3Wa+LfU5gWRmVJCE7cdwhy7ewRR9bqZm76mxzYQvprS9ti/OB7wB
	zhXDThdOhmNeKBudbR9VzN2oRufT1Cw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-2DEm0RmPMfKhBOcgchMomQ-1; Thu, 22 Feb 2024 14:23:45 -0500
X-MC-Unique: 2DEm0RmPMfKhBOcgchMomQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41290676819so298535e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:23:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708629824; x=1709234624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZ+RDIdGnhU5lg6jFGeCqCjJlhqa8k7CnALV244t9Yw=;
        b=D02ALBMcB18nvMQa85NcvSAFA9hSI/TARocAHSbM7YqkAp7wS1paeOIrX6rD94ja6g
         M5sNRy2aKFKhus3YXcsKL9Yp2XeEogITcCbmGru3hadLoPrTNezS1+l7MkY4LRJ0vWr1
         MFeEL1s5+KResTVxtoqUzD8KDd2IxUgv5rITlMnlOpT1pY9a5doPcJJ4vxDMtsPm318w
         zSWWvPdZEXVZZ9IEpUhAtbW6ltuWw8eYCSFlY49SI7tkcgsW3fk2jCm8krGRdTnkicvc
         08TTLkUhRQaKqUXLPeUdeCKslPWy5zsgv9GlJZ5cUmIEykbY5YdhhhWSkFxzofwsmKXJ
         4gQw==
X-Forwarded-Encrypted: i=1; AJvYcCXngP+FizuNPgo6uC0l3NjHAAEgfxhjUZF2DLoaRG1yQ+dwouycX8GostG+WzvWLDgWXmSyWSmpz4Y1/rZfofubAQN33vjR5/BY5L8z
X-Gm-Message-State: AOJu0Yx+6XJcUTvEAtUpDAnzHe+iTYqL1YxUUFnYVi4sqM8PMYK/Hyeq
	km7S3VSIoSteAqvTN1z8z3VyHLS+HXY3CMTbZ7gSImRRyJtKAjbwQXoG4yT+c1Ejfi/Zepp+0gw
	aIfYaqVvQ+nJRVp1KGT7hseWnkhamqgROg39cIPMGTXUxL+g9XbciywKpbeHsLg==
X-Received: by 2002:a05:600c:4c99:b0:40e:a569:3555 with SMTP id g25-20020a05600c4c9900b0040ea5693555mr18945734wmp.35.1708629824327;
        Thu, 22 Feb 2024 11:23:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRkfAP3Yd4xKF6bdlzBebTP+hY1tBDnghJRdAmvC+uFZRuB+6mlbezFnXDMpRlAhkJUEHJUQ==
X-Received: by 2002:a05:600c:4c99:b0:40e:a569:3555 with SMTP id g25-20020a05600c4c9900b0040ea5693555mr18945722wmp.35.1708629824024;
        Thu, 22 Feb 2024 11:23:44 -0800 (PST)
Received: from redhat.com ([172.93.237.99])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c311000b004127942bcd6sm5410408wmo.7.2024.02.22.11.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 11:23:43 -0800 (PST)
Date: Thu, 22 Feb 2024 14:23:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Jason Wang <jasowang@redhat.com>, Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20240222142254-mutt-send-email-mst@kernel.org>
References: <42870.123121305373200110@us-mta-641.us.mimecast.lan>
 <20231213061719-mutt-send-email-mst@kernel.org>
 <25485.123121307454100283@us-mta-18.us.mimecast.lan>
 <20231213094854-mutt-send-email-mst@kernel.org>
 <20231214021328-mutt-send-email-mst@kernel.org>
 <92916.124010808133201076@us-mta-622.us.mimecast.lan>
 <20240121134311-mutt-send-email-mst@kernel.org>
 <07974.124020102385100135@us-mta-501.us.mimecast.lan>
 <20240201030341-mutt-send-email-mst@kernel.org>
 <89460.124020106474400877@us-mta-475.us.mimecast.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89460.124020106474400877@us-mta-475.us.mimecast.lan>

On Thu, Feb 01, 2024 at 12:47:39PM +0100, Tobias Huschle wrote:
> I'll do some more testing with the cond_resched->schedule fix, check the
> cgroup thing and wait for Peter then.
> Will get back if any of the above yields some results.

As I predicted, if you want attention from sched guys you need to
send a patch in their area.

-- 
MST


