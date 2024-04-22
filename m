Return-Path: <linux-kernel+bounces-153449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BDC8ACE3E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E5B1C20F81
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE9115098B;
	Mon, 22 Apr 2024 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bxhLHCfK"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032B714F9DC;
	Mon, 22 Apr 2024 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792673; cv=none; b=Vl1Bhh2iRxhxKu7TmX09wiYCneDL+ymkgWkEqUGkl9OtdZmhQeKNl8dLzknu3S9NklV5ZQxR28Q+Tl+HVfhfC6/IuxaTQdxp0bmOpY/PCOzVw1KuZaWIHPMcQJQ3TQ3mdKLzKtL5ue2XVW1ZjtMeUlRr8jkoHdCuhEcOK+3SBVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792673; c=relaxed/simple;
	bh=BR+rjfuQ3fKF08ic/hIpkJH4RlB+LtgV/zV25IOt8TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZY6CEefiDdARCw07G/fBexrMllqFHE2YZzCgKHkRDW2sWUGnpiUS2x1KwM5WSG1/Ko2bRx7lKYd8p07h/Zqz0khLmplkrdqTbwZurlg+0XF2pnCV/en/x96BsvbP70hWZonPvayhDNweuuoyB2wYkjZs0tXCkdnwhogUIMNJD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bxhLHCfK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/slTi2dI7/QqEXj4ACAD+Owz9e1ZqfqrM5C8CzmcduE=; b=bxhLHCfKc4xATSEEzdpCppGraH
	Yk7vXDFnCYaD2yDZng1bfdIW/UprJAACXiS9H+fuqLu2gduEPzlmLJc7Rh2SUqoGP6IT8cvCI/2tv
	Bswo2fNhi4KvMxXQt7zm6C12rpQXCKFee/7VBW2nKVv034Bo90O1PpYw0id3jvl1IVjE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rytlA-00DcVS-DE; Mon, 22 Apr 2024 15:31:04 +0200
Date: Mon, 22 Apr 2024 15:31:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Fabio Estevam <festevam@denx.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH net 2/2] net: dsa: mv88e6xxx: Avoid EEPROM timeout
 without EEPROM on 88E6250-family switches
Message-ID: <47350aa7-b4d0-49f0-98f5-4fc52c4f2c42@lunn.ch>
References: <2b924dcdf8adfe2c0b6b5998e47e836dd8f9e1b1.1713442039.git.matthias.schiffer@ew.tq-group.com>
 <67dc4da11986fd7fd192fbb183813bf5a721001f.1713442039.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67dc4da11986fd7fd192fbb183813bf5a721001f.1713442039.git.matthias.schiffer@ew.tq-group.com>

On Thu, Apr 18, 2024 at 02:16:08PM +0200, Matthias Schiffer wrote:
> 88E6250-family switches have the quirk that the EEPROM Running flag can
> get stuck at 1 when no EEPROM is connected, causing
> mv88e6xxx_g2_eeprom_wait() to time out. We still want to wait for the
> EEPROM however, to avoid interrupting a transfer and leaving the EEPROM
> in an invalid state.
> 
> The condition to wait for recommended by the hardware spec is the EEInt
> flag, however this flag is cleared on read, so before the hardware reset,
> is may have been cleared already even though the EEPROM has been read
> successfully.
> 
> For this reason, we revive the mv88e6xxx_g1_wait_eeprom_done() function
> that was removed in commit 6ccf50d4d474
> ("net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent") in a
> slightly refactored form, and introduce a new
> mv88e6xxx_g1_wait_eeprom_done_prereset() that additionally handles this
> case by triggering another EEPROM reload that can be waited on.
> 
> On other switch models without this quirk, mv88e6xxx_g2_eeprom_wait() is
> kept, as it avoids the additional reload.
> 
> Fixes: 6ccf50d4d474 ("net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

