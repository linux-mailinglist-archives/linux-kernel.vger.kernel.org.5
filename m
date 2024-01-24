Return-Path: <linux-kernel+bounces-37503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4230C83B0FD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91EA2820D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82BC12BEAB;
	Wed, 24 Jan 2024 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WfqY8RNk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3A012BE8F;
	Wed, 24 Jan 2024 18:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120490; cv=none; b=DBfiiZ92dz3CPMsgiPZ5+8AOeV4c9g1K+2wEWZDRTGeqpOZyufDKXMxMYcuwzE1R9FeJNbGaz0fis7mO6zWCa2V/IOFmQ+ZtaPKx527Bih4Vn+ygmQdWY5xiuMG+TuQ2v114hPTnbTRTXhMkHl2rJk/IY7O70IcQAzmqL7ipeo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120490; c=relaxed/simple;
	bh=bAOqor9jVDIe2ro9v+Dr8T0G8/kwV2eE4vt8giEW+18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8d1hCyBk8JcppwfBiXXBlFpEuTsj0OpxSEjtDNxtUmUnTpdriOgsnM4ysti0Ebd+09HFrNRfEDKJmO47ofInL+mDcW4cs0vSfn/RgGendRC9bbaLyxI1dOasit9j7u8XKb02wPwaoSy4CJlO/uJhW3KPmUZXijJa6lOmS1XRO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WfqY8RNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B09CC433C7;
	Wed, 24 Jan 2024 18:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706120489;
	bh=bAOqor9jVDIe2ro9v+Dr8T0G8/kwV2eE4vt8giEW+18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WfqY8RNkir20TGHJefjyezhrPNuWOSUmRZVTXPG7Upa9L51rybqgd+LVIm5yvDeHg
	 XkJB20mTbrsf3evvzwVd/0ZjkCPO1nKNUY4YcWltfBtTeiFgTgWCzm87I249kT8r1w
	 mVwIqdZS007u9zlmFwH+TSuuML1uah6KHkNOAi3Y=
Date: Wed, 24 Jan 2024 10:21:18 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-staging@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] staging: Remove EMMA Mobile USB Gadget and board
 staging support
Message-ID: <2024012406-handgun-mutation-86d0@gregkh>
References: <cover.1705932585.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1705932585.git.geert+renesas@glider.be>

On Mon, Jan 22, 2024 at 03:24:29PM +0100, Geert Uytterhoeven wrote:
> 	Hi Greg,
> 
> Board staging was introduced to host temporarily legacy board support
> for platforms that are under active conversion to DT.  Currently it
> hosts:
>   1. USB Gadget support for the Kyoto Microcomputer Co. KZM-A9-Dual
>      (KZM9D) development board,
>   2. Display support for the Atmark Techno Armadillo-800-EVA development
>      board.
> 
> During the last few years, the KZM9D development board didn't receive
> much love.  Also, no one really cared about the EMMA Mobile USB Gadget
> driver, which is also hosted under staging.  Recently, the SH-Mobile
> LCDC DRM driver and Armadillo-800-EVA display support have been
> converted to DT.
> 
> Hence this patch series removes all board staging support, together with
> the now unused EMMA Mobile USB Gadget driver.
> 
> Changes compared to v1:
>   - Drop RFC, widen audience,
>   - Drop EMMA Mobile EV2 clkdev registration patch (merged),
>   - Add Acked-by,
>   - Remove Armadillo-800-EVA and core board staging code, too.
> 
> Thanks!
> 
> [1] "[PATCH/RFC 0/3] Remove KZM9D board staging support"
>     https://lore.kernel.org/all/cover.1686325857.git.geert+renesas@glider.be/

Nice, thanks for this, all now queued up.

greg k-h

