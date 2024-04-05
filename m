Return-Path: <linux-kernel+bounces-132851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0186A899B35
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A247B283B34
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F6A16ABCB;
	Fri,  5 Apr 2024 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="obCleuUv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1171474DC;
	Fri,  5 Apr 2024 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314248; cv=none; b=PhfO6SIC0yYAGm3D9LFihDs4pzkRYN+M6rNxpL08H++nbAIQcqocyaDWe6+nH0vXS8TQ3lpZ6srqT3vGt9nYxiFtg+LBHKeUimux2fzIgeQ7a12A9OgaQ9Oqj33V14LzeqZZCn5BQvnpOYJvT14TLNkR8UTRGpO45QuTffTjuqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314248; c=relaxed/simple;
	bh=Ap18guPgOAvc5ueUjlDoye1qzx2QpqgdZEJZoL9P7E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IC5ClAdyquQKw1ej4AadBMR5ilNzaGml6w2woJzNZl4mdGYChLdsSIW/qlanExJ4ULDEZhJLa/aWSCKY4ZZonxxtd+TPu9HSFMYzqWOi0tDQXTHs5g23tkx0f6U1RtnRdA3d7Pomk9jO/yCA2TWq36mhr372slXAU7tcIhJzjrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=obCleuUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8E1C433C7;
	Fri,  5 Apr 2024 10:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712314248;
	bh=Ap18guPgOAvc5ueUjlDoye1qzx2QpqgdZEJZoL9P7E4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=obCleuUvwATqsz/GdE3saleN1ncVq+YXQ14jFY2uAaEQBMyhZ/Cy0LihHgVk9mjOL
	 p4gRM6XjW02kKre/moiWwiacAC7P3RXxARpBb1uDUniKD1bD1s14YB8qGQdKgznv8X
	 HQZGqpOWKLogivjioecktBrCLKDtExqE7d86d1Oo=
Date: Fri, 5 Apr 2024 12:50:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Shahar Avidar <ikobh7@gmail.com>, linux-staging@lists.linux.dev,
	kernel-janitors@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Felix N. Kimbu" <felixkimbu1@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v3 6/7] staging: pi433: Add debugfs_remove in case of
 driver register fails.
Message-ID: <2024040538-voice-debit-b8be@gregkh>
References: <20240405074000.3481217-7-ikobh7@gmail.com>
 <f0cb08d3-00a5-4ed1-adf1-05f40875c510@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0cb08d3-00a5-4ed1-adf1-05f40875c510@web.de>

On Fri, Apr 05, 2024 at 12:42:38PM +0200, Markus Elfring wrote:
> I suggest to use the summary phrase “Call debugfs_remove() in case of
> driver registration failure in pi433_init()” instead.
> 
> 
> > debugfs resources were never cleaned in case of failure to register driver.
> 
> How do you think about to use a change description like the following?
> 
>    Debugfs resources were not released after a call of
>    the function “spi_register_driver” failed.
>    Thus fix the exception handling accordingly.
> 
> 
> Regards,
> Markus
> 

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

