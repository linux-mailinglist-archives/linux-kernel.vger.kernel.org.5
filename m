Return-Path: <linux-kernel+bounces-75355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A93E885E726
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DA42824DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D1B85C6C;
	Wed, 21 Feb 2024 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MHDKAmz1"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F5E85927
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708543287; cv=none; b=Yjks7L04fw6akQvytVCvpD/KuH12QIVi4BbSS0X9KYnfvsF/uQRAY6nqGDlQKsUXiNGKtWjYhW9KE2pSsKmnLoDkx6moD1UKbayvm9C6d6ragrXgbpYLMfm32IQdLtwi6VzZLqxw7KW5WcJn0kERbU/KfVJYHtptPxN5XOd/+kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708543287; c=relaxed/simple;
	bh=HdMlqULDtWlIMNZNUW7ZLf3uCtFoVG1nSKFK9mt9pBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrxPfrzK+ubonCLpFBRP7/CNMzMQMYai3c9Ta7LWIl48q4xc0hwgeqZyTU01AzoEYB0XFP0yoyeRJ13fWF/pP6UkabJbIYnGzZ/BZDjL3BDuqVI26bEJggNO4KlFiDnudCQabKOMjUbyhoiAkiuK/vqcQ5EGLnZuWdYJB4kP4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MHDKAmz1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so997315ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1708543286; x=1709148086; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXnITZvZmNDkzIIUT13S2TkCGR7EbwncViIWo1TLK1U=;
        b=MHDKAmz1/Yb+kd13xNWPObHRCX0F6NVs2stJpkhXl0fDqbEtzcHn/HuVTi7+HrFQH4
         bRcQLbg1fu5khTIZwPdVGGlMgc0T5XJlXi6SmYT8amLqWITTQWrfPIhnCYAYOFzPIu+9
         MBjSgKMmhOceS8hq9G6I4bp5GqYBUYxI/mUb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708543286; x=1709148086;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXnITZvZmNDkzIIUT13S2TkCGR7EbwncViIWo1TLK1U=;
        b=pa0lXJA0h8P1H1H4f80TdaU0bkQoDVBXiXYc1BK0fQHTeHl38/yCAtpDHLBtJg7p1s
         R8MS1gq57zSJ6u/WxwGd0CCRpWTXMAjyl8CjaVRAqMsmPRkN1D+LxVlr7eTSEOanwGYn
         pt1EMVfc7zoLwWWEfnA0XLZLSPphBJlbzw29FQ6hxdt6c9AFXY4khAWShz0kS4P2MK/C
         O1RobIAe+/EQTQLtGnCSwwOAu7LN/lb/4jHmL9XXWazw3DXJxNOKK40Mx99mUVxuni04
         z0CQ3I9lkzbW37Abf7TA8ifKJFyVHAWKVxr+CfuOGX7RtgakFmgR0zu4COf0EqRyu8gk
         LbzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmum5Fhx0w065DFxFykSzZv8DTqQsRJcFvKnk+jy4nnXMeP9Xq1CT2m58bg4rsUJmGUOJtm+XAZRQzgpaEHhHvmyC7jcO3JWJlXWxf
X-Gm-Message-State: AOJu0YyBE6MLWQ+GgCW6M56ouqpjLwn6PiD7nieVMylI4w2L8AhhioTj
	4FPvKOfL8MO1EZza0XbUCC8mWZ/JerehpOV4IvilIDMiGb0D0VDGcPVttEfklRU=
X-Google-Smtp-Source: AGHT+IGtN7O8EGpAOM8aCGfwjiEkAjhIsJvLzLczA2g8N3YOnpuTvrMrg8bQvLaQGzKdYPvc7EB71w==
X-Received: by 2002:a17:902:e805:b0:1dc:1db2:f60d with SMTP id u5-20020a170902e80500b001dc1db2f60dmr606057plg.2.1708543285751;
        Wed, 21 Feb 2024 11:21:25 -0800 (PST)
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id kg3-20020a170903060300b001dbbd4ee1f6sm8441720plb.11.2024.02.21.11.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2024 11:21:25 -0800 (PST)
Date: Wed, 21 Feb 2024 11:21:23 -0800
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
Message-ID: <20240221192122.GB68788@fastly.com>
References: <1708531057-67392-1-git-send-email-jdamato@fastly.com>
 <20240221110952.43c0ae6e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221110952.43c0ae6e@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Wed, Feb 21, 2024 at 11:09:52AM -0800, Jakub Kicinski wrote:
> On Wed, 21 Feb 2024 07:57:28 -0800 Joe Damato wrote:
> > Greetings:
> > 
> > The netdev netlink APIs currently provide the ifindex of a device
> > associated with the NIC queue or NAPI when the netlink API is used. In
> > order for user applications to map this back to a human readable device
> > name, user applications must issue a subsequent ioctl (SIOCGIFNAME) in
> > order to map an ifindex back to a device name.
> 
> To be clear, if_indextoname() is doing it, right? I wanted to be sure
> the concern is really number of syscalls, not the difficulty in getting
> the name.

It seemed a bit odd to me to require the user to hit different APIs -- one
to get the ifindex and then another to get the name. I didn't realize you
had intentionally left the name out, though.

> > This patch set adds ifname to the API so that when queue or NAPI
> > information is retrieved, the human readable string is included. The netdev
> > netlink YAML spec has been updated to include this field, as well.
> > 
> > This saves the subsequent call to ioctl and makes the netlink information
> > more user friendly. Applications might use this information in conjunction
> > with SO_INCOMING_NAPI_ID to map NAPI IDs to specific NICs with application
> > specific configuration (e.g. NUMA zone and CPU layout information).
> 
> For context, the reason why I left the names out is that they can change
> at any moment, but primarily because there are also altnames now:
> 
> 2: eth0:
> [...]
>     altname enp2s0np0
> 
> Most of the APIs try to accept altnames as well as the "main" name.
> If we propagate the name we'll step back into the rtnetlink naming
> mess :(

OK, I see. I didn't realize this was a thing. I suppose what you are saying
is that we wouldn't want to expose names at all and stick with ifindexes
only, is that right?

