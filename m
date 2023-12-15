Return-Path: <linux-kernel+bounces-732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 643CD81454C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8691F23F16
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139281946E;
	Fri, 15 Dec 2023 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NJjjmzbB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F01A596;
	Fri, 15 Dec 2023 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=NaKT5qoM+qCmvzKX65nbLG/srH1WrOorsHKdumObti8=; b=NJ
	jjmzbBpViyMWjd/BWRY6PLwWucmKJSCdLtRqTA97Yfa4MiQnXnMYihg47mshv2m3yCUN7ljv5z3g3
	ZO4cgeDx1T9i27CTcOfLNiwoqbmCkND1P/IBljgq0vA3euiwFY9gfzIbPOBJwDL1k8YH7MC4r2baQ
	tuLD2BL8k9cUB2c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rE5Gw-0030Yc-Ry; Fri, 15 Dec 2023 11:18:22 +0100
Date: Fri, 15 Dec 2023 11:18:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: marvell,orion-mdio: Drop
 "reg" sizes schema
Message-ID: <e59ff8c2-caa1-4072-b86f-0446120ac49b@lunn.ch>
References: <20231213232455.2248056-1-robh@kernel.org>
 <20231214-buzz-playlist-2f75095ef2b0@spud>
 <CAL_JsqKaGFfQNwR3HqRnVs3K7SUtevpoG6tEDntM0SNfyyp6AQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKaGFfQNwR3HqRnVs3K7SUtevpoG6tEDntM0SNfyyp6AQ@mail.gmail.com>

On Thu, Dec 14, 2023 at 12:12:42PM -0600, Rob Herring wrote:
> On Thu, Dec 14, 2023 at 10:23 AM Conor Dooley <conor@kernel.org> wrote:
> >
> > On Wed, Dec 13, 2023 at 05:24:55PM -0600, Rob Herring wrote:
> > > Defining the size of register regions is not really in scope of what
> > > bindings need to cover. The schema for this is also not completely correct
> > > as a reg entry can be variable number of cells for the address and size,
> > > but the schema assumes 1 cell.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > Does this not also remove restrictions on what the number in the reg
> > entry is actually allowed to be?
> 
> Yes, that's what I mean with the first sentence. We don't do this
> anywhere else with the exception of some I2C devices with fixed
> addresses. Keying off of the interrupt property also seems
> questionable. If the register size is different, that should be a
> different compatible.

Reading the code, it appears the hardware always supported interrupts,
however the first version of the driver never used them. It seems like
some DT blobs had the register space cover just the needed registers
for polling, and excluded the interrupt control register. When
interrupt support was added, all in-tree DT files were updated with
the extended register space, but to allow backwards compatibility, the
driver checks the length of the register space and will not enable
interrupts if its too small.

I'm guessing that since the hardware did not change, a new compatible
was not used when adding interrupt support. And the yaml is there to
help when old out of tree .dts files are merged into the tree and have
the old register space.

This is and old driver, and its usage of DT is from long before many
of the current best practices where determined, or yaml was even an
idea. So i'm not surprised it has a few odd quirks.

I don't see a reason not to remove these constraints, as i said, the
driver should do the right thing if the register space it too small
and YAML does not warn about it.

      Andrew

