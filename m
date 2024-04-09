Return-Path: <linux-kernel+bounces-137028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB4789DB52
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7771C21D29
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F46913667A;
	Tue,  9 Apr 2024 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Vcofo+q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571DA130E3B;
	Tue,  9 Apr 2024 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670756; cv=none; b=VlrSr0F5oN7IPPluQjynpcWBZOxJ1zuO5RrewRUkSj2qJMDmgqiKqdtYNLVrL6C58cQPhL79UhL8TWNKWdT7m2JqEaF84VJLJbQfl0MUmxfu4uWybwwcVpLfoSrrUJmTNs1K5YObwAgSqLVxdrorYoIY4yRN/yn2xjwcKkUfw6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670756; c=relaxed/simple;
	bh=Gz5S6+Wi61b3nNFO2B+UJGdz5h/o97smuwG+85sEphE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzWOHx19x5J6uBg5fvcc7CmtdaUrkbPO6H/m0MDXz30sM0wLWFzJmLMbnxCRIOCS2fP7gopd4MDxPfu65g9rEJHTabq4JHl97oME3lV92j1yrAYPZ9J2o4hRNLwseDrjlV3gqppiT+/dwhak43aptVxRfvfDIlzBgVFzfJgpK1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Vcofo+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD82C433C7;
	Tue,  9 Apr 2024 13:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712670755;
	bh=Gz5S6+Wi61b3nNFO2B+UJGdz5h/o97smuwG+85sEphE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0Vcofo+qjZ8Hy/8ZP8Ie+lLmdBlc+Wg5LIn2OTjEe40kl/TfTDLlkaYdHFkv/8XDE
	 TmcEvFv6r09gAexnjhoiJ9Bb9Z0qKdP04NMiX8hQc5sJwokx6i2IpeWmVMexqkfhxV
	 sJPXiwojisyc9+bE8Vm5ax14unfshyt4wk8JX/x8=
Date: Tue, 9 Apr 2024 15:52:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hugo@hugovil.com>
Subject: Re: [PATCH v2 00/16] serial: max3100: Put into shape
Message-ID: <2024040903-handcuff-lanky-cc13@gregkh>
References: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>

On Tue, Apr 02, 2024 at 10:50:27PM +0300, Andy Shevchenko wrote:
> Put the driver into the shape with all new bells and whistles
> from the kernel.
> 
> The first three patches marked as fixes, but there is no hurry (as it
> was for ages like this in the kernel) to pipe them to stable. That's
> why I sent all in one series and it's good for tty-next.
> 
> Tested on Intel Merrifield with MAX3111e connected.
> 
> In v2:
> - fixed a few typos in the commit messages (Hugo)
> - added an additional fix to patch 2 (Hugo)
> - appended tag to patch 13 (Hugo)
> - v1 (20240402154219.3583679-1-andriy.shevchenko@linux.intel.com)

Only a portion of this series applied to my tree.  Can you please rebase
and resend the remaining bits?

thanks,

greg k-h

