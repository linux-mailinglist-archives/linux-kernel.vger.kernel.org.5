Return-Path: <linux-kernel+bounces-102682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6CF87B5E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D529F1F2346E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB7A4A0F;
	Thu, 14 Mar 2024 00:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOUg+uZy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227FBEDE;
	Thu, 14 Mar 2024 00:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710377230; cv=none; b=Rs3Ikl5yRkmYYK02g/IIcQFINrtQENnCROeMIP1sT+1aqY+877kVxjc66ZNevGp209QTtdv0uAVrchC0qWeWOAOMDaobIWCAm3FDAD/aKsFXjm7NE4tf6oogp+UTFljfX0lgjKYxexUbtnFSIinfOtyA8HytqiqM1DTLFTMsc4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710377230; c=relaxed/simple;
	bh=qKPmuFy5jSv2FUvDU4I5u79zHoe/ceDCsJmZZRqwyOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FY7/ZLE5zlBT4k7m16C53m0rDLBYzFTRtpj7Cv4Z5cZqSKD1CN9o4+SbvueCqyP23anDiTKDjjn0LwlCJ1CqxfB5xOhy53+0AExJsjEc49/RsahJUatlXA3OoMGl3uuTyrZfYmEwv2H6jzvfdtM7sdrBlUdTfJIC+6tVDgRvDHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOUg+uZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5922C433C7;
	Thu, 14 Mar 2024 00:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710377229;
	bh=qKPmuFy5jSv2FUvDU4I5u79zHoe/ceDCsJmZZRqwyOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MOUg+uZyX9cDVxyGl6rSui5A5exxQL4gHPuZAPhCUKckccnqatCcSh+C9TSjt6iPG
	 IfMwNgn+LKySu8F9Z2fpNm7WWtQ5kqPwAIIG5qW29tIGLf4TVbh0IHE//nX9B8xaKa
	 JDxLs44pSksmjfuQfhGIYwieosrBPcu2ILguyaSZcLVqbCEohFHkn3MmYvwMwcThRe
	 m1Zg4vx251IfsJYACqIHRzaZJviqfCMScMc9hFj9qkxaf7daWr62YXmxAC5iMWoklY
	 GAl20CYA9tlXYWQv3+ar/cCTRcBb+BjydX/s+1DbfwoA6SQrz/R6lX4yPaPrPjowcY
	 enayLsU5bKG9A==
Date: Wed, 13 Mar 2024 17:47:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 alexandre.torgue@foss.st.com, andrew@lunn.ch, corbet@lwn.net,
 davem@davemloft.net, dtatulea@nvidia.com, edumazet@google.com,
 gal@nvidia.com, hkallweit1@gmail.com, jacob.e.keller@intel.com,
 jiri@resnulli.us, joabreu@synopsys.com, justinstitt@google.com,
 kory.maincent@bootlin.com, leon@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, liuhangbin@gmail.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com,
 paul.greenwalt@intel.com, przemyslaw.kitszel@intel.com,
 rdunlap@infradead.org, richardcochran@gmail.com, saeed@kernel.org,
 tariqt@nvidia.com, vadim.fedorenko@linux.dev, vladimir.oltean@nxp.com,
 wojciech.drewek@intel.com
Subject: Re: [PATCH RFC v2 6/6] tools: ynl: ethtool.py: Output timestamping
 statistics from tsinfo-get operation
Message-ID: <20240313174707.38a71c84@kernel.org>
In-Reply-To: <87plvxbqwy.fsf@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
	<20240309084440.299358-1-rrameshbabu@nvidia.com>
	<20240309084440.299358-7-rrameshbabu@nvidia.com>
	<20240312165544.75ced7e1@kernel.org>
	<87plvxbqwy.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 17:22:50 -0700 Rahul Rameshbabu wrote:
> I think this is for 'flag' type attributes. Not for the "header" flags
> for the ethtool request, so I believe this cannot be done here, since
> the header flags are a u32 type, not a flag type.
> 
>   https://lore.kernel.org/netdev/20240222134351.224704-2-jiri@resnulli.us/
> 
>   -
>     name: header
>     attributes:
>       -
>         name: dev-index
>         type: u32
>       -
>         name: dev-name
>         type: string
>       -
>         name: flags
>         type: u32
> 
> vs
> 
>   -
>     name: bitset-bit
>     attributes:
>       -
>         name: index
>         type: u32
>       -
>         name: name
>         type: string
>       -
>         name: value
>         type: flag
> 
> So I believe Jiri's change applies for the latter, not the former (could
> be wrong here).

Ah, we're missing the enum definition and linking :S

I mean:

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 197208f419dc..e1626c94d93b 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -16,6 +16,10 @@ doc: Partial family for Ethtool Netlink.
     name: stringset
     type: enum
     entries: []
+  -
+    name: header-flags
+    type: flags
+    entries: [ compact-bitset, omit-reply, stats ]
 
 attribute-sets:
   -
@@ -30,6 +34,7 @@ doc: Partial family for Ethtool Netlink.
       -
         name: flags
         type: u32
+        enum: header-flags
 
   -
     name: bitset-bit

See if that works and feel free to post it with my suggested-by

