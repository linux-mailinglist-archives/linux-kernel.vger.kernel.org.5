Return-Path: <linux-kernel+bounces-70315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15398595F3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29270B21B25
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98332134BC;
	Sun, 18 Feb 2024 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jrz1br/P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6172125D5;
	Sun, 18 Feb 2024 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708248373; cv=none; b=MOG8rEw2EqzIwSnO5Ye3hJ9CVyDLlBSlZ4ZklYcJxyiI0OwHG8h33hlBsPKFkOtH5JJLqWA8KqH2qwVUCCt2NOED5jU5X90k2Gem8sENPkeUfxFp13NQ6/dZGPHrBcCdth8etBr0AABKdmG6aNNhb0+p3nF8DADcAZPkHWygRac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708248373; c=relaxed/simple;
	bh=vGhRXWkO1iYIXMZUX7rXB9O4rimzPHxvoDUdM8GM2Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5c4Nszyn3lSjdx3WtZiEHvr+sBKtKl58WgKgZ2IgwY4AlpQIL5IMAnNemLdr4jLA/4FD2sWEPa7xzzlJ4uHy4+FZkmcbpFy/LMqtD287kxbCIEVNmM42vVzFHa8H+g+gMc8e3vwFeB5mOrgSNbpMj1Cwmq/ff0wV+kDer07qMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jrz1br/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32D0C433C7;
	Sun, 18 Feb 2024 09:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708248373;
	bh=vGhRXWkO1iYIXMZUX7rXB9O4rimzPHxvoDUdM8GM2Dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jrz1br/PmM4xcXTFkGAufq97NSUX9yeEEbe5gjSoN+0eDA7cyygjATHoDxh6RXi0s
	 nZRDPe3r5wE+ySPDQwW49iD8Rs0GfG3GTWqwX6vCP2EgJMgI7jyZQMcTsmzg2ZWuET
	 92LA5Hsne5dWUk2oolHolN7ExJyS/r17vwm4vSjE=
Date: Sun, 18 Feb 2024 10:26:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: jirislaby@kernel.org, surenb@google.com, riel@surriel.com,
	willy@infradead.org, cl@linux.com, akpm@linux-foundation.org,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH] mm: huge_memory: don't force huge page alignment on 32
 bit
Message-ID: <2024021839-creed-retail-3b27@gregkh>
References: <20240118133504.2910955-1-shy828301@gmail.com>
 <ad920491-9d73-4512-8996-badace520699@leemhuis.info>
 <CAHbLzkp7s1CcSE0rc-CpfcCrNtMdepAA5-K+0P4wz11x4SK6=g@mail.gmail.com>
 <dc9f8eab-ec5c-46f1-a168-c510650d1cac@leemhuis.info>
 <1354c5d5-99b7-4178-bcf5-9ddb776de946@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1354c5d5-99b7-4178-bcf5-9ddb776de946@leemhuis.info>

On Mon, Feb 12, 2024 at 02:45:04PM +0100, Thorsten Leemhuis wrote:
> Hey Greg, is below mail still in your queue of linux-stable mails to
> process? If so please apologize this interruption and just ignore this
> mail. I just started to wonder if it might have fallen through the
> cracks somehow, as I've seen you updating stable-queue.git for 6.7.y,
> but it's still missing this patch (and the other one mentioned) --
> that's why I decided to write this quick status inquiry.

Yes, my queue is quite large because of travel and the CNA/CVE work that
was happening, am catching up now.  I've queued these up now, thanks.

greg k-h

