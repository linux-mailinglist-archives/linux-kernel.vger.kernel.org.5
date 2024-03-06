Return-Path: <linux-kernel+bounces-93519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F38F8730F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB86B21FAA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18195D75E;
	Wed,  6 Mar 2024 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T9M7Wjdr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F089E2E641
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714414; cv=none; b=ubJNF2vyuMImCa87n4PyQn3iu1ygoY7JjnmofGHs9dFNaOqeu/4btQZ1FDWg281jBfSXh+5ouGpXd7IgtJ18uuxUto7EfyRg9C4qYBRy7Y2Ya10bZ512Z6Zh4OcReNepiFvEY/ofn4SyuLVfGQPnks4dIwI3cW0f6RdD8Gvpi5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714414; c=relaxed/simple;
	bh=ZuU3Syw6vHSb9m0W3SEXJ7dIREkCqdvYhwu5F4k7yyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQ8qAqUg0Wc/uUhl7Co17pnGhpzD0h2efG8M2JIOGE0FoN+plr4PqV5y/4S7kkM45osWM+bjEez1KRYPfmvgqqZQhdLjuQ8aYnVFFACSEh/7kvihO1XGIAZOA5H0R+G2GCKyYAcJGXOg2eXAr/ddwcccV0dvKb7lv8+lbKGKLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T9M7Wjdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514BFC433F1;
	Wed,  6 Mar 2024 08:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709714413;
	bh=ZuU3Syw6vHSb9m0W3SEXJ7dIREkCqdvYhwu5F4k7yyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T9M7WjdrpeAhlVznzweK/LWO4Wx+OLPJ/MECehdCTU4ugWUYhj1gC62s+AM5leC/Z
	 81B6XJrnkpJLEwR6AY71tc5IfPLW3CZljpV4jzzSQLgYc1jMRvjHmwPUTpcdb4voe3
	 b/4jeyyTJSFmx6lamyM3NJGfW0nNR+SeV/lPEMhM=
Date: Wed, 6 Mar 2024 08:40:10 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2021-47090: mm/hwpoison: clear MF_COUNT_INCREASED before
 retrying get_any_page()
Message-ID: <2024030651-drizzly-sanitizer-cba4@gregkh>
References: <2024030413-CVE-2021-47090-a429@gregkh>
 <ZedoMIyhF8d_XLIV@tiehlicka>
 <2024030541-unhappily-staff-8662@gregkh>
 <ZegkEqtGcC1p_7Xb@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZegkEqtGcC1p_7Xb@tiehlicka>

On Wed, Mar 06, 2024 at 09:06:42AM +0100, Michal Hocko wrote:
> On Tue 05-03-24 22:20:17, Greg KH wrote:
> > On Tue, Mar 05, 2024 at 07:45:04PM +0100, Michal Hocko wrote:
> > > On Mon 04-03-24 19:11:17, Greg KH wrote:
> > > > Description
> > > > ===========
> > > > 
> > > > In the Linux kernel, the following vulnerability has been resolved:
> > > > 
> > > > mm/hwpoison: clear MF_COUNT_INCREASED before retrying get_any_page()
> > > 
> > > I would like to dispute this CVE. The interface is behind CAP_SYSADMIN
> > > and allowing access to this to any untrusted party is risking serious
> > > troubles. This is a testing only feature.
> > 
> > This fixes a weakness in the kernel, one that is allowed to crash it,
> > why isn't that a good thing to have a CVE entry for?  Are we saying that
> > all VM_BUG_ON_PAGE() instances should not be accounted for?  That's not
> > what the config option for CONFIG_DEBUG_VM says, it just says it will
> > affect performance.
> 
> I wouldn't personaly recommend anybody using CONFIG_DEBUG_VM=y in
> production. But I am not questioning if somebody does that. This is
> not really what I am objecting to. Hwpoisoning or soft offlining is not
> aimed for other than testing purposes. Things can go wrong during
> these oprations.

Agreed, things can go wrong, but people use them for "reasons" otherwise
we wouldn't have those options in the kernel at all.  Because of that,
this "fix for a weakness" was given a CVE, that's all.

Again, we do not dictate use case, or severity at all, that's not our
role.

> If you insist this still qualifies as a vulnaribility/weakness fix then
> I would propose a new category pig-with-a-lipstick-CVE.
> 
> > Also /sys/devices/system/memory/soft_offline_page doesn't say "can crash
> > the system", so it should work properly, even if an admin uses it, it
> > shouldn't shut the box down.
> 
> I agree that Documentation/ABI/testing/sysfs-memory-page-offline would
> benefit from an update. Documentation/admin-guide/mm/memory-hotplug.rst
> is explicit about this being a testing feature.

The fact that I didn't even notice that is kind of proof that maybe
others might also miss it :)

thanks,

greg k-h

