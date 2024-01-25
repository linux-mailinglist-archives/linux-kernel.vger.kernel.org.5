Return-Path: <linux-kernel+bounces-39051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FFB83CA42
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8369C1C25049
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FD9133409;
	Thu, 25 Jan 2024 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdHbrdAq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D71C13175A;
	Thu, 25 Jan 2024 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706204686; cv=none; b=WYLN71A4zeK5+r5LGXKbgmCwZU7PMAMKMSbypQsCqaJjgA/56Mld5oDYlnYaykkp0FBTv+lbFPmVZwGTG5eM8iE5rfbt29/0RGCz/lsqiKnAReY2G1CT6MCat7i2SOwZN25rYssDnTDRccAfoNpm0Ktz6ePbKzB0so3BMvNHL50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706204686; c=relaxed/simple;
	bh=nSGwV2wF/A1m1KK33CaJZwXh3S7H2z5bahv5KRLksB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5xGx5ZX+0O6/bHxZkJU9zs824HrbLrE2sR+kqgZOhKBo7e3MdC6sMeps87mDtwmACIy7kV1WEM2KPaZmGmhuUF1bA97NyNvOpkP/2y8D7w5ZA0rVZgube2Kc8ZZWRnj1x89CyuQedDsbT9Ip4cfIdsgsKpRprgrNsTNxg4R/0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdHbrdAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919ACC433C7;
	Thu, 25 Jan 2024 17:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706204686;
	bh=nSGwV2wF/A1m1KK33CaJZwXh3S7H2z5bahv5KRLksB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hdHbrdAqT2alPvemeu3jLjZ3JHu0DurC/s+/H7+BDLCVZu2XlCcJUwAkFFQggt+da
	 esOSKqPtpkWKLLIT3MpqAsBLhFUq3j60Z9KhNEWWyclOvHUmQ0BKC0nvU0nmOSJ6uV
	 JhKnWsQ1TcSpugkRQW/d0GcSED727DX2VAPRVojQLIq8FYzwL/9Uz+XvZM2566Wxjw
	 88+5pqSB9vthc+X28dzy1qDXADNo01L9wtAFTbqdIzEO2cc3+UsfnOJoRj+z52r0QN
	 W+Cv4xTusZZFDX59Xlka52qkepPjYweqolT9XthKdpLhDszHcAaiJeE8SB3xJxCPJN
	 44zEekVODTswg==
Date: Thu, 25 Jan 2024 09:44:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan
 <michael.chan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, gospo@broadcom.com, "open list:BROADCOM
 BNXT_EN 50 GIGABIT ETHERNET DRIVER" <netdev@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] bnxt_en: Make PTP timestamp HWRM more silent
Message-ID: <20240125094444.3185487e@kernel.org>
In-Reply-To: <CALs4sv3cpcy5G6d+3UL8dVSyN1vFbgiin8gLiVxKOfWUAAB0+Q@mail.gmail.com>
References: <20240125134104.2045573-1-leitao@debian.org>
	<CALs4sv2U+3uu1Nz0Sf9_Ya6YKxK09WU=QH4VmO94FjC3iWX3rA@mail.gmail.com>
	<ZbJ11qxfmOfRseJO@gmail.com>
	<CALs4sv3cpcy5G6d+3UL8dVSyN1vFbgiin8gLiVxKOfWUAAB0+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 20:51:25 +0530 Pavan Chebbi wrote:
> > > LGTM, however, you may still need to add a proper fixes tag.  
> >
> > Thanks. I didn't include a fix tag because it is not a fix per se, but,
> > I can easily send a v2 if this is needed.  

We should pick it as a fix. If we put it in net-next and someone
complains cherry-picking it into net would be a PITA. And we shouldn't
spew WARN()s about known-to-be-occurring conditions, GregKH is pretty
clear about that.

If you can post the Fixes tag in a reply our apply scripts should pick
it up automatically. Or at least mine will :)

