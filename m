Return-Path: <linux-kernel+bounces-144764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588778A4A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC7A1C21C46
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7139383A3;
	Mon, 15 Apr 2024 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KP7JSEyY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08E538390;
	Mon, 15 Apr 2024 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170125; cv=none; b=SY0Jng38RA6H656jY+LiLbPqKnmA7ypTJEuvpsahHOe5WOMbM3UFxKUB1suxqAyP3Vn7oreWulUVNvbopa6AXsv9dJNsVkjLU+fhRi8lfy2BIrW2L/+1/sUrQHOF/VIMVHuM2IFjz/wQ8hm2B56S8V24kLE9UUDe07YAu/xIsv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170125; c=relaxed/simple;
	bh=/rzQxdBfFz+bhG2WYY4i5FmzNnju0GiDyWDfmfsDHuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvYz/R3baQ3onuqeVEke+naEWBZdhzHdL7tgLbO6PyFGwztP1zrRS/nOhCvhGNGWvrmmsHPykYqK49+O5E+H54dk02uXGDDYX6KY6Qp/vrUxBoNvtG5z5yZIZzKXzzY8tHJO5NYA3IYH1vz7J+ewHMF0pOSN85xLaNQW9R7D4ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KP7JSEyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D712C113CC;
	Mon, 15 Apr 2024 08:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713170124;
	bh=/rzQxdBfFz+bhG2WYY4i5FmzNnju0GiDyWDfmfsDHuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KP7JSEyYD+saYwrXxh+gBWZdx0VlJPh0B0scJvdhNXVkiSxW7b7596pTtkonqS+yC
	 THNAttUnB/7GyEV/lsVBYHtftAbwGD2TTZjkxY89N01SVLudaGc0Wgg8xgWdDPfZ3S
	 Kb/uNmRhYjYmiG4jwnl1MCyZXk1SaW7GQIfQbj94=
Date: Mon, 15 Apr 2024 10:35:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Alex Elder <elder@linaro.org>, corbet@lwn.net,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: coding-style: don't encourage WARN*()
Message-ID: <2024041544-fester-undead-7949@gregkh>
References: <20240414170850.148122-1-elder@linaro.org>
 <ZhzgTeEHFF19N3UZ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhzgTeEHFF19N3UZ@infradead.org>

On Mon, Apr 15, 2024 at 01:07:41AM -0700, Christoph Hellwig wrote:
> No, this advice is wronger than wrong.  If you set panic_on_warn you
> get to keep the pieces.  
> 

But don't add new WARN() calls please, just properly clean up and handle
the error.  And any WARN() that userspace can trigger ends up triggering
syzbot reports which also is a major pain, even if you don't have
panic_on_warn enabled.

And I think the "do not use panic_on_warn" recommendation has been
ignored, given the huge use of it by vendors who have enabled it (i.e.
all Samsung phones and cloud servers).

thanks,

greg k-h

