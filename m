Return-Path: <linux-kernel+bounces-94742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FA48744A3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DBD41F29664
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EE2200D1;
	Wed,  6 Mar 2024 23:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FmSbYH6f"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E0F1D545
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 23:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709768572; cv=none; b=YJhk4XGEQxeEfEcxy6Sv1aFq0hdWv1CYhyLQPdqRbdMPry+KMRUZKoPJ2AxmUi6XBow4wkbw27k1TS30w89oZbs0ad3kZMQLReIrdN4DnGJUovehTiUFYD8Zk/N6spb6vojN9AtUM5GU0cYRk/0/nBaifiMV4fkkC9RwSXn9J20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709768572; c=relaxed/simple;
	bh=1uAjtmVUg8TOo5XCruda8HusbcghSINaRVyMFyYA2J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnNGUnp8xB4+b2SWME2jrU6V6otJ9+Hbc462zQpHPd6+TbhBySTmVuc4qszyVwPZssC8KyBJHNLjQQNsJu6M85C8u1fMSDDKCow/TLlLdCsGxtyasgnqiTN5J7dozZlZv2eBxVoDV8rpaFUynoHK+YXGwtPlp2DLpRh7UPj4Ukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FmSbYH6f; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dcad814986so2582515ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 15:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709768570; x=1710373370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KXRCoET8aNW/39aRLX1D1ZOWhLKJAW+cDfFuNbY9XEo=;
        b=FmSbYH6fycrBViC7DCGpYBQTBNKeiLm5BFgumllN9wfDs9gtX8DjA+H2k+7xsw3uZh
         dVDfu9e02ZMkLJebbKwQGddns31OuD4WcmFXqqLYzox4ntB6UaHyv9djld8SEyOQScJr
         /jvP+RRIS4GVngcdsgUr5JwcyrGtNEeWI8B9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709768570; x=1710373370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXRCoET8aNW/39aRLX1D1ZOWhLKJAW+cDfFuNbY9XEo=;
        b=IBTcqyetFdkNL5gNF/2mG38nVC0ZshAuHX6Haw0/BJyyy64xLEkf0EpRl4XI3ix7L5
         yqdZ8NYM16M4ow7aja972+Po7eRj43HIGfvv81eVq4+pMZd+iIAiyIvP++inH1NXsoam
         83flwT8OifJZwsE5V+Uqa5+ugw0TCUCEEg/Xbu/E76xapH4uhZBTa2AEADQg9eTknQDg
         EiL+GcEx3WfkrYCB3I1MJX1EEFkAA70DaKgpnI+8RJNAtQaR7Ie04Z/fSrah2V9TxptS
         cJFv7UmzsTWFEs6ZK2JbrQw5mD/srOU58uLSRQn3cntsBWK/lAtlYfxLZLpWAN86KfAl
         uPhg==
X-Forwarded-Encrypted: i=1; AJvYcCXixChICVrfQomu74Bo4cjWWM/BTJX8fRL1ZfdQP7XenHwHh5zR4o1Gs3TyerL3SnrzhZlmfGiTdgBasFhIrrHJ6SLv2yQgE+oPZ6cE
X-Gm-Message-State: AOJu0YwerhrW1aY2Xz/g31HOc1DVDU0PNLwJ2KROKXoTdEFqiifC9zKg
	NN9us7Q5wSnSbeJDfj86t0Xs9PxZqsTLmXhQjNIkupj0zLtIAQKWhG1Hq7D3wA==
X-Google-Smtp-Source: AGHT+IHADupVs6FRdhDggj0sTct4wDHOWb2w2b9Auv5+VfZEeMw6HDOu57s1NGT+WKYASYmgqSVHgw==
X-Received: by 2002:a17:903:11c3:b0:1dc:d8de:5664 with SMTP id q3-20020a17090311c300b001dcd8de5664mr7564197plh.33.1709768570588;
        Wed, 06 Mar 2024 15:42:50 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090341c300b001dd0d090954sm7330904ple.269.2024.03.06.15.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:42:49 -0800 (PST)
Date: Wed, 6 Mar 2024 15:42:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Coco Li <lixiaoyan@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netdev: Use flexible array for trailing private bytes
Message-ID: <202403061540.A8462E9@keescook>
References: <20240229213018.work.556-kees@kernel.org>
 <20240229225910.79e224cf@kernel.org>
 <ZehsoPb/WZzUcFHa@gmail.com>
 <20240306070658.4216fdf2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306070658.4216fdf2@kernel.org>

On Wed, Mar 06, 2024 at 07:06:58AM -0800, Jakub Kicinski wrote:
> On Wed, 6 Mar 2024 05:16:16 -0800 Breno Leitao wrote:
> > I've been looking at some of these embedders as reported by Kees[1], and
> > most of them are for dummy interfaces. I.e, they are basically used for
> > schedule NAPI poll.
> > 
> > From that list[1], most of the driver matches with:
> > 
> > 	# git grep init_dummy_netdev
> > 
> > That said, do you think it is still worth cleaning up embedders for
> > dummy net_devices?
> > 
> > [1] https://lore.kernel.org/all/202402281554.C1CEEF744@keescook/
> 
> Yes, I think so.
> Kees, did you plan to send a v2? Otherwise I can put the cleanup on our
> "public ToDo" list :)

I found the requested collateral changes that popped out of v1 to be
rather a bit much for me to tackle right now, so I think adding to the
TODO list is probably best. :)

-Kees

-- 
Kees Cook

