Return-Path: <linux-kernel+bounces-119144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1198988C4C3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CBF61C617E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1763B12D1EA;
	Tue, 26 Mar 2024 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lRV6JDv3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5D212D74A;
	Tue, 26 Mar 2024 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462218; cv=none; b=Mchl94cRuYrw6HG45WoB4Ny+KyR2OtRp1R5kATcfGtXmzMq+NHO55NeTDs2E9KjaNfrd26k/xk3LeQxIkP+O5jNUDsZfwxiZKjttnNRZQKp90ft6FdHiebshrsIgRMNgSLohw2LzVblW17TA37dP0To9Il/v97032Ntl/oHgQ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462218; c=relaxed/simple;
	bh=usLAHk8BV9jHqvzX3o4QI3o24c0IExgHc7XQSzkNkw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+wr0ekqJI5X+zm6kXAELyYgukJUN6X/ekIqOVv1NUymDlusRB8h5tiG9vRtLffm0DDpqTqKE5V70S9cB7SyTa2o5gH3fCOg6wo0MsiTm0CTwM3u2T1nZNBxA3spYLEShmUiQtD+ftA+ojOpxPdHuelS8gPESpLFtX8oFb8iolo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=lRV6JDv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D77FC433F1;
	Tue, 26 Mar 2024 14:10:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lRV6JDv3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1711462214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1pu5lwM70ugmVTU5ofl0zZEKekyP5GxIE+9D4D9dNtg=;
	b=lRV6JDv3MhBjFHPKF0rp2Pmyo2aXFIIwEtNOc1A6gPIaiP5UvLjl+G2W4tIklkrDVHy6au
	xW/8XtChvcHnNAXVo3EsWOk8i5arIxho2iK8S1RpksBx4EzbsW4BT9v2tusO51peEVtU4k
	qyeeLalj1yBe8aFUh1240vaPMabE3zE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 217a2fe7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Mar 2024 14:10:14 +0000 (UTC)
Date: Tue, 26 Mar 2024 15:10:11 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com, thomas.lendacky@amd.com,
	dan.j.williams@intel.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, graf@amazon.de, dwmw@amazon.co.uk,
	bchalios@amazon.es, xmarcalx@amazon.co.uk
Subject: Re: [PATCH v3 4/4] virt: vmgenid: add support for devicetree bindings
Message-ID: <ZgLXQ0P8aDl4Xh21@zx2c4.com>
References: <20240325195306.13133-1-sudanl@amazon.com>
 <20240325195306.13133-5-sudanl@amazon.com>
 <5ca78fc8-4a53-4f09-878f-4a47875f9de5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ca78fc8-4a53-4f09-878f-4a47875f9de5@linaro.org>

On Mon, Mar 25, 2024 at 10:51:25PM +0100, Krzysztof Kozlowski wrote:
> >  		.owner = THIS_MODULE,
> 
> This is clearly some abandoned driver... sigh... I thought we get rid of
> all this owner crap. Many years ago. How could it appear back if
> automated tools report it?
> 
> Considering how many failures LKP reported for your patchsets, I have
> real doubts that anyone actually tests this code.

Now you're commenting on the context rather than the patch.

No, this isn't an abandoned driver, no it's not untested. Rather, it's
code I maintain, care deeply about, and have a tree that receives quite
a bit of testing (random.git) where I'll be taking these OF patches in
the case that this patchset improves (and thanks very much for your
review on it; I'll be appreciative of your ack whenever/if ever it
improves to that point), and if you have other cleanups like removing
owner, please don't hesitate to send a patch.

That all is to say, I'm following these threads closely and care.

Jason

