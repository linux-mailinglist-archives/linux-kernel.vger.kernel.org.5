Return-Path: <linux-kernel+bounces-122598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D38E088FA3F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D17B2932C7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF20C51C3E;
	Thu, 28 Mar 2024 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AbqKfglN"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856D24219;
	Thu, 28 Mar 2024 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615700; cv=none; b=CNRC1EHya9o4AxTuv4gW7nhdGQiifAU31/Jnx/aT0ruaXFGzjioTiUv8TnzuWUzQIjNc+kntqutPeWpvAg7JRXPQetMTEgdNJQ45EsKnpZClE1foGrc3TdqC8hNayDINodq2jxjBkOJrKe6e6gb4BX3I5XCHWvRk3luqgN2rZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615700; c=relaxed/simple;
	bh=u/1FHiDNRladIOArz9ybCTG/xaqsxfeiA3DoCS1mRTA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ISHZkZypwgZnt074jSC0NhJXGmUvdac57abLtQlXM1KfuqvEYMXD/v3g+NKOR4OYlQxmsZxSE8MQNUyKFr0ZpYmRE/WeXtfQRCG8rjntTDaC7MSdViFSNA313z1yd1NCi169e7kHf7pZdk4nA9B43ANx/+V7FlGqEXss58Mk1QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AbqKfglN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iHrHxou/LQhUWas1UemQMQryecJ9CPAti3mj44c5cFc=;
	t=1711615698; x=1712825298; b=AbqKfglN7B81f7kofAZWkbRWg4YqigVf0AsQd0p9JAeRwXw
	lGMp/O8ZQ02thQMIug4UEI/ebmTG2ocwrtklmDMTTFAM0MV2XiMTWlS1q+oShXsDfMKivCzdnmUol
	YwBs71G5M0v+YZ2UYJNAaFveNaOluxJBBjLQ0csSZDrBIxezIqe3VaReh0gUpfGtcJa9Z7AI3oSPS
	4udM7Iea7e5cNx4XFtliAf/6PCs+CMeS594ABpqjD0iSB+/IsnuTAv55z86Gs1Mu4enB8Rq1Mfwuh
	sh+sd7AtASXa+XcMU1tEmGhz7vCaeZZ8XanCAL6AhKrlLgPupW55aN/+JG2Cmiog==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rplQd-00000000nRW-3isQ;
	Thu, 28 Mar 2024 09:48:08 +0100
Message-ID: <261b229ae93fbd27f63d887b3217e3bade4e816f.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] arch/um: fix forward declaration for vmalloc
From: Johannes Berg <johannes@sipsolutions.net>
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: sfr@canb.auug.org.au, kent.overstreet@linux.dev, sj@kernel.org, 
	richard@nod.at, anton.ivanov@cambridgegreys.com, linux-mm@kvack.org, 
	linux-um@lists.infradead.org, linux-next@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 28 Mar 2024 09:48:06 +0100
In-Reply-To: <20240326073750.726636-1-surenb@google.com>
References: <20240326073750.726636-1-surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-03-26 at 00:37 -0700, Suren Baghdasaryan wrote:
>=20
> -extern void *vmalloc(unsigned long size);
> +extern void *vmalloc_noprof(unsigned long size);
> +#define vmalloc(...)		vmalloc_noprof(__VA_ARGS__)
>=20

I was confused a bit by the define at first, but that's because this is
a user-side header file.

Reviewed-by: Johannes Berg <johannes@sipsolutions.net

johannes

