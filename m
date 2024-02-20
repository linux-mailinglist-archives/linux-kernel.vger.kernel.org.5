Return-Path: <linux-kernel+bounces-73190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F040B85BF06
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7B7284065
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3566D1B8;
	Tue, 20 Feb 2024 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z/GpseWU"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168362C6AA;
	Tue, 20 Feb 2024 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440324; cv=none; b=f90akbaP158s2BJD9Jy/7bbowh0K03U9o4mB82Kxuzt68ASf6eplSsXpiGzkC2J+YqAdHxdbUwKgwgQ1TYWnuKZQWwo1sRQ0kWNo2mCp9iXyezuXcVdauzbTjS3Zx9hcwyjHxPSc/xnxtfhdnrmv2NONhU58J/6bRggmAeb35nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440324; c=relaxed/simple;
	bh=9OuL8BYQcUg2azVMZYx+EOilMab+eq2qmK5iOEnFmb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1tMVqg64gsEKb917+xVdCkCeGewe9bb2Ei31cfjfhzrUzqY865xtVaZywf/JRjYa+y+7ZPyhUqLUP1f8odXRbTh9kBOe6LuA3nSPd8k+6AhhWSlBGz1oSwxsFz5DHIt8tGHTdL2CMg0ORA7Tn2wzX4eWAcMepCY4cxKtmTsSfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z/GpseWU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zfldrZzT5rYLjsaVPisGJB5OtCgQ4dz4zxtJzhM67DU=; b=Z/GpseWUybd0CL/+h9GRJnkeHV
	bPjCC1+KlPq/kicfwPpx92uuiaaam8wCG28OzXBtIKSGUkuxr/tGEajFDSk/abmgCx+fIFDq6chQ0
	BzsHOQ/r/t8FITaNIta+aHvW2EKnnvlfmNOqaIKhx1QHz2lzUng4v0oFd2n85Pfk/RyM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rcRNA-008I4I-2Y; Tue, 20 Feb 2024 15:45:28 +0100
Date: Tue, 20 Feb 2024 15:45:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v4 3/9] net: qlogic: qede: Use linkmode helpers
 for EEE
Message-ID: <a52361ef-66ab-41bd-b245-ccd26fcbd957@lunn.ch>
References: <20240218-keee-u32-cleanup-v4-0-71f13b7c3e60@lunn.ch>
 <20240218-keee-u32-cleanup-v4-3-71f13b7c3e60@lunn.ch>
 <20240220124405.GB40273@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220124405.GB40273@kernel.org>

> > +	unsupp = linkmode_andnot(tmp, edata->advertised, supported);
> 
> nit: Given the types involved, I might have written this as:
> 
> 	unsupp = !!linkmode_andnot(tmp, edata->advertised, supported);

linkmode_andnot() calls bitmap_andnot():

static inline bool bitmap_andnot(unsigned long *dst, const unsigned long *src1,
			const unsigned long *src2, unsigned int nbits)

It already returns a bool, so there is no need to force an int to bool
conversion using !!.

	Andrew

