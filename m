Return-Path: <linux-kernel+bounces-158874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FFA8B2615
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC4C1C2225E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F42B14D29C;
	Thu, 25 Apr 2024 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPzbvXwu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9996714BF89;
	Thu, 25 Apr 2024 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061635; cv=none; b=tNhS/Y43LDZY0kgZ3rwgGbjBY/Tc4ScGX7LXJ5JQRrQzAJGWXael8VOBPeCdkXpGcsftK781cBSMhKzfM+sFU0m4dikoeh3HrE/u3zWurAEGLzfYJK7cPj7MZvImEeFlmaJ3njN1qz+6Q5aFSlZsDDKKQUGWxx0JztvaT8oiqro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061635; c=relaxed/simple;
	bh=6t12H9puFZ+mkEGcvxzxKTojHv6zCzX108YB4QBepgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CePZdiugUp/Xw6ILscS180MjwCeSn5+KjogbA6p3OYfp9EnqnmYFzTzZYmQidQ+DwrF23OPdjdPEy9MC+phyDe/1f8XS9qv+TROPwvHg+/m7ne8mXd6dvDczkOpo/OAPQ8JKNUsI3kR1qvrclJfIEjJ5vyVh5U3asJdY9w56/kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPzbvXwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EA5C113CC;
	Thu, 25 Apr 2024 16:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714061635;
	bh=6t12H9puFZ+mkEGcvxzxKTojHv6zCzX108YB4QBepgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CPzbvXwu75VXAuPPPZRYURmRQqaweeZYUACY2vwmHNLpP6VsWxCpIOU6OGSO1wm2I
	 XSulIHoNb+Eg+0Ajb5wfjHSTN65s6em4lxNJ5dmDMSyxvmCvpt1XJMB/qAiLC142Ok
	 pOQ0lwQy5kHLZpD7WdQ/h4mVUQnmRkrVdUT4UuOK3hmzwr5lBOql2j+QPYWnBVThJI
	 WUMSCCpeNysK1ADqwP1u5hGHQQgeOhtDGu8Z8bIEi5jVimHy5cGZcy+cMirX9lXU5M
	 0VQ39cM8vftPVVnSep/Ke/63gZ0Uii8JOedLPh0yBn3FaNLdUBq++FSIsFnmm60BkQ
	 PtPHfy9PPAUvA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s01jP-000000005B3-1X4u;
	Thu, 25 Apr 2024 18:13:55 +0200
Date: Thu, 25 Apr 2024 18:13:55 +0200
From: Johan Hovold <johan@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] Bluetooth: qca: fix invalid device address check
Message-ID: <ZiqBQ3r3gRk2HBir@hovoldconsulting.com>
References: <20240416091509.19995-1-johan+linaro@kernel.org>
 <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com>
 <Zid6lfQMlDp3HQ67@hovoldconsulting.com>
 <CAD=FV=XoBwYmYGTdFNYMtJRnm6VAGf+-wq-ODVkxQqN3XeVHBw@mail.gmail.com>
 <ZioW9IDT7B4sas4l@hovoldconsulting.com>
 <CAD=FV=X5DGd9E40rve7bV7Z1bZx+oO0OzjsygEGQz-tJ=XbKBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=X5DGd9E40rve7bV7Z1bZx+oO0OzjsygEGQz-tJ=XbKBg@mail.gmail.com>

On Thu, Apr 25, 2024 at 11:22:50PM +0800, Doug Anderson wrote:

> Quick question. I haven't spent lots of time digging into the
> Bluetooth subsystem, but it seems like if the device tree property is
> there it should take precedence anyway, shouldn't it? In other words:
> if we think there is built-in storage for the MAC address but we also
> see a device tree property then we need to decide which of the two we
> are going to use. Are there any instances where there's a bogus DT
> property and we want the built-in storage to override it?

I guess we could decide to implement something like that, but note that
a devicetree may have an all-zero address defined by default which the
boot firmware may or may not fill in.

So we can't just use the presence of the address property as an
indication that the device has an address, but we could of course parse
it and see if it's non-zero first. (Actually, I think this bit about
checking for a non-zero address is already implemented.)

Note however that we still need to determine when the controller address
is invalid for the common case where there is no devicetree property and
user space needs to provide an address before the controller can be used.

Johan

