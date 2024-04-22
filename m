Return-Path: <linux-kernel+bounces-153433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6CB8ACE10
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838341C214D9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5CC14F9C9;
	Mon, 22 Apr 2024 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPzNy8mc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742FF14A0A5;
	Mon, 22 Apr 2024 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792049; cv=none; b=Odd3xk4YImQm1llr3SpzdrV1hRCtsJhWUxwvjiLEHP1zE/tWmFS5xkR3cMU/doCdcbhyD3CWV5MSn6bd38uif8EDRxozqz3h8NvCBOt1GuOxh84MusezZPMSPKT1wP3+VVLpyQVJ3sKWI+dRn7UHfHmLKTIqeoFsGZCah3wHMSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792049; c=relaxed/simple;
	bh=hWCwjGT5sP5+zSGORK1zGhuuRF7d0frJiwFI0KinOds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDv6MD7d8F7wCIz17WOYeKbzQjY1fbVYbWgnZfLF9ynyavJYy83dpx4tpoETXmJfnINcar777L/qu4B/LGp7eIFpgMHZsM9Yc+owSNkY+B/ieivmjhN/uQtKBYgbJ0od+cyH8ukMlfkjNBJs4I3PAETOxTvuBf0dvOAOZ81aNwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPzNy8mc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FACC2BD11;
	Mon, 22 Apr 2024 13:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713792048;
	bh=hWCwjGT5sP5+zSGORK1zGhuuRF7d0frJiwFI0KinOds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DPzNy8mcpLidbC5CUMtFoR62kMvHl3Gr7zYmWIh6fXaydq2vSxq2n3e8kbMnu0AXL
	 sSndbuevdHm9ZsCm52VwLFR4hshv3Ybb/foKHXog9DVbMbNzjkThW/G9ryxAlowPVt
	 Oq6kdbcIWmtI9Z/rD/O9XAc9wQrg0wxTHcWxW9bS74A9h0BQuTg5j0hP5dJ+4xDvd5
	 COzAQedIB63v2o/HSv1oZD9NLwdAKDUyPsqCnt4BvfzLw0pIiNJRCLR/GUYthQPnKi
	 XRUrJi5m3hDfZd0xbZcf0aCAwwfqUS9EQAnr97qy+FroWivlqvc1VUUWazPLLK9IDh
	 nU+cRYFrgUpMA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rytb9-000000005Nn-2nXU;
	Mon, 22 Apr 2024 15:20:44 +0200
Date: Mon, 22 Apr 2024 15:20:43 +0200
From: Johan Hovold <johan@kernel.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Zhengping Jiang <jiangzp@google.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Bluetooth: qca: fix NULL-deref on non-serdev setup
Message-ID: <ZiZkK4BAoqxNg7yG@hovoldconsulting.com>
References: <20240319154611.2492-1-johan+linaro@kernel.org>
 <ZiZdag8fw8H1haCb@hovoldconsulting.com>
 <438844e9-47e8-486e-9611-ae524d6974b3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438844e9-47e8-486e-9611-ae524d6974b3@quicinc.com>

On Mon, Apr 22, 2024 at 09:04:58PM +0800, quic_zijuhu wrote:
> On 4/22/2024 8:51 PM, Johan Hovold wrote:
> > On Tue, Mar 19, 2024 at 04:46:09PM +0100, Johan Hovold wrote:

> >> Johan Hovold (2):
> >>   Bluetooth: qca: fix NULL-deref on non-serdev suspend
> >>   Bluetooth: qca: fix NULL-deref on non-serdev setup
> > 
> > Could you pick these up for 6.9 or 6.10?
> > 
> > The patches are marked for stable backport and only privileged users can
> > set the N_HCI line discipline these days (even if I'm not sure about
> > pre-5.14 kernels...) so it may be fine to wait for 6.10 if you prefer.

> could you share the patch links for me to review. i can
> 't find them now

Sure, but you should bookmark lore.kernel.org in your browser as you can
search the archives there yourself:

	https://lore.kernel.org/lkml/20240319154611.2492-1-johan+linaro@kernel.org/

Johan

