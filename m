Return-Path: <linux-kernel+bounces-47340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7CB844CAF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B522A1E9E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484C33B794;
	Wed, 31 Jan 2024 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHYtI09U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3464655F;
	Wed, 31 Jan 2024 23:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742488; cv=none; b=tKGgzxM6cRHUAmL9T/4fpJvicHr3XQaHYjFLUn/pjMVOzBVoKMnmarvcsJGOr54NCmXBX/Rr6yMTG/v23Gh8bD9fxOzFf9VZtjxFHpaB/CI6wiZLPH6CLx3htUE269kKgsAzNJbk7p4oBJcAkiWvY8q3Lf0ulL/vZkFnVhU9Ocs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742488; c=relaxed/simple;
	bh=146G6LfzA0wSxxyMWUaSwDQCMGOdwZna8K591J5YPx4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K45Uy7HrtIIPhmgcVSqnuLscbgIHpVjUKL6AfYNnCyHkrNBaxSOJLI9ATg8JyhF7TJtSItgWLqb3wNqFf/2ZcTdrhgkyN30UhLbPr9VUxsXHqYc48U1nuhLpj7RvQcPogoRFQOrHKY68kDJQf6f2Q/mYHgOrb4q6QTw+2Sfs7c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHYtI09U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0C8C433C7;
	Wed, 31 Jan 2024 23:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742487;
	bh=146G6LfzA0wSxxyMWUaSwDQCMGOdwZna8K591J5YPx4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HHYtI09UkBLzcady1Mkgr1r3aqnyQMIZ00yr7WRk3eeZxltyVQK3fzNVzwSb2BS8C
	 JP7Ir9fTMasTjW7fl785B0TMYSjzV2M4cnxYf+EFBf/N3LdVW95/Ogao8sNK4fYkW5
	 dLDjraLlo9mB3DHVEgJTC/TkHLwRZO+1/5mj+b28Zh1n0XrDHOcn9F+05sKq72n/cP
	 TJn3wGEqL7tjnnbXIiXD7BiohQeBWzq8b49ycvc99tHr+Cz7MNo25oQH9cKD6G/tAz
	 6SV+rsVi2s6BYv6ZXzjFepPrfi0SxNXsVYk4snSCQM5s/UWGzvgcQt3YWxX6f5X8gp
	 K79DxyPLXMygA==
Date: Wed, 31 Jan 2024 15:08:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RESEND] nfc: hci: Save a few bytes of memory when
 registering a 'nfc_llc' engine
Message-ID: <20240131150803.2fec5a5c@kernel.org>
In-Reply-To: <6d2b8c390907dcac2e4dc6e71f1b2db2ef8abef1.1705744530.git.christophe.jaillet@wanadoo.fr>
References: <6d2b8c390907dcac2e4dc6e71f1b2db2ef8abef1.1705744530.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jan 2024 10:58:29 +0100 Christophe JAILLET wrote:
> nfc_llc_register() calls pass a string literal as the 'name' parameter.
> 
> So kstrdup_const() can be used instead of kfree() to avoid a memory
> allocation in such cases.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

There is a kfree() call in nfc_llc_exit() that looks suspiciously
like it may also free the name.

