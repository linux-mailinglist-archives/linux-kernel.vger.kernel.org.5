Return-Path: <linux-kernel+bounces-149324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ACD8A8F92
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C356C1C20E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23D381ACC;
	Wed, 17 Apr 2024 23:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="JbP2WTgy"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4B881748
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713397319; cv=none; b=BJGmqG2RB4dd5PYDFycI9rZrtnCbu/JKXoJqfjw9oGKnDP8zrNJ5YBNte58DG6hhbqRYCResve3atQbfaSzfkFQwjrOvcaglKbqEfefPw/1/ELVbr1au2r2LNwczDsOWpYcssioCI2RRhH4dpGCPcYshVDXXDIfVD+TEj7+Tnko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713397319; c=relaxed/simple;
	bh=d/AzyoJNXW+kEe+3Im15qH+BP+LWLSajKmHbYzbPun0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L2P5c/xg4UMnD58peNVAh/0Vk/u4CSLn8lx91ZggvNW+cnuOmOZ5culcC/O/B4PDHet81smFoWMxIK7CeCDGVH217XTuZHBR5vWsUa2LFrUZbPq1xn3Fb49BIgwtI3OQ2LI4u/Z/xMW/SgK7xJ519nAZj9WR2iwKl0r8XphNl8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=JbP2WTgy; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-127-66.adl-apt-pir-bras32.tpg.internode.on.net [14.2.127.66])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5185E20157;
	Thu, 18 Apr 2024 07:41:52 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1713397315;
	bh=d/AzyoJNXW+kEe+3Im15qH+BP+LWLSajKmHbYzbPun0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JbP2WTgygM6dBAHFoxSdQ6T212Uf4v+Ybq4wDbS0DSrHZeSt7LdobuhADZU0LIOuu
	 hKJCcA+xcCQFvu9kiLAMB+u2aSjNCVCLl+/tYrIjdQNg/JfZ4oY8Z74kP1TVvrvdaE
	 sP5pD5es95wkSXN7dX1UMQXOz7Sl65UwHMJVNpKdXpIqU0l0qVa4Szo+/Q74adprb+
	 bZYKBXWOpB6sIVnjGSfwEAv3DOcV5CbxUAsMTiF8r7Gj/3CVHpPSRJC8ObCp6cvTVJ
	 l5RfLEroZqsEiE+dNjV2cUhX3vtTXJkQAwgyx2xjrMFuH+aCF9BNhMdwZ/r1mC11ZN
	 K3jtG3p2kqiOQ==
Message-ID: <7b0ef5c90138e8c1d1829de249a480709170141b.camel@codeconstruct.com.au>
Subject: Re: [PATCH] peci: aspeed: Clear clock_divider value before setting
 it
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Iwona Winiarska <iwona.winiarska@intel.com>, openbmc@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org
Cc: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 18 Apr 2024 09:11:47 +0930
In-Reply-To: <20240417134849.5793-1-iwona.winiarska@intel.com>
References: <20240417134849.5793-1-iwona.winiarska@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Iwona,

On Wed, 2024-04-17 at 15:48 +0200, Iwona Winiarska wrote:
> PECI clock divider is programmed on 10:8 bits of PECI Control register.
> Before setting a new value, clear bits read from hardware.
>=20
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>

I think it would be best to add a Fixes: tag and Cc: stable in
accordance with the stable tree rules. Are you happy to do so?

Andrew


