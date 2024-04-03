Return-Path: <linux-kernel+bounces-129530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7193896C35
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77EB11F289B3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D004B137777;
	Wed,  3 Apr 2024 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLUONVuK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E51A259C;
	Wed,  3 Apr 2024 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139901; cv=none; b=QQJDBaVj9vPyExEoOQSWkgb8kTfAo/QBWsap7rQlEJwuWMaOaiZaf8m4zCIohs03dRmTk3tL9G6JEr3FK6WoPyiEUiNFdlsY9rBlOlg9aeaySptgqpi18q+RLU8bKXD5RM1netmNEbqBDwhNmWU3bXjUiwhIZ5FFSwFtQIff0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139901; c=relaxed/simple;
	bh=i7EVMi2k6asX/CslsBvhJo87LJVDLcOCeMymckLgdy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvgA4PdR0mo++IzDafJsAUwUVYPvvsCEFHjuXcNpF2ptZLk1vnSTZf8mzJ3L28baCwXAk2APB4g7MLBUUOULRnz7NoRMYvfDyQ3TMpq5nrX8a6boX47fz3f+Rr0mazeYdFFQag9abb4bOSF9rVuAWE8N+KhIBNEffcRZI7mqpMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLUONVuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1B8C433F1;
	Wed,  3 Apr 2024 10:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712139900;
	bh=i7EVMi2k6asX/CslsBvhJo87LJVDLcOCeMymckLgdy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gLUONVuKkysU9vnwUm2raqV+9g2rbvK/nPiMr1UiwLRFR1UcsXrZNzjKpVWrMNaQ7
	 4xLCu7UAqk5O6VEd6gw3eSTrdQLoqD0XWhqL4TGCDJv7KRqVPSyfTe9ARiEXIJh7nd
	 XZGbhcZXT5lJ5jNU8XYtoWwg+UytGA83pOxlMpuAurnaYg+3ojP0N2535E4j0OMls9
	 53eoGC47pSFWS3+M4cdIxAx2GvuXb+FyrQV84XwbKLqjVYDf7wuj4lHP8pg8yEVVrj
	 AcP60S7UN1V7xxZT6wLX5Szi+WlaoKkMHupHGUZhXOb8fRp1LGcAjjDv7DVlHIZP6O
	 d8HnLNo6nFJfA==
Date: Wed, 3 Apr 2024 11:24:55 +0100
From: Simon Horman <horms@kernel.org>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Michael Chan <mchan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH net-next v3] tg3: Remove residual error handling in
 tg3_suspend
Message-ID: <20240403102455.GU26556@kernel.org>
References: <20240401191418.361747-1-kiryushin@ancud.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401191418.361747-1-kiryushin@ancud.ru>

On Mon, Apr 01, 2024 at 10:14:18PM +0300, Nikita Kiryushin wrote:
> As of now, tg3_power_down_prepare always ends with success, but
> the error handling code from former tg3_set_power_state call is still here.
> 
> This code became unreachable in commit c866b7eac073 ("tg3: Do not use
> legacy PCI power management").
> 
> Remove (now unreachable) error handling code for simplification and change
> tg3_power_down_prepare to a void function as its result is no more checked.
> 
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


