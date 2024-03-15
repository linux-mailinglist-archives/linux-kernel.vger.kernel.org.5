Return-Path: <linux-kernel+bounces-104270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3041B87CB7F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08E3281D34
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D17B1B597;
	Fri, 15 Mar 2024 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVxVNr2+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989D219BCA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710498722; cv=none; b=Gx7Q3GFkbwEAlrJdZBXKHj9uwkvnDavdOUnmkDQ2E+ffY5EmO/HR0Ze8d22X+bSO0Yo/NxH5e5A+NdPf+kDu6rdoydPthtnfdiTVnUFQfvXI3LG71xV9kcEzL3s33fUvVmAGQaZM1AerCkzRISRmYJleQq+3ZyzBK97A0RusU2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710498722; c=relaxed/simple;
	bh=CnKgpulySBPIstBIX+4GBHLu73MwceFKZjKwPr4Yj2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+tMD6j1CbWvvlQVnGQn0TR1rnef1hk4+067D5fk55zm5/Z8ZCr/y+qe5l2wdiH6K6B/P5Fzd08P5T5pxl8zSphZD+jevBNXoJFaeDiNHr6QeyP5L2xxKYQeIb5PTXgeTO7ibUIHz4ODd4oB1WDg8KfMXhGl12aYs9CKIENRUMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IVxVNr2+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710498719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MZnFLHEJZESpYeN3Ng7zY31MsrRVHON+Av+y9YSoKww=;
	b=IVxVNr2+gKyK6sQEiKG4/VpDAIIbQEXTzlx3kyx35CcamLnrV+oK1mRJXcdniRqQazpEu8
	zpQA35EamzvRAmHdHk+Wo5DEQlOIVvJ4FHsBpwY3EYFvUMH51axVzlv0xYlYLJeBIq3in/
	HXCenwmv7E8U75TpDl+/naRSB5IeIuk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-M6DWbJV-Orm7cfzqTP2GWg-1; Fri, 15 Mar 2024 06:31:58 -0400
X-MC-Unique: M6DWbJV-Orm7cfzqTP2GWg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-513c9f60af8so2545393e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 03:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710498716; x=1711103516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZnFLHEJZESpYeN3Ng7zY31MsrRVHON+Av+y9YSoKww=;
        b=ZWl1cIQVtHiIbjfQqI9ux0NLfsMTy9PEyNzxB4672D/5G83b0uyc1LnWn61DWRaYEm
         SWcdIklMrAwXcb3YRARqtp3Bf+LQ3PcBhLngfubDNmuLfQlg8iU/q8Pzlta4f5Cvk/cq
         qOwE7wRAbVUPzE6DGlnYMbhqAeAQFsLMVMR/c+lQviTsixPrZ+LhWNKc96NUsrWv5bWl
         gE/Phi5JYwCb3tmFGsOkamh3YuDvw95bQt5LKXb+ui/wq0AZ/bqQkzla/yKMddGxiUC1
         krCJl1drcRtGhZ6Xwt8GmtVKbbHMNllP9Afy76dQYT1cpdnMTxMnKOykBX08dEwR72R7
         OKvg==
X-Forwarded-Encrypted: i=1; AJvYcCVnopNYhTco+hF55hNVUfdgo12/JZdf/CSPbBYXjwUV3LgxUaU7ZYtR33IlXe7AxZe+J8ME6LAaXygZf6OvQzRkbOc11FyBaLvTHQC1
X-Gm-Message-State: AOJu0YwvcY/iIv0PVkwvJs/suLbAava5FOlY9T+Ob46hkqtN2EgxF0ji
	FoRuk03jLvND8u4SD8ZeSyzdlVv1ogakBKHK8p6ULHA/0ovZuW1Qh4RGOeYwpVKPs5DGT6uw7g/
	GOVqqP8ICnl3P4bizddlG9mDWD6TOcYEqrTVsEZFnpAaCBJgyRhBAjM8W9mdbJQ==
X-Received: by 2002:a19:8c01:0:b0:513:1a38:2406 with SMTP id o1-20020a198c01000000b005131a382406mr3166917lfd.13.1710498716501;
        Fri, 15 Mar 2024 03:31:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAM6kfVM3kaMJlGNo7Ajg4Diy8CaM0JJcB7qTAbD6/81jGCJ0Jyqc8MhtlygniOjlu3WPFjw==
X-Received: by 2002:a19:8c01:0:b0:513:1a38:2406 with SMTP id o1-20020a198c01000000b005131a382406mr3166891lfd.13.1710498715942;
        Fri, 15 Mar 2024 03:31:55 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:3a04:e2ee:42e3:ba74:3b8e])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b00412e3717ae6sm8678154wmo.36.2024.03.15.03.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 03:31:55 -0700 (PDT)
Date: Fri, 15 Mar 2024 06:31:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Luis Machado <luis.machado@arm.com>, Jason Wang <jasowang@redhat.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	nd <nd@arm.com>
Subject: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6 sched/fair: Add
 lag based placement)
Message-ID: <20240315062839-mutt-send-email-mst@kernel.org>
References: <92916.124010808133201076@us-mta-622.us.mimecast.lan>
 <20240121134311-mutt-send-email-mst@kernel.org>
 <07974.124020102385100135@us-mta-501.us.mimecast.lan>
 <20240201030341-mutt-send-email-mst@kernel.org>
 <89460.124020106474400877@us-mta-475.us.mimecast.lan>
 <20240311130446-mutt-send-email-mst@kernel.org>
 <cf813f92-9806-4449-b099-1bb2bd492b3c@arm.com>
 <73123.124031407552500165@us-mta-156.us.mimecast.lan>
 <20240314110649-mutt-send-email-mst@kernel.org>
 <84704.124031504335801509@us-mta-515.us.mimecast.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84704.124031504335801509@us-mta-515.us.mimecast.lan>

On Fri, Mar 15, 2024 at 09:33:49AM +0100, Tobias Huschle wrote:
> On Thu, Mar 14, 2024 at 11:09:25AM -0400, Michael S. Tsirkin wrote:
> > 
> > Thanks a lot! To clarify it is not that I am opposed to changing vhost.
> > I would like however for some documentation to exist saying that if you
> > do abc then call API xyz. Then I hope we can feel a bit safer that
> > future scheduler changes will not break vhost (though as usual, nothing
> > is for sure).  Right now we are going by the documentation and that says
> > cond_resched so we do that.
> > 
> > -- 
> > MST
> > 
> 
> Here I'd like to add that we have two different problems:
> 
> 1. cond_resched not working as expected
>    This appears to me to be a bug in the scheduler where it lets the cgroup, 
>    which the vhost is running in, loop endlessly. In EEVDF terms, the cgroup
>    is allowed to surpass its own deadline without consequences. One of my RFCs
>    mentioned above adresses this issue (not happy yet with the implementation).
>    This issue only appears in that specific scenario, so it's not a general 
>    issue, rather a corner case.
>    But, this fix will still allow the vhost to reach its deadline, which is
>    one full time slice. This brings down the max delays from 300+ms to whatever
>    the timeslice is. This is not enough to fix the regression.
> 
> 2. vhost relying on kworker being scheduled on wake up
>    This is the bigger issue for the regression. There are rare cases, where
>    the vhost runs only for a very short amount of time before it wakes up 
>    the kworker. Simultaneously, the kworker takes longer than usual to 
>    complete its work and takes longer than the vhost did before. We
>    are talking 4digit to low 5digit nanosecond values.
>    With those two being the only tasks on the CPU, the scheduler now assumes
>    that the kworker wants to unfairly consume more than the vhost and denies
>    it being scheduled on wakeup.
>    In the regular cases, the kworker is faster than the vhost, so the 
>    scheduler assumes that the kworker needs help, which benefits the
>    scenario we are looking at.
>    In the bad case, this means unfortunately, that cond_resched cannot work
>    as good as before, for this particular case!
>    So, let's assume that problem 1 from above is fixed. It will take one 
>    full time slice to get the need_resched flag set by the scheduler
>    because vhost surpasses its deadline. Before, the scheduler cannot know
>    that the kworker should actually run. The kworker itself is unable
>    to communicate that by itself since it's not getting scheduled and there 
>    is no external entity that could intervene.
>    Hence my argumentation that cond_resched still works as expected. The
>    crucial part is that the wake up behavior has changed which is why I'm 
>    a bit reluctant to propose a documentation change on cond_resched.
>    I could see proposing a doc change, that cond_resched should not be
>    used if a task heavily relies on a woken up task being scheduled.

Could you remind me pls, what is the kworker doing specifically that
vhost is relying on?

-- 
MST


