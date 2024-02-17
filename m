Return-Path: <linux-kernel+bounces-69978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9001D859132
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A3B1F21169
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8217D404;
	Sat, 17 Feb 2024 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1+KjMo16"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02581D681;
	Sat, 17 Feb 2024 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708188518; cv=none; b=FX+LkvecxwwTPOQXczPfXABetns+sqSF8At1FRBY973h+KB+a7lkONyiY8E7GmXH9QldN1YIdn+aOyNNJEy28N0lwFO4c12Nu9QJnHsBZ3Tw/teoxFJMPKSxUF1gaHdFybPIq00guzE1w0WdPqQ8pnf+xuwt6W8MoYGx1wWZiRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708188518; c=relaxed/simple;
	bh=nlUMRV4bOjTiEhIam9kOjSfsJBtBaZN4aNAM40JaQHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxilaW6p/B12FRMSw4ORQgMDu5WAMUHpLRlZpVPfdl6cjeiPaU33uEvBqsWO15CUfbh+sJYCyVkyZRUtu8Luooxi84Fn9HHJhqyHwPVqdYUbc80p5ND9E9cGwSlQK0H8XDs1gmFrnieERPkMnuiLCQCQDudnUWEs5IDBAxOwHtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1+KjMo16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170A9C433C7;
	Sat, 17 Feb 2024 16:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708188517;
	bh=nlUMRV4bOjTiEhIam9kOjSfsJBtBaZN4aNAM40JaQHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1+KjMo16UQ/KknPdv1Lzp5O08CSY3Akt9qAcZ+tAr14NqgYh9uuiDo8g9Em/yqc/G
	 Iy0fFwwhxnWHam3gL74L6yuWahOEuCLdKBNUF6N1XClJ4GVsqT5nVzHE9doe8lSehp
	 +2yIpL1iZ3ohzGiV/ZwTlCh4jtSh3rGJAUuMD2zg=
Date: Sat, 17 Feb 2024 17:48:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 1/1] tty: Don't include tty_buffer.h in tty.h
Message-ID: <2024021721-banknote-pasture-52f3@gregkh>
References: <20240215111538.1920-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240215111538.1920-1-ilpo.jarvinen@linux.intel.com>

On Thu, Feb 15, 2024 at 01:15:38PM +0200, Ilpo Järvinen wrote:
> There's no need to include linux/tty_buffer.h in linux/tty.h.
> Move the include into tty_buffer.c that is actually using it.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> v2:
> - Fixed shortlog to make sense

I didn't see a change in the shortlog, but hey, I trust you :)


