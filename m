Return-Path: <linux-kernel+bounces-109513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3908B881A67
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12BF1F216D5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA6915BB;
	Thu, 21 Mar 2024 00:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KEOMcEn3"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEE1370;
	Thu, 21 Mar 2024 00:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710980043; cv=none; b=OcxfTTp2n9yuXytV2Q1jGP3+sIniSw+OhC663Q8/tiCLlBH06q5mLdf6xFV+EWyoMBdj21YCYtDtzaCnhSa6fK8dVG/MkAaRUr/qI8IuUvaLQw0tdFo3tK5IFqdgWAOSDY5Q53S9OMWQwx+VNHc55H7Me1RiArwQp1cN5CTfQjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710980043; c=relaxed/simple;
	bh=EoA8/0mAlNhT0TMql29QIH/To0Z4Mj6i7EIGx21gk2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaVby27W8n0fE3ZVzhkaxTz97ikbT8XE0xZ+B+UYnMH16R5HxuotNO2DBwHdMy5A00yULZ2wasjmoytVEVHw2+9uUaFLdVbdWIgGQcDXHkeyvjXInJtNGytVq7quumqP1AftF4JNyhV0wrlPUhrS03+aZNqaPMjoUu1Pm2F67YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KEOMcEn3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=YxRIA795DUfjJPHRguMNE/KtiSNi+tYHAEz8Wqm1/Ws=; b=KE
	OMcEn31ptc7LQKoPC+shqiRuiNN4+L3t3CKqJJguSWQhmXin0TiD5sJfBRI1KQQeV1RDd3DRnfmKm
	58aDt3Y75wmo9WLt5AdSmDat2vyH5dE2ZX6FjsZ8zUj8syq3/8WF4lnwO8Qhkvi9nuyEVRWuCoOLG
	IXaR398SB1DTc7s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rn647-00ApHH-UA; Thu, 21 Mar 2024 01:13:51 +0100
Date: Thu, 21 Mar 2024 01:13:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Elad Nachman <enachman@marvell.com>
Cc: taras.chornyi@plvision.eu, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kory.maincent@bootlin.com,
	thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
	przemyslaw.kitszel@intel.com, dkirjanov@suse.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] net: marvell: prestera: unbind sfp port on exit
Message-ID: <a0b1fc9f-b801-44e2-aaad-c29a5046ba1d@lunn.ch>
References: <20240320172008.2989693-1-enachman@marvell.com>
 <20240320172008.2989693-6-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320172008.2989693-6-enachman@marvell.com>

On Wed, Mar 20, 2024 at 07:20:08PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Call unbinding of the sfp port when ports are released, This will call
> phylink_destroy() to cleanup and destroy the phylink instance, needed
> to unregister SFP and free used memory, which will otherwise leak.
> 
> Reported-by: Köry Maincent <kory.maincent@bootlin.com>
> Closes: https://lore.kernel.org/lkml/20240312164526.4a0e242a@kmaincent-XPS-13-7390/
> Fixes: 501ef3066c89 ("net: marvell: prestera: Add driver for Prestera family ASIC devices")
> Signed-off-by: Elad Nachman <enachman@marvell.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

