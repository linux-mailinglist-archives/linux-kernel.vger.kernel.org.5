Return-Path: <linux-kernel+bounces-65073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D260185477B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876AB1F2155E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F3018E29;
	Wed, 14 Feb 2024 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHd1grYr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F8518C28;
	Wed, 14 Feb 2024 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907503; cv=none; b=qr3t1djgeddXY2Vwqq03R/j9Mk207jAyNmOVM898iqQZVpYBTDQza3/ZCyzZLWYnjwmpShTehIXu3kPUwrwV5kJ68Q5/OyxaBZK0mhRS1tYU8bs4zDL0m59h+Mt2l63JDpvDnIhEnXpxsJII9Tub0pzQnJesyTWa+E3k/sbk9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907503; c=relaxed/simple;
	bh=c5a5QD1qybAX8sIO7SlkwMh3DXcoPgzluORoGmCH18o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Xl8ISgZ4BfeAS+ULThSr1AosnjWt/CPhAHpl/1PYVXN0ehQ4LVNykEqwZxZQ5fZHI7ZIReynWJSqmlDNIa7Y3gAc0QzxdkF1TUDG89OQzsOzA/40l1iiyv1YFm/BukxZqOsaQYBRkB8pqsb83jq54k8tACQVRS31ef+/kVpFi8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHd1grYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F91C433F1;
	Wed, 14 Feb 2024 10:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707907502;
	bh=c5a5QD1qybAX8sIO7SlkwMh3DXcoPgzluORoGmCH18o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=MHd1grYrjnKc6N9SBwHUg+n7lvaoMgaqHzbsWY/uOvBtvyA/Sdh5GG2It2CXBgr+O
	 f6cdD473ETW5ujH6eag47aT9vAFUtzuCDz2Qo3hbR/iKNTJ/nzTfi1eDzuyMui+ma4
	 SMSV86kIPVszpaikgwZmMolujKS0mFjwrO1ZBlfpR2uNg46S5LBdN/EY/clf9ny6t/
	 w1UtIqsz3y+mk73XgXWesN6JXldOrboaDEk/OC0MDo9uacqx3ZHkVSzh9ww4X84cMk
	 KNU4hDcT6ApwBbp0wc6VQdixjI1QQ5UdladLXqrjxpiYZHjQ5XLKeZg98BIMBPUvZc
	 TEhhP98yNTKZw==
From: Kalle Valo <kvalo@kernel.org>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Arnd Bergmann" <arnd@kernel.org>,  "Jeff Johnson"
 <quic_jjohnson@quicinc.com>,  "Karthikeyan Periyasamy"
 <quic_periyasa@quicinc.com>,  "Aloka Dixit" <quic_alokad@quicinc.com>,
  "Wen Gong" <quic_wgong@quicinc.com>,  "Muna Sinada"
 <quic_msinada@quicinc.com>,  "Aditya Kumar Singh"
 <quic_adisi@quicinc.com>,  ath12k@lists.infradead.org,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: sanitize ath12k_mac_allocate() return code
References: <20240213100912.459018-1-arnd@kernel.org>
	<170790025305.3179441.138152315558305278.kvalo@kernel.org>
	<08ac32ef-610d-479d-a3fd-a3c3b8c4c697@app.fastmail.com>
Date: Wed, 14 Feb 2024 12:44:58 +0200
In-Reply-To: <08ac32ef-610d-479d-a3fd-a3c3b8c4c697@app.fastmail.com> (Arnd
	Bergmann's message of "Wed, 14 Feb 2024 11:37:52 +0100")
Message-ID: <87plwze34l.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Wed, Feb 14, 2024, at 09:44, Kalle Valo wrote:
>> Arnd Bergmann <arnd@kernel.org> wrote:
>>
>>> The return code has no initializer:
>>> 
>>> drivers/net/wireless/ath/ath12k/mac.c:8006:9: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
>>> 
>>> Make it return -ENOMEM for allocation failures and remove the unused
>>> variable instead.
>>> 
>>> Fixes: 6db6e70a17f6 ("wifi: ath12k: Introduce the container for mac80211 hw")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>
>> Nathan already fixed this:
>>
>> https://git.kernel.org/kvalo/ath/c/04edb5dc68f4
>>
>> Patch set to Rejected.
>
> Ok, sounds good. Nathan's patch looks fine to me

Great, thanks for checking.

> but I see it's not in linux-next yet as of today.

Yeah, it's a problem that ath.git is not included linux-next builds. The
commits will be in linux-next only after ath-next is pulled to
wireless-next :/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

