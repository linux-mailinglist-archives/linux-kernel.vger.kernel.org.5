Return-Path: <linux-kernel+bounces-88618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4027A86E446
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63BCF1C22FCA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4C56EEF7;
	Fri,  1 Mar 2024 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrUU4ngc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B2038DC3;
	Fri,  1 Mar 2024 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709306787; cv=none; b=ndXjjerflFgE8HAS8si2e29OsRGaD1ErByUbB17nwhfjDlrV60GGNPKEbPyRlHF/S4Ddwy871CnGAABf/90zhuLvRbx+2wMPj22h/7eI+U81ep4uDEoGtD1bNBibr8FEsaNd1oVCNfaChnh+qlFjVRjY0vp8QSFSH+XiTLTqQKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709306787; c=relaxed/simple;
	bh=zgiUj9sVZV5Oq0DjxQko+Hccbg5xqEMZ+xVejxKhGoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZzytAzxo9bmKmlhfOrsOlnU0MGnhgj6BKQdO82vOfskGmZYNmg5euwxDMlCNB11muGg1gHAQ4EvHbxBw0ZUfXyUWytmtPcGvo7MCxZSSrj42LqXByCG4i5ePFOY7yEFzdI3Nnk1jaELe48gYzz/cLHcONUZQ2P9mmA71Wcgz4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrUU4ngc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B606C433C7;
	Fri,  1 Mar 2024 15:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709306785;
	bh=zgiUj9sVZV5Oq0DjxQko+Hccbg5xqEMZ+xVejxKhGoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DrUU4ngcFNuRchLFpsKXqbpsoJake9L5IrlGQHhdba6XZQQA7QmPYrzqnRwFZkOJz
	 IEZgslEEPDxH8GLYLMk5OhBn5pvWiJbLO1zTozo/x1dSVXBkgS/imxQ4AM26lQMA1Z
	 Aavg7kEoioO9ltWD3rRBBGTFU1mpfxURNQwdfzKxt96pWuriqGXNedqPma6cX5xuqm
	 oGXzNUV/HCG5aXiou4uJffUrPU/Ho1FWwX20zmOR2ixHRcVxMcYWJlTx8x7sJOeKI4
	 ObjXl+sM3wpWz3EzsbaB/GMGxDWG0xq6r67PP57lOqGGzwTjpmfIwl9Bfu8BJJAcde
	 ofC6W9/d0mVrg==
Date: Fri, 1 Mar 2024 15:26:21 +0000
From: Simon Horman <horms@kernel.org>
To: Rand Deeb <rand.sec96@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	deeb.rand@confident.ru, lvc-project@linuxtesting.org,
	voskresenski.stanislav@confident.ru
Subject: Re: [PATCH] net: ice: Fix potential NULL pointer dereference in
 ice_bridge_setlink()
Message-ID: <20240301152621.GC403078@kernel.org>
References: <20240228155448.121603-1-rand.sec96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228155448.121603-1-rand.sec96@gmail.com>

On Wed, Feb 28, 2024 at 06:54:48PM +0300, Rand Deeb wrote:
> The function ice_bridge_setlink() may encounter a NULL pointer dereference
> if nlmsg_find_attr() returns NULL and br_spec is dereferenced subsequently
> in nla_for_each_nested(). To address this issue, add a check to ensure that
> br_spec is not NULL before proceeding with the nested attribute iteration.
> 
> Signed-off-by: Rand Deeb <rand.sec96@gmail.com>

Thanks Rand,

I do wonder if for some reason this cannot ever occur.
But assuming it can then I agree with the fix.

Reviewed-by: Simon Horman <horms@kernel.org>

As a fix I think it probably warrants a fixes tag and
being applied to net. As such, the following seems appropriate.

Fixes: b1edc14a3fbf ("ice: Implement ice_bridge_getlink and ice_bridge_setlink")

..

