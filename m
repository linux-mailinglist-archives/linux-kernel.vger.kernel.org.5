Return-Path: <linux-kernel+bounces-45759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 026978435E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3537F1C25AB9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A523C3D98A;
	Wed, 31 Jan 2024 05:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gV37/hIF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D513D550;
	Wed, 31 Jan 2024 05:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706677862; cv=none; b=Jitu8CVRFckuDHIW95uERzjdo5Aos5qRWkIShfReFJmU1rBIhauTgpVpb8E6L/QQM35yArY4DHRx0IS5BzKBMSgAJyScJn3kd85jgYO5WpEMGx5dzhyO7T1eU9Uu/up16H+ASd0fugFssQfa1nUB7zlIScmgkgwHpT3pXUAtjro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706677862; c=relaxed/simple;
	bh=xrcGrwHhitnih9E8v9UQ+w1w2AvDKYiVY78bIEM1OfU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=U2LMKTyu0ujFnnLKeo3c7T6Thai9c9PvpPF7gldfHiqj9LL5Kh3gDcXn9qQHmZjY4mtRnID+5c3J5Wyu73NF/mW/mH4RhASv9cPY59GLl9F0v7fPiXCGn160rzk5E+4TLiRhhCXoE9X49tLknfHruO72Wwh1mJUHPvBIBurUBus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gV37/hIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B728C433F1;
	Wed, 31 Jan 2024 05:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706677861;
	bh=xrcGrwHhitnih9E8v9UQ+w1w2AvDKYiVY78bIEM1OfU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=gV37/hIFfWJQ2Y6bf0lACNqLo0bKasPahlBztYPNgvksqUGAX8CgQq99fvvn91Cvw
	 JYbKYeRH6cuFoeDzc7WhJ2CoCe0rJXAFaDvU2PrLBeAkBDbq02x9yorLAVZXhWC9yA
	 XfEQWvQTKz0QSHWaQujfvHmytIr9spTbtx1Iif8a1RkhszgeFABGbvUrMa1GD1FtU4
	 QwyhgLjQmtRSGen9pFqqAvdHtJpAjSQfHaDGRYlUE9cKEDw48GpV5yhTqkBQb12/xR
	 f/fVcG4h8LJ9EMqdGisIE1qoKJ6uXXoMkxvZFZWNqqUdDpgZzbGeWVzKHZdai80qXg
	 sy0N9UpvdOlMg==
From: Kalle Valo <kvalo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>,  davem@davemloft.net,
  pabeni@redhat.com,  edumazet@google.com,  dsahern@kernel.org,
  weiwan@google.com,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  horms@kernel.org,  andrew@lunn.ch,
  leit@fb.com,  Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>,  Kees
 Cook <keescook@chromium.org>,  Johannes Berg <johannes.berg@intel.com>,
  Emmanuel Grumbach <emmanuel.grumbach@intel.com>,  Justin Stitt
 <justinstitt@google.com>,  Li Zetao <lizetao1@huawei.com>,  Francois
 Romieu <romieu@fr.zoreil.com>,  Rob Herring <robh@kernel.org>,  Marc
 Kleine-Budde <mkl@pengutronix.de>,  Ruan Jinjie <ruanjinjie@huawei.com>,
  linux-wireless@vger.kernel.org (open list:TI WILINK WIRELESS DRIVERS)
Subject: Re: [PATCH net 1/9] wifi: fill in MODULE_DESCRIPTION()s for wlcore
References: <20240130104243.3025393-2-leitao@debian.org>
	<170662101207.2289851.7564186430529596261.kvalo@kernel.org>
	<20240130181435.13f6e2cc@kernel.org>
Date: Wed, 31 Jan 2024 07:10:54 +0200
In-Reply-To: <20240130181435.13f6e2cc@kernel.org> (Jakub Kicinski's message of
	"Tue, 30 Jan 2024 18:14:35 -0800")
Message-ID: <87y1c6uly9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 30 Jan 2024 13:23:34 +0000 (UTC) Kalle Valo wrote:
>> > W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
>> > Add descriptions to the TI WLAN wlcore drivers.
>> > 
>> > Signed-off-by: Breno Leitao <leitao@debian.org>  
>> 
>> These patches go to wireless-next, not net. But no need to resend because of this.
>
> FWIW I've been taking these thru net (or wireless in your case)
> rather than the -next tree. There's zero chance of regression
> here and the warnings are annoying. But up to you.

Good point, I'll take them to wireless. Thanks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

