Return-Path: <linux-kernel+bounces-41492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC45983F2BC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 02:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71EA0284C77
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 01:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84C6184E;
	Sun, 28 Jan 2024 01:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WWQu0ndt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112211113;
	Sun, 28 Jan 2024 01:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706405386; cv=none; b=hq3i15swHjp+q+4eWZyHpxu57Vi0tcu32tc620aTW4AIIfNTEXQw2shW0FLD8u7XyM2eEUZxKSmEjrQyvI/8kdhboyGL5YVDkTCSY80sG/WJtgMyHHwRS/TW/qxGJFu8twQVeOlSVR52qFRBPwuEzLsgP1i3MhnFYFLHLDy6qxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706405386; c=relaxed/simple;
	bh=iPTcSpldKderHfTJOkFotGkZbDgZ0cvvdpUsSLEh7zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFIKq/0bPvvShUPORPW3GtK1xMrIK5rM1qAnYVx5hlb/qApSFZ+RhAw4mGuf+OvQF5AdqBf6cZxfNY7p+r3OxazhhfLc16IRcK9pbu56mRURYryf7IlXSz7gAGzn4W7NYhgCij8sVcUllz/k2A1JCkMoc5rEvW5Ec9GnpWp+BU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WWQu0ndt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C809C433C7;
	Sun, 28 Jan 2024 01:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706405385;
	bh=iPTcSpldKderHfTJOkFotGkZbDgZ0cvvdpUsSLEh7zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWQu0ndtlfL0E4lf7y8G3LZpKWF/0SDnXDILj175K62E4y/nqw6+1jL1MR64AmCXx
	 jMi3LRMdQ4nsgMVEHmFUz2ZL3r9bNPJTXnrgDS9v+xoXW6ZFm8/0W2J5kiQXOd/OQt
	 4AlBMD8/RN8AS2oE3vkBA3taVfjsWhrK/+hiBy4w=
Date: Sat, 27 Jan 2024 17:29:43 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Kuen-Han Tsai <khtsai@google.com>, quic_prashk@quicinc.com,
	stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: u_serial: Add null pointer checks after
 RX/TX submission
Message-ID: <2024012724-chirpy-google-51bb@gregkh>
References: <20240116141801.396398-1-khtsai@google.com>
 <02bec7b8-7754-4b9d-84ae-51621d6aa7ec@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02bec7b8-7754-4b9d-84ae-51621d6aa7ec@kernel.org>

On Thu, Jan 18, 2024 at 10:27:54AM +0100, Jiri Slaby wrote:
> On 16. 01. 24, 15:16, Kuen-Han Tsai wrote:
> > Commit ffd603f21423 ("usb: gadget: u_serial: Add null pointer check in
> > gs_start_io") adds null pointer checks to gs_start_io(), but it doesn't
> > fully fix the potential null pointer dereference issue. While
> > gserial_connect() calls gs_start_io() with port_lock held, gs_start_rx()
> > and gs_start_tx() release the lock during endpoint request submission.
> > This creates a window where gs_close() could set port->port_tty to NULL,
> > leading to a dereference when the lock is reacquired.
> > 
> > This patch adds a null pointer check for port->port_tty after RX/TX
> > submission, and removes the initial null pointer check in gs_start_io()
> > since the caller must hold port_lock and guarantee non-null values for
> > port_usb and port_tty.
> 
> Or you switch to tty_port refcounting and need not fiddling with this at all
> ;).

I agree, Kuen-Han, why not do that instead?

thanks,

greg k-h

