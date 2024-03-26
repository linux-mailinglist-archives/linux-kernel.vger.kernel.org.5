Return-Path: <linux-kernel+bounces-118691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999EC88BE19
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D1B305259
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F17584D33;
	Tue, 26 Mar 2024 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w/59IuuD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72FB839F0;
	Tue, 26 Mar 2024 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445777; cv=none; b=ABQ3o1lj7vgzj+GlhW2ldWe55Yyak1YtUoYdrQAvOiZYbOsgBauCUWhIqXCJch3PMkhO2L1FckKAGyviUPYFwW5KFyiPVZqYY/KogEnn5RD5Y6W3nSTpbVBhuQIBbXew3T5KvuFCeU4IemkdlWeqrd3XkBGNnkLfET7ml5eYmFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445777; c=relaxed/simple;
	bh=PrW9e8jhIEo6+UcdkVF3qk3y8slqdz/j6UOpbQt+Vck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQDerN8Lmhd0ur37gBUcuaKFHyepjmZ4rwpB7aOqPxfjrR7KfRwdku3+xM16F33xSVzMvIvHaOy6Squ8xYRi+ThI0RkyHahAbthf/+o+u/JOl0DGcwZONMdjQ1L4eQAsVZP3wcLq3ng+mV64xK+xCGU9YltkQJbLQATf+NbxmzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w/59IuuD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE48AC433F1;
	Tue, 26 Mar 2024 09:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711445776;
	bh=PrW9e8jhIEo6+UcdkVF3qk3y8slqdz/j6UOpbQt+Vck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w/59IuuDCoM+veNkiLLcWFqu/ovBFGI9qYMVgVJaMviy9Mf0qABZ6Ggk/znHeh/0M
	 MIwzQCmhSPaoMKYzqmwrTtMW4o7Fh9u9oro+pH2SE++RXVmWj3ezJFKlkuERhBkKBz
	 1oFh9Y3gR3Z3rxn+StOhRKMUpPYKICk4H581bKaA=
Date: Tue, 26 Mar 2024 10:36:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Surong Pang <surong.pang@unisoc.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Orson.Zhai@unisoc.com, Zhiyong.liu@unisoc.com,
	Surong.Pang@gmail.com
Subject: Re: [PATCH] usb: gadget: rndis: add multi packages support for rndis
Message-ID: <2024032639-pope-tiling-340c@gregkh>
References: <20240306054949.324172-1-surong.pang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306054949.324172-1-surong.pang@unisoc.com>

On Wed, Mar 06, 2024 at 01:49:49PM +0800, Surong Pang wrote:
> --- a/drivers/usb/gadget/function/rndis.c
> +++ b/drivers/usb/gadget/function/rndis.c
> @@ -39,6 +39,8 @@
>  
>  #include "rndis.h"
>  
> +static int max_out_pkts_per_xfer;
> +static int max_out_size_per_xfer;

Note, this will not work, you can't have device-specific variables as a
single entry, otherwise multiple devices at the same time will not work
at all.

thanks,

greg k-h

