Return-Path: <linux-kernel+bounces-128404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2F9895A64
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A1D282F1F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4911315A483;
	Tue,  2 Apr 2024 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p562LXWq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD9E15990A;
	Tue,  2 Apr 2024 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712077648; cv=none; b=TkxrRaxPlk1cmi9/qH8WaHYhf5USmAvIxFO+oCODTRxTyXI8zu4Y7895h7Npyl5zTiMD/tBW7NWJuf80kvh9/PLkfEDtQ9ZEC8/vgqcZvs0F9iSoLb0peKtH5qPF7sQokhfypA9gLILtWSkGTGkWoD2iDTd59JBXFjxqDiUweO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712077648; c=relaxed/simple;
	bh=N2mTXtynJzd6hDyCQblGT1NKDEqb1Nqa7bobWw39oGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdLtAKfsl/2qEei/yn+U8vtT4RfeXwmwSR3PsSRf0kRXx3uGeDuFjWNAi+vhKoV6eEQlQ3gzSvmgMZ3vRh9eTmjGiq2o3T+dutEiogkSx2KcIJAJE6Y4f1INQ1NeM0j5wXVB+7DaS4C0fx1/aveDhlyIvJmNKMNp4fiV+dhWNSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p562LXWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED93C433F1;
	Tue,  2 Apr 2024 17:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712077648;
	bh=N2mTXtynJzd6hDyCQblGT1NKDEqb1Nqa7bobWw39oGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p562LXWqGCwJ52oQOOMED/b2EvAEZDHuuAQR0R1sLV5mK2tKhQNjyLsKpPCKCXqFy
	 fkyVgMYpyrBCp0ipdutnv3f7ky5N5sNmPRti00JuZpjEDqn/rYnHeqSPaeoMCjZphi
	 4pCyW5KKF6wmR2+68I8TdjSPxz7oYrKT67mv/LQ1wnTl86UWDLzbTIJUgygAkSxkHv
	 ZQ7f+RQv3eTZzDYtDlZZqFUaap6biCPIfGCg9/MeHx5wITgtUaRKzacRhwYjzORMj5
	 f1vZPh3rSEyWE1gtW0LPQMg/pUmnk67xMugToHOHB5t8nh+T4f3XFZTymhOJtlTU97
	 ZJugRBCdGz3pw==
Date: Tue, 2 Apr 2024 10:07:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <Arun.Ramadoss@microchip.com>
Cc: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
 <Woojung.Huh@microchip.com>, <pabeni@redhat.com>,
 <o.rempel@pengutronix.de>, <edumazet@google.com>, <f.fainelli@gmail.com>,
 <kernel@pengutronix.de>, <san@skov.dk>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v1 4/8] net: dsa: microchip: ksz8: Refactor
 ksz8_r_dyn_mac_table() for readability
Message-ID: <20240402100726.0516e762@kernel.org>
In-Reply-To: <e559c5c81e90039f17b555b66c5b3837d410c489.camel@microchip.com>
References: <20240402131339.1525330-1-o.rempel@pengutronix.de>
	<20240402131339.1525330-5-o.rempel@pengutronix.de>
	<e559c5c81e90039f17b555b66c5b3837d410c489.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 15:44:30 +0000 Arun.Ramadoss@microchip.com wrote:
> >         int rc;  
> 
> If rc is initialized with 0, we don't need to assign rc = 0 in the
> success path.

Not so sure -- it's easier for the compiler to catch uninitialized
variables than "accidentally stale" values.

