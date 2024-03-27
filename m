Return-Path: <linux-kernel+bounces-121448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F0E88E803
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2A21C2F69A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AFE1494D9;
	Wed, 27 Mar 2024 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LtEJdsCC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A341494AC;
	Wed, 27 Mar 2024 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550225; cv=none; b=KovbBO1/CgxuyEFIgEVNu1sevMW6ZC30X7iD6nk34hmXiNrHLwzjR61kY9UksyivHv7xfaE84W7JeYSk26vxdVYTj831VvAdAdHBCeu/x4qzvm24jCAW4zPuAG+pg1MX1xojGEI34RwmQ8g1NVHGEjJSwVTZdK5ChgpDZ1mz488=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550225; c=relaxed/simple;
	bh=CNvTdSlrwsQbv/udDF8Dk7iqvTn3Y6HeV3CkmDU+yOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWtx4oAF16idl+FGVBu7TauhjBPjzLma4YnRrc707C97yMmZtBVrqSre/chd1B8+lmgjR+oXgxZKgd5ufWRSMcnoL9xhhodNbcIQeQPraAL74UNKDwQaHE40wa3BrXQpZvZtvTdXIOKXWjYNGaSAUgHzIpt+pXZ1LtOozg39P3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LtEJdsCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867B0C433F1;
	Wed, 27 Mar 2024 14:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711550225;
	bh=CNvTdSlrwsQbv/udDF8Dk7iqvTn3Y6HeV3CkmDU+yOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LtEJdsCCdKpsltsQU6Ytj7X4C265OAerO6/JumdSuySgr+fi/PZIZV6fjzUF4+zj3
	 eIcOFw82FGggfERd9RGAZd8jPx9PPULtfnL7gW6UVoofpnZOOr3JJ9TmA+n7iSNWrG
	 wxssgc1GiQiEHR+ljTQ8kSPLatxk/4kaZkwbP82s=
Date: Wed, 27 Mar 2024 15:37:02 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: linux-cve-announce@vger.kernel.org, cve@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52462: bpf: fix check for attempt to corrupt spilled
 pointer
Message-ID: <2024032752-crave-emu-c82a@gregkh>
References: <2024022335-CVE-2023-52462-b663@gregkh>
 <zbmamyicnciykxaepg53jnq6qnkbl6xdsymukrjbmblgvcfw5f@o7xd2v4hjofd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zbmamyicnciykxaepg53jnq6qnkbl6xdsymukrjbmblgvcfw5f@o7xd2v4hjofd>

On Tue, Mar 05, 2024 at 11:41:52PM +0800, Shung-Hsi Yu wrote:
> On Fri, Feb 23, 2024 at 03:47:35PM +0100, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > bpf: fix check for attempt to corrupt spilled pointer
> > 
> > When register is spilled onto a stack as a 1/2/4-byte register, we set
> > slot_type[BPF_REG_SIZE - 1] (plus potentially few more below it,
> > depending on actual spill size). So to check if some stack slot has
> > spilled register we need to consult slot_type[7], not slot_type[0].
> > 
> > To avoid the need to remember and double-check this in the future, just
> > use is_spilled_reg() helper.
> > 
> > The Linux kernel CVE team has assigned CVE-2023-52462 to this issue.
> > 
> > 
> > Affected and fixed versions
> > ===========================
> > 
> > 	Issue introduced in 5.10.163 with commit cdd73a5ed084 and fixed in 5.10.209 with commit 2757f17972d8
> > 	Issue introduced in 5.15.86 with commit 07c286c10a9c and fixed in 5.15.148 with commit 67e6707f0735
> > 	Issue introduced in 5.16 with commit 27113c59b6d0 and fixed in 6.1.75 with commit fc3e3c50a0a4
> > 	Issue introduced in 5.16 with commit 27113c59b6d0 and fixed in 6.6.14 with commit 8dc15b067059
> > 	Issue introduced in 5.16 with commit 27113c59b6d0 and fixed in 6.7.2 with commit 40617d45ea05
> > 	Issue introduced in 5.16 with commit 27113c59b6d0 and fixed in 6.8-rc1 with commit ab125ed3ec1c
> 
> While commit 27113c59b6d0 ("bpf: Check the other end of slot_type for
> STACK_SPILL") is referenced in the Fixes tag, and made the switch to use
> slot_type[7] instead of slot_type[0]. This shouldn't cause any issue
> because its commit message stated that
> 
>   ... Verifier currently only saves the reg state if the whole 8 bytes
>   are spilled to the stack, so checking the slot_type[7] is the same as
>   checking slot_type[0].
> 
> It is the next commit in the series, commit 354e8f1970f8 ("bpf: Support
> <8-byte scalar spill and refill"), that rendered checking slot_type[0]
> problematic.
> 
> So I believe the issue is introduced with commit 354e8f1970f8 rather
> than 27113c59b6d0. That said kernel releases seems to either contain
> both or none of them at all, so in pratice the difference probably
> doesn't matter too much.

Thanks for the information!

greg k-h

> 
> > [snip]
> 

