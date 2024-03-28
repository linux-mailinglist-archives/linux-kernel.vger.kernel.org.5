Return-Path: <linux-kernel+bounces-93366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F56B872E90
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359741F24E76
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DE01BDDF;
	Wed,  6 Mar 2024 06:03:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E641BF27
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 06:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709705035; cv=none; b=aylcIk9YXMMOTF60KvAJ5L1efoERyv1vHaQUigKGmy4rUjcTq62Zsy0jruZ+Yz0MPBP8A4cPpkzbEiB2LRrS1Sq0DoY6WdBg/t1g60gbsFgpO9bJimnCn1knH7YpQeBGZWuNz3WZZzQhrYOO3KtDdpZYlXZGlsOZ5GN2pRmJXyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709705035; c=relaxed/simple;
	bh=u1Xd+DEBwlWvH4JSesKY3KcTPm5k1vZeFrEEYSgXBX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FP93CT4KwlaRY/R+GzyEjKQfJXbNgocwPh4tDW2fijSVqPMCNHhgrNB8thZXcZOZoe12t/XjW8xpOT8c3ZKK1cJz7mc1kM7BOA3sOtS48fEz52NPFNG4XxqeV+xmecDwkkCn7Xt77hjz4b3xvBcMallnsLSq+M9D9FH8XWUuEQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rhkNR-00048i-HB; Wed, 06 Mar 2024 07:03:41 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rhkNP-004gyk-9S; Wed, 06 Mar 2024 07:03:39 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rhkNP-004nse-0d;
	Wed, 06 Mar 2024 07:03:39 +0100
Date: Wed, 6 Mar 2024 07:03:39 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Arun.Ramadoss@microchip.com
Cc: kuba@kernel.org, andrew@lunn.ch, kernel@pengutronix.de,
	olteanv@gmail.com, davem@davemloft.net, Woojung.Huh@microchip.com,
	linux-kernel@vger.kernel.org, pabeni@redhat.com,
	f.fainelli@gmail.com, edumazet@google.com, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v2 1/1] net: dsa: microchip: make sure drive strength
 configuration is not lost by soft reset
Message-ID: <ZegHO_PqO-3qwFMQ@pengutronix.de>
References: <20240305064802.2478971-1-o.rempel@pengutronix.de>
 <20240305191457.37419bd4@kernel.org>
 <935b7bd6fe116291ff5f1f5a7a52cdad89e4607a.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <935b7bd6fe116291ff5f1f5a7a52cdad89e4607a.camel@microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2024 at 03:29:32AM +0000, Arun.Ramadoss@microchip.com wrote:
> Hi Jakub,
> 
> On Tue, 2024-03-05 at 19:14 -0800, Jakub Kicinski wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> > On Tue,  5 Mar 2024 07:48:02 +0100 Oleksij Rempel wrote:
> > > This driver has two separate reset sequence in different places:
> > > - gpio/HW reset on start of ksz_switch_register()
> > > - SW reset on start of ksz_setup()
> > > 
> > > The second one will overwrite drive strength configuration made in
> > > the
> > > ksz_switch_register().
> > > 
> > > To fix it, move ksz_parse_drive_strength() from
> > > ksz_switch_register() to
> > > ksz_setup().
> > > 
> > > Fixes: d67d7247f641 ("net: dsa: microchip: Add drive strength
> > > configuration")
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > 
> > Hm, this is much larger than I anticipated, and also doesn't apply,
> > so there will be conflict with -next. Andrew, should we go back to
> > the v1?
> 
> Suggestion: Instead of moving ksz_parse_drive_strength() from end of
> file to above, can we move ksz_setup() & ksz_teardown() down. So that
> the changes will be minimal. Will that work?

This will make it hard portable to stable too. As alternative I can
offer to use v1 patch for stable and send bigger patch for next after
in the next net-next window.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

