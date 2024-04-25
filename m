Return-Path: <linux-kernel+bounces-158855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 803968B25D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3FF2824B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE3514D2B1;
	Thu, 25 Apr 2024 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PH4IDFhj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87D714D29C;
	Thu, 25 Apr 2024 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060732; cv=none; b=fI5WbiFeyKtjl/w0lw0NUegIRAmLEo6ZIz1mgacE1mSBjsrj/UO4btM9Z8VsMpjMRb1u4wfISGdWDQtprFd1I4amQ33+GgybBdMVE+5QAjKkb+2wIOQFnQ66eyB0poom3PiSoZLYWpPyJUKgYobmEIcCOHCpqcc/RDG3sXO1VLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060732; c=relaxed/simple;
	bh=YYdsZZbDf0uQAsXcaRfqvezdgx2X+zgwj12LUKvIeNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZat7yOtZHuH/dbqtAiwuCKzm1bOAi9tlVDynVYljHo4gOiq3te7fC7j0EazzxxBZfldxEpQ1nmv3seWC6xglidfE5AC5QngxPCqyv32LkKdpgKrRusTq/cUOA86QapkUOyG4apsdwQairabOl2IoqAWTJExza55SLsE/fDH2io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PH4IDFhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C51DC113CC;
	Thu, 25 Apr 2024 15:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714060732;
	bh=YYdsZZbDf0uQAsXcaRfqvezdgx2X+zgwj12LUKvIeNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PH4IDFhjSzZYQ+XALybeigvADap8feq7Bi03/34DmyNcNZ51MieycxnwUgIjPh83R
	 LHgBESNlAzZUkYBmUPKwcqs5buT/lBMZrCPWVvOoWnrtKp/bOOtPnadWrRK+lOpK91
	 m0s7w5EYTpg5JwkRYvBScK8iFa8e22QMO/9BxxcEKEf2knXvbdliNWNiXhwzQafdYb
	 3ExkwuWohaklyhLZUx2zxHrvtkHr7bGHH9alYKsTxBz43E0K3oG/uej6duRIUkhIbN
	 BFiVBJUnCWFVt2OxlIT/ZWK/8p4c1TGKQ8/B+w3y+WxLwUqgKsVQqDjZP/CJ1bcEsh
	 39gqJcDvBdf4A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s01Uq-000000004z4-2pvz;
	Thu, 25 Apr 2024 17:58:52 +0200
Date: Thu, 25 Apr 2024 17:58:52 +0200
From: Johan Hovold <johan@kernel.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Doug Anderson <dianders@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] Bluetooth: qca: fix invalid device address check
Message-ID: <Zip9vMHa2x-uW-pf@hovoldconsulting.com>
References: <20240416091509.19995-1-johan+linaro@kernel.org>
 <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com>
 <Zid6lfQMlDp3HQ67@hovoldconsulting.com>
 <CAD=FV=XoBwYmYGTdFNYMtJRnm6VAGf+-wq-ODVkxQqN3XeVHBw@mail.gmail.com>
 <ZioW9IDT7B4sas4l@hovoldconsulting.com>
 <c9ea5867-2db2-4f64-a1e3-f6c2836dd45d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9ea5867-2db2-4f64-a1e3-f6c2836dd45d@quicinc.com>

Hi Janaki,

On Thu, Apr 25, 2024 at 08:31:50PM +0530, Janaki Ramaiah Thota wrote:

> Apologies for the delay. As of now, we have observed the following
> values in the upstream firmware files for default BD addresses.
> We will confirm ASAP if there are any changes.
> 
> ---------------------------------------------------------
> |   BDA	             |      Chipset		        |
> ---------------------------------------------------------	
> | 20 00 00 10 80 39  |	WCN3988 with ROM Version 0x0200	|
> ---------------------------------------------------------	
> | 00 08 74 12 80 39  |  WCN3988 with ROM Version 0x0201	|
> ---------------------------------------------------------	
> | 00 07 64 21 90 39  |  WCN3990			        |
> ---------------------------------------------------------

Thanks a lot for these. I see now that the default Trogdor address Doug
reported (39:98:00:00:5a:ad) appears to comes from the fw too:

	$ od -x crnv32.bin | grep 5aad

	0000020 0000 0000 5aad 0000 3998 0008 0008 0000

which means that patch I sent this morning should be all that is needed
for those machines at least.

Can you please confirm that all the WCN39xx have OTP storage for an
address that an OEM can choose to use?

If that's not the case then we could simplify things by always marking
their addresses as invalid, but I assume that they all have address
storage.

Johan

