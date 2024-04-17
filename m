Return-Path: <linux-kernel+bounces-148388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EBB8A81D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC902286971
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B792813C68E;
	Wed, 17 Apr 2024 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UoQslgqD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F185E13C80B;
	Wed, 17 Apr 2024 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352545; cv=none; b=Pcekb7kNWFskysasShpJV3ZyyaAGyBT4xXClILrcfy1XUxjMbDP20ySOGjlD+Q9Cqe9U9/tTVk1Id3oRPJnAo2NLMs6ud99brnB9FFZKxbffM2lJ2ZCra8Cl4O2lDhn3fmSmfHNWtZjBZIY4l/zaZputHE0Z2cVTK5VftKvgtDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352545; c=relaxed/simple;
	bh=jiijXboTnxv6WF0GtfVWrrS1rMd7DbJe7sF4sHbj9m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWVEKoPcW069G7c604LH37+/w+oIMm7yIKvBqMshUcmpjWdZXERBYPourc7RH3BR31+UKaw2C2aNSEI/xK2LCKJqgSSyJZUrIajPWITXzEnzPpifYiMRvg6+eyZJPY+UAMxMhvZUl7hb8UUqX6GnaSElvqKoVgJ7nWv2pGdX8BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UoQslgqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB66FC072AA;
	Wed, 17 Apr 2024 11:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713352544;
	bh=jiijXboTnxv6WF0GtfVWrrS1rMd7DbJe7sF4sHbj9m4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UoQslgqDgGW45+rOYjV72iC2IdN3SqyxZrLRU4PhWHHDt47uZb6OqOlEL66MmVGb3
	 iyt+vFXnMoMnc8fv65aMVU4XsbQNKySa9wGPyCoC6pY5YnFojsgZQKhXCh1JnB0xA6
	 +fjRNHBvL4d7+FHHpwvbiFaffAY5st1D/JlHt9Bc=
Date: Wed, 17 Apr 2024 13:15:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Parker Newman <parker@finest.io>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v3 3/8] serial: exar: added a exar_get_nr_ports function
Message-ID: <2024041708-flail-pester-d1fa@gregkh>
References: <cover.1713270624.git.pnewman@connecttech.com>
 <56bda5690e76a297bdec6768ea1f5d11c32e5eed.1713270624.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56bda5690e76a297bdec6768ea1f5d11c32e5eed.1713270624.git.pnewman@connecttech.com>

On Tue, Apr 16, 2024 at 08:55:30AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> Moved code for getting number of ports from exar_pci_probe() to a
> separate exar_get_nr_ports() function.
> 
> Chnages in v3:
> - Only moved existing code in this patch, will add CTI code in subsequent
>   patch

Nit, the "changes" need to go below the --- line, otherwise it shows up
in the change logs.

So when you resend this, can you put these below the --- line please?

thanks,

greg k-h

