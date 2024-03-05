Return-Path: <linux-kernel+bounces-93048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FDF872A1D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA1A1F26561
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FFC12D1FD;
	Tue,  5 Mar 2024 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bPTXjEmR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAAB12D1FA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677221; cv=none; b=TSBMYKguhjTr0HGqg8OtDzMrQ6A2WFbOwMogaZThnYcXvjo9VaOt+b7bms6DtX1DqHZxDlU3sbs3m0lCioVWJpgCT4ApK1OVdRPFZN7ZGIY5OHLSG+wG1AJLI1glvPQRjDuIF1CiZjdVaCCjLetW6kDUHpYk3cuAwpqn1t5U6XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677221; c=relaxed/simple;
	bh=ZTkmXtPxMavIvLui55rLxCNEIn2zGMJAQ36Kig5x2yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwvW++x1hrU3oghuhveOO9LC0ngUhWvNke5kPLvvVwwMHVQT75I2NizlKXGJrR56+LpeRKZ5TaaQASSN6+IRfwRBiQ0Zm0C3KBiPFQozmbIRGGrGK1EDytpyHsXPyz/C8Uh4bxfKVbfbVg3r6wqRUtiD5VGKBRFfWK7q/9ZMts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bPTXjEmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB09C433C7;
	Tue,  5 Mar 2024 22:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709677220;
	bh=ZTkmXtPxMavIvLui55rLxCNEIn2zGMJAQ36Kig5x2yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bPTXjEmRr2xT5Gi0he71DNjlJ4psENOp2G5NmwlG9FTl4mcaxd79gGP7RD5QmUWh0
	 b5zdg9KVADZ+LxlNjJd7RWZmPkGZcCF5ifE3ITRJZ3aJvR11eoJes35P648xGbRDsq
	 sH9ZfactiJZEIrgz1PbrCbiLui5xJzMugSSChYFQ=
Date: Tue, 5 Mar 2024 22:20:17 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2021-47090: mm/hwpoison: clear MF_COUNT_INCREASED before
 retrying get_any_page()
Message-ID: <2024030541-unhappily-staff-8662@gregkh>
References: <2024030413-CVE-2021-47090-a429@gregkh>
 <ZedoMIyhF8d_XLIV@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZedoMIyhF8d_XLIV@tiehlicka>

On Tue, Mar 05, 2024 at 07:45:04PM +0100, Michal Hocko wrote:
> On Mon 04-03-24 19:11:17, Greg KH wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > mm/hwpoison: clear MF_COUNT_INCREASED before retrying get_any_page()
> 
> I would like to dispute this CVE. The interface is behind CAP_SYSADMIN
> and allowing access to this to any untrusted party is risking serious
> troubles. This is a testing only feature.

This fixes a weakness in the kernel, one that is allowed to crash it,
why isn't that a good thing to have a CVE entry for?  Are we saying that
all VM_BUG_ON_PAGE() instances should not be accounted for?  That's not
what the config option for CONFIG_DEBUG_VM says, it just says it will
affect performance.

Also /sys/devices/system/memory/soft_offline_page doesn't say "can crash
the system", so it should work properly, even if an admin uses it, it
shouldn't shut the box down.

confused,

greg k-h

