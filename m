Return-Path: <linux-kernel+bounces-29067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C19B8307D0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFE61F23D59
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27A220DE6;
	Wed, 17 Jan 2024 14:15:34 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4385922EE3;
	Wed, 17 Jan 2024 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500934; cv=none; b=BV3JRYZfpqOqjNe1qqgKxfAVfkvSIDMtGJ8q/g9mBGFopyYJhEHK747mNPzYBbztoU+hO3ebcHEZmaCS+7BbUIO6oANuS7rIzF15rKsWnrvMASyOWlROcpAYArKYyZakkg5sUJ2xGwY+uw+PB99JGdmScSpb1yf+nTCHc1zecaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500934; c=relaxed/simple;
	bh=PFwU7OV8TL81BTaq5Hvr6NOTTBFHJNWQsEG/Y0TBme8=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 User-Agent; b=XanmWLNb/zQI3Zqp1evBGlcczGzJrmZkYXXwYdkX7ktN4OUfI4jfP6oHl0J010eQf2JdisjI8KPYohqp/Pz4nMFBUBMMKWPbYqyGI3FVS9NxiDp1CF3imnH0b9a/+8wRNhWuRPbaeSj+fAHehjbxfXUlFPuKrBbanCx6COiwyek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rQ6hL-00040S-HW; Wed, 17 Jan 2024 15:15:19 +0100
Date: Wed, 17 Jan 2024 15:15:19 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>, David Ahern <dsahern@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Kees Cook <keescook@chromium.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev, kernel@openvz.org
Subject: Re: [PATCH v3 0/4] netlink: bridge: fix nf_bridge->physindev use
 after free
Message-ID: <20240117141519.GB11468@breakpoint.cc>
References: <20240111150645.85637-1-ptikhomirov@virtuozzo.com>
 <ZafLhL9U3f/i07BU@calendula>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZafLhL9U3f/i07BU@calendula>
User-Agent: Mutt/1.10.1 (2018-07-13)

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> My understanding is that this problem has been always there for
> br_netfilter.

Right.

