Return-Path: <linux-kernel+bounces-110088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A198859E7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE522B22143
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B881C84A55;
	Thu, 21 Mar 2024 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="US4NyYmO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C09134CD;
	Thu, 21 Mar 2024 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711027150; cv=none; b=OimOm5yrf5v5r2jw6UiNFvzYdT5X680hiBUJCqRghWILtniT/zeCCIz9Bj+Nh4vn+k91V6+nQeHJ0k0+zlHpJTtULnZIh5AQR2OrWsHOT0w+2okAxpjasbCj6IKPv0ovC2JKZV1UvMAQSV5n+HBZOytgCarnnjHVRLt3dX0ea6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711027150; c=relaxed/simple;
	bh=AQiVU6QDBK9keYmpVAn9qAMVZHSVfZCCrd90QaWx1Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rrw+/QdVOng9GeKb1X57EdzhE+TlKb78uZY2d2LsLKEM/WngrohXn/VXT8WZS3QuWG3csKIXbJc6VVoJK1sPH0uXJ98+xPqvfvKMsfF4PkUsq4HyRm6Xsrjlhpyh2BbYvvLdZEkuYiwaYjT7ILKra8/WDfPKK/bqlGzyBOe2Ztc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=US4NyYmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D109C433C7;
	Thu, 21 Mar 2024 13:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711027149;
	bh=AQiVU6QDBK9keYmpVAn9qAMVZHSVfZCCrd90QaWx1Yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=US4NyYmO+vr/1M7HF2tzRimSFK18hbGocDhHbiUlo7G1pqn0qc0vhb7fW/4M0XYST
	 eiCkPbe8OP8p3aWVMafV8hGp451QD4uRzoA+maDjioFTGjYZ3TBYjiaWYmC+HurTWY
	 fy7JoENbFyfEIPqwC96GGEINpHULXLsUNh2tuf20=
Date: Thu, 21 Mar 2024 09:19:02 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Daniel Golle <daniel@makrotopia.org>, 
	DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Bartel Eerdekens <bartel.eerdekens@constell8.be>, erkin.bozoglu@xeront.com, mithat.guner@xeront.com
Subject: Re: [PATCH net v2 0/2] MT7530 DSA subdriver fix VLAN egress and
 handling of all link-local frames
Message-ID: <20240321-tentacled-pearl-ferret-efd5be@lemur>
References: <20240314-b4-for-net-mt7530-fix-link-local-vlan-v2-0-7dbcf6429ba0@arinc9.com>
 <f6f064b8-efb2-4ab0-94f1-468d5d273d6e@arinc9.com>
 <49d23df1340f342822702de0439674ddbc5bff6f.camel@redhat.com>
 <7a7e6c46-03a4-48eb-9f46-84a05259cf26@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a7e6c46-03a4-48eb-9f46-84a05259cf26@arinc9.com>

On Thu, Mar 21, 2024 at 02:29:19PM +0300, Arınç ÜNAL wrote:
> > For future memory: I think the SoB in the cover letter is not required,
> > and is, at least to me, a bit confusing.
> > 
> > No action needed here, I'll keep this unmodified, but I suggest to omit
> > it in future submission.
> 
> b4 puts it on the cover letter so it's not my doing.

This is done because many subsystems use the cover letter as the merge commit
message. Those subsystems who don't follow this practice don't generally care
if there's a Signed-Off-By in the cover letter anyway, so I don't see why this
is a concern that it's there.

-K

