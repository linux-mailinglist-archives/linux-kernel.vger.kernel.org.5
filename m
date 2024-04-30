Return-Path: <linux-kernel+bounces-163523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7B28B6C85
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E815B1C222E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEEF47F42;
	Tue, 30 Apr 2024 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ny2YddjI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A33140BEE;
	Tue, 30 Apr 2024 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714464697; cv=none; b=fom4Qw7CNv0iKZM6dcrR/BbvFTzAO5omMCRWzV8DJCCxn/rQ0h1odBlFGRvTmX/sJS7fY5gCmnoGaFqv+bQjAmRw6VFy26CMw6PG5arX5OZGwUrIzlMC92lWuuaMESK39EH5YZ1q7fBczo3yBu3FLnWtW7UQBugOG+pMwEntCnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714464697; c=relaxed/simple;
	bh=Okuepw31SRehXeoqshjfC4InPzrJlMsj8crjxsmEs+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aA9tQE8BE/emAYOrNLovFLUJ8HDdEKzMx5V7MtSm+rqqN/KzxftEbbTdGytUpqsWj0orZCLrb1eSL04U9UtOZ88bgKaGJxzJtqyBx4Tk9W4X+XA8FoYhcYjr8wM0HuvQ24XOXkCnk9dWnnH8y4DrSYg6kFuTj/gQOt6UgRy9C14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ny2YddjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86651C2BBFC;
	Tue, 30 Apr 2024 08:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714464697;
	bh=Okuepw31SRehXeoqshjfC4InPzrJlMsj8crjxsmEs+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ny2YddjIXd62EgONouXUw4MIpgq1mcR4Ny2Gcwe6ACTc+CdV0UXIy/YQCIIYl47Vc
	 UkQZoe0UGviKS6I/fiNMlR9e+zWbI6Va9a+ig1QuIAQgsZzcpNQGGCsroAtZYZ7Spv
	 zoWTvbkxlPFJxh4l9BIbK80yv3YxIwAHjrS4aFH8=
Date: Tue, 30 Apr 2024 10:11:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Juergen Gross <jgross@suse.com>
Cc: cve@kernel.org, linux-cve-announce@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"Xen.org security team" <security@xen.org>
Subject: Re: CVE-2024-26908: x86/xen: Add some null pointer checking to smp.c
Message-ID: <2024043015-pauper-aching-a3d4@gregkh>
References: <2024041747-CVE-2024-26908-4690@gregkh>
 <f73bb0fe-9ba6-46de-8732-bd372438068e@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f73bb0fe-9ba6-46de-8732-bd372438068e@suse.com>

On Mon, Apr 29, 2024 at 01:53:44PM +0200, Juergen Gross wrote:
> Hi,
> 
> I'd like to dispute CVE-2024-26908: the issue fixed by upstream commit
> 3693bb4465e6e32a204a5b86d3ec7e6b9f7e67c2 can in no way be triggered by
> an unprivileged user or by a remote attack of the system, as it requires
> hotplug of (virtual) cpus to the running system. This can be done only by
> either a host admin or by an admin of the guest which might suffer the
> out-of-memory situation.
> 
> Please revoke this CVE.

Sorry for the delay, thanks for looking into this and letting us know.
It's now rejected.

greg k-h

