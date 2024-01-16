Return-Path: <linux-kernel+bounces-28118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B3482FA6A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BCF28B2A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D367A1552F8;
	Tue, 16 Jan 2024 19:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BJOmr6bI"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABAD154BF4;
	Tue, 16 Jan 2024 19:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435181; cv=none; b=p5uH+655HJ7xc5jl9fLGDoXGvsDwu9uvBwmL2XhKO7ltXK6HwzNVxRxdd3dqy6p6Whvwn5PV9NoKXrr6vFaKvML/i03vWdoxDw0yRrenUlZu/rdie5JV/Wg84o/UXsluZGXHESHucHS/t0jHHCbaoGYxrFRJJN4jSOcFq+sAJrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435181; c=relaxed/simple;
	bh=JPlHMBUhUwT7tKuxqJxvPrreTY+vcwsiULPGR0PWxf8=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=iNLKS0d2i/oKnS5/v0UV1RXjOqjMtvZRJtST3pnHzrKAl+jlv/y23OjbQn7wX8LI+DWI42ZlS3TLmgDgQwH+oWSlgwDj4M1Pda8bfD746S8WaMKkopYK8JAmUEdpRg8W96Yk+/YOEsKBbw3icjl3L4vK/EFTeKG+XR2PDr61oHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BJOmr6bI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QOrbjSeg+FOA9pqS7cPB6dtob5KTxlC45EjTRB0DpCc=; b=BJOmr6bIkh2IDeTbIhp0UzgwLu
	gx5JPFpdn526aCakeC23REpDuV+5AqtqTGju1OCirbriR/EPL6G6SLLWbhlH2ZAtm3KB+1jnq47Tw
	OkgsJUwK6iaguqtEgg788dbAFbdbfIA869/6OW+WFtaMh1jm510ZadsetMNQ+6+s+7+8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rPpaq-005Lc7-Rj; Tue, 16 Jan 2024 20:59:28 +0100
Date: Tue, 16 Jan 2024 20:59:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tim Menninger <tmenninger@purestorage.com>
Cc: f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: mv88e6xxx: Make *_c45 callbacks agree with
 phy_*_c45 callbacks
Message-ID: <04d22048-737a-4281-a43f-b125ebe0c896@lunn.ch>
References: <20240116193542.711482-1-tmenninger@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116193542.711482-1-tmenninger@purestorage.com>

On Tue, Jan 16, 2024 at 07:35:42PM +0000, Tim Menninger wrote:
> Set the read_c45 callback in the mii_bus struct in mv88e6xxx only if there
> is a non-NULL phy_read_c45 callback on the chip mv88e6xxx_ops. Similarly
> for write_c45 and phy_write_c45.
> 
> In commit 743a19e38d02 ("net: dsa: mv88e6xxx: Separate C22 and C45 transactions")
> the MDIO bus driver split its API to separate C22 and C45 transfers.
> 
> In commit 1a136ca2e089 ("net: mdio: scan bus based on bus capabilities for C22 and C45")
> we do a C45 mdio bus scan based on existence of the read_c45 callback
> rather than checking MDIO bus capabilities then in
> commit da099a7fb13d ("net: phy: Remove probe_capabilities") we remove the
> probe_capabilities from the mii_bus struct.
> 
> The combination of the above results in a scenario (e.g. mv88e6185)
> where we take a non-NULL read_c45 callback on the mii_bus struct to mean
> we can perform a C45 read and proceed with a C45 MDIO bus scan. The scan
> encounters a NULL phy_read_c45 callback in the mv88e6xxx_ops which implies
> we can NOT perform a C45 read and fails with EOPNOTSUPP. The read_c45
> callback should be NULL if phy_read_c45 is NULL, and similarly for
> write_c45 and phy_write_c45.

Hi Tim

What does phylib do with the return of -EOPNOTSUPP? I've not tested
it, but i would expect it just keeps going with the scan? It treats it
as if there is no device there? And since it never accesses the
hardware, this should be fast?

Or is my assumption wrong? Do you see the EPOPNOTSUPP getting reported
back to user space, and the probe failing?

     Andrew


