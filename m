Return-Path: <linux-kernel+bounces-136614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA33F89D62D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB9C1C2341C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3172B81724;
	Tue,  9 Apr 2024 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaS3hDVH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2A280619;
	Tue,  9 Apr 2024 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657005; cv=none; b=VkpINaxxZtVlpwfjAFQ0GTfwo8+FLwcl61QUJ0p9lJIB9KoQsZ11gIRmr+6lUVx0/EQGhm38UPR8uc77OIjSRwfXuoT/7YAxCszrHA4/QPrBrvzM4RU/c7l+cKr/wyGpyu9deJX71k3s2AiF/4Vgnx7ywVsQOs9quMOXPSX8dJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657005; c=relaxed/simple;
	bh=iTNCMmIBrqKAd1ZLJrqU0oi+mUhYpPEw/iRl1+vEJFM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=n+iwzPZ9ZbwZ42WbYs2tOxg4e2oHqf/zz/aXUMNJEIZSF45NfY+pJMEqLWlEk16FuSRQeS84pSh/F2BHiYBBAZTwVMLXcCsj7MrrqwoKGfwYONxXJg+JG406KNxmVhk/adNxwMR3b3V/0HphebSfwIYITdGF6hgNaYtTl4pp/OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaS3hDVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C6CC433F1;
	Tue,  9 Apr 2024 10:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712657004;
	bh=iTNCMmIBrqKAd1ZLJrqU0oi+mUhYpPEw/iRl1+vEJFM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=CaS3hDVH0ZSF6klcFqrO4Ey1bc/QKOA07ywyZGABJzEipRFSqFG8Lp9ZluAu+PVYW
	 msvEMtYrfeQIiDeSGp3iL/bvKf8pFCOh3gI2sz1/perPxta+N1ubLmp/MHXJH2EzZC
	 TlFDXjJ5KwjWkWEpA0HM7cMk7jywfJ8Ir0R4UuAOAQCshGgdg0HImae39J7aqZMxNG
	 MuGh0G5azU7jBbpQ2dRXDUXvrVKy16FCZXv18+ZR7Dh/vz3+0s9cOdzyTu1mENJ70C
	 EpwTbekjNbVRLfdBDrXml9uXi8G2zauJCrkdjYaI4qe5j0pvKeiZPcQUeSJ5vZ+xWH
	 LctGFMmx4zI9A==
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
Date: Tue, 09 Apr 2024 13:03:21 +0300
In-Reply-To: <ZhRGo3I57rXxsMV/@gmail.com> (Breno Leitao's message of "Mon, 8
	Apr 2024 12:33:55 -0700")
Message-ID: <87edbe26qe.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Breno Leitao <leitao@debian.org> writes:

>> > Reading the issue, I am afraid that freeing netdev explicitly
>> > (free_netdev()) might not be the best approach at the exit path.
>> >
>> > I would like to try to leverage the ->needs_free_netdev netdev
>> > mechanism to do the clean-up, if that makes sense. I've updated the
>> > ath11k patch, and I am curious if that is what we want.
>> >
>> > Would you mind testing a net patch I have, please?
>> >
>> >   https://github.com/leitao/linux/tree/wireless-dummy_v2
>> 
>> I tested this again with my WCN6855 hw2.0 x86 test box on this commit:
>> 
>> a87674ac820e wifi: ath11k: allocate dummy net_device dynamically
>> 
>> It passes my tests and doesn't crash, but I see this kmemleak warning a
>> lot:
>
> Thanks Kalle, that was helpful. The device is not being clean-up
> automatically.
>
> Chatting with Jakub, he suggested coming back to the original approach,
> but, adding a additional patch, at the free_netdev().
>
> Would you mind running another test, please?
>
> 	https://github.com/leitao/linux/tree/wireless-dummy_v3
>
> The branch above is basically the original branch (as in this patch
> series), with this additional patch:
>
> 	Author: Breno Leitao <leitao@debian.org>
> 	Date:   Mon Apr 8 11:37:32 2024 -0700
>
> 	    net: free_netdev: exit earlier if dummy

I tested with the same ath11k hardware and this one passes all my
(simple) ath11k tests, no issues found. I used this commit:

1c10aebaa8ce net: free_netdev: exit earlier if dummy

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

