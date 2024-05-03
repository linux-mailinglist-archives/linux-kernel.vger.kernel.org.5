Return-Path: <linux-kernel+bounces-168081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBD58BB367
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C649B215E0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EA312F5A7;
	Fri,  3 May 2024 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ePikg0wS"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E37036B1C
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761814; cv=none; b=t5nGsEXXNAxvZPhw7XTspgqfocVKbws/axr9CTZqXFGikRApRd1btgLinQxh9garFJD4v/C3LQdI53JoJXhTdNo2UMaNTOaabUzNeQHDGajX8uLb8sA95llVI56mpx/td+6vXkfIEExkkE2iaOu+Ph9b03XTnyUYCFMlj3FK8lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761814; c=relaxed/simple;
	bh=PcHI2mXSjOY4NXtmW1TqHHOIJEHPiSVx2p/CZ40zV8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGyhvbaXGmo08IQeffMprgpwpFnpErLE07gQda7u4AFBw4g3TYctJZgW1KB0OYeYqMElVCM482AKN5w+mItoqXyfnA9wMilpeWfiZQjdfexksluOh6wlx02NkgTdPqYBIbJngRveisHNsrfA+jynVHpF/8Jfr1ZCfXiGWNkKTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ePikg0wS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec5387aed9so39090665ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 11:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714761811; x=1715366611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FFXylIM8Lgjr0fl64+mxvP0VZact2yQlaPnfxj1/4U0=;
        b=ePikg0wS7nTpjPmUR9Wbw6vKzXEnI/bGfNsx6oJ7FIjeCLMXrduM8RQj+wa/5iCWUZ
         I9qpk0rwSPpR/1riJIpwK/BXbbp4QM//XGQKS6TaaddmJOG0VIOmkSRyqOdNixS7QFW2
         9C7kyvoyJI4gZJyD9NIIW2aPH0ae0WsAfVdNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714761811; x=1715366611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFXylIM8Lgjr0fl64+mxvP0VZact2yQlaPnfxj1/4U0=;
        b=EYfLVtCtzbNKwp/Z9sWkEHkjmgy5yGtlH1rdrXpc+RKCKRQSXAWxVOqFVlY8/ZTBKS
         bfWDNhyO4NYr+sjCUluwC9BfplI08+k4ZlNUVAqtlPKAcmENv6mDtuRyPtRuIkhml+9U
         vW4DckFJidp5NRn/Hyoqk/l//gjfjcuVOEFRhNvkPbUkT4KHc5ME3DGX7r97wsBs+syh
         GiEPFjXw7Dx4MDa+dqW06kI80EDEfjsYHn00xcJmDDYCBS1n1f8H/q9PJG145Q+e5U11
         FfbRUNDpeagFr5tdk3ztdnYHwygsfBIbwd+wyvOB20/piJVn5loO+H59pxhk3/s8Rty4
         5PTQ==
X-Gm-Message-State: AOJu0Yzb6JFGJ4FOr/CDagBGboPXOekhvRR48vNdTAoK32VxG5pIqYeH
	q3UB3XjlLrv2Iz/3CVNgjl5/xmPl14wNFaHu0uQ4A9Kj57CX7rM81+1HCkPPb00=
X-Google-Smtp-Source: AGHT+IELQNadSxtn2qD7K4UmKbShRX1xBPsnrbEvAT1ulySbjcsBh1/3r1nD5X/Dflgo+e9sRpoYKA==
X-Received: by 2002:a17:902:7612:b0:1e6:622c:7bb4 with SMTP id k18-20020a170902761200b001e6622c7bb4mr3161044pll.19.1714761810756;
        Fri, 03 May 2024 11:43:30 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902ee4200b001ecc9a92e1csm3562096plo.267.2024.05.03.11.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:43:30 -0700 (PDT)
Date: Fri, 3 May 2024 11:43:27 -0700
From: Joe Damato <jdamato@fastly.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
	saeedm@nvidia.com, gal@nvidia.com, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
Message-ID: <ZjUwT_1SA9tF952c@LQ3V64L9R2>
References: <20240503022549.49852-1-jdamato@fastly.com>
 <c3f4f1a4-303d-4d57-ae83-ed52e5a08f69@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3f4f1a4-303d-4d57-ae83-ed52e5a08f69@linux.dev>

On Fri, May 03, 2024 at 12:55:41PM +0200, Zhu Yanjun wrote:
> On 03.05.24 04:25, Joe Damato wrote:
> > Hi:
> > 
> > This is only 1 patch, so I know a cover letter isn't necessary, but it
> > seems there are a few things to mention.
> > 
> > This change adds support for the per queue netdev-genl API to mlx5,
> > which seems to output stats:
> > 
> > ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
> >           --dump qstats-get --json '{"scope": "queue"}'
> > 
> > ...snip
> >   {'ifindex': 7,
> >    'queue-id': 28,
> >    'queue-type': 'tx',
> >    'tx-bytes': 399462,
> >    'tx-packets': 3311},
> > ...snip
> 
> Ethtool -S ethx can get the above information
> "
> ...
>      tx-0.packets: 2094
>      tx-0.bytes: 294141
>      rx-0.packets: 2200
>      rx-0.bytes: 267673
> ...
> "
> 
> > 
> > I've tried to use the tooling suggested to verify that the per queue
> > stats match the rtnl stats by doing this:
> > 
> >    NETIF=eth0 tools/testing/selftests/drivers/net/stats.py
> > 
> > And the tool outputs that there is a failure:
> > 
> >    # Exception| Exception: Qstats are lower, fetched later
> >    not ok 3 stats.pkt_byte_sum
> 
> With ethtool, does the above problem still occur?

Thanks for the suggestion, with ethtool it seems correct using the same
logic as the test, I understand correctly.

The failing test fetches rtnl first then qstats, but sees lower qstats - the
test expects qstats to be equal or higher since they are read later. In order to
reproduce this with ethtool, I'd need to fetch with ethtool first and then
fetch qstats and compare.

A correct output would show equal or higher stats from qstats than ethtool
because there is minor delay in running the commands.

Here's a quick example using ethtool of what I get (note that in the output of
cli.py the bytes are printed before the packets):

$ ethtool -S eth0 | egrep '(rx[0-3]_(bytes|packets))' && \
  echo "======" && \
  ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
           --dump qstats-get --json '{"scope": "queue", "ifindex": 7}' \
  |  egrep '(rx-(packets|bytes))'

     rx0_packets: 10799916
     rx0_bytes: 4949724904
     rx1_packets: 26170804
     rx1_bytes: 12694250232
     rx2_packets: 11901885
     rx2_bytes: 5593129387
     rx3_packets: 13219784
     rx3_bytes: 6151431963
======
  'rx-bytes': 4949927222,
  'rx-packets': 10800354},
  'rx-bytes': 12694488803,
  'rx-packets': 26171309},
  'rx-bytes': 5593321247,
  'rx-packets': 11902360},
  'rx-bytes': 6151735533,
  'rx-packets': 13220389},


So you can see that the numbers "look right", the qstats (collected by cli.py)
are collected later and are slightly larger, as expected:

rx0_packets from ethtool: 10799916
rx0_packets from cli.py:  10800354

rx0_bytes from ethtool: 4949724904
rx0_bytes from cli.py:  4949927222

So this looks correct to me and in this case I'd be more inclinded to assume
that RTNL on mlx5 is "overcounting" because:

1. it includes the PTP stats that I don't include in my qstats, and/or
2. some other reason I don't understand

> > 
> > The other tests all pass (including stats.qstat_by_ifindex).
> > 
> > This appears to mean that the netdev-genl queue stats have lower numbers
> > than the rtnl stats even though the rtnl stats are fetched first. I
> > added some debugging and found that both rx and tx bytes and packets are
> > slightly lower.
> > 
> > The only explanations I can think of for this are:
> > 
> > 1. tx_ptp_opened and rx_ptp_opened are both true, in which case
> >     mlx5e_fold_sw_stats64 adds bytes and packets to the rtnl struct and
> >     might account for the difference. I skip this case in my
> >     implementation, so that could certainly explain it.
> > 2. Maybe I'm just misunderstanding how stats aggregation works in mlx5,
> >     and that's why the numbers are slightly off?
> > 
> > It appears that the driver uses a workqueue to queue stats updates which
> > happen periodically.
> > 
> >   0. the driver occasionally calls queue_work on the update_stats_work
> >      workqueue.
> >   1. This eventually calls MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(sw),
> >      in drivers/net/ethernet/mellanox/mlx5/core/en_stats.c, which appears
> >      to begin by first memsetting the internal stats struct where stats are
> >      aggregated to zero. This would mean, I think, the get_base_stats
> >      netdev-genl API implementation that I have is correct: simply set
> >      everything to 0.... otherwise we'd end up double counting in the
> >      netdev-genl RX and TX handlers.
> >   2. Next, each of the stats helpers are called to collect stats into the
> >      freshly 0'd internal struct (for example:
> >      mlx5e_stats_grp_sw_update_stats_rq_stats).
> > 
> > That seems to be how stats are aggregated, which would suggest that if I
> > simply .... do what I'm doing in this change the numbers should line up.
> > 
> > But they don't and its either because of PTP or because I am
> > misunderstanding/doing something wrong.
> > 
> > Maybe the MLNX folks can suggest a hint?
> > 
> > Thanks,
> > Joe
> > 
> > Joe Damato (1):
> >    net/mlx5e: Add per queue netdev-genl stats
> > 
> >   .../net/ethernet/mellanox/mlx5/core/en_main.c | 68 +++++++++++++++++++
> >   1 file changed, 68 insertions(+)
> > 
> 

