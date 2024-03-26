Return-Path: <linux-kernel+bounces-118686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23A588BE05
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A25EB2615F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780037581F;
	Tue, 26 Mar 2024 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F/G4l/Ou"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40A673539;
	Tue, 26 Mar 2024 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445413; cv=none; b=p5ygQLgF7Mr5TTi/DMyWzVKOz0w096St3QKjploMPXDidlNkKBOvI60owJlQ53dAF1k6pjwJj15lP4Av/KbEhfE1EEtsEASyC/qDvv9lVKlcYbyVxKyuh6d2ak+pDinUezXVY6qyEvh6Qa8QZMhb7FzUaQJ4c8jegqvTTi67BZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445413; c=relaxed/simple;
	bh=TmO8LZS/iJ3ZXxl/r7qHjzUSiyZSbemk8sv8R3kPSOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMYpZZ+tS8ZlivPVs/s3Xv59IEkD6PbpP3Jk1B1gMACQPwh0b5biNM7js3MENv9aduhgU+p1NgCFfVOdC20iPp6ZIcSj//PylS2xxN29HWYNwxnnH7EccAc/K2Hba6zq8t3i+nKTR/aSd7VT8UMNt7EjS9+WSa2gavJs2JTc/sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F/G4l/Ou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF838C433C7;
	Tue, 26 Mar 2024 09:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711445413;
	bh=TmO8LZS/iJ3ZXxl/r7qHjzUSiyZSbemk8sv8R3kPSOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F/G4l/OuQjxv+o/7NKr/07ZmBhUW+OadMjpt2lOVT92fEJ9kRN7F/D5IahchUyBvb
	 MZMvUnOoeKIUaJ09SUgWSsmRiH+S5ZFQI0qjm+nHBHgr8JG4YL00j/m3/nxPyZXken
	 3Oxdv4daNNmwXFdDHk+0hDkwJi1Rk453JTyj0g4w=
Date: Tue, 26 Mar 2024 10:30:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kyle Tso <kyletso@google.com>
Cc: linux@roeck-us.net, heikki.krogerus@linux.intel.com, badhri@google.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: Correct the PDO counting in pd_set
Message-ID: <2024032624-drizzle-coaster-c97f@gregkh>
References: <20240319074337.3307292-1-kyletso@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319074337.3307292-1-kyletso@google.com>

On Tue, Mar 19, 2024 at 03:43:37PM +0800, Kyle Tso wrote:
> The index in the loop has already been added one and is equal to the
> number of PDOs to be updated when leaving the loop.

That says what is happening but not the issue that is being addressed.
What is the problem with the number being off by one?  Is this a "crash
the system" or merely "our accounting is wrong"?

thank,

greg k-h

