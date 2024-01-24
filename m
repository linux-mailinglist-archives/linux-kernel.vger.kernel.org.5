Return-Path: <linux-kernel+bounces-36222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F40839DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B5E1F284B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51B210E5;
	Wed, 24 Jan 2024 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkZPUw+Q"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF492655
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706056227; cv=none; b=Zc/JXmi3Vl78+q5+0v0JA3915ZfH48hvyCgbwJ5XahVlkp5x2sRWBnBVXi0TKdaQGNxVviA052irpyPUKhNS4o0GFwzAkBsvHtg7XLynfa0PBSOiguH3kCnyBnSuD83yzh7KqVZHDC173q1DJcqnaPeigLF3WXedF8D/1MYgAj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706056227; c=relaxed/simple;
	bh=Azb85vuryiZtjf52BYHTP6g5cHSof1IGK2t+bUitu/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OI5aAJ49CkQUudkhcE+ljDf+rU6+Um/vw7eRUFWKl7RfLFgI63USYvuG/3bMSDAxqFR1w+q3X+vF3G3JcpiZogjHuukcq3Ej86g+97Y0Z7+lQWKJfQ05bTJKUvn8HPNlZJRZH01zeZpttv0mvEIo4ROCEUUBPUOC+KVor+PVw/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkZPUw+Q; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59502aa878aso2152497eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706056225; x=1706661025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlRvytM145TXuABixAsC0P8tA9Wl2Z8OXmlMUS74bdI=;
        b=LkZPUw+Qd8vAIKuvb1VHlX0cELLPMKqtQEVvnR4fjLRydAPZzBGDvYyQa7ujP/UAYW
         7xUiQD8feIYEbZ53DdWiKxMGiy1FZ4dPJQTYzTN/AHQDM5d03g0OZTiTx8gXjN9KCRvC
         P6SRWionpOpsoyfNBHkrzP54qLbnAzWbu5VTUIzf7pn0Gp6VKd41oP7/Arriex9f4qNU
         7CX2/SqOxAczwzc4hb38cRofM+wZsa4XEyeTburwvbrNV1+ZYIzo/9ebmqbWeDEYZnU6
         ZocjPd334IEgbKR07JhzTkQDaZSrkFo/HKdERrd4ub69VCMsxriENz8bX4wW6cWC232a
         QA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706056225; x=1706661025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlRvytM145TXuABixAsC0P8tA9Wl2Z8OXmlMUS74bdI=;
        b=QMoiItAFHmq8G9JUQSmCSnEOlKHMtMT7sfebZnogfJ5wdIHq6lP21xC4l//EipCTh+
         Q46vTtEvGrigF3elJZnunvnnt5WgYyVl8MxBM+m3BmgjJ41TT7OjIB9D7WlnuE7xn1Ce
         7HsHmV93ONQ9cXReOUJnsGEdVxvxGnjQ0Jph3W9vgh5vb0AevCov4e0fQ6iwiKldq3TT
         GO9UU0U4+0t5XNUq/BYbtYeIe7TAldtBo5P7JI1wpLxyLGpC7CBZ8v9sQydxpVwo8ijj
         LZmj2mOnMpk8zzBbqcwkzMK8tieFaYyUjo/jqdcOfsyeo1SP0nshQ6H7AwubTg4Wwqk6
         ebKA==
X-Gm-Message-State: AOJu0YwSIbR1k4jTutwUqSqBy6AQdCEKkQs57DCdpLh5Ie/yw/ICRe+7
	u9Fv6JOgpWKDddy6MR2sB3iqBKwhpLpCKNn7tq/dNSyRkpY7lppk
X-Google-Smtp-Source: AGHT+IF2OD25ayOPZKsOQN8VvHXuug6Ks36E5+kAMDFTfsNIQhSuQkynujt2CP2tNKPernM+6Anz9g==
X-Received: by 2002:a05:6358:7f18:b0:172:b39d:2ae4 with SMTP id p24-20020a0563587f1800b00172b39d2ae4mr6044599rwn.19.1706056224685;
        Tue, 23 Jan 2024 16:30:24 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id b12-20020a17090a550c00b0028be1050020sm12041540pji.29.2024.01.23.16.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 16:30:24 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 23 Jan 2024 14:30:23 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCH 9/9] workqueue: Implement system-wide nr_active
 enforcement for unbound workqueues
Message-ID: <ZbBaH2uSqLmJmSsV@slm.duckdns.org>
References: <20240113002911.406791-1-tj@kernel.org>
 <20240113002911.406791-10-tj@kernel.org>
 <CAJhGHyDaNCoXaK4g4fKg3vfBYuQ7r+e8TT8ObrtT3nBcTeeuMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyDaNCoXaK4g4fKg3vfBYuQ7r+e8TT8ObrtT3nBcTeeuMg@mail.gmail.com>

Hello,

On Fri, Jan 19, 2024 at 03:54:24PM +0800, Lai Jiangshan wrote:
> node_nr_cpus[node] and num_online_cpus() are global values, they might
> not suitable
> for this particular workqueue and might cause skewed proportions.

Good point.

> the cache values:
> 
> pwq->pool->attrs->pool_nr_online_cpus =
> cpumask_weight_and(pwq->pool->attrs->__pod_cpumask, cpu_online_mask);
> 
> wq->wq_nr_online_cpus =
> cpumask_weight_and(wq->unbound_attrs->cpumask,  cpu_online_mask);
> 
> can be used instead. They can be calculated at creation and cpuhotplug.
> pool_nr_online_cpus doesn't contribute to the pool's hash value.
> 
> Or the result of wq_node_max_active() can be cached in struct wq_node_nr_active,
> see the comment next.
..
> > +       node_max_active = wq_node_max_active(wq, pool->node);
> 
> It is a hot path for unbound workqueues, I think the result of
> wq_node_max_active()
> should be cached in struct wq_node_nr_active.

I'm skeptical this would make a meaningful difference but if we're
calculating the numbers per-workqueue anyways, maybe this won't add too much
complexity.

> >  /**
> >   * pwq_activate_first_inactive - Activate the first inactive work item on a pwq
> >   * @pwq: pool_workqueue of interest
> > + * @fill: max_active may have increased, try to increase concurrency level
> 
> I think it is also legitimate to increase the concurrency level ASAP
> when called from try_to_grab_pending() path.

Can you elaborate why that'd be useful?

Thanks.

-- 
tejun

