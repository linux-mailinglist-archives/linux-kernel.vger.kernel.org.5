Return-Path: <linux-kernel+bounces-47975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F00A784558F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABAFA28352E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA8D12BF1A;
	Thu,  1 Feb 2024 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b="E9rY6QO0"
Received: from puleglot.ru (puleglot.ru [195.201.32.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B98384A58
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.32.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783799; cv=none; b=TpFmkHiZYAIGV82Ke5B/c/J5RBx/GLpYkF7m3WgzAJmUypqXvLksOfyxugxe5O4hloxeN+hxoYddYTOjvZe6Rp6xhA+5tKyv8qs2nOaOWRNdhqWp2YvO1m75UGhS3byG7xN/ZRUFXy3DhojIp1bA40qI3vwQXQ/PXzdw09X8oZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783799; c=relaxed/simple;
	bh=gw3OWOfQUIXyqJNESI7+QUXlcp6KFqescLxFFanz6no=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M9xL7m4X1IqZhSJzgHUmkr33V3xOC11VZoMQT31v3YTEmOcicKcCbAN/u48nWPGjWiOw/N2LKkPdvvH4iYVf7BwtapWGY4HLH9n7+M30KLr8GxSSQYYVrtqeh2NzmizHsAv9RKXAEKoyrAoECCYRIpr/WWmLcWFmyIuCQluiAVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tsoy.me; spf=pass smtp.mailfrom=puleglot.ru; dkim=pass (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b=E9rY6QO0; arc=none smtp.client-ip=195.201.32.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tsoy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puleglot.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
	s=mymail; h=Sender:MIME-Version:Content-Transfer-Encoding:Content-Type:
	References:In-Reply-To:Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
	:List-Post:List-Owner:List-Archive;
	bh=gw3OWOfQUIXyqJNESI7+QUXlcp6KFqescLxFFanz6no=; b=E9rY6QO0ycHRh4dquFDJsb+MKU
	ETPkBMT77OmHGUYZQQ2a28MIaeDQLllM4IPffL2mY4ouHU0/doGz4fzP50YWwBCgdYbC6nHWYVC+F
	WnV+Rm/bOb4n5fF00vRsIsP05+yBCbVR6dZL2colgVQQQ4YWGPoN3rnosUxZ09SMTJPM=;
Received: from [2a00:1370:819a:ceb:89dc:eced:962a:5b2f]
	by puleglot.ru with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <puleglot@puleglot.ru>)
	id 1rVUQj-00000000yPJ-00nX;
	Thu, 01 Feb 2024 13:36:25 +0300
Message-ID: <6872e9ea993633dff4e248f01cafd1ac32651355.camel@tsoy.me>
Subject: Re: [PATCH] ALSA: usb-audio: retry clock validate when it takes
 some times
From: Alexander Tsoy <alexander@tsoy.me>
To: vincenttew <vincenttew@google.com>, perex@perex.cz, tiwai@suse.com, 
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Date: Thu, 01 Feb 2024 13:36:11 +0300
In-Reply-To: <20240201070641.401684-1-vincenttew@google.com>
References: <20240201070641.401684-1-vincenttew@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: puleglot@puleglot.ru

=D0=92 =D0=A7=D1=82, 01/02/2024 =D0=B2 15:06 +0800, vincenttew =D0=BF=D0=B8=
=D1=88=D0=B5=D1=82:
> Behringer UMC202HD and UMC404HD take some times to validate the clock
> source. To prevent more DAC have the same delay which return the
> false
> in the first time, remove the USB id check to have a chance to retry
> the
> clock validate.
>=20
> Signed-off-by: vincenttew <vincenttew@google.com>

Thank you for the patch! My thought about this change:
- Retrying clock source validation probably make sense only in the case
of Internal clock. But I'm not sure.
- If we want to make this a standard driver behaviour, then the code
needs to be moved out of the quirk function IMO.

