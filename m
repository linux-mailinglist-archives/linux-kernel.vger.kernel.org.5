Return-Path: <linux-kernel+bounces-101604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD5E87A93E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A13F3B2169A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A91547A5D;
	Wed, 13 Mar 2024 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWtH5jcO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFE359B6A;
	Wed, 13 Mar 2024 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338966; cv=none; b=ZuDmQu5zTeuU9ygR6PUPW0znmj44bm+7aB+8OpnDpubZX1V9yle6zhvT+bwJx21Ry9BV25xttDqT0xrcBcjkFjHrs2Dr7rb9hZeDvdnhsSTO1TgqlpMncXUFTAw2x61Mm59zF9Z8TdVKye36kmKR9y34vnEALI0OiBKztzTU/wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338966; c=relaxed/simple;
	bh=dvw3ivlsqICd8d+CZLX/i5bIeLkieb1tVfglGT0YbIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCTUZaHbfRJzhSlJWlDcPUyhjluxiUZzEJF5O5Tw5QgbnhCoZ6oGH0PfcEZIRg6G1+EJkX0Uq5g8ralu1f6/TT0eZRek98zF/102fE0NS6zoRXYjcVSZAJrY/XbPYpnWnXAD656XsOVGHPLaj0lCXb7bi9KiuIjq8Pd4IpY7zjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWtH5jcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C37BC433F1;
	Wed, 13 Mar 2024 14:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710338965;
	bh=dvw3ivlsqICd8d+CZLX/i5bIeLkieb1tVfglGT0YbIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UWtH5jcObQlkjOslGBPx4iwqH3Lqelf9xYXhJLNAAqMr9ToVkChO0GNj3uMAN7qRH
	 JbFzA7QH+8QWbXMNUxKBK9lXuQG4ZfZqaoeWZKCeWyvlSJxevNxv41gsEB6A+OBU94
	 TnZAUGhmuc8O0v7MMU4IrnGz3JY5bCkf73bqHp8LE7fa6430LU3xhpyG6xfbNoOnBG
	 JgDUk1qZ01H2TPWDAmhraimTdnQxMSkMY8hCYufRHBTtkAfnPiIUkROgHbD1eaQTwe
	 cJUpSglp+Z6LcKcSx+xhcSh0wdmmOH2Ff38PticIHmQndciWAUBF714/ZrNIiJq20L
	 PlZKsefEIJOxw==
Date: Wed, 13 Mar 2024 07:09:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Ignat Korchagin <ignat@cloudflare.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-team@cloudflare.com>
Subject: Re: [PATCH net v2 2/2] selftests: net: veth: test the ability to
 independently manipulate GRO and XDP
Message-ID: <20240313070924.26416c37@kernel.org>
In-Reply-To: <ZfGyJMSWbZCqqFlM@localhost.localdomain>
References: <20240312160551.73184-1-ignat@cloudflare.com>
	<20240312160551.73184-3-ignat@cloudflare.com>
	<ZfGN6RTBCbEm6uSO@localhost.localdomain>
	<20240313065725.46a50ea8@kernel.org>
	<ZfGyJMSWbZCqqFlM@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 15:03:16 +0100 Michal Kubiak wrote:
> > > Missing "Fixes" tag for the patch targeted to the "net" tree.  
> > 
> > it's adjusting a selftest, I don't think we need a Fixes tag for that  
> 
> OK, sorry! My mistake, then.

No worries, it's pretty subjective. And the patchwork check for
the Fixes tag doesn't do a great job on the corner cases either :(

