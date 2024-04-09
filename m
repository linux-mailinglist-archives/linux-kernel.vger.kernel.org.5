Return-Path: <linux-kernel+bounces-136794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5EA89D83E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9697B21833
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557AD12EBE3;
	Tue,  9 Apr 2024 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNNsbZnK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EE386AF4;
	Tue,  9 Apr 2024 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662814; cv=none; b=LI4lb5I8zbTncJ7JOdI1Fts/3ZW1LEK75AiZK3VGwHUSD2uQ23r8Jz1wWsPgp7FGsagTYijZl66BShXnahF3uCIeyBYItpNxGSw4mQT8t+9HkLd7fVyKZWiLCBqLFfzwHIODr1dAlxFmBNtvfTg7YVZzHyLwmHoBtHUzb5pZLjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662814; c=relaxed/simple;
	bh=RW86VgmMfAcJkSsLpIIwkE6YL29bSdtmFPZKlRKZqL0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=P8YQ8uGKNbWW/sng04lZfeP08D5Hyg62ftfnlnh9UtR0/w+g5KTYQUKN4HTXadZOwkIkapV9IXfp3/fz5VsnFcBgvNTUic3qQzSch6lQ2IM4IleW5JqKwUTnVzBsBQTIrAGzhn2U95tKOElK8plqBWiJhW7Qc1+PTorDiEm/mO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNNsbZnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C080C433C7;
	Tue,  9 Apr 2024 11:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712662814;
	bh=RW86VgmMfAcJkSsLpIIwkE6YL29bSdtmFPZKlRKZqL0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=cNNsbZnKiwP9ciyhq95bqBZiXTBTVFFgYSa0BH8/TOyoMtYsUYDOM8eGjT5kpXOyc
	 +WV5ZDL9ZbB6xUc9X/VydgYqxgFyGzi/W4wvyfn1o4Pf4sYEEc6LNpQn/wIr8z8+yL
	 yAUZPgv/kCrsUFZvNvgmsCsXJcUT5dlXakXCx3g7OW15HMdj5h1VRj4xo/PPkaXMKi
	 dxL2qEkqWFsd5aEhhRi5WCJEvDMlID4FvN7eMcvQ61i9uiAxgo2M3uGhfYgAcG+y7W
	 m9SolINR2DOwFgtfq079+zgmxQkVg1Y7DS3zIjow9jE+CweF+L3zZ7ExVChXTPfLqW
	 MElB5W1pVMrsA==
From: Kalle Valo <kvalo@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org,  ath11k@lists.infradead.org,
  ath10k@lists.infradead.org,  linux-wireless@vger.kernel.org,
  imitsyanko@quantenna.com,  geomatsi@gmail.com,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] wifi: Un-embed ath10k and ath11k dummy netdev
References: <20240405122123.4156104-1-leitao@debian.org>
	<87y19r264m.fsf@kernel.org> <ZhPyRHHlVot+a8Xq@gmail.com>
	<87pluz24ap.fsf@kernel.org> <ZhRGo3I57rXxsMV/@gmail.com>
	<87edbe26qe.fsf@kernel.org> <ZhUdxpnC+nMkNp+U@gmail.com>
Date: Tue, 09 Apr 2024 14:40:10 +0300
In-Reply-To: <ZhUdxpnC+nMkNp+U@gmail.com> (Breno Leitao's message of "Tue, 9
	Apr 2024 03:51:50 -0700")
Message-ID: <875xwq2291.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Breno Leitao <leitao@debian.org> writes:

> On Tue, Apr 09, 2024 at 01:03:21PM +0300, Kalle Valo wrote:
>
>> Breno Leitao <leitao@debian.org> writes:
>> 
>> >> > Reading the issue, I am afraid that freeing netdev explicitly
>> >> > (free_netdev()) might not be the best approach at the exit path.
>> >> >
>> >> > I would like to try to leverage the ->needs_free_netdev netdev
>> >> > mechanism to do the clean-up, if that makes sense. I've updated the
>> >> > ath11k patch, and I am curious if that is what we want.
>> >> >
>> >> > Would you mind testing a net patch I have, please?
>> >> >
>> >> >   https://github.com/leitao/linux/tree/wireless-dummy_v2
>> >> 
>> >> I tested this again with my WCN6855 hw2.0 x86 test box on this commit:
>> >> 
>> >> a87674ac820e wifi: ath11k: allocate dummy net_device dynamically
>> >> 
>> >> It passes my tests and doesn't crash, but I see this kmemleak warning a
>> >> lot:
>> >
>> > Thanks Kalle, that was helpful. The device is not being clean-up
>> > automatically.
>> >
>> > Chatting with Jakub, he suggested coming back to the original approach,
>> > but, adding a additional patch, at the free_netdev().
>> >
>> > Would you mind running another test, please?
>> >
>> > 	https://github.com/leitao/linux/tree/wireless-dummy_v3
>> >
>> > The branch above is basically the original branch (as in this patch
>> > series), with this additional patch:
>> >
>> > 	Author: Breno Leitao <leitao@debian.org>
>> > 	Date:   Mon Apr 8 11:37:32 2024 -0700
>> >
>> > 	    net: free_netdev: exit earlier if dummy
>> 
>> I tested with the same ath11k hardware and this one passes all my
>> (simple) ath11k tests, no issues found. I used this commit:
>> 
>> 1c10aebaa8ce net: free_netdev: exit earlier if dummy
>
> Thank you so much for the test.
>
> I will respin a v2 of this patchset with the additional patch included.

Sounds good. Feel free to add:

Tested-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

