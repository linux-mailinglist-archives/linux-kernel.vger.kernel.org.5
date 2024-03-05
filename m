Return-Path: <linux-kernel+bounces-92912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7818E87280C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338E228D2E0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CC786654;
	Tue,  5 Mar 2024 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxte8lc0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28BA5C601;
	Tue,  5 Mar 2024 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668493; cv=none; b=hHtEWrX+KwtMI1ZKeWdFrQdY10nllAoe/LkQQooNyHiw4jXn6/J30/Prb6EnlC/ZPjbqQipXBFNiuAHe59BkbMKvoYtEMGGBXYN0wIpWMSj7SXe1t2nGUomyv9zkxC6CZ2Kfp8fav/mL1vslYLiI3ILY6JheeHAX6unT+Clz1hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668493; c=relaxed/simple;
	bh=gntd/YhRPEAN2+Z16W3V+ZZ+Frwia39/RWn+d6a3EcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLrl8kpG0jsprV1gTz3dmPoIIySKSXMRXvQXiVmKEzRyf2i/XjZs/2F/III+O03kX7S2Es6vq+z/pirBl5h0mJKTOhtMSo8WUerbQdwoZzlKCRc2Nd2BkbAT47UhA6NRJEkX5uquVlp3D0p8B+9thT2cszu9GIJK4NI6ccypTjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxte8lc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71B3C433F1;
	Tue,  5 Mar 2024 19:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709668492;
	bh=gntd/YhRPEAN2+Z16W3V+ZZ+Frwia39/RWn+d6a3EcQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lxte8lc0Jppw6kKqg7dMmphrkb66r7fSWpzIBGQScH3qVouaLwS9X4lbSspmbLj7X
	 FYpmoJT1SaeEwQCxuNe9cEtjaXBc3KJ12P+rNHpsoDWNOHfypEvo5zJZCY5DhZty+H
	 /6BbaHVMHH3mYQWxEwwQuWGX8Ek+ePmHxIi5LXldaVKLpeLR5AHYtH/j6YnkYBuB/V
	 lySQnFe27R/KHt23pqZGICCc+/5U0VAR+OyZ2A6/GQ2uPbaQL22Wficrc1Bkf7YvUt
	 URX19gVDZ8l8b2a079SeXZwNaXzRPBe/8IUY2BaJl777Rei3mgUexeIEzzHfw0Wm/C
	 Gqez787JWGetw==
Date: Tue, 5 Mar 2024 11:54:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mateusz Pacuszka
 <mateuszx.pacuszka@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Lukasz Plachno <lukasz.plachno@intel.com>, Jakub Buchocki
 <jakubx.buchocki@intel.com>, Pawel Kaminski <pawel.kaminski@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Mateusz Polchlopek
 <mateusz.polchlopek@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Pawel
 Chmielewski" <pawel.chmielewski@intel.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-net 0/5] ice: LLDP support for VFs
Message-ID: <20240305115450.577c161e@kernel.org>
In-Reply-To: <ZeJ3u2x3Ihs8WQJn@lzaremba-mobl.ger.corp.intel.com>
References: <20240228155957.408036-1-larysa.zaremba@intel.com>
	<20240228084745.2c0fef0e@kernel.org>
	<ZeBMRXUjVSwUHxU-@nanopsycho>
	<20240229072813.5d7614c3@kernel.org>
	<ZeDb8Dr8mBvov9fc@lzaremba-mobl.ger.corp.intel.com>
	<20240301090836.185e3b79@kernel.org>
	<ZeJ3u2x3Ihs8WQJn@lzaremba-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Mar 2024 01:50:03 +0100 Larysa Zaremba wrote:
> For RX: match on Ethertype and mirror, every trusted VF should be able to scan 
> neighbors.
> 
> For TX this is more complicated and is done not through eswitch, but through 
> modifying security options, so do not think this would work with tc. So private 
> flags are the best option? Our requirements say only a single VSI can transmit 
> LLDP.

It is doable theoretically, tho, right? Driver can detect that all
eswitch VF/PF ports but one have a "drop LLDP" rule and update the
security option correctly?

