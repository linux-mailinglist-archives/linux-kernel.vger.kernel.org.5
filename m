Return-Path: <linux-kernel+bounces-64667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AD9854143
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714BF28C61F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FD8111A2;
	Wed, 14 Feb 2024 01:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4S0KaLb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B62125AD;
	Wed, 14 Feb 2024 01:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873987; cv=none; b=eWJ5lSOusgc1OyXSIpxCSgM0bnmTaSZ4MbPLMUKRwGnbppjUIDqcJ4H+fsQ2CkkRtvbJscAICJjILbuTSwyzb4x6Bn4vDGkvksKTu+/hhefwfeRMxUWZPSeRR7hcigwnR8+hji5GpZcx9FS99wFEiq9YZrePZlGtg+5vWW6CWg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873987; c=relaxed/simple;
	bh=QqVN4I8a66LbGVcZBXtseJS+ansGULIYrOKlUjQzjzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QiBzkROmqitvtF9n8bz9T9MiY5Bm5zyztaDhtKTRfHNgN5fL8Fall+P3V/XcIG6ON/+dpvwIGDm3klIqCW3WGZXc1cvzC8QrmVPbXT3ywn7NBOEzmRNb6LZTk2NdMyuK8/Bis41+pyp3MaV/0C3Y6tqTcb9L76bCresOXsXWeeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4S0KaLb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B06C433C7;
	Wed, 14 Feb 2024 01:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707873987;
	bh=QqVN4I8a66LbGVcZBXtseJS+ansGULIYrOKlUjQzjzg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h4S0KaLb1o+OMmx2bXq4SVkektMTrZqjoAhUzxkddpz41QC63VYJiBD/OGQAZ2uOy
	 OcTVy1QAXwVJKls9pKD3jKt9TnIVULm2Jfz65gG2ozqLAzTfjQtg3nBMS58Smjffzd
	 Kfghpib8IrOLEbRpm9NMsEL3i+NRwnh9CZUfuwu5LUcAttrp3YwAkY5aiVv0GtOZNU
	 Y/ddXC2HHDWidMWL7wdR1GBaCWNbn4RkERLSXLu505irkfwZAYeg+3a9eL5OfItqPM
	 HKPNm+WSH0dUf63IYvv9S7SZXYjp/1aaqKSQgJAcrFxHL47vJ1D5sJCKv/tWeS/FaO
	 /ooCo4j6X2nug==
Date: Tue, 13 Feb 2024 17:26:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, Daniil Dulov <d.dulov@aladdin.ru>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] net: sfp: remove redundant NULL check
Message-ID: <20240213172625.73643a36@kernel.org>
In-Reply-To: <cae5b4d55770da3a1dc9678ffa55c9afb9c81723.camel@redhat.com>
References: <20240211150824.3947-1-d.dulov@aladdin.ru>
	<cae5b4d55770da3a1dc9678ffa55c9afb9c81723.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 13:43:57 +0100 Paolo Abeni wrote:
> On Sun, 2024-02-11 at 07:08 -0800, Daniil Dulov wrote:
> > bus->upstream_ops in sfp_register_bus() cannot be NULL. So remove
> > redundant NULL check.  
> 
> I'm unsure about that?!? in theory drivers could call
> sfp_bus_add_upstream()/phy_sfp_probe() with NULL ops, even it that very
> likely doesn't make any sense.
> 
> @Russel, @Andrew: WDYT?

Since Russell is AFK let me discard this instead of queuing.
We'll resurrect if any of the maintainers sends review tags or alike.

