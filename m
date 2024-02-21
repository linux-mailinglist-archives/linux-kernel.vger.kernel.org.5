Return-Path: <linux-kernel+bounces-75366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588F985E748
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779AF1C24CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECE483A1F;
	Wed, 21 Feb 2024 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jhJBIYu6"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE11185C69
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708543797; cv=none; b=kGaJjDCTkdFaBBDz/plDzDR8lxyrpX7LWJdfsdOD5RhK7J0iUPtdL/AYjUMlY0k86hh5Mj0iP6FMNif8KH5TQtuf091WkDDPnQbJLhMJefmXbvao4bO89IStjffffhd9/T3ucmSGmtrWEeMfLw9X8aR02TxuCz2iSQYHiRhNJ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708543797; c=relaxed/simple;
	bh=43X4YpzZH4v/vn1Eqx2F+XMhsGxh0Tln/FFKxX/JnX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFoSriCYiqn7SW7t+Fys9KxFW6XHyu+pneR4HHssfeVWKJvGg/xPtxh8iF19yZY4kL1rwDpeAktnFUU1anLMdcXhksUycFEgBiqtx7wj5wFUSDQARq2O2mFnihfRpPZORG6Hi/fI0hHxBLNKDTVFINiDb/rJqv7pvitiHoFNL/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jhJBIYu6; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e3bdea186cso2206447b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1708543795; x=1709148595; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOVn5TYSq7Yd0cVO/zWwQ5H33DS+ESxqa50xaVlE/Kc=;
        b=jhJBIYu67dLcUjbENh3T32qDr4AMWLZZOD9RuhFJ4qJRGFA0FuYWLeXP7eXwu9I1Bm
         /NDEgki7pGmpndIL6ADbd9orjF2wS9YvspRi4qgiLdgvPd/0QxuXmqPW6omSo7G5eaT7
         ify7C0K/AFIZj4Jfyp3SpFK/cRVU03xhnaY84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708543795; x=1709148595;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOVn5TYSq7Yd0cVO/zWwQ5H33DS+ESxqa50xaVlE/Kc=;
        b=V1ZRv/HRFjTdk8ZwhIibzyG03Bjp4muuyagzFO2F5eUIVe+N93D1qTbJ7aSjtr0WkK
         4QWeb+RPk1YPkE03E+Pe/J0PDS3OWt4i0EHLuPNPPJEdZ1tpHtIx9ae4EZBRusud1WUk
         CmOYissNqklPZ6MvWXWGohBYxjmYbnKLEpWt5OjJW0b2HBvCUOa9SVdyVXDWgtisdyXM
         j3VC0TJXpQnyZp956zFlu3oWvCBDLy1kYXEOyb/wLNzqOxW3gNwAHaA9vHwG+CfMi2x8
         1OHV71OxZO0eOcpx2S050TDr9h/bmvMSkHZVg3Xe2CIEE0CjVqeZWYc1YDpuT5QRIgml
         tc/A==
X-Forwarded-Encrypted: i=1; AJvYcCU8i85dxc2utlFOA2z9zz+rZcVJptcKpiBQc4MaLfDN2Rvpw/9g31ZlcujPiVdDY57NjOHJD1prHiLjE53TvgebNGhZuCkW7cgT+A+M
X-Gm-Message-State: AOJu0Yw+I7JUbBD/7BOjheGUdd2gYr+X7rg0u7cEuPQlFUdJPAf7Tqbi
	zO5tnFSiXsSnagBMlHmDOSVvKGZ2exmwgiL1z5o/ruN2zvDaOeKIO3Ziz9CLD8w=
X-Google-Smtp-Source: AGHT+IHF8ZqCMtE9CiPKgIAurre13OC+r7VUoIWRBVeEkxEam/JrULm+6CdJIthPNg5+CCb8zrUgIA==
X-Received: by 2002:a05:6a00:9a4:b0:6e4:59b3:928c with SMTP id u36-20020a056a0009a400b006e459b3928cmr11375495pfg.10.1708543794969;
        Wed, 21 Feb 2024 11:29:54 -0800 (PST)
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id jw40-20020a056a0092a800b006e4c2ee6cb2sm563160pfb.29.2024.02.21.11.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2024 11:29:54 -0800 (PST)
Date: Wed, 21 Feb 2024 11:29:52 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next 0/2] Expose netdev name in netdev netlink APIs
Message-ID: <20240221192951.GA68878@fastly.com>
References: <1708531057-67392-1-git-send-email-jdamato@fastly.com>
 <20240221110952.43c0ae6e@kernel.org>
 <20240221192122.GB68788@fastly.com>
 <20240221112644.3d8c4c5a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221112644.3d8c4c5a@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Wed, Feb 21, 2024 at 11:26:44AM -0800, Jakub Kicinski wrote:
> On Wed, 21 Feb 2024 11:21:23 -0800 Joe Damato wrote:
> > > For context, the reason why I left the names out is that they can change
> > > at any moment, but primarily because there are also altnames now:
> > > 
> > > 2: eth0:
> > > [...]
> > >     altname enp2s0np0
> > > 
> > > Most of the APIs try to accept altnames as well as the "main" name.
> > > If we propagate the name we'll step back into the rtnetlink naming
> > > mess :(  
> > 
> > OK, I see. I didn't realize this was a thing. I suppose what you are saying
> > is that we wouldn't want to expose names at all and stick with ifindexes
> > only, is that right?
> 
> If you think it's a major usability improvement I can be convinced,
> but yes, leaving the names out initially was indeed intentional.

Well... it is useful to me, but I think I'm only one user and the side
effects of adding this might have painful results in the future so after
your comment I think it might be best left out.

Sorry for the noise.

