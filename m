Return-Path: <linux-kernel+bounces-45248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BC6842D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE671C2258D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5940471B4F;
	Tue, 30 Jan 2024 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=svenjoac@gmx.de header.b="uWMEorml"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5689771B32;
	Tue, 30 Jan 2024 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645741; cv=none; b=KR4BxtDRsAXoduea7gzME2PmICNhpnk0nb+FjHllF6lpbNV8EZGgPlB/R+OkaOONXi7KGt/4FUtXsTL+8dK2lxp9ugE6xDHZLo/mIEpSEtRuGEhbli6hsNSN9JVAKbdVD7pSViKNCg/HYgQ4wEQVHKVF/GDumcL06fw4O/7l+x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645741; c=relaxed/simple;
	bh=qF0LHiAbtVxxFWy/i7EP+gADimSNgL/R6tCnG0ux6K8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B+44SipOfY8YjqyivHyb6SZSN+fa2WasI7SAMe/kzElWFw8bhZPZx+U+Ln6W9z03ECtT0s7TiIvmKbXlo0jNRnxl1QTwCTp43Fjnh2N+0DsQt4JcNfZbdRQi+SSaR6ZSdrZm9KqsSCxuQwBlzG3ivk1A5nmpJfusX9dgT7GGswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=svenjoac@gmx.de header.b=uWMEorml; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706645714; x=1707250514; i=svenjoac@gmx.de;
	bh=qF0LHiAbtVxxFWy/i7EP+gADimSNgL/R6tCnG0ux6K8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:In-Reply-To:References:
	 Date;
	b=uWMEormlo9y5Z9yrFtScMh04LDQAUJr92eA1YfUDG0PnpYd7CkF3tTj3h3XgUbw7
	 IZS3xGwEZyoDYbOjQ8mXr+5aNNQSWFIH0B3QzApqjqWUC1CF0KZplKz9GkQeWvryF
	 TSDdPZjB3AYjW57F6rOz10V51XwDkMule/oiV35cB8/RZdzBh6f6ZX+jk08RfgJqj
	 fgTdps0O5o/xXP2aTFrw9asEYRGzodZOpOsxhZ1dRYp3G5T6d6OmgF8JAvsU3jSPU
	 u7HR8MjgvsG4p03K1ao4pwsfPWXwp8EcxfXfoFq0FZEA71wUtqYaxO3zpCyOuGmvV
	 /RRgqlqmT5He9/7VtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.203.86.131]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MBDnC-1rLarE0cEo-00CeKc; Tue, 30 Jan 2024 21:15:14 +0100
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 9A91D80110; Tue, 30 Jan 2024 21:15:11 +0100 (CET)
From: Sven Joachim <svenjoac@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,  patches@lists.linux.dev,
  linux-kernel@vger.kernel.org,  torvalds@linux-foundation.org,
  akpm@linux-foundation.org,  linux@roeck-us.net,  shuah@kernel.org,
  patches@kernelci.org,  lkft-triage@lists.linaro.org,  pavel@denx.de,
  jonathanh@nvidia.com,  f.fainelli@gmail.com,  sudipm.mukherjee@gmail.com,
  srw@sladewatkins.net,  rwarsow@gmx.de,  conor@kernel.org,
  allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/185] 6.1.76-rc1 review
In-Reply-To: <20240129165958.589924174@linuxfoundation.org> (Greg
	Kroah-Hartman's message of "Mon, 29 Jan 2024 09:03:20 -0800")
References: <20240129165958.589924174@linuxfoundation.org>
Date: Tue, 30 Jan 2024 21:15:11 +0100
Message-ID: <87cyti4lyo.fsf@turtle.gmx.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:QcvQmzEyCles02lS8o7pqH6JGpABMgHLojmyeXih92ZDAoTm0B3
 fAPfWXwWdVYDlk6FsPBsF+yo+PDARFfTwpnaZSh/sA3VrTOnFRod0V7FVJR2Ep2yenioGjn
 PdZWX7puK/YYpQJ/N5ERhuqNYxDExIV9aYYLZzAWG+wOowBAtMuiU8ml2qOCdkF2CTp9Wm7
 C+xeBuLm0voXzjd5cpBgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h6Gspw9SZOo=;tbWGYlzFam6OQQvyxCWTuzFzAHw
 SiiKYT4Hc2m9P/hmkAWj1E7hjxOoYDkcJYsgHkhbrSL2PbKdH2YT4h95r+tQFT6RqrhHZxetF
 NeG1j+faKnLl/Pwpb2KIwNrKS01B2IYFekX7bfC/GvqT3W0wmjYyTEAKgVECwPQv4C+FjsY1x
 kuda4aXd3VdQPiLPb1YHkAIm3nI/iZIEy37X6eSZO6OPS+X/4NcLPF+CrzL7rMclfesotJY7K
 +O06/lTsaO0DkBmNcgsueFCVk9YMlker3rAD1gZ4BDYfMUdFp+y0bzzl3B9YgwjlwTKMAvlXt
 QPnHIfybTOVjHFLg0noxXsRSDWpDno8ZRvZRXq27H9lam4899fHNs0U1T0hAiAcgj3jFS/jFK
 m0B/BxS7/LzuKrQFIRCHmKFjemiPqlsQFJoQgKBxVF45ivtOrk0eOXZ8BJBHna4V6JNxyihYQ
 oyQ/mOJevqtr2O1OJYe3qIv8eYGpTOhNIaBI/VyYq17QDyqwhQ2jqmYuPu3adDAFWfSga+gMD
 0FkgxixmWes5hesJiIcRysq2jtr+sswuL2CNxgOwHKDn2gHKp+7FaQ31t47o5hKEbtx5muRI7
 4z5t9KbiCkm+nzK+qRibYqma8uV+wt/BKPk3maPft3WJXgZYx3R0rmXITT+hqsOtYLq5NSR1P
 UgNYAUaD/260NHVPJDfp4ntPOwypIo1sXjbTs0eg7aIzNbNfGtboZa5Edw2SyVlgR1Id2Bp/p
 M0ZbhrZpb8A90Vx91MQqbfsks66/aB9Bcypls7JkN1yevtOgG5E0Or56O5Fekrs9aQKYXza6f
 bWNfwYgF2lGjmJepvh7NJ83VLMXbI9EG6M4eIjRbnr/rh7DY5TNwPjp6zzItRm8W57kPj1KfR
 ncTezcT+z7/UY3LWOUffDdOR+SnDcv7qGlxKyu3+/N9cXcNSD0j6XQuDToQWrMNkhHGFJVxK7
 vQT23v/sLjotewPGlC48hWIbOxU=

On 2024-01-29 09:03 -0800, Greg Kroah-Hartman wrote:

> This is the start of the stable review cycle for the 6.1.76 release.
> There are 185 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.76-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.

Works fine here on x86_64.  No Mellanox hardware, so I was not affected
by the build failures which lead to -rc2.

Tested-by: Sven Joachim <svenjoac@gmx.de>

Cheers,
       Sven

