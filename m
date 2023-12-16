Return-Path: <linux-kernel+bounces-2360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C04815BA1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 21:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA631C21DAD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 20:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04E032C6B;
	Sat, 16 Dec 2023 20:19:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from a3.inai.de (a3.inai.de [88.198.85.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08EB328D6;
	Sat, 16 Dec 2023 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id DD4AB5882030E; Sat, 16 Dec 2023 21:13:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id DA66A60BFA2CC;
	Sat, 16 Dec 2023 21:13:14 +0100 (CET)
Date: Sat, 16 Dec 2023 21:13:14 +0100 (CET)
From: Jan Engelhardt <jengelh@inai.de>
To: Samuel Marks <samuelmarks@gmail.com>
cc: Pablo Neira Ayuso <pablo@netfilter.org>, 
    Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, 
    netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
    linux-kernel@vger.kernel.org
Subject: Re: PATCH [netfilter] Remove old case sensitive variants of lowercase
 .c and .h files
In-Reply-To: <CAMfPbcbUD_29FihCpePpKOdJUAAw5XE_ciDAb6Lf_XcDU0JKRQ@mail.gmail.com>
Message-ID: <n64s37qp-093s-705p-q1r4-no875n163o91@vanv.qr>
References: <CAMfPbcbUD_29FihCpePpKOdJUAAw5XE_ciDAb6Lf_XcDU0JKRQ@mail.gmail.com>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Saturday 2023-12-16 20:22, Samuel Marks wrote:

>`git clone` fails on case-insensitive file systems, e.g., on Windows,
>MSYS, Cygwin due to case sensitive files. All but one are in
>netfilter, and they seem to be old code that isn't necessary.
>
> include/uapi/linux/netfilter/xt_CONNMARK.h  |   7 -
> include/uapi/linux/netfilter/xt_DSCP.h      |  27 --
> include/uapi/linux/netfilter/xt_MARK.h      |   7 -
> include/uapi/linux/netfilter/xt_RATEEST.h   |  17 -
> include/uapi/linux/netfilter/xt_TCPMSS.h    |  13 -
> include/uapi/linux/netfilter_ipv4/ipt_ECN.h |  34 --
> include/uapi/linux/netfilter_ipv4/ipt_TTL.h |  24 --
> include/uapi/linux/netfilter_ipv6/ip6t_HL.h |  25 --
> net/netfilter/Makefile                      |   4 -
> net/netfilter/xt_DSCP.c                     | 161 ---------
> net/netfilter/xt_HL.c                       | 159 ---------
> net/netfilter/xt_RATEEST.c                  | 233 -------------
> net/netfilter/xt_TCPMSS.c                   | 345 --------------------
> 13 files changed, 1056 deletions(-)
> delete mode 100644 include/uapi/linux/netfilter/xt_CONNMARK.h
> delete mode 100644 include/uapi/linux/netfilter/xt_DSCP.h
> delete mode 100644 include/uapi/linux/netfilter/xt_MARK.h
> delete mode 100644 include/uapi/linux/netfilter/xt_RATEEST.h
> delete mode 100644 include/uapi/linux/netfilter/xt_TCPMSS.h
> delete mode 100644 include/uapi/linux/netfilter_ipv4/ipt_ECN.h
> delete mode 100644 include/uapi/linux/netfilter_ipv4/ipt_TTL.h
> delete mode 100644 include/uapi/linux/netfilter_ipv6/ip6t_HL.h
> delete mode 100644 net/netfilter/xt_DSCP.c
> delete mode 100644 net/netfilter/xt_HL.c
> delete mode 100644 net/netfilter/xt_RATEEST.c
> delete mode 100644 net/netfilter/xt_TCPMSS.c

Did you ever test this?

	iptables -t mangle -A PREROUTING -i xyz0 -p tcp --syn -j TCPMSS --set-mss 1440

will now fail.

