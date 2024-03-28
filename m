Return-Path: <linux-kernel+bounces-122584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC12A88FA02
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCB91F2612F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30D15811E;
	Thu, 28 Mar 2024 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aLZyzoYU"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C2256B7F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711614442; cv=none; b=F/mNz/UkaO9BGmJPAOM1RPzXdi3qnToFN7u3kAzeg9gfA0IUfYaoE2yh8EPSX3JTNZbFlcl0DRYrVP1hsQOO2ufp5ltGqeQNIf7M1DSeupClwf2cy9OGURV54xruKjQDFR7Yx9Oh5Px3u7fkbovzJYro5croTPV1LKV7xeEraW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711614442; c=relaxed/simple;
	bh=HqQErbvN+ijNu1Jdkp6E3sCfvGXfGUK+92NtkuPAjjs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ugyR5snPwo+/GtjS5/81yrpnZNJ6NRAVohCZjrwsPsVIM8BArOqMuK1JMCxutsA9Trwq7xsmBt8F1NLx0z5RhL13i2dEL4ewrZmOAqyOoNBNSskV36PQ3oXuXG4W44rOHTwFmC7QPcWdw61JXX9Qt6g2vEyURHV8CiLOmizPSX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aLZyzoYU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HqQErbvN+ijNu1Jdkp6E3sCfvGXfGUK+92NtkuPAjjs=;
	t=1711614440; x=1712824040; b=aLZyzoYUbhry1HbINh1uF/XZDdbyY0/I+RUiXOsekIDG5aA
	sMt7fhf+djlzUzde7oLZ8H189U++OD0u+nb81Z0r7gK1g22IkrlnlxcMgwBt8AGOeiV7XGc+KTat8
	JitiLYo1+UN110mAxe1ySmwJpRRzLRoUJlc+cNW00s/b1lgQzeUYKYRIkqYkezrH0Lj34KUt5JJmL
	vBgmV2NV7fzGvKzqlqChBc7bhOd4DEPyHYx2yzUDM/4cBduYlM5ys496HmwG8DqtOWSM1FYfnCEkk
	1ldVvRhHxmcIoUE/ndGiOPpq6wqa12wPxaWziA+UswdSGe9dfbhtnx9Av8GKtbtQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpl6P-00000000mZL-3bbB;
	Thu, 28 Mar 2024 09:27:14 +0100
Message-ID: <6fa3c18b3421d5dfc80c82ce29a49171c1841bf0.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Fix return value in ubd_init()
From: Johannes Berg <johannes@sipsolutions.net>
To: Duoming Zhou <duoming@zju.edu.cn>, linux-kernel@vger.kernel.org
Cc: linux-um@lists.infradead.org, richard@nod.at, 
 anton.ivanov@cambridgegreys.com, axboe@kernel.dk, brauner@kernel.org,
 hare@suse.de,  jinpu.wang@ionos.com
Date: Thu, 28 Mar 2024 09:27:12 +0100
In-Reply-To: <20240306091259.18605-1-duoming@zju.edu.cn>
References: <20240306091259.18605-1-duoming@zju.edu.cn>
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

On Wed, 2024-03-06 at 17:12 +0800, Duoming Zhou wrote:
> When kmalloc_array() fails to allocate memory, the ubd_init()
> should return -ENOMEM instead of -1. So, fix it.

Not sure this really matters, but the code seems cleaner with it :)

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes


