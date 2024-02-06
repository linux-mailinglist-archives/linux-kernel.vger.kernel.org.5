Return-Path: <linux-kernel+bounces-55115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507A584B7F1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2ECF1F26790
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CA94B5CD;
	Tue,  6 Feb 2024 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hp0qlIpq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D911E866;
	Tue,  6 Feb 2024 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229917; cv=none; b=JtfM4KbTmr1oKB1yqqW2tLIEcjmKi0mIQtgkUiRpI6kZSpzBQo3Y7QFXvCkpibIpOgkdR/lwWM9RdxSK2DuJmBsYYNDgYM9xhnuUcmSXOB2fOLuB2cFkujnNWDfwz+Ppo1AcOidOnOOxPoErng9gqP/7iagWq6lDGyzyc4aXvNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229917; c=relaxed/simple;
	bh=aEt/V2OZH7efYZxHVX0OSsx7A33Zpr5Q4epy53wq8hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVD3Aq46zGCB8vUbzJC4x6JK57cdDK0d0YrOGQwjJDEQ/3r0LqqdrssrGc7ZdGXf2F28kIZGQLB0qZLRWoy4jyJ4u4jDWYMK/IhAE6BbynERDKjZLXFMGtMTq/uZ8SOr1zjvpnv3FqiEbgnembJ85DNUPYcUFrWpymMV7Ok5Xh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hp0qlIpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6C2C433F1;
	Tue,  6 Feb 2024 14:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707229917;
	bh=aEt/V2OZH7efYZxHVX0OSsx7A33Zpr5Q4epy53wq8hE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hp0qlIpq1DVLQi2q+Xc/hwYGFU2DaMwn+PgQMcIZ00eR3thyNofOGvNiPlpbiGupv
	 3kikZk8y8CiL5K3dzAYTYsnXlYE84TdSJK0F2E4sWyRMpYXXmqBxlzNoHAZsmCWUrh
	 0k7ZISpNBVe379I4S1OFwN+1N9JWo7gM/ukIbGU0y/LF+fgFOM/2vsacBWMLO/8NbR
	 bfMJDFJTTCzK/3GI19c3F+/voK3hFWTvZ0zJ1P1xgDWNpZFvuTMhYM6OmDEGtsMnMy
	 qsLBbxOqs5NzF7VrBanAUdBr5PLEWBAx9aDrYcJlUdQ5ozfZQyXwf/2jzysXYYEXzo
	 BiiEDqvchbMOQ==
Date: Tue, 6 Feb 2024 14:30:23 +0000
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: krzysztof.kozlowski@linaro.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nfc: hci: Introduce nfc_llc_del_engine() to
 reduce code duplication
Message-ID: <20240206143023.GB1104779@kernel.org>
References: <cover.1706946099.git.christophe.jaillet@wanadoo.fr>
 <6d9a8544b923d92defdf2ab1b9092004cc7b51f1.1706946099.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d9a8544b923d92defdf2ab1b9092004cc7b51f1.1706946099.git.christophe.jaillet@wanadoo.fr>

On Sat, Feb 03, 2024 at 08:51:03AM +0100, Christophe JAILLET wrote:
> Add a new helper to avoid code duplication between nfc_llc_exit() and
> nfc_llc_unregister().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <horms@kernel.org>


