Return-Path: <linux-kernel+bounces-49972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F15384724F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193C829231A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F328C145B02;
	Fri,  2 Feb 2024 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghXb/fWY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAC847774
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885727; cv=none; b=VcFqshyyuyqPcZ/xKdfI43+J7B+THBv3fsfWjnTz2RvX+F33tFgvosyjc27aR+C495kVDfX//KYYDngtkvzJWOxD0vXici+gakvFTJxrUw7SrYGI1mpstTQ8Xt3eEIi36mkDGQRi/k/yn4fD0H92lZVbuYxVsUTIu0DhOBdA9jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885727; c=relaxed/simple;
	bh=FDmCfYcYrJAQN2FZ3hUO8CV1dIYQcj/nQnzfYq13GdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6cFYRY90Rmb3MxDskeNVlwXHwk42fJzDX7ZTqlAmPYdtVnvJRaBnffkAlbYXmfdMLXddS5Y4M0KzlpqYCYbi9K74zA8j0mFkX70Z67hpmyy/rg1xgF9dantoJjX/3nGKJKNRl1iTwGPN0HP7FP6Te4z2+z/9KTLmt8JniZpgZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ghXb/fWY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706885723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+jzHzjkx7wAlR4i0iiz1jxVoCpgPbIcw/3M8GzERXSo=;
	b=ghXb/fWYWAiBilG/mFvkZltWiVazzhy+nWvRG5dZNxsEvFFCK++YVyugd1PeYDT/yDgV1R
	5jmBsztfP1X0ztAchIW80RPfyzmvxCp52F3DlBDKwoehBkjah2o1uHxsRQLp1fSNXnIAuB
	luzZb/wgcPZBpHW8WI0qKY1x01l04IQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-ywxebK-DNUqeHreVLX_8uw-1; Fri, 02 Feb 2024 09:55:21 -0500
X-MC-Unique: ywxebK-DNUqeHreVLX_8uw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-42beca944beso28271211cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 06:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706885720; x=1707490520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jzHzjkx7wAlR4i0iiz1jxVoCpgPbIcw/3M8GzERXSo=;
        b=mm4MyIMRvvbw74kqxHHDZ1NRom6KQAYsfkU7pFL64zlZuy2X7CKeHmcVIWEE1b3yKw
         0vNpoNqh8qYDFoUz0pZgK4Y1MGwRhLX0pbpyv4UJHiw6tI7o0hr5SwiM7khBGyF7C9d7
         jJgfYXs3y5IPKpjNX+M6CH6p78IJnV8baobSAWCxHEVTbRvRnFCp744+p8WPLoHIrd2z
         JHr/b3HYfCBYReSdfkbQSFNwWhgrOpr3gddvko0j9ZCKXxCMejbEW8xgLxdfIlAMnSFZ
         9UmgUQfJ5jLSalA1D5UY6VC7uyJSInSdox1CUKH7UOokRZ2hUbbM56cdr/PmAFqTiheE
         xr/Q==
X-Gm-Message-State: AOJu0YwTqltu8eHrk3vAxwJ6NjQDIbiNWHpBN05EH3JeQdixO66Pxc4H
	0P66UZXO+ludU2r3E2gtYyJo0SGM+NxsZJ19VIocw45cMy14eEJc3FdnwiPd5zkCUwsJnIckXjt
	6p0QiGQwG7QHm8BzfjXQoFm1zOvTri6+QKvkvK97vbKi9+VbDHFhkp07g7G35/w==
X-Received: by 2002:a05:622a:5c7:b0:42c:a4e:e266 with SMTP id d7-20020a05622a05c700b0042c0a4ee266mr496617qtb.21.1706885720480;
        Fri, 02 Feb 2024 06:55:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdvzYW/mO/aHwG8d/fyOMPNgM5X6Ei7hEHaZPUJTTwoXEYk1hP5nHn7cYvumPCjk6kIiLYdQ==
X-Received: by 2002:a05:622a:5c7:b0:42c:a4e:e266 with SMTP id d7-20020a05622a05c700b0042c0a4ee266mr496598qtb.21.1706885720172;
        Fri, 02 Feb 2024 06:55:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXDZbI+ex6y0R4OHoxuBdIsJiyiRkEAuUMJRnR3Ui6AeVrsi9Lz3ME9NMOm1Iv1/XIoYBCew5rZ5QGm8YoyGgY5ujhEvl62F6jts63dACIGiTzQv65//0VhPMDyn8FLka7PhvV96CCOjgNZIBOF2s16afb1S5CVGp+7Bds3PP9BiAEosK1rCUNxRW0NVsc=
Received: from localhost.localdomain ([151.29.75.172])
        by smtp.gmail.com with ESMTPSA id cc22-20020a05622a411600b0042be0933c1csm886818qtb.15.2024.02.02.06.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 06:55:19 -0800 (PST)
Date: Fri, 2 Feb 2024 15:55:15 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>
Subject: Re: [RFC PATCH 0/3] workqueue: Enable unbound cpumask update on
 ordered workqueues
Message-ID: <Zb0CU2OrTCv457Wo@localhost.localdomain>
References: <20240130183336.511948-1-longman@redhat.com>
 <ZbpElS5sQV_o9NG1@localhost.localdomain>
 <89927d84-279a-492e-83d3-6d3e20b722f7@redhat.com>
 <Zbtv4v2KCKshnCL2@localhost.localdomain>
 <ff2c0ce1-4d40-4661-8d74-c1d81ff505ec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff2c0ce1-4d40-4661-8d74-c1d81ff505ec@redhat.com>

On 01/02/24 09:28, Waiman Long wrote:
> On 2/1/24 05:18, Juri Lelli wrote:
> > On 31/01/24 10:31, Waiman Long wrote:

..

> > My patch only uses the wq->unbound_attrs->cpumask to change the
> > associated rescuer cpumask, but I don't think your series modifies the
> > former?
> 
> I don't think so. The calling sequence of apply_wqattrs_prepare() and
> apply_wqattrs_commit() will copy unbound_cpumask into ctx->attrs which is
> copied into unbound_attrs. So unbound_attrs->cpumask should reflect the new
> global unbound cpumask. This code is there all along.

Indeed. I believe this is what my 3/4 [1] was trying to cure, though. I
still think that with current code the new_attr->cpumask gets first
correctly initialized considering unbound_cpumask

apply_wqattrs_prepare ->
  copy_workqueue_attrs(new_attrs, attrs);
  wqattrs_actualize_cpumask(new_attrs, unbound_cpumask);

but then overwritten further below using cpu_possible_mask

apply_wqattrs_prepare ->
  copy_workqueue_attrs(new_attrs, attrs);
  cpumask_and(new_attrs->cpumask, new_attrs->cpumask, cpu_possible_mask);

operation that I honestly seem to still fail to grasp why we need to do.
:)

In the end we commit that last (overwritten) cpumask

apply_wqattrs_commit ->
  copy_workqueue_attrs(ctx->wq->unbound_attrs, ctx->attrs);

Now, my patch was wrong, as you pointed out, as it wasn't taking into
consideration the ordering guarantee. I thought maybe your changes (plus
and additional change to the above?) might fix the problem correctly.

Best,
Juri

1 - https://lore.kernel.org/lkml/20240116161929.232885-4-juri.lelli@redhat.com/ 


