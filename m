Return-Path: <linux-kernel+bounces-47173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D37844A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105A7286F5D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CAC39856;
	Wed, 31 Jan 2024 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEei4V0b"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7728C39854;
	Wed, 31 Jan 2024 21:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736755; cv=none; b=RdPOyyI9pMgJRgQzF19wU7JyWEOwI7woSo+KiGuIa+oF34Vki1iCkmfvFDJM9aTax4IPlNYPEZ8O/kAdSqTZdbHZAydh0EIhQgc/1YM8/Um/38rQE2OoIOQePm2s2Z8ZEvLlH608UlZcVkyxwLYqs6xwGMlXbDuasu717HJHcq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736755; c=relaxed/simple;
	bh=OPLlnkShPkDfpkes/8TXUTg03uQrES6q+f1wxtN714Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2fjq0f8zAREfMYV9HWV3xy9tET8EbBp+Y+KSFx7R/wZCojVxm71DcTgOKN9ntfXRd//ux61T/1VZ965+Okq7c3QdIfXvMSGufJsQ3dVNfXJunLjMb9gcGvWBb8tdBpOxtGDoi9eccVZbr7FfPlM+Ge4O0k41Ve1mApzSSIdo1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEei4V0b; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so225302a12.3;
        Wed, 31 Jan 2024 13:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706736754; x=1707341554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFmzHu5ktzDR5khDgjr495NTAW/wkz8lMozFpGfYzLY=;
        b=nEei4V0bLB8Ul/1dSNb+9j0RD2O9AR2iP8f3Rb5zS65qCgZype+fuoNCciVFbMFcGX
         HGFno9VN4U2I77LrjmFiFPAxOwxti6Z2ieSiAKZqLN3TpdpPxaK8Gx8jKYqU4n0dxTqd
         t7cM+MlIROgMxLQtY9jpRycTMGVRMh1Ka1wSXQKC4x/HjeiwNXehqBvcGBWW0iLbNpad
         qVmcjbCw2VC7zJ1+/n/4atxsZgGqKsC7uVEV01haA5f4LNQ7Mn/a6SSwY/JJpD2nDVtO
         ptSAwTtDZY23Cqtir/XpQSNMEFgDF68CZZDPlvil2N7/Ox2ZntbHkZR26+w4ULlECRzy
         AJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706736754; x=1707341554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFmzHu5ktzDR5khDgjr495NTAW/wkz8lMozFpGfYzLY=;
        b=KVTv8PYX4Capt80SwKzluxSrXrDIKmlj/zeeIlfBjLP3L9CE0KaLFKHItWkJrH7Ds2
         qrIZI0V1WGhDw94kRxz3O5hKgJm3434K1Yrq+MUmkwQOC2bLBjUraC9NgQ9Uax2aS35R
         eVyJoeOsLXoHk1BXgQ8WbVVyrhAyKEAcOa9I1RsdY1oHa2BGyuR/iNPmBAjVVzuIiIJM
         8CfUt+gD2JIQ6EmpBTT4vcE20n9bH6FJWabwN86wByFMlKNqkdkG0WCTz+iwjj14P/4x
         6ThXt88/snseWR805UYwC8FNhGfG5aDDmOg08+Ba9dqvWC646tMMRILOHFlE+BX6e2DT
         GT5Q==
X-Gm-Message-State: AOJu0Yy9psJ5rOPh6Hk5U9yX50bzGWOfqIb7Q//PaEmubXwtmhDUiARP
	Siq9ViALXZeEUctuDPuvFOXeSxzVISg+dHZDdPd4DoF6lCdd9uV1
X-Google-Smtp-Source: AGHT+IEpmHN/DNRIANW5YYSpE26RvQKmubELfaV5A42tZ4DYpL2qxuRBcFzMnkJ+Da9TID3wIvqjnA==
X-Received: by 2002:a05:6a20:3b94:b0:19c:7c49:4cf with SMTP id b20-20020a056a203b9400b0019c7c4904cfmr2582707pzh.43.1706736753446;
        Wed, 31 Jan 2024 13:32:33 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e20400b001d93bb0c9c8sm966974plb.85.2024.01.31.13.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 13:32:33 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 31 Jan 2024 11:32:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, msnitzer@redhat.com, ignat@cloudflare.com,
	damien.lemoal@wdc.com, bob.liu@oracle.com, houtao1@huawei.com,
	peterz@infradead.org, mingo@kernel.org, netdev@vger.kernel.org,
	allen.lkml@gmail.com, kernel-team@meta.com,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH 8/8] dm-verity: Convert from tasklet to BH workqueue
Message-ID: <Zbq8cE3Y2ZL6dl8r@slm.duckdns.org>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-9-tj@kernel.org>
 <c2539f87-b4fe-ac7d-64d9-cbf8db929c7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2539f87-b4fe-ac7d-64d9-cbf8db929c7@redhat.com>

Hello,

On Wed, Jan 31, 2024 at 10:19:07PM +0100, Mikulas Patocka wrote:
> > @@ -83,7 +83,7 @@ struct dm_verity_io {
> >  	struct bvec_iter iter;
> >  
> >  	struct work_struct work;
> > -	struct tasklet_struct tasklet;
> > +	struct work_struct bh_work;
> >  
> >  	/*
> >  	 * Three variably-size fields follow this struct:
> 
> Do we really need two separate work_structs here? They are never submitted 
> concurrently, so I think that one would be enough. Or, am I missing 
> something?

I don't know, so just did the dumb thing. If the caller always guarantees
that the work items are never queued at the same time, reusing is fine.
However, the followings might be useful to keep on mind:

- work_struct is pretty small - 4 pointers.

- INIT_WORK() on a queued work item isn't gonna be pretty.

- Flushing and no-concurrent-execution guarantee are broken on INIT_WORK().
  e.g. If you queue_work(), INIT_WORK(), flush_work(), the flush isn't
  actually going to wait for the work item to finish. Also, if you do
  queue_work(), INIT_WORK(), queue_work(), the two queued work item
  instances may end up running concurrently.

Muxing a single work item carries more risks of subtle bugs, but in some
cases, the way it's used is clear (e.g. sequential chaining) and that's
fine.

Thanks.

-- 
tejun

