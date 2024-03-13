Return-Path: <linux-kernel+bounces-102443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC9D87B297
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CC3BB26527
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717C84D117;
	Wed, 13 Mar 2024 19:41:08 +0000 (UTC)
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9197A4CE11;
	Wed, 13 Mar 2024 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358868; cv=none; b=XLu5yaPk+k7ozb6g+vpede9bGYSaoW70E+LK8MRpkZL+VM4Hrcuz20JQkLNVgZQcZNAkZFAMRqntt4VN+JZm9sxkvk3BKANwhcVdLuBWsbnMGrmtwbQQedCHe5m+42EVGhE1VCkc53L3VLApZU4+AHtG0CWlCcn3n0h44pHnmbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358868; c=relaxed/simple;
	bh=G/HV2rkBpLvlZFMNXRNboGfFRvkIxzCR/w0qKB3g1D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtISN1m+okw++iEChXhVWGf8KvQ47MEygt8S6q19XEoLNXCySOiAXkls5aoIY1tdlznCfahmHkUGLWrXiclLYUv5lkfoBmkpCmjEOaaDG3mXJNrdk4pSzkEQ99sHiPkc+vq2b3Hm43+DS5CVE0mc35Ie4kjebq5lyYeoeJwtbus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 13B733F07B;
	Wed, 13 Mar 2024 20:40:50 +0100 (CET)
Date: Wed, 13 Mar 2024 20:40:49 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dietmar Maurer <dietmar@proxmox.com>,
	Thomas Lamprecht <t.lamprecht@proxmox.com>,
	Wolfgang Bumiller <w.bumiller@proxmox.com>,
	Alexandre Derumier <aderumier@odiso.com>
Subject: Re: [PATCH net] netfilter: conntrack: fix ct-state for ICMPv6
 Multicast Router Discovery
Message-ID: <ZfIBQbPeP8SYc3jf@sellars>
References: <20240306141805.17679-1-linus.luessing@c0d3.blue>
 <20240307101254.GL281974@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240307101254.GL281974@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, Mar 07, 2024 at 10:12:54AM +0000, Simon Horman wrote:
> Hi Linus,
> 
> this appears to be a fix and as such I think it warrants a Fixes tag.
> You should be able to just add it to this thread if no other changes
> are required - no need for a v2 just to address this.
> 
> ...

Hi Simon,

From reading the code and git logs I suspect this
commit, which introduced icmpv6_error():

  9fb9cbb1082d [NETFILTER]: Add nf_conntrack subsystem.

  (introduced in: Linux v2.6.15 / 2006)

Unfortunately, I was only able to reproduce it in practice
on a Debian 5 / Linux 2.6.26 in a VM so far.

I could boot a Debian 4 + Linux 2.6.15, but wasn't able to
insert conntrack rules with ip6tables there though, even
with some iptables + kernel rebuilds/reconfigure attempts.



Also this related fix introduced in v2.6.29 should hint to the
age of this issue:

  3f9007135c1d netfilter: nf_conntrack_ipv6: don't track ICMPv6 negotiation message

Which only picked/fixed a few ICMPv6 types but not ICMPv6 MRD
though.


tl;dr: for me this would be ok, if it were ok for others, too, that I
couldn't fully bisect to it in practice... :

Fixes: 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.")

