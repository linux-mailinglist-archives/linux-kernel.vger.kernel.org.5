Return-Path: <linux-kernel+bounces-52740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AD6849C1D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C989C1F24429
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DEA20DF6;
	Mon,  5 Feb 2024 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gquqHcC/"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457E2249F7;
	Mon,  5 Feb 2024 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140526; cv=none; b=t+Jp5EC6zGi0c3b4x47sCAFTkCkQhLzzmZr+QDHs6+z0p+cvFEZvKgwjxGfq+bDY3SOistTDtF5H4qYn5YRh/baqEMHM5Gs1fE5YKORhgt4cTpLHQjfPPGl+zTKpcRZgd47An6pr42wP5RYjlNgLShoZCHRb+H61bneYoY0u0yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140526; c=relaxed/simple;
	bh=/wQMrpuzD8DLeB+dyVSLRlSrwYiBDeLVdQ7mpA9FdPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o40TH1XR2i3YgZgBhKFJ7OweUjxTPXM7kYg9dtD4eCfGKyQLu8zhkbSNrQZtiQqi/qfo+92Nr7X8izmQwGWQe9MoNUfYBhO7ShKBzxC3xOdjplSrOZZ0KONnnW7Ypkw0ZHSDcjHLZ5HX7QFiHmT05mOPCxITnTESYYuva5w+0PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gquqHcC/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uH4U9fvNVZDiK+h5rTo4LU81eBV5vhHy4QRdufhEcjc=; b=gquqHcC/HDgYFuP6KhxFqHtsw4
	1doib5d7IYx7x3a3eXDwCoVrcwLy5kSDWZicdKg7rF6T/Drml9ZaYCRet/ZXyaVQyOsqsdmZ/7knA
	f55+lhKm9BYgn/cngcIyEkol0wQ8agPYaioG11gwVxCEs0ku2/aVpnxYtvRkuoYJjsU8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWzEI-0072Ct-4p; Mon, 05 Feb 2024 14:41:46 +0100
Date: Mon, 5 Feb 2024 14:41:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lee Jones <lee@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Pavel Machek <pavel@ucw.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Li Zetao <lizetao1@huawei.com>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] leds: trigger: netdev: Fix kernel panic on interface
 rename trig notify
Message-ID: <2cf84815-f9b6-4a0a-a3b4-d23628a89aa4@lunn.ch>
References: <20240203235413.1146-1-ansuelsmth@gmail.com>
 <8d51f09b-e6d2-4ee1-9e7d-b545d561798a@lunn.ch>
 <20240205085007.GA19855@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205085007.GA19855@google.com>

> > This should have 'net' in the subject line, to indicate which tree its
> > for.
> 
> No, it shouldn't.
> 
> Contributors aren't obliged to know anything about merging strategies.

With netdev, we tend to assume they do, or at least can contribute to
the discussion. They often know about any dependencies etc which could
influence the decision. When there are multiple subsystem maintainers
involved, i tend to use To: to indicate the maintainer i think should
merge the patch, and Cc: for the rest.

> Why does this need to go in via net?

It does not, as far as i'm aware. Christian, do you know of any
reason?

	Andrew

