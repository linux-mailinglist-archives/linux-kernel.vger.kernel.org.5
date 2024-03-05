Return-Path: <linux-kernel+bounces-92857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C70872706
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369571F268F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB0F22EF2;
	Tue,  5 Mar 2024 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ecm+wuF4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2AF18EBB;
	Tue,  5 Mar 2024 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664837; cv=none; b=PKktMb2umToAnRR1MDLIWODuKI6EE4udaNyWekhfvFtsYabSk7KeOLx5x9+bbzLw1VAhhRNCcpqOUd70xG2x8nxG5A6CVPaqZvOJcT1Ln9s4Kn5WZ4IMUWit1pf7jaZXy6hWLuxxyqlDdkVm+SwrTb8dDIY+9Jnwp5MM+nCYSyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664837; c=relaxed/simple;
	bh=vLqY0HFHJgDeiDMFCS0uUpBm2ixyQTrPWM9Q5wyrM2U=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=oSnE4/3sTDWI8FRax8+xAys2Ilmswxn147NrQZEtUxlow9yNuoCXx1RbPengRIjiBwchrcne3NXrErVbleKlUZ6zzLEVUUseoMpW3xzJPn6GitEUk/wLkGde0cNm0g/KEgJlgYw/OEe/W5NesKJ+KYzF2/973fN2xwFxy0gQixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ecm+wuF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDEEC433C7;
	Tue,  5 Mar 2024 18:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709664837;
	bh=vLqY0HFHJgDeiDMFCS0uUpBm2ixyQTrPWM9Q5wyrM2U=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Ecm+wuF4LmNV/89c+AryxHeGUFkgtZ53aQH4ZAJt/9QIlYMkIETKcayycNeF9Ej0W
	 9z31v9TCkC1RGdhBbg655U8SrfzlPYD/GvEGu9aeKXaQCKmhHyoh5ZHGn8q3eawP9q
	 9xQUyPYHdLrV9q/E1GahCw9ZqiTdiwIpJieYo4ArV+6QS7OwxEzI20u5LgZ7Kc3JMo
	 r7sHbulsQMz1TVKwmwy/u7AlUgW9aPkv8ws1uVVadOur07B8oWcsgFNVWa9lb9bAn+
	 phXLJ5RT4oyCqm9sHwqUIP2XlwD0ekSbUurBGpzGbhNmlFcYUbJZkU0LYoOVgZ3K8f
	 kK1+ULfHs54AQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] wifi: wlcore: sdio: Rate limit
 wl12xx_sdio_raw_{read,write}() failures warns
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240228101042.728881-1-javierm@redhat.com>
References: <20240228101042.728881-1-javierm@redhat.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Breno Leitao <leitao@debian.org>, Li Zetao <lizetao1@huawei.com>,
 linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170966483365.424347.18076602135809337745.kvalo@kernel.org>
Date: Tue,  5 Mar 2024 18:53:55 +0000 (UTC)

Javier Martinez Canillas <javierm@redhat.com> wrote:

> When these failures happen, the warning and call trace is printed which is
> excessive. Instead, just print the error but rate limited to prevent warns
> to unnecessarily pollute the kernel log buffer and make the serial console
> practically unusable.
> 
> For example, on an AM625 BeaglePlay board where accessing a SDIO WiFi chip
> fails with an -110 (ETIMEDOUT) error:
> 
>   $ dmesg | grep "sdio write\|read failed (-110)" | wc -l
>   39
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Breno Leitao <leitao@debian.org>

Patch applied to wireless-next.git, thanks.

f6e36d9e1c63 wifi: wlcore: sdio: Rate limit wl12xx_sdio_raw_{read,write}() failures warns

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240228101042.728881-1-javierm@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


