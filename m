Return-Path: <linux-kernel+bounces-64990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE809854648
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B82D1C27177
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AAF13AF3;
	Wed, 14 Feb 2024 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj5w8DIU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B3B6FC5;
	Wed, 14 Feb 2024 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903639; cv=none; b=YdXILhCG3MuXTHpt1kbtrSUBh90mNzRky81U2Um1iG+R/B6JkJlsOqNZGXrmkSg7sR3elfqAGnP1PoipeWNFMBKT7+1e5VzI29bR4bV/Ok7ZnzqBjqOGH5OpygwoQ5vXneMCS+dvcny1KV7xaW1QpxKyqqMAVeX4pdSMoA04SLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903639; c=relaxed/simple;
	bh=iu39BEEgArgD/pNVUP6vwDeca5vUUKZPOX5j4WIjVUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COjKh9F7RLaGMmDWsNx2m6iToVcCik+jelNLZyQMy0gMo/H0HAotZTvaxD8gOFH1OnqjhZRV4YS3P7uRECLW7DM+dQszL7pZcSfpk8rxqLJ3X3UYTK1A5w7HGAvA17odsjvDI6F+nY/MPtXGkoKJozowPSN1j/gqjkwZHWAmFXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lj5w8DIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CE3C43390;
	Wed, 14 Feb 2024 09:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707903638;
	bh=iu39BEEgArgD/pNVUP6vwDeca5vUUKZPOX5j4WIjVUI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lj5w8DIUPFWhiTrxSaHdTurN/Cbq6Hl0jPBlXdVqsjXiMUKaNLQV5oGnWTQvxWsGo
	 NbKg61pmsrtJWgWEYlCAP4f5mUu058q+6k0BZ1KB02/7K+rweilUolIXfrv5J2/VaN
	 4NzLOc1S+3cPrw6I7nkI/btptDIGa5ZPNfmEEOggPQPo22DD6PzCPuGCtTY7cDLZIz
	 94RwNZ5THP1hEp3z9eyJa6gdIEvnrYiX3Cjb3tSXeb0iDvS7xIxAEs21cbSc619kEA
	 Kp5ssqG5GLfHtMCIo7blpD5uuzQKTvBam0NL1uVCqbC2kyWj806Wg2jzrG0xim+msu
	 0W9WW/9Cw8gLA==
Message-ID: <6f4fe4fa-f6ce-4bf5-8354-edebf62e21fb@kernel.org>
Date: Wed, 14 Feb 2024 11:40:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] usb: dwc3-am62: add workaround for Errata i2409
Content-Language: en-US
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
 r-gunasekaran@ti.com, b-liu@ti.com, afd@ti.com, nm@ti.com, srk@ti.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
References: <20240205141221.56076-1-rogerq@kernel.org>
 <20240205141221.56076-6-rogerq@kernel.org>
 <20240211161815.GC4443@francesco-nb>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240211161815.GC4443@francesco-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/02/2024 18:18, Francesco Dolcini wrote:
> On Mon, Feb 05, 2024 at 04:12:21PM +0200, Roger Quadros wrote:
>> All AM62 devices have Errata i2409 [1] due to which
>> USB2 PHY may lock up due to short suspend.
> 
> Is there any visible log trace when we have this phy lock up situation?
> Eventually it would be nice to have this in the commit message.
> 

I have not been able to reproduce this issue here so no log trace.

-- 
cheers,
-roger

