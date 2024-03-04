Return-Path: <linux-kernel+bounces-90878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D2B870630
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A132827A6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6086482DA;
	Mon,  4 Mar 2024 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRimCEW3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E1D45BFD;
	Mon,  4 Mar 2024 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567427; cv=none; b=jDhq2EAw0+pr/0vMORD731Rl4nIX7lYdi/595y6bcc8RgjmPwWSjKyDCO56LDLBtLyLFABDucx+7BopBLyHqOgjmIlAwdQoRXhM4GgelaUc6ZuoRGDXLP9GiOx2K3A29jnzxRQk3nWzN2J/OjV3c2OBt22qVevjn1QV/f4Vuvqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567427; c=relaxed/simple;
	bh=wlqZ5WQ/dxPPrl/h6+AO78c+TduyB6DGNUpNUGSxus4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xx+i2t356N6WLGSdc8WvL1RS9zBvLqwDZNWsQj1K6Q5DEvVSLV2faN3XKTg9Ia/HvuSCjweMJlVMa7WmWhHPXHgby37KCBe5rrkoNbvxcSk2Yot97goqDqFwf0oiLgJeH/pfG0Gfa2S0VvZFXZWMVbTTxPNV3CO7ZCxNFUJn+M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRimCEW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298F4C43399;
	Mon,  4 Mar 2024 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709567426;
	bh=wlqZ5WQ/dxPPrl/h6+AO78c+TduyB6DGNUpNUGSxus4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TRimCEW3/+jtrrcSRbPpUgzRs23Q/HCsO9K743eBCPPMqCY16lgirDsgWlLchG2Ja
	 U0mTVIdEGAhgT0RuiuXuLMNVrYEXfNdOz2i7nNWdMHfMjCD1nHAydEPgnYmDa8fp0m
	 p5nn20vVXKDousRjRGoWMuq9ef/3xOsWtp1MKQM+DId3wpCZlFWfUM27DUq/UZa+KZ
	 Q5TQtpmo0paqGfwb0ToljnuKIMtxVUOcUiZYPc12pwn4h+/S+soN24u0O+U9k8/3Zr
	 D8d3XNi01fWK9PaUnBFj2FyfNbGOp7pBxpW4rzf9e4+AOWGSlw17GQSQlqeJfr6Su4
	 dDSfzX9QsJuHA==
Date: Mon, 4 Mar 2024 15:50:21 +0000
From: Simon Horman <horms@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, lars.povlsen@microchip.com,
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com, bjarni.jonasson@microchip.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: sparx5: Fix use after free inside
 sparx5_del_mact_entry
Message-ID: <20240304155021.GH403078@kernel.org>
References: <20240301080608.3053468-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301080608.3053468-1-horatiu.vultur@microchip.com>

On Fri, Mar 01, 2024 at 09:06:08AM +0100, Horatiu Vultur wrote:
> Based on the static analyzis of the code it looks like when an entry
> from the MAC table was removed, the entry was still used after being
> freed. More precise the vid of the mac_entry was used after calling
> devm_kfree on the mac_entry.
> The fix consists in first using the vid of the mac_entry to delete the
> entry from the HW and after that to free it.
> 
> Fixes: b37a1bae742f ("net: sparx5: add mactable support")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>


