Return-Path: <linux-kernel+bounces-67428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C587856B65
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F921F22355
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E6D137C35;
	Thu, 15 Feb 2024 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="od8eOLiE"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFB21369AB;
	Thu, 15 Feb 2024 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019181; cv=none; b=CKjjobuqmWrZKMvwOYtRfufHMPZSf6GTttnJfOCIKTj65At8V6p9zWc3KbjUCMKoZShWFJqdl8KtK5nWoTv6ty35TH5tI8mlVCKsLzGrxWZt7Y/oo33PlbN/mUVvk3LizZNyS6HH96pzyCeeOmqv1HrMJC0raQm3u+Eeq/uUPAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019181; c=relaxed/simple;
	bh=tSVwzJYE9mMhTP4PRPrJFe7vbFAidXXe9lT6bNV75jA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hk3vWjUdcjKBKPaJOG1NIaG/73AZT1a/7jAEGxS+VRVb3k+z2uMlkqYm4WAtJxaqaKWyL3P2WloKlo/FN4esqWJU6/rBC39m4tRFynTHMrK3zG5XmzNPWMOo2wKTgSmAkdkeWlXvp2Z0X2QjLUBgWo+k7iCzutJgGVfOz+FtqRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=od8eOLiE; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B0EC8240002;
	Thu, 15 Feb 2024 17:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708019176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=inH8EjjrxlOBnJ9O5h+irj6SqwiMSYBxDH0OH8nLG0A=;
	b=od8eOLiECnaDNLhsK97ovwmZovi+OYGOWZvJEle+XxC1RECogVyhPrpR6DAxahyqcuJXLi
	4bYPCe04UCrdEK1ybZNKSKNV0KESVI0c8btHLeJbauEN0NU2vn3WRfdf+CIK6lKWaPYige
	jwDl3wjhlgn4idv9iFOj4Wj/8DWtEOeykZbM5cSCWJXLh4r5kr84XSQ/2uTZ7UbcnWzERO
	+CLGKxUN3Im1ZM0sBJ00W8OGbjudjEVw2JOm03ugtvoorwu97/ZiRdCIYzS3ItxWYwDZju
	cR49LC4DmHxkO3dYTL4Ad9s2sz4TWnpbBF+d7ENqiLUjs2C/epqVz6P23t797A==
Date: Thu, 15 Feb 2024 18:46:12 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>, Mark Brown
 <broonie@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 RESEND 3/6] bitmap: Make bitmap_onto() available to
 users
Message-ID: <20240215184612.438bd4f2@bootlin.com>
In-Reply-To: <Zcptyd/AWrDD3EAL@yury-ThinkPad>
References: <20240212075646.19114-1-herve.codina@bootlin.com>
	<20240212075646.19114-4-herve.codina@bootlin.com>
	<ZcoOpPb9HfXOYmAr@smile.fi.intel.com>
	<20240212143753.620ddd6e@bootlin.com>
	<ZcokwpMb6SFWhLBB@smile.fi.intel.com>
	<20240212152022.75b10268@bootlin.com>
	<Zcos9F3ZCX5c936p@smile.fi.intel.com>
	<Zcptyd/AWrDD3EAL@yury-ThinkPad>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Andy, Yury,

On Mon, 12 Feb 2024 11:13:13 -0800
Yury Norov <yury.norov@gmail.com> wrote:

..

> 
> That's I agree. Scatter/gather from your last approach sound better.
> Do you plan to send a v2?
> 
..
> 
> I think your scatter/gather is better then this onto/off by naming and
> implementation. If you'll send a v2, and it would work for Herve, I'd
> prefer scatter/gather. But we can live with onto/off as well.
> 

Andy, I tested your bitmap_{scatter,gather}() in my code.
I simply replaced my bitmap_{onto,off}() calls by calls to your helpers and
it works perfectly for my use case.

I didn't use your whole patch
  "[PATCH v1 2/5] lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers"
because it didn't apply on a v6.8-rc1 based branch.
I just manually extracted the needed functions for my tests and I didn't look
at the lib/test_bitmap.c part.

Now what's the plan ?
Andy, do you want to send a v2 of this patch or may I get the patch, modify it
according to reviews already present in v1 and integrate it in my current
series ?

Yury, any preferences ?

Best regards,
Hervé
-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

