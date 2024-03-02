Return-Path: <linux-kernel+bounces-89596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B69286F278
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 22:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0338FB22847
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0054120B;
	Sat,  2 Mar 2024 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dXi4cdWG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92A217C69;
	Sat,  2 Mar 2024 21:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709413323; cv=none; b=QUS+D2xLj6twUZtBCqxEzEBiUGsu8Gpkn7v5IrQzmRTWqVmubLZMJFJjpgmmGTlyiDN2udECj578xspfJgGsX68fJ88TOxmQ0uD1WTzMTdPwNClmexvXrKtOqzCz+DZOIHqnaqrNjERlkcq6E7B1hC2XYUD5fNxTAEIXTfvH6WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709413323; c=relaxed/simple;
	bh=OhRRtWzsfHY9LE7E5OaFQ+ldKlKe7NOVWy6A4WnvNA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fH+WL0m2HAdd4BqUho3+h2leIMjglZmo9wtRcqmoh4ZT+h/QA4f6nk5Nk6+CuUihD+XXQV0p2q7ZqndXFS2WuIbYw+Z5h3zr3A5Axp91r0G0lcIz2HpkHvX+KaU1dQyP4fCknbCnck4gnEaNAdKhe959483xJ60LMlNOADMcJbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dXi4cdWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7088C433C7;
	Sat,  2 Mar 2024 21:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709413322;
	bh=OhRRtWzsfHY9LE7E5OaFQ+ldKlKe7NOVWy6A4WnvNA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dXi4cdWGtQk7hUyIJd7lHeLe2/JzPXjPT2XxjOl3b+0cdMQFApRZgGEMgdutxxn2A
	 RXDJoIahs82as2hnDfon2kwzs/ZnXOg5Y1aYDJJgZQTOPsEjXOzQVg7iR3pn8JEBmL
	 /TU3tHHxUWolTuBNusQqq5cOBE/lx1/5OEXq/DXY=
Date: Sat, 2 Mar 2024 22:01:59 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Collingbourne <pcc@google.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_dw: Do not reclock if already at correct
 rate
Message-ID: <2024030233-safely-mama-5f52@gregkh>
References: <20240222192635.1050502-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222192635.1050502-1-pcc@google.com>

On Thu, Feb 22, 2024 at 11:26:34AM -0800, Peter Collingbourne wrote:
> When userspace opens the console, we call set_termios() passing a
> termios with the console's configured baud rate. Currently this causes
> dw8250_set_termios() to disable and then re-enable the UART clock at
> the same frequency as it was originally. This can cause corruption
> of any concurrent console output. Fix it by skipping the reclocking
> if we are already at the correct rate.
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/I2e3761d239cbf29ed41412e5338f30bffe1efc70

Again, why the link?  What does that help with?  Our tools add a Link:
tag to this public email thread, not a google gerrit instance.

thanks,

greg k-h

