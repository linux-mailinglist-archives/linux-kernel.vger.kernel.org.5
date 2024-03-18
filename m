Return-Path: <linux-kernel+bounces-105862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A052D87E5A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0B228128D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AC52C1AA;
	Mon, 18 Mar 2024 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ds2bBwb/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F3B28E26;
	Mon, 18 Mar 2024 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753878; cv=none; b=W5tHVfJR1XPzRcuCCVLpLTXKAMlA28AUaXy/rUIsbcRme/GlLcHpOkZ2XGWdYojrTZ7yn/J/VeAVyJhi5VyyD+jSgGMRLPZVJj1XG9LlaSZWsCcZht84RjENmAkn+ae7vYbzufQ9rqaEbb8y3Dzso8twbpWk4hap3GFWbYqumw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753878; c=relaxed/simple;
	bh=f4u7gfvz9oytKQulL4eGifX9xLIjGt5Zzac7xAxZyw4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=m+qC643688xo+1IAT8RnoX2dhVN1CqyKHG9JXK/qAND5CXc6/4ngZA3vAupDhRQUxRvda4yaJUIOXd28IqkrM5FqkhARUZy0O1NmqvcEw1g/lOzVoA/5AKGc4rmXNf06VhbQ/ewyqpXATdB/mXwEHzqgTvaXXw53qbE9SrB+xC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ds2bBwb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4A4C433C7;
	Mon, 18 Mar 2024 09:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710753878;
	bh=f4u7gfvz9oytKQulL4eGifX9xLIjGt5Zzac7xAxZyw4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ds2bBwb/Yn+36mwDpqNfcpYJH/v8PZsTeHqCdx3Zq+gs8vrgrsx9tLunIgkYgdpbY
	 /8y8IFwF5Ypkrzz9z9Y4waF4uCoTssTKN0jaSmowgTOguq/HRiae4G1Go7Z55mT24f
	 W56C0U8YOvzccAJNEh0cMLgkNHiJIYeh9Sy/W3nZkTM/FPHfIboTKXpbDI3wQyq9cc
	 6EpwfSnGKDwg1VJ9AUNqAi+/8RD2ysT8khL9zuC934WzlirDsq5GaroFcZ0Fv48BfQ
	 uBA1O7geZTeehhfLA0TG/nwIazP+LbIgKDzXUN4TZRzKJfWYFiyDUpXOthMWfDHMr/
	 K78pwphMme5Xg==
From: Kalle Valo <kvalo@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: briannorris@chromium.org,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  David Lin <yu-hao.lin@nxp.com>,
  tsung-hsien.hsieh@nxp.com,  rafael.beims@toradex.com,  Francesco Dolcini
 <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host mlme
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
	<20240315094927.GA6624@francesco-nb>
Date: Mon, 18 Mar 2024 11:24:34 +0200
In-Reply-To: <20240315094927.GA6624@francesco-nb> (Francesco Dolcini's message
	of "Fri, 15 Mar 2024 10:49:27 +0100")
Message-ID: <878r2fevu5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Francesco Dolcini <francesco@dolcini.it> writes:

> Hello Brian (and Kalle),
>
> On Wed, Mar 06, 2024 at 10:00:51AM +0800, David Lin wrote:
>> This series add host based MLME support to the mwifiex driver, this
>> enables WPA3 support in both client and AP mode.
>
> What's your plan for this series? I know you raised some concern when
> this started months ago and I'd love to know if there is something that
> would need to be addressed to move forward here.

Based on the history of this patchset I am a bit concerned if these
patches break existing setups. I'm sure Brian will look at that in
detail but more test results from different setups we have the better.

> p.s. I'm aware we are in the middle of the Linux merge window and
> nothing will happen till it closes.

BTW, thanks to some for-next branch trickery, we keep wireless-next open
also during merge windows. This is to avoid unnecessarily stopping the
development.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

