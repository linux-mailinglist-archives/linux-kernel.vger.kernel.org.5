Return-Path: <linux-kernel+bounces-153500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB2C8ACEC3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF374B23792
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B24152180;
	Mon, 22 Apr 2024 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+alJTfF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808AB15216C;
	Mon, 22 Apr 2024 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793898; cv=none; b=XWPLsLJjG860jEKRfuqD1EADE+2p/amBbzd9ErotHgF3e9QaKSJc/DA50HYkvD3eHY76vnGfOVGuhOEXkatIfCOg8vdwpvyAg9LAaVY4W0jJVDehNXUPQIA9m/txS061ZCAzm742yKvBD3xEGjf7qsecC+R4T1P2OwB/a5zmQ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793898; c=relaxed/simple;
	bh=DKdNSGjJABf+9HIqbf2cLZjO82kl5RLsMQ9HO4SM3vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhGlB6lGLRmhkJQD3kBJGhNrX3Je/1WAmQk/s09KmkZC5NdvkdfNtedlMGib9HLRbB0DIluKYF3R2c4zsEdSu19MuNTEjOKU69CGADCduskjWo74S5HFVP5S83Mu3HGfAeIvNfBCGd0nYVX0DdliOfbCvK+GwriyN2ltOJBcN1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+alJTfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058A2C113CC;
	Mon, 22 Apr 2024 13:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713793898;
	bh=DKdNSGjJABf+9HIqbf2cLZjO82kl5RLsMQ9HO4SM3vU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t+alJTfF123uFsolDIvyRACUxtmro7kDwWDqXoQvJnXT4kqB5lXLOxPR4ZgvEzUnC
	 8G4P3EQ3XbehTvkxVKsGM344zXlbjdVmKTacU0HbGxKmawkE9m2089W/dN34TUU437
	 bin0yOkwXKBE8+mnS/6I0uHjHXiOAArYv0FfdhR+iwA72m7dIfM9O4GJgtz25jbTMs
	 PlNe84KDiFEoqJx9RIQcLs2mIYHqMY/W70JGW7N0N0xQXGaNI276+Di6N4RTGs9QEB
	 7ljVJknAAt2/6FRoqL19f7YF7bDxgNRwokneGijFwGSIkt+2F2IIevHRPQKhKs5Yh/
	 4FMNxYXpq+zPw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1ryu4y-000000005tL-3TFo;
	Mon, 22 Apr 2024 15:51:33 +0200
Date: Mon, 22 Apr 2024 15:51:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: quic_zijuhu <quic_zijuhu@quicinc.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Zhengping Jiang <jiangzp@google.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Bluetooth: qca: fix NULL-deref on non-serdev setup
Message-ID: <ZiZrZFNLg8pyoOkB@hovoldconsulting.com>
References: <20240319154611.2492-1-johan+linaro@kernel.org>
 <ZiZdag8fw8H1haCb@hovoldconsulting.com>
 <438844e9-47e8-486e-9611-ae524d6974b3@quicinc.com>
 <ZiZkK4BAoqxNg7yG@hovoldconsulting.com>
 <CABBYNZJ1H7eEi8qsZUAxOa5HoE=xQ0wb2YFx0g7-SxxkNAS3Bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJ1H7eEi8qsZUAxOa5HoE=xQ0wb2YFx0g7-SxxkNAS3Bg@mail.gmail.com>

On Mon, Apr 22, 2024 at 09:44:59AM -0400, Luiz Augusto von Dentz wrote:
> On Mon, Apr 22, 2024 at 9:20 AM Johan Hovold <johan@kernel.org> wrote:

> >         https://lore.kernel.org/lkml/20240319154611.2492-1-johan+linaro@kernel.org/
> 
> Did you send these to linux-bluetooth? I don't see them in:
> 
> https://patchwork.kernel.org/project/bluetooth/list/

Yes, I did and they are in the linux-bluetooth archives on lore. Not
sure why they don't show up in the tracker.

Do you want me to resend?

Johan

