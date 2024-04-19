Return-Path: <linux-kernel+bounces-150922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2279B8AA6BD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2A31F21C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039C34696;
	Fri, 19 Apr 2024 01:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pObsNj9F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42387137E;
	Fri, 19 Apr 2024 01:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713491726; cv=none; b=B9WmtbMuWlM+BQmfxQLiKwmv5Z36dBIhf3xjKWHZ4cn5+daJjMKOhDerym8heWEBqWT7JYH9AEAVnV3XEq/QWIiGkEWqU/4Pp3AOYLHX6QGRS+SkTbQCP9B+1ns4aBL4i83sOJ+j8tnsFc5gGGnaRmgMZo/XSx8aCnAAMJf73J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713491726; c=relaxed/simple;
	bh=Z1qeLBAS2VxS7zLPOdYBW2uzoW9207/K4imjfec+zbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTPea+eMssA1OsFan+Fsq3iqx5XHhhBRUiuFuTys/ypl40tu4g99PAPweRYwzP5VH7RtOXNm0auOdFdRbVIEWSN5d0Aij9lukQUT1VB+VxfXGAReXSve/H8V4P4WZnBO/qDfq7bN+IKzYBW1iIlCUUw6MJCosLP0kRKFhyiRkIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pObsNj9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F94BC113CC;
	Fri, 19 Apr 2024 01:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713491725;
	bh=Z1qeLBAS2VxS7zLPOdYBW2uzoW9207/K4imjfec+zbU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pObsNj9FOxhCLq25tTQOnDSSi8ExwVy2PQHmLz5vxb8RlNwSpA4TVEFOvVrPx6Q/D
	 ai6wI3af/nxRvsqU9uXfUs2ZbdUFZ08FhOav4KESYVv8ClUo3Cj61+OQBhJxIItFA3
	 GIl33t3PVX+zjyZn5M4jQn+xOCIiSBMTkI7ynKFsJwUQCOggQa5jdhnXxNs7LM6ZA/
	 xq5ReCgMQ3JHcZq3Fs6IC1dpDHwVtgTy9BQteddWzXHjssse4eWy2JbBBKid6h91Dz
	 aGJPKBp/isz9mI22383ds1ldlITjD+qt9pztzA0VXel6Ln2NcfqeAXkfs/DP1PgnSt
	 FiWjpFPG8H2Vw==
Date: Thu, 18 Apr 2024 18:55:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mahesh Bandewar <maheshb@google.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Richard Cochran <richardcochran@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Sagi Maimon <maimon.sagi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, John
 Stultz <jstultz@google.com>, Mahesh Bandewar <mahesh@bandewar.net>
Subject: Re: [PATCHv2 next] ptp: update gettimex64 to provide ts optionally
 in mono-raw base.
Message-ID: <20240418185524.18801983@kernel.org>
In-Reply-To: <20240418042706.1261473-1-maheshb@google.com>
References: <20240418042706.1261473-1-maheshb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2024 21:27:06 -0700 Mahesh Bandewar wrote:
> --- a/include/uapi/linux/ptp_clock.h
> +++ b/include/uapi/linux/ptp_clock.h
> @@ -157,7 +157,12 @@ struct ptp_sys_offset {
>  
>  struct ptp_sys_offset_extended {
>  	unsigned int n_samples; /* Desired number of measurements. */
> -	unsigned int rsv[3];    /* Reserved for future use. */
> +	/* The original implementation provided timestamps (always) in
> +	 * REALTIME clock-base. Since CLOCK_REALTIME is 0, adding
> +	 * clockid doesn't break backward compatibility.
> +	 */
> +	clockid_t clockid;	/* One of the supported clock-ids */
> +	unsigned int rsv[2];    /* Reserved for future use. */

This suffers from a moderate inability to build:

usr/include/linux/ptp_clock.h:164:2: error: unknown type name 'clockid_t'
  164 |         clockid_t clockid;      /* One of the supported clock-ids */
      |         ^
-- 
pw-bot: cr

