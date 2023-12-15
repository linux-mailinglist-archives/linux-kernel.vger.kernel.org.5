Return-Path: <linux-kernel+bounces-393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 714A2814072
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 122B2B21CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB821879;
	Fri, 15 Dec 2023 03:10:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34F7468C;
	Fri, 15 Dec 2023 03:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rDyLH-0004Mo-0I;
	Fri, 15 Dec 2023 02:54:24 +0000
Date: Fri, 15 Dec 2023 02:54:20 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
Message-ID: <ZXu_3OnSzmLq5GAH@makrotopia.org>
References: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
 <20231214183123.0f0af377@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214183123.0f0af377@kernel.org>

On Thu, Dec 14, 2023 at 06:31:23PM -0800, Jakub Kicinski wrote:
> On Tue, 12 Dec 2023 00:05:35 +0000 Daniel Golle wrote:
> > Calling led_trigger_register() when attaching a PHY located on an SFP
> > module potentially (and practically) leads into a deadlock.
> > Fix this by not calling led_trigger_register() for PHYs localted on SFP
> > modules as such modules actually never got any LEDs.
> 
> Any suggestion of a Fixes tag?
> Looks like the triggers were added a while back, are we only seeing it
> now because we started exercising the code more?

I've noticed this as a consequence of commit 2f3ce7a56
"net: sfp: rework the RollBall PHY waiting code"
because (?) some PHYs on SFP+ now probe immediately as the previously
enforced minimum delay now became a timeout.

Blaming that commit would be wrong though, it's more that the problem
has probably always been there and was just previously augmented by
the delay.

