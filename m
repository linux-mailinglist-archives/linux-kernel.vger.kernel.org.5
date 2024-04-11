Return-Path: <linux-kernel+bounces-139647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D798A05C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07FC1B2421B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D05164CC0;
	Thu, 11 Apr 2024 02:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sriAHo9A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A1A6217D;
	Thu, 11 Apr 2024 02:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712801912; cv=none; b=QSryDWWwFsSsgTDhaVEXzk6F0sT5qxnyj0GaW/Q7cDYSRuJaE7eDrgThf5LQVBYhVh174SCivjSbG8/FnpMo/KXuZip5Sm8FYFHsADywmQ21OEDBzK54Z7Nu07ImluCcPEtOZSgbD1ftIr88mYRtYa0gVMFGK/osWHuqrppYgjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712801912; c=relaxed/simple;
	bh=3szFjZcS6dYXoKzbbtos+AFGu/s1GpsB7xiQE6oD8jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uls0dtWL6SmpQOes+2ghrk8MFoejUBYdkuxOtQnqQaAPUdP92SDlCnhcYUiaGiJA8XuaZ2CoHY9UKC49F4adSC2u9PP1oS8QIj25BJJKjpcp+k3VP6nBe9BATDD0t27NbDOF+xSW48IEGRnROqYjw1/N7lbV3s9DQmfC3rw6Fek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sriAHo9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5246C433F1;
	Thu, 11 Apr 2024 02:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712801912;
	bh=3szFjZcS6dYXoKzbbtos+AFGu/s1GpsB7xiQE6oD8jU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sriAHo9AyKBRDBbME148MrgeGc+XAFLNXaBA2iJGz1i/F2ai617j3Wc/LvKpb4YqD
	 AB+2WjiKXXYAcnSd5p0zf3IcHKp/aLrvh+omWR5qzlvJYSldgOQmEnsdK2tFgETlxq
	 laX2XwlOj9es6QUdpYF9H+RtdZNo96gPnUh+VQrBkQ/1TExOdrgI/1UcJkL2uSLDpe
	 IDHJ+v0raqSsza1tbHGmRIbhD0D/M1A77SjOL7dwOS6MYkzxa2n6WFkC3u+yVP2q+b
	 VdWoeaFle0BmlTFkbW1qpwB/0S400SkECDltz/nblEkH6IKrLTG8RuopScdBDKWipi
	 Kj5jrpXyIJ2ug==
Date: Thu, 11 Apr 2024 10:18:27 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Noah Loomans <noah@noahloomans.com>
Cc: Guenter Roeck <groeck@google.com>,
	Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Robert Zieba <robertzieba@google.com>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_uart: properly fix race
 condition
Message-ID: <ZhdIc3vt3DFvT066@google.com>
References: <20240410182618.169042-2-noah@noahloomans.com>
 <CABXOdTe02ALsv6sghnhWMkn7-7kidXhjvWzpDn7dGh4zKEkO8g@mail.gmail.com>
 <D0GS8UL1WKI5.1PLEUUWOD7B8@noahloomans.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D0GS8UL1WKI5.1PLEUUWOD7B8@noahloomans.com>

On Thu, Apr 11, 2024 at 12:06:33AM +0200, Noah Loomans wrote:
> On 2024-04-10 at 21:48 UTC+02, Guenter Roeck wrote:
> > On Wed, Apr 10, 2024 at 11:29 AM Noah Loomans <noah@noahloomans.com> wrote:
> > > This is my first time contributing to Linux, I hope this is a good
> > > patch. Feedback on how to improve is welcome!
> >
> > The commit message is a bit long, but the patch itself looks good to me.
> 
> Hmm yeah it's a bit on a long side. I'm not sure what could be removed
> though, it all seems relevant for understanding the bug and the fix.

Applied with shortening the message slightly.

