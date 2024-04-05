Return-Path: <linux-kernel+bounces-132739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EE7899977
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BEB2827C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B115160781;
	Fri,  5 Apr 2024 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="viEqF5xd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCA615FD0E;
	Fri,  5 Apr 2024 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309471; cv=none; b=t8H5YVJKO15rVOuakHutkfU5I+VC/O6NyljVa6aFnOVcygmz9jlWgiBwrBFaehDNKpPgSJ4GNodpWz1tljVAwzSIITRwrSrzSeX80nRTiZzJnp0HBQPtwvZkP+g532pnGJ1/UQ9uMDtKLcT0tZzAC3tsWUQQq+DuL/nDynpaMxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309471; c=relaxed/simple;
	bh=dniDo1sgdOQm6zM+x1ikpEN80wVJ/lI9EmhvdFyMQgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8Yh6CWXn7WwlrkrorJfx2rgAFxknQM19k984vcawPO0nAzGMNiQsn66qTp8Lqio9npl3TJ5m/rKU74sp4zf/hP10ZmoT/Nijn/YYWCxr76GEPLCujWPxkKxfI0hmHUTaGcioL5IIziz4n2rq3nIKrCRTM7hsVlx3+3HtjKbQ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=viEqF5xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FB4C433C7;
	Fri,  5 Apr 2024 09:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712309471;
	bh=dniDo1sgdOQm6zM+x1ikpEN80wVJ/lI9EmhvdFyMQgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=viEqF5xdgfl9pZw9Cwi6Hy70edGzutsbRA2EkRjIWSaoxi6FyggXT5v5H5C4W/fP8
	 M732pM1o2NYA4lGUaKJ1Mm7Xy2cgs7+o305XZf7WPm68N59ifQHN3LsjPZd2ENlcFP
	 LqpZHtZZyPQgvAh4GQfotxbQHcn4Iji3FhJfUmWU=
Date: Fri, 5 Apr 2024 11:31:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
Cc: stable@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, x86@kernel.org, hpa@zytor.com,
	linux-kernel@vger.kernel.org, ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	Pu Wen <puwen@hygon.cn>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v5.10] x86/srso: Add SRSO mitigation for Hygon processors
Message-ID: <2024040559-vascular-silenced-8786@gregkh>
References: <20240402084809.82243-1-ashwin.kamat@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402084809.82243-1-ashwin.kamat@broadcom.com>

On Tue, Apr 02, 2024 at 02:18:09PM +0530, Ashwin Dayanand Kamat wrote:
> From: Pu Wen <puwen@hygon.cn>
> 
> [Upstream commit a5ef7d68cea1344cf524f04981c2b3f80bedbb0d]
> 
> Add mitigation for the speculative return stack overflow vulnerability
> which exists on Hygon processors too.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/r/tencent_4A14812842F104E93AA722EC939483CEFF05@qq.com
> Signed-off-by: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>

Now queued up, thanks.

greg k-h

