Return-Path: <linux-kernel+bounces-126558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62713893972
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93BF71C20DD5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89351095A;
	Mon,  1 Apr 2024 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tt/EZVv/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EEEDDB6;
	Mon,  1 Apr 2024 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964260; cv=none; b=oq2kRbxF0i84FrLFMmTU2HDFf2Oc0FPruaRtsIEt4YqEEtWWdEt899nw4HwTWfqDhWAXIEe6Ux1eNEYJ8BzOD/zNmHk/zNo4qo004r6lz5ehR7YOX9mKhEHm33kGaAwAt1mNT22o9SpnEruR43b2vVqTILgWjos63sT8roKNBfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964260; c=relaxed/simple;
	bh=oDisQHZ5QyWOBRBhJ8kMuP+uptWUSRjIpRSluHtVhVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3UdP/rcxqPZeD0te7KSciz0V/MH39XJ6z6CWnbw/37zvCAbrrJckGYTetCBbpkpeqkkob+9Qjp6jGqYzEKhAdMyHXcTE1+tUNKFrGjyXDyZwrG3dLuDU5M/8miuUYHvkcvG4IU4IxYznK5BJ3gj+xAQWGw+nsTbXAHh8L4wGOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tt/EZVv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB43C433C7;
	Mon,  1 Apr 2024 09:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711964260;
	bh=oDisQHZ5QyWOBRBhJ8kMuP+uptWUSRjIpRSluHtVhVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tt/EZVv/ZR4QHN+8t5vtOuvEZrap4N7Kp7jzy5BgK0XNRRXOjGiX6dc0f9EBgKWys
	 kJiG9vkUu2CBvy3w1voiAz8nZDbgVZ6J/pWy2Zh9bZiS+TDbC+66fW6wetGS7Qmn7/
	 AF1ChqhTPW7+uehANNKEHibK+mojRJtl/93diCQA=
Date: Mon, 1 Apr 2024 11:37:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Kuntal Nayak <kuntal.nayak@broadcom.com>, stable@vger.kernel.org,
	jslaby@suse.com, linux-kernel@vger.kernel.org,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	Yangxi Xiang <xyangxi5@gmail.com>, stable <stable@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH v4.19-v5.4] vt: fix memory overlapping when deleting
 chars in the buffer
Message-ID: <2024040149-countable-ecosystem-ee44@gregkh>
References: <20240329191208.88821-1-kuntal.nayak@broadcom.com>
 <2024033014-deception-cartoon-7470@gregkh>
 <CAD2QZ9aJtFpXWYRVmgJRjad6qXXECvi+-J++QAR2t4opa6cdUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD2QZ9aJtFpXWYRVmgJRjad6qXXECvi+-J++QAR2t4opa6cdUA@mail.gmail.com>

On Mon, Apr 01, 2024 at 02:51:55PM +0530, Ajay Kaher wrote:
> On Sat, Mar 30, 2024 at 2:37 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Mar 29, 2024 at 12:12:08PM -0700, Kuntal Nayak wrote:
> > > From: Yangxi Xiang <xyangxi5@gmail.com>
> > >
> > > [ upstream commit 39cdb68c64d8 ]
> >
> > Please use the full git id in the future, it makes it easier and our
> > tools want it that way so that we can tell the difference between a
> > "Fixes:" tag and an actual backport.  I'll go queue this up now, thanks!
> >
> 
> Thanks Greg for accepting the patch.
> 
> ./scripts/checkpatch.pl confuse developers, as it gives error/warning
> if we use full git id.

No need to run checkpatch on backports, as the changelog text should not
be an issue.

> Example:
> ERROR: Please use git commit description style 'commit <12+ chars of
> sha1> ("<title line>")' - ie: 'commit e26d3009efda ("netfilter:
> nf_tables: disallow timeout for anonymous sets")'
> #6:
> commit e26d3009efda338f19016df4175f354a9bd0a4ab upstream.
> 
> Or shall we have something ./scripts/checkpatchstable.pl or
> ./scripts/checkpatch.pl stable (pass argument)?

Nah, it's never come up before now, I don't think people actually run
it, and I know I've never done so or even noticed, so all is fine.

thanks,

greg k-h

