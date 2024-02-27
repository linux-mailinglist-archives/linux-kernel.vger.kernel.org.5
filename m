Return-Path: <linux-kernel+bounces-83884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDE0869FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87746B2BE22
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478FF14A08A;
	Tue, 27 Feb 2024 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGkZAgr9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7E95102E;
	Tue, 27 Feb 2024 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060505; cv=none; b=gQ9mDZstWECWRXSvuHDybSJAUzo2rfRkohVElDlpQ58pLT2rJgPbRoK24xOonzMLnkI3OtVt+qnIlJUOaQXZc6/S802jZmoiowSUPdfzG9uWbXY+P+TvCMZMwp58P2R4F8++m2uv+Up0lwUq+fYcWMVnSrpiMy+KdGpV6YsmVQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060505; c=relaxed/simple;
	bh=o5w7oZIQE4oxT0QNjs9kj3UTnhmzFAHdqoFnmG1qGNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hg5WjitWTPjyD7NInbabPE9/Kby/FBMQ44MGCuJUFFSIbXojt+jGTvfVE8DPB4xUdv0Y8TCIJ9h/TH/8ja9CPPU4ZEwGD7VQv8uFHfkVyyfEEm50vMpXkpS4e9QATY0W7oLJeYVpagz7iVxgm4HsKP5UrsYXpIsmF1u95Z+pbmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGkZAgr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C73C433A6;
	Tue, 27 Feb 2024 19:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709060504;
	bh=o5w7oZIQE4oxT0QNjs9kj3UTnhmzFAHdqoFnmG1qGNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGkZAgr9/wxKL2073jxmP6UrqwQwsbsuPKEz1Vtu46Fh16sClttuMKFoTA3H+/MPP
	 cfxlqAiwcLmfrnP3YMKYLNxTz2qGQ+76EOCVUHJ+zD/esKLZeD15+2wsHPO7weCabQ
	 esbHMiTbXbkaGYBIQEY1bZoV4JLXEekjY7CqnKBghP30L8B/HVPIJiZRiqyyJnIAJR
	 aFDaoJeeab5kC89bA5g2SfEYno8uN0i99myh9Jo+x0VSm0jZGQTeiehf0C5w+Oz+Tt
	 aoCGONljLtB2vc2CbTeuIvhIRSTJVcot0ULySH7Ncna30CKWTgZoMdRIPWMiJ2PLm7
	 tCrV3VMZuambw==
Date: Tue, 27 Feb 2024 19:01:40 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v5 2/9] net: usb: ax88179_178a: Use linkmode
 helpers for EEE
Message-ID: <20240227190140.GK277116@kernel.org>
References: <20240226-keee-u32-cleanup-v5-0-9e7323c41c38@lunn.ch>
 <20240226-keee-u32-cleanup-v5-2-9e7323c41c38@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-keee-u32-cleanup-v5-2-9e7323c41c38@lunn.ch>

On Mon, Feb 26, 2024 at 07:29:08PM -0600, Andrew Lunn wrote:
> Make use of the existing linkmode helpers for converting PHY EEE
> register values into links modes, now that ethtool_keee uses link
> modes, rather than u32 values.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Simon Horman <horms@kernel.org>


