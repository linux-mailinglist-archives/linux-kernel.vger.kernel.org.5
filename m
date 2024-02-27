Return-Path: <linux-kernel+bounces-83569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08073869BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9891F27955
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1945E1482F5;
	Tue, 27 Feb 2024 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVt68zCU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527A854F8A;
	Tue, 27 Feb 2024 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050163; cv=none; b=jVmelDiWfV8Qb+Q7AHi2UeeA1SIQyF7zTERIFMG+44rP6BCMxrdzwza+oECMdEzSV0tb+04xjOlGBu1mcLm/Kc7m9S9EYV9iXXPWd1bbgUi3ms1KbOWBbQepvFmf7w0gCFLWacAdxVXK+OvyyPJKQZB2w3Qv3uNDJAciBuJxnDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050163; c=relaxed/simple;
	bh=MH22YmXA4bTMQ7/5kOWcmCJTkTE0LNMzDjYX1mzE/8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3P+O4L0U1Y1vbHxu6XPIIKuk9rAnSj6EoSfkmKLh/gYJPZOYItN/0XJZlFJZx+hjb66fXl2EV53ZRE8gj+T6EpaZAo3UFbMw+jASzMciMukTZJn8gzE7jVSxkl6ZnRwk8mGazEvt5KnXrfrxcurEJq40ML+Jf4o7sGGkEJFZxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVt68zCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7639C433C7;
	Tue, 27 Feb 2024 16:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709050162;
	bh=MH22YmXA4bTMQ7/5kOWcmCJTkTE0LNMzDjYX1mzE/8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bVt68zCUuOKFRbqW/jzbsgaXuVjspytrlTx2TaFMZDOJwEY8zrLzhjzu+niVnelAg
	 gQPR+xLK5jYYPUd8E1UYLnU7Fx/LUPAfcR241/z0ci9ipUvE4sd6UOfbURBdA59OEp
	 TRf2w9iKuTzwIBDAc9ylw456djOVXFN0fXlkI06+xkR1V/y64TSCva9n1sy7/6UREr
	 GXbJkGOzI+7nG8l3M1skTOn8knFklJR35yEsb2Pia6/mjk3J8RkDSEJkeWD+HlfC4g
	 KIJi47RXDz06bPTTN3kvNLjVvXe7P2CfaGCcexpYkd6oW2k2XrqHc4cGzuV8FwYiTs
	 X+saSa0AzO8pw==
Date: Tue, 27 Feb 2024 16:09:18 +0000
From: Simon Horman <horms@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Peter Korsgaard <peter@korsgaard.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: dm9601: fix wrong return value in
 dm9601_mdio_read
Message-ID: <20240227160918.GB277116@kernel.org>
References: <20240225-dm9601_ret_err-v1-1-02c1d959ea59@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225-dm9601_ret_err-v1-1-02c1d959ea59@gmail.com>

On Sun, Feb 25, 2024 at 12:20:06AM +0100, Javier Carrasco wrote:
> The MII code does not check the return value of mdio_read (among
> others), and therefore no error code should be sent. A previous fix to
> the use of an uninitialized variable propagates negative error codes,
> that might lead to wrong operations by the MII library.
> 
> An example of such issues is the use of mii_nway_restart by the dm9601
> driver. The mii_nway_restart function does not check the value returned
> by mdio_read, which in this case might be a negative number which could
> contain the exact bit the function checks (BMCR_ANENABLE = 0x1000).
> 
> Return zero in case of error, as it is common practice in users of
> mdio_read to avoid wrong uses of the return value.
> 
> Fixes: 8f8abb863fa5 ("net: usb: dm9601: fix uninitialized variable use in dm9601_mdio_read")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

I guess it would be nice if error values could be used,
but as you have described, that does not seem to be the case here.

Reviewed-by: Simon Horman <horms@kernel.org>


