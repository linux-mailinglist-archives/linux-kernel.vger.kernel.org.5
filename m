Return-Path: <linux-kernel+bounces-68333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88C68578E4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A2F1F25835
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E08B1BC41;
	Fri, 16 Feb 2024 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMBtj1cn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D556B1BC22;
	Fri, 16 Feb 2024 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076051; cv=none; b=I9tQ/TT0mcoKM6mLxV24mjPYJQS5ID8vdteeEKJlhvrsWR6M7GSVlvalQ9KvxXlZDKGtT8gSwyMRi7X7nWrJqJfn6oOVV633rOA+bK6ZE7hqJo4RNOD7/k+hRtW6vIuluWJrT5SXbcyCj6jSjbeW5HQU4Rd8PulYyX08uw1a5UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076051; c=relaxed/simple;
	bh=ZzTHE2cnWVvBb/62SMWSYBMXUUIVUk+6+8TNfNJ8PNo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=hzviGT5tI4BA2+lz38iV+K6/xbVM4olSRZhOOcy/BsVtNciSBqt3g8cWvoRUP9Lk9U2awBk/4xR5MycebbzUUbgOfkiUtxZlQdug+rxYg+AOLNdA54S11xNI1FiZt4OHcA+wYQ4OtSJ/iWQlSNU2tol6tvH45cBO1DJqFW3ykNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMBtj1cn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8627C43399;
	Fri, 16 Feb 2024 09:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708076051;
	bh=ZzTHE2cnWVvBb/62SMWSYBMXUUIVUk+6+8TNfNJ8PNo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=BMBtj1cnZOaed/xrNuYPn5WSaLHbll4l2V8IJi/BfMhwwkxzkeqOcprSgRT/7MPOF
	 mf8o9CGfeOQxwAQWM+I8LuMepPWWaMa592PuAgJy68OJCH2tg0H8AphvLVC6Leur6H
	 nirn2ihkE4Fyj/qc5kpEZS/CnrHfsKIYj54EgvFe5g53pd1biIlc+bIa5y6EF04k/c
	 vGaj5fS6DA2WAJSXSs6So108SaCB+p7v7uNFtWNf4B7C1psd21Yo6eRMo33BNCn99E
	 OHloaQ8tRJiAAvHL8z4UbxL6QF1vfm0017+kCeiiOI+pb7PP4oubQEC6NCIgtfxWB5
	 A4JUxDxBUDb8A==
From: Kalle Valo <kvalo@kernel.org>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,  Ajay Singh
 <ajay.kathat@microchip.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Sergey Matyukevich <geomatsi@gmail.com>
Subject: Re: [PATCH 1/2] wifi: nl80211: force WLAN_AKM_SUITE_SAE in big
 endian in NL80211_CMD_EXTERNAL_AUTH
References: <20240215-nl80211_fix_akm_suites_endianness-v1-0-57e902632f9d@bootlin.com>
	<20240215-nl80211_fix_akm_suites_endianness-v1-1-57e902632f9d@bootlin.com>
	<87cysxekbc.fsf@kernel.org>
	<d539e013-7205-4661-9b13-b359e5bd8610@bootlin.com>
Date: Fri, 16 Feb 2024 11:34:07 +0200
In-Reply-To: <d539e013-7205-4661-9b13-b359e5bd8610@bootlin.com> ("Alexis
	=?utf-8?Q?Lothor=C3=A9=22's?= message of "Fri, 16 Feb 2024 09:21:54 +0100")
Message-ID: <87plwwda7k.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> writes:

>> Alexis, thanks so much for working on this! This has been bugging me for
>> long but never found the time to investigate it.
>
> I'm glad to help, especially since I have the corresponding hardware. This
> warning was on my radar, and your last complaint about remaining sparse w=
arnings
> in the wireless tree eventually triggered the action :)

Hah, at least there's one person who reads my complaints :)

I owe you a beer on this one, if we ever meet please remind me.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

