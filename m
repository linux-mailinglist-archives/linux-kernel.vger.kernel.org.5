Return-Path: <linux-kernel+bounces-52077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB978493DC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1E02841F6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCE1B645;
	Mon,  5 Feb 2024 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnPtCfqX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A1A945A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707114630; cv=none; b=hyQkEqtHDjaVh+U3sO2HJsj6IU+PxjHWQxY6EGrZ0WvQw2B7o4YrBmFlv2Y4iexGIzcLPfDE4L9FGfYiLKQa8wvlHCF3Uvdb+EPXWBJFRPAGpoXlTXDZWsn/phM3alPwYQ2RkqaBfBg6C1rRoiDcUyofD0gxhs+JcpUlDjo0rhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707114630; c=relaxed/simple;
	bh=bnScuGLju9VHQImcMtTPD+sGgaX5LcFPr2iaF0yk4V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5aYErTqwmKM/aQYyTLXFRz4t3gXb9XgZFziHODMAhD4prZKu774JCZ5M8Vw7LDQh+oClhmafuy/nvPb7vF+c6xZFJgx20sLIuJZJjDQjysNt+msNN+W2/moiaJO+1Y4lkEfSwfVwC90efQ2F4cqRmmL0ycFUNn7hoto/aqA4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BnPtCfqX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707114624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eV/tLnsqNhW+pRy+AA8xpyhzKsi7N3av2R672qVebY8=;
	b=BnPtCfqXm+Xmm1eR+eRAiM+bajCtxqigQfzKj3KGgW5vHe4JVpBLe7W52vsNNAcP5uBH6/
	keBWz+ZaHh8tlxnacq//Zjl7V/XB3SI40nQOio3SgrHPvQ1EKh/QUUWDF5R7ho2cuw8lvP
	5TAm1YbJuV+xkbg7tQp3cU5fyEu+ZYs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-5QS9zIKFPJqaXMuN4vmQQQ-1; Mon, 05 Feb 2024 01:30:21 -0500
X-MC-Unique: 5QS9zIKFPJqaXMuN4vmQQQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40fd34dcad4so8351565e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 22:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707114620; x=1707719420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eV/tLnsqNhW+pRy+AA8xpyhzKsi7N3av2R672qVebY8=;
        b=sh7jrdBDvSvYSWEXfpaH4D9PXGTgr/iJGqGWqX3V5Qlg0W9p/IuBWRbNbxV8P+0t7Z
         wZRZmLsxZeVeOX6AUzt5JB1sathQQ58mDKfhJoXUwUy+pqNGdnvPajtnrO/Hs4+AMGe/
         ses5NzURYnGMUvxZpHzry1gAJ0jNbberf3RsnB7vBNgWMTicfRtWwJ1LmKUQf9ohEqFb
         nOnNMcW84PerN13WqT89pkBOSYXjtOPRPA8Ptv6p7Nq5oSePchs2YQv/XzFa4zC5iFtx
         XXo9OH5y7XDHNqgRad/s8sjcMoM1eCqABfPjFcs+OA+iOXKu2UuWs8en3iCQZnEGf9xI
         emNg==
X-Gm-Message-State: AOJu0Ywtts53bTgSxWxpLogrx1lraz5lOOY1XerDThKZ3Std2uR5pGxd
	pZs9rHekf6Yg7RpcFk4Fw5jVP9hWksYQUjzngGdqI4jYwoT87SPoBFkvHOskw6PPDvNuVKJmbJ7
	2t+yRGiYr6tR/5uNbMZASxRubTLvaJ9T68z1mUY/rV6i7ffEV5wO64Vl5s0b1Pw==
X-Received: by 2002:a05:600c:45c7:b0:40f:dd72:d9f with SMTP id s7-20020a05600c45c700b0040fdd720d9fmr357931wmo.39.1707114620414;
        Sun, 04 Feb 2024 22:30:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHA4MyzFsH4am2+kILCpONQh6/6SLjmRL1eyr+CfyjEfDM3MaaoPG0EwQuB76QAX7G6evEZ3w==
X-Received: by 2002:a05:600c:45c7:b0:40f:dd72:d9f with SMTP id s7-20020a05600c45c700b0040fdd720d9fmr357920wmo.39.1707114620065;
        Sun, 04 Feb 2024 22:30:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV3sQVj5SHh2F2lZa5pTdQxPYuu9vrWDuyhWTLZBbW4lWlYlxKhOZ+WYusp6rPJEf6KAaQRi1Q1U2VClgQW20/L18FXIETTdGnsbWhNLonpNEIDGuX7eP7CtGIV0HdAgZy3/oI8I/4eaMO8p9YAzhmpamvzUOQrrkYe+zjO/zyq/mIUbWt34O1LZ8nsVXo=
Received: from localhost.localdomain ([151.29.75.172])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c4f5000b0040e3635ca65sm7611024wmq.2.2024.02.04.22.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 22:30:19 -0800 (PST)
Date: Mon, 5 Feb 2024 07:30:17 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>
Subject: Re: [RFC PATCH 0/3] workqueue: Enable unbound cpumask update on
 ordered workqueues
Message-ID: <ZcCAefuXoVAFgew4@localhost.localdomain>
References: <20240130183336.511948-1-longman@redhat.com>
 <ZbpElS5sQV_o9NG1@localhost.localdomain>
 <89927d84-279a-492e-83d3-6d3e20b722f7@redhat.com>
 <Zbtv4v2KCKshnCL2@localhost.localdomain>
 <ff2c0ce1-4d40-4661-8d74-c1d81ff505ec@redhat.com>
 <Zb0CU2OrTCv457Wo@localhost.localdomain>
 <Zb0hXLDlXmfmn_Yw@slm.duckdns.org>
 <d7adf125-52d2-47b1-9abb-c2c085eb5382@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7adf125-52d2-47b1-9abb-c2c085eb5382@redhat.com>

On 02/02/24 14:03, Waiman Long wrote:
> On 2/2/24 12:07, Tejun Heo wrote:
> > Hello,
> > 
> > On Fri, Feb 02, 2024 at 03:55:15PM +0100, Juri Lelli wrote:
> > > Indeed. I believe this is what my 3/4 [1] was trying to cure, though. I
> > > still think that with current code the new_attr->cpumask gets first
> > > correctly initialized considering unbound_cpumask
> > > 
> > > apply_wqattrs_prepare ->
> > >    copy_workqueue_attrs(new_attrs, attrs);
> > >    wqattrs_actualize_cpumask(new_attrs, unbound_cpumask);
> > > 
> > > but then overwritten further below using cpu_possible_mask
> > > 
> > > apply_wqattrs_prepare ->
> > >    copy_workqueue_attrs(new_attrs, attrs);
> > >    cpumask_and(new_attrs->cpumask, new_attrs->cpumask, cpu_possible_mask);
> > > 
> > > operation that I honestly seem to still fail to grasp why we need to do.
> > > :)
> > So, imagine the following scenario on a system with four CPUs:
> > 
> > 1. Initially both wq_unbound_cpumask and wq A's cpumask are 0xf.
> > 
> > 2. wq_unbound_cpumask is set to 0x3. A's effective is 0x3.
> > 
> > 3. A's cpumask is set to 0xe, A's effective is 0x3.
> > 
> > 4. wq_unbound_cpumask is restore to 0xf. A's effective should become 0xe.
> > 
> > The reason why we're saving what user requested rather than effective is to
> > be able to do #4 so that the effective is always what's currently allowed
> > from what the user specified for the workqueue.

Thanks for the explanation!

> > Now, if you want the current effective cpumask, that always coincides with
> > the workqueue's dfl_pwq's __pod_cpumask and if you look at the current
> > wq/for-6.9 branch, that's accessible through unbound_effective_cpumask()
> > helper.
> 
> Thank for the explanation, we will use the new unbound_effective_cpumask()
> helper.

Right, that should indeed work.

Best,
Juri


