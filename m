Return-Path: <linux-kernel+bounces-25888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2705082D74F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18B12823A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A95812E63;
	Mon, 15 Jan 2024 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y7q5/Ttb"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF703249E2;
	Mon, 15 Jan 2024 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay3-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::223])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id D3ACFC30D0;
	Mon, 15 Jan 2024 10:23:05 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6EC9C60008;
	Mon, 15 Jan 2024 10:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705314177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37RG/l7y/QlP+BRyRVRXMag0rOrfgpLAB0aLP6thvQk=;
	b=Y7q5/Ttbht1UxhlrwLk9i5ViBEAmqgX9NsxIPM1f1R4KPeIiUMCuApH9kQZdBzRc8AKABL
	ixtk6QTf6z3hDrXdUkUTw2Wi0cO1F4OPUOvRlDeCRAWvmHeFpcoHaB/Khk9IQ8VOhHpeCD
	WeL/dMxM48zTK6LJZ3/L/sF6nrMNg1BFZKIGZ34a4gKaPtwRz+bnnIO5DUcKA7RNGOZGwQ
	TcKRhPklqQaCLhLJ4GwAl7z7Ba3h+Zov6BFUBACQeWql3FY7OWE7HjFkbgPj13jz8uSmkw
	3jp2wn1rphp8G0uKD/tg209RI7UHgujQ2Ofueo+lN7G3ZVDIq5v606Di4gaTWQ==
Date: Mon, 15 Jan 2024 11:22:55 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <richardcochran@gmail.com>,
 <Divya.Koppera@microchip.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net 2/2] net: micrel: Fix set/get PHC time for lan8814
Message-ID: <20240115112255.53d5bb85@device-28.home>
In-Reply-To: <20240113131521.1051921-3-horatiu.vultur@microchip.com>
References: <20240113131521.1051921-1-horatiu.vultur@microchip.com>
	<20240113131521.1051921-3-horatiu.vultur@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Horatiu,

On Sat, 13 Jan 2024 14:15:21 +0100
Horatiu Vultur <horatiu.vultur@microchip.com> wrote:

> When setting or getting PHC time, the higher bits of the second time (>32
> bits) they were ignored. Meaning that setting some time in the future like
> year 2150, it was failing to set this.
> 
> The issue can be reproduced like this:
> 
>  # phc_ctl /dev/ptp1 set 10000000000
>  phc_ctl[118.619]: set clock time to 4294967295.000000000 or Sun Feb  7 06:28:15 2106
> 
>  # phc_ctl /dev/ptp1 get
>  phc_ctl[120.858]: clock time is 1.238620924 or Thu Jan  1 00:00:01 1970
> 
> Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

This looks fine to me,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime


