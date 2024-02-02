Return-Path: <linux-kernel+bounces-50683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54815847C87
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46ADB1C2405B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EF9126F13;
	Fri,  2 Feb 2024 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boSTt5Zf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5771E876
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 22:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914181; cv=none; b=V2NJ/MFa42zd+AKUszXL4KeO6ZzX67fLdSZhedr/coFLSLiA5SqnkSkW4RvygUlB4WEleiOsy4KzMtj4Px8zlzT23NSnpzBBHTAyMHUjNylHa/ceAwlwT7narFZJ7tDRhakRr2pOBwcZArv7M8lO37Eoz9CD5J7UMByEZq5MKhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914181; c=relaxed/simple;
	bh=XeSblRB42/YZlnp1E9dabRYvXz9IdEs8lmOUxmmzrv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1rjW/a+vzKWm0XPm/VJZdh8X5Da5QJpfdaLr8v8EopjDesohu3nswgD9ReyWs4OAcIJUzv2EDy5BsBdlbb0cZvAbKrYRb3VR0jf9kXX5HpcJTLnK1oaQ+reVSbNRUbq1rR/78Mmh/h6nXxxEzw9kOwmVFo+ZGqd50ThSbs4URA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boSTt5Zf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14372C433F1;
	Fri,  2 Feb 2024 22:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706914181;
	bh=XeSblRB42/YZlnp1E9dabRYvXz9IdEs8lmOUxmmzrv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=boSTt5ZfXfEhnNFa36YvwU7Nzq7lj32vsfw5RxaSyX34RDQ9ifG4x0K2YrUBqBex4
	 +NqlnDTi0OBRs9rYZu+I5xznmrg3ttkn/6WJVN9BI2iTaI+ITK91rSLnlggH8sC1mQ
	 ePWg/G8jdeEDP+LfGyRfX9AKc2SdJ5LE7PiIXR4fXdIAkK7PkuMaxJ5R3DkGGyD+Vf
	 mgMzTXzk5Vf8ZhGaoIShF40ohMmw+W5YmIBlAksq4GrZj3hMd7sWybiX/sS4OdYgYS
	 QwEV3MIYJ0VfBSpzzWgpcFZT98JLsBeYf/hw7qyTl5AL+LiHjZMnuKGVVP0FAlSO0Y
	 3zQG5wrTVBybA==
Date: Fri, 2 Feb 2024 14:49:39 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] riscv: lib: Introduce has_fast_misaligned_access
 function
Message-ID: <20240202224939.GA2055@sol.localdomain>
References: <20240201-disable_misaligned_probe_config-v2-0-77c368bed7b2@rivosinc.com>
 <20240201-disable_misaligned_probe_config-v2-1-77c368bed7b2@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-disable_misaligned_probe_config-v2-1-77c368bed7b2@rivosinc.com>

On Thu, Feb 01, 2024 at 03:30:45PM -0800, Charlie Jenkins wrote:
> -	if (((unsigned long)buff & OFFSET_MASK) == 0)
> +	if (has_fast_misaligned_accesses() || (((unsigned long)buff & OFFSET_MASK) == 0b101))
>  		return do_csum_no_alignment(buff, len);

Why did the 0 change into 0b101?

- Eric

