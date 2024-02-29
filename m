Return-Path: <linux-kernel+bounces-86856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2248C86CBC7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4EB1286238
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1204F1361B8;
	Thu, 29 Feb 2024 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRMMlmJR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9614412E1CC
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217639; cv=none; b=b9g3MXcrwJdKDMZlDN2m6JlfAj2L/Yjdpk08x+vLkdKCN0vh+9bf1kaYkL6QYMsg1iy6WjuWbj80OzotXn/y+eENxs7emupwM7PZrawaY9nPmYrm7WdwVqY3Q3tAdQlaao4oYucUCR5tqdjMqLz843BEZ+kNOfse7fbJk+AsoYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217639; c=relaxed/simple;
	bh=p2DX8xubba2iuV/dOoMIWytAJpO1FcXWNbLHMDea4O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyUkfoCCDaUlCK9CwzOYXk21aGjIP6XhDHkUveKiOQqRMrGmPCrec1FINCoPg0N+vZUO/Slh3Qg2VCyLgxj7PkunO9DV5yaxrDbJInD6Jmx+6czQNkQOz/F2hmFvb3yQtUdJ5fgGbVxrnue/JBWA9NybwBmj3H/OvES+p3OSXog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BRMMlmJR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709217636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QyWEFJ+yNqsYLqP/8VLeQ0BF2PSGGH8euQh2ckEVwzo=;
	b=BRMMlmJRLAKqmajIeHvfoixPQsFQw8lFB+RiAbOjhI5OQk86qOhUyOc3sQAs2MHBfAxuoQ
	CTf6TnWZ+gQXf9dRlTjHAuVZCw4GvshAyAvjgroYR4QXnuPEasChBxzMpjcwVRhLH+guVS
	H1oWClaBH7rX6pj376HIOJRlD7n7jEU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-iZtiUsxKOtCSnFyRzwBH_g-1; Thu, 29 Feb 2024 09:40:35 -0500
X-MC-Unique: iZtiUsxKOtCSnFyRzwBH_g-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-69033ba441fso9064606d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709217634; x=1709822434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyWEFJ+yNqsYLqP/8VLeQ0BF2PSGGH8euQh2ckEVwzo=;
        b=OGFa29R6lT1pMs72/Urfp2LBKZ2TnhSavDOeQksSFRfoTkGHEnH9Z6XYyQsk9KKNQI
         I/mtQxyV1Ro9VagJLj9Hr/p2uGVaBpiXSnll5N3ttJsLOCfpjtUFFN3Ph4EU2mRxTCJi
         DhONZE0+on+70D+9Ly33e3yBx1QERYoiBCFr0kWEnVz8ZOIZcfGwht00OfNvFiPOQ97C
         rdtPzYZWNyBVpYw/UWF6iPZnAsK47xf3f2X2IJP8QUspI/f/RbZgSUeM6Wp5+aedtPBt
         0pi4Rapga3LL5QvoQsAeXVSvF4bINa9B+MtsYOf2JiZetC0/a+Jcm2PoBhFvYmJ/ibwM
         wjqg==
X-Forwarded-Encrypted: i=1; AJvYcCUypfviWCoSeKCMFGcNisfLT4acxUkngeKQoqqc+nHyOoE9I4XLzT8iVXtDPqBAZ3meoBFqAPShh6rmGgB/WcLGfjUweKQns5R//Xqz
X-Gm-Message-State: AOJu0YxOuootMa3vGmgTycpVE6IuafLa9mCJydULSbzukTCWMIXpGpvQ
	PrwUksPFos7Oac1k+VuNK0RukkDUJB5UESbSgUj7yiRombG+v64uOyzrLW+iEXrULZZ/kPjT1Q1
	gvKJmAZSRoM64O+yiLSAST+tEwzIrNPKc4zDJMwB1YAKXoqmhESUWNMUHvmztHg==
X-Received: by 2002:ad4:4e33:0:b0:68f:6f85:b1d5 with SMTP id dm19-20020ad44e33000000b0068f6f85b1d5mr2373665qvb.9.1709217634610;
        Thu, 29 Feb 2024 06:40:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdYyFRszf73jgTS8NKBbYyKil6pr8MJMzM+bEc/R2duxhWCgviXSBTbwSrroPnDmhzr3tfGA==
X-Received: by 2002:ad4:4e33:0:b0:68f:6f85:b1d5 with SMTP id dm19-20020ad44e33000000b0068f6f85b1d5mr2373641qvb.9.1709217634333;
        Thu, 29 Feb 2024 06:40:34 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id lu19-20020a0562145a1300b0068fc83bb48fsm780149qvb.105.2024.02.29.06.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 06:40:33 -0800 (PST)
Date: Thu, 29 Feb 2024 08:40:31 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, kernel@quicinc.com
Subject: Re: [PATCH net-next v2] net: Modify mono_delivery_time with
 clockid_delivery_time
Message-ID: <5h23xaefpzjr544hw2lsiby7v4zokfnmxm5bye66yx7h3qn6br@te7gptkdamdj>
References: <20240228011219.1119105-1-quic_abchauha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228011219.1119105-1-quic_abchauha@quicinc.com>

Hey ABC,

One minor nit below.

On Tue, Feb 27, 2024 at 05:12:19PM -0800, Abhishek Chauhan wrote:
> Bridge driver today has no support to forward the userspace timestamp
> packets and ends up resetting the timestamp. ETF qdisc checks the
> packet coming from userspace and encounters to be 0 thereby dropping
> time sensitive packets. These changes will allow userspace timestamps
> packets to be forwarded from the bridge to NIC drivers.
> 
> Existing functionality of mono_delivery_time is not altered here
> instead just extended with userspace tstamp support for bridge
> forwarding path.
> 
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
> Changes since v1 
> - Changed the commit subject as i am modifying the mono_delivery_time 
>   bit with clockid_delivery_time.
> - Took care of suggestion mentioned by Willem to use the same bit for 
>   userspace delivery time as there are no conflicts between TCP and 
>   SCM_TXTIME, because explicit cmsg makes no sense for TCP and only
>   RAW and DGRAM sockets interprets it. 
> - Clear explaination of why this is needed mentioned below and this 
>   is extending the work done by Martin for mono_delivery_time 
>   https://patchwork.kernel.org/project/netdevbpf/patch/20220302195525.3480280-1-kafai@fb.com/
> - Version 1 patch can be referenced with below link which states 
>   the exact problem with tc-etf and discussions which took place
>   https://lore.kernel.org/all/20240215215632.2899370-1-quic_abchauha@quicinc.com/
> 
>  include/linux/skbuff.h                     | 22 +++++++++++++---------
>  net/bridge/netfilter/nf_conntrack_bridge.c |  2 +-
>  net/core/dev.c                             |  2 +-
>  net/core/filter.c                          |  6 +++---
>  net/ieee802154/6lowpan/reassembly.c        |  2 +-
>  net/ipv4/inet_fragment.c                   |  2 +-
>  net/ipv4/ip_fragment.c                     |  2 +-
>  net/ipv4/ip_output.c                       | 13 +++++++++++--
>  net/ipv4/raw.c                             |  9 +++++++++
>  net/ipv6/ip6_output.c                      | 12 ++++++++++--
>  net/ipv6/netfilter.c                       |  2 +-
>  net/ipv6/netfilter/nf_conntrack_reasm.c    |  2 +-
>  net/ipv6/raw.c                             | 10 +++++++++-
>  net/ipv6/reassembly.c                      |  2 +-
>  net/sched/act_bpf.c                        |  4 ++--
>  net/sched/cls_bpf.c                        |  4 ++--
>  16 files changed, 67 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 2dde34c29203..24a34d56cfa3 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -816,10 +816,14 @@ typedef unsigned char *sk_buff_data_t;
>   *	@dst_pending_confirm: need to confirm neighbour
>   *	@decrypted: Decrypted SKB
>   *	@slow_gro: state present at GRO time, slower prepare step required
> - *	@mono_delivery_time: When set, skb->tstamp has the
> + *	@clockid_delivery_time: When set, skb->tstamp has the
>   *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
>   *		skb->tstamp has the (rcv) timestamp at ingress and
>   *		delivery_time at egress.
> + *		This bit is also set if the tstamp is set from userspace which
> + *		acts as an information in the bridge forwarding path to net

s/net/not/ or maybe "avoid resetting" ?

> + *		reset the tstamp value when user sets the timestamp using
> + *		SO_TXTIME sockopts



