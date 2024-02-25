Return-Path: <linux-kernel+bounces-80027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94A58629E0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 10:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63847B2133D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 09:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB16EED5;
	Sun, 25 Feb 2024 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ih0xWlGL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1C3DDC6
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708854451; cv=none; b=U29xf6MeaODcRoP83spfSJe6EKzYzEy5gnYWz87fslE0oi/SuBrjN7PzERLcNq3vYrvtTjIEmbWSp/68CsKtJ0h6WCkO1+Nfc34HMCJ3bZiAf6bHM0ytCmq7yWo7gXUG09hu9lOn/cLKJj5YSeUCIsGxX9jziWR2jvSS6NA4l2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708854451; c=relaxed/simple;
	bh=HY51YprnekZMzXPFjZP7Tia3Yjursz8h+JsEwAygOtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaQtuxtz2V2lOzxySfHPxnFDFTKiRWLfAxYe6vQUs0e1YlxR/DBgcj657zbpGyl8zakrG4eJWTQaCneGn+eBsFIJs85lAJdlc/n6B0CORME004AEt9cNKbJlF5LuofHjZ8niOzNZV1pwfKHJPhD3UyKr826EOUKhKyU5ueSwOo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ih0xWlGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5405C433C7;
	Sun, 25 Feb 2024 09:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708854451;
	bh=HY51YprnekZMzXPFjZP7Tia3Yjursz8h+JsEwAygOtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ih0xWlGLpQQApCeFTY4j4zHKRQIdoJDf0czKb93vnQxlQkNssOmht8lw1+t1hgeWk
	 hJXbO84/RQrpaS4sSuCRdeKAPREQrHthq8gk03JyLApnkB9BZgnYPHeaKEFJApdpay
	 ENScR9vBcRexn1nc/yf7v+rdoi0MAfeJyZrGBbgc=
Date: Sun, 25 Feb 2024 10:47:28 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-26602: sched/membarrier: reduce the ability to hammer
 on sys_membarrier
Message-ID: <2024022510-goofy-entering-12e3@gregkh>
References: <2024022414-CVE-2024-26602-5e76@gregkh>
 <22f42e54-d791-42aa-88f3-172f616b8316@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22f42e54-d791-42aa-88f3-172f616b8316@leemhuis.info>

On Sun, Feb 25, 2024 at 10:31:19AM +0100, Thorsten Leemhuis wrote:
> On 24.02.24 15:57, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > sched/membarrier: reduce the ability to hammer on sys_membarrier
> > 
> > On some systems, sys_membarrier can be very expensive, causing overall
> > slowdowns for everything.  So put a lock on the path in order to
> > serialize the accesses to prevent the ability for this to be called at
> > too high of a frequency and saturate the machine.
> > 
> > The Linux kernel CVE team has assigned CVE-2024-26602 to this issue.
> > 
> > 
> > Affected and fixed versions
> > ===========================
> > 
> > 	Issue introduced in 4.14 with commit c5f58bd58f43 and fixed in 4.19.307 with commit 3cd139875e9a
> > 	Issue introduced in 4.14 with commit c5f58bd58f43 and fixed in 5.4.269 with commit 2441a64070b8
> > 	Issue introduced in 4.14 with commit c5f58bd58f43 and fixed in 5.10.210 with commit db896bbe4a9c
> > 	Issue introduced in 4.14 with commit c5f58bd58f43 and fixed in 5.15.149 with commit 50fb4e17df31
> > 	Issue introduced in 4.14 with commit c5f58bd58f43 and fixed in 6.1.79 with commit 24ec7504a08a
> > 	Issue introduced in 4.14 with commit c5f58bd58f43 and fixed in 6.6.18 with commit b6a2a9cbb675
> > 	Issue introduced in 4.14 with commit c5f58bd58f43 and fixed in 6.7.6 with commit c5b2063c65d0
> >
> > Please see [...]
> Greg, JFYI, I noticed that this announcement did not refer to the fix in
> mainline (944d5fe50f3f03 ("sched/membarrier: reduce the ability to
> hammer on sys_membarrier")) while most of the others do that. I don't
> care at all, just noticed this by chance and wanted to let you know in
> case it's due to a bug in a script or something. I hope there is not a
> good reason for that difference I just failed to spot... (if that's the
> case: apologies in advance for the noise!).

The json entry will be updated when the commit shows up in a tagged
release (i.e. the next -rc release), and then when the real release
happens from Linus (i.e. 6.8), it will be updated then as well.

But for now, the mainline commit is not in any "real" release so we
can't reference it here in the message or in the json record as per the
rules from CVE.

hope this helps explain things better,

greg k-h

