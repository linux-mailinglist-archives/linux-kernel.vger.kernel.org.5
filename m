Return-Path: <linux-kernel+bounces-44794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D901A842780
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6067BB26A12
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A098121B;
	Tue, 30 Jan 2024 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zc9UAHgY"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC41E60ED9;
	Tue, 30 Jan 2024 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627040; cv=none; b=NeZzftfeqSVPzSb9bS9VV5UN+S19umwWER/4dxrE3iN/prTYlRwWg+KDZ3nVjEBVxH4I5cI/z7VN66dOw2e4zi37gazkvxd3tR7Y6tz/9yUsK+CwcpqyG32W/fy+SvA+Mk2CpnLBB4LzaHEu9aaiwnXi04MptKtiBoataz9Cxi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627040; c=relaxed/simple;
	bh=//kFKSouwAE4cOJHqMCMPzz68JKEdAOc+2/aJyyBShg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kvXDYBoXPQk0uz58oFJ8SPKEMAOo9gWIyFCGWx6CDJJZrOKGXg2mVX/nn9IrSh010SUofWe8kk2vxq5QJ6+pj/mjPfkqhG90IAKzblsAo42ilXERFZvB96R6RRia1iniCMVR9cznUJFnAnRUNKlJ+PZ62XwZTpOdmyeoo7hc054=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zc9UAHgY; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706627038; x=1738163038;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=//kFKSouwAE4cOJHqMCMPzz68JKEdAOc+2/aJyyBShg=;
  b=Zc9UAHgYXO5H5YGJDKCAZBhjsb+3IgMIbOZbsvYn2UGiqn664d9+Muh3
   ilGokoDwLX4hf/B5XKFVoVcFq/HZszEFC6nb2dl4ReJRbZWx3YFG3wORX
   6oepYk9i7gl6eQAncKFDdq4eJIl0Cxo/qJD9clKVLO7O8n0ImiALW4uxj
   3F/rUCjCh48oqD+D0s01iFHZ2ZdABN6GxcgL8Ba7103GQgkPV8a9k9PD3
   lJMEyUugp/N6V2SjQsrMk7qxYbDqFyhe98Kjg08JlvtjWck/1MTiMgRuf
   55qQj/uYn/ekdnzyM42EFw8HhMnZuP3vSj3RmCnvz8FwlWF5j/E2RQ1OP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="434478342"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="434478342"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 07:03:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="737803418"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="737803418"
Received: from dcarleto-mobl.ger.corp.intel.com (HELO localhost) ([10.252.59.176])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 07:03:53 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>, Breno Leitao <leitao@debian.org>,
 kuba@kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH v3] Documentation: Document each netlink family
In-Reply-To: <87jznqewa7.fsf@meer.lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231121114831.3033560-1-leitao@debian.org>
 <874jevjgvo.fsf@intel.com> <87jznqewa7.fsf@meer.lwn.net>
Date: Tue, 30 Jan 2024 17:03:50 +0200
Message-ID: <87wmrqj221.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 30 Jan 2024, Jonathan Corbet <corbet@lwn.net> wrote:
> Jani Nikula <jani.nikula@linux.intel.com> writes:
>
>> On Tue, 21 Nov 2023, Breno Leitao <leitao@debian.org> wrote:
>>> This is a simple script that parses the Netlink YAML spec files
>>> (Documentation/netlink/specs/), and generates RST files to be rendered
>>> in the Network -> Netlink Specification documentation page.
>>
>> First of all, my boilerplate complaint: All extra processing for Sphinx
>> should really be done using Sphinx extensions instead of adding Makefile
>> hacks. I don't think it's sustainable to keep adding this stuff. We
>> chose Sphinx because it is extensible, and to avoid the Rube Goldberg
>> machine that the previous documentation build system was.
>
> So I feel like we've (me included) have kind of sent Breno around in
> circles on this one.  This *was* implemented as an extension once:
>
>   https://lore.kernel.org/netdev/20231103135622.250314-1-leitao@debian.org/
>
> At that time it seemed too complex, and I thought that an external
> script would lead to a simpler implementation overall.  Perhaps I was
> wrong.
>
> I worry that a proliferation of extensions adds its own sort of
> complexity and hazards - look at the things Vegard has fixed recently,
> for example.

If we're talking about the same things, I think one of the main problems
there was shelling out to an external script while it could all have
been trivially implemented directly in the extension. ;)

> Relatively few people can work in that environment, and
> extensions can make our version-support troubles worse.  So I'm not
> fully sold on the idea that everything should be an extension,
> especially if it can be expressed as a simple dependency and build step
> in the makefile.

I think we're just going to have to agree to disagree here. And,
ultimately, it's your call as the documentation maintainer.

I'm sure some individual things are simple to put in the makefiles, but
I believe overall the entire thing would be simpler if we avoided that.

> Some of the uglier makefile stuff we have is a different story...
>
> Anyway, I apologize for my role in making this particular addition
> harder than it needed to be.  Perhaps, for the future, we should put
> together and agree on a document (of all things) on how we think this
> sort of functionality should be added.

Perhaps. The problem at hand, though, is that after 'make
O=/path/to/build htmldocs' I have this cruft in my source tree:

$ git ls-files -oi --exclude-per-directory=.gitignore
Documentation/networking/netlink_spec/devlink.rst
Documentation/networking/netlink_spec/dpll.rst
Documentation/networking/netlink_spec/ethtool.rst
Documentation/networking/netlink_spec/fou.rst
Documentation/networking/netlink_spec/handshake.rst
Documentation/networking/netlink_spec/index.rst
Documentation/networking/netlink_spec/mptcp_pm.rst
Documentation/networking/netlink_spec/netdev.rst
Documentation/networking/netlink_spec/nfsd.rst
Documentation/networking/netlink_spec/ovs_datapath.rst
Documentation/networking/netlink_spec/ovs_flow.rst
Documentation/networking/netlink_spec/ovs_vport.rst
Documentation/networking/netlink_spec/rt_addr.rst
Documentation/networking/netlink_spec/rt_link.rst
Documentation/networking/netlink_spec/rt_route.rst
Documentation/networking/netlink_spec/tc.rst

I'm not even sure what the best way to fix that would be. (Apart from
turning it into an extension, of course. ;)


BR,
Jani.


-- 
Jani Nikula, Intel

