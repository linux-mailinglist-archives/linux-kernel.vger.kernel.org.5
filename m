Return-Path: <linux-kernel+bounces-153849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6A48AD425
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65274283306
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BA7154C0E;
	Mon, 22 Apr 2024 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/fHrcaO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5E515443B;
	Mon, 22 Apr 2024 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811501; cv=none; b=SjHR2fTQS5vdS3B+ajTnMgT6UkW2EZAWmsr1FImHChP4nMKbwGPeJGHeDGtxTTO+kR530m+weVfTNFW8En/fXaGyYCkduQRlBOHB1nmtZ7rKW9z2/3mnZdh77XsQF3undNm17WRLc0R7dNuFTStE0RzEgtAjfnGgMpDXt7tAOn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811501; c=relaxed/simple;
	bh=vwry6iTBcupii6vruuEf2saDqUhPlSYQSZ2MuEN49sU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXQcK2U1xV+BjLKC3c3AaxxDwlKTeB3l7JWC/rdrlnXRnL3d6cAiL56ibl+D8OQ6vnHO4X5wo/TZf5zfLHL9QVs5uVrY6SFQi5FIvxbJRg7nKU7AdcTpBIov/wN6XzoXaGeeO2fMqOWtEqC7YU/hOwpiOM1LfnIpJ4Ns6E9oPMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/fHrcaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F06C113CC;
	Mon, 22 Apr 2024 18:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713811501;
	bh=vwry6iTBcupii6vruuEf2saDqUhPlSYQSZ2MuEN49sU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I/fHrcaOUVto2u66JzHJdFRlrvYzBrCjnyxNVHi7Bs1YjfGCthcQGg/9EDm90/3R9
	 VXyRbsJAtw1PIKpaq5Gmm7CAa+pts7tJfL2tMwrsY7n/QlsMCa+I1DFQTc8qSIsjGU
	 2l1XK9+zLiFzFKz6GbwKxkL8N9tfs3EXp7dQRf0+lQovcU73Q3dOYc1mzxSzcd9+dx
	 qvFdH2yqDdjQis2BkJMBLWU39tIKn3FvnKaJCkE15r45vt/JTTVrJfxXg9tAN5Dfyw
	 S7I6QU3nPToYjdRftzK4OUTG1vq7DtsssJYjuT4WA1H1lMYHkr7V6bs80MwdJmjFR8
	 TthpTpSSJYwLQ==
Date: Mon, 22 Apr 2024 11:44:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Julien Panis <jpanis@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Dan
 Carpenter <dan.carpenter@linaro.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew
 Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 <s-vadapalli@ti.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v8 0/2] Enable RX HW timestamp for PTP packets
 using CPTS FIFO
Message-ID: <20240422114459.46dd016c@kernel.org>
In-Reply-To: <67c7f423-18ce-4804-8be9-cc4521733cd2@ti.com>
References: <20240419082626.57225-1-c-vankar@ti.com>
	<67c7f423-18ce-4804-8be9-cc4521733cd2@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Apr 2024 17:09:41 +0530 Chintan Vankar wrote:
> Is it possible to merge this series if no further comment ?

Perhaps you are blocked by us not merging this, yet.
In that case, to avoid sitting idly, may I politely suggest
reading the Linux kernel process documentation. Especially the part
which explains whether it's polite to ping maintainers (after less 
than two work days).

