Return-Path: <linux-kernel+bounces-165731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E118B9054
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32951C22089
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFC11635D3;
	Wed,  1 May 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e38YSG09"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD2417C6A;
	Wed,  1 May 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714593633; cv=none; b=VUx/Xs3cc0vDPlra3/HYMulRkDUKPIhE6JRFCeUc53hqfos7DA6qMTYusBwYqPeSzXFCOSJA8cMR9m3xmpA+IgcIkxPHqmMDyyRUv1lzexeYS1Ed48+F/WnTxBT1DH9soZwiISGV8xfDnI8C56qMSNfApYieg07EKTadFy6OYjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714593633; c=relaxed/simple;
	bh=AmaZMjCeQsx2Rs32HSiWyZp9mnQATp7BS+/sJb4R7ro=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rZSXnyJg6pH+uSOOI9HnGVx+IwLf8Qf6tgzFlvk2IOkxwL6pMrRThWz2xtagwqdqk7DHxWvqb9iqLZrm6vvdfyF1xBU4OsznZ57GM8t8Apns2fuCSebIVnuJiX7ajNhbAQu+pmwarm8m5pgoyaIv8BBXz5ZAw8MQbse8E6DTbkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e38YSG09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E2CBC4AF19;
	Wed,  1 May 2024 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714593632;
	bh=AmaZMjCeQsx2Rs32HSiWyZp9mnQATp7BS+/sJb4R7ro=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e38YSG09zcA9QMrprjSlRCCGzOCxarrKAzQrMFh+P8gVsOyN/tqUBpfzrLvTfzYkc
	 eC2gMKZyTS4nSBd9ZSIO94TA4aXgrc9mYztl+KDBrxWaR+0Od+TWl+E34OxIyWLycf
	 d9Qzwxsk/fQHI0nkDqwcMNK9eXRcp8xHFRsBqJEyQG1XK0b75KbCQ/dBzvNy12FM0t
	 CGGDsH0A39p8PNMFhBwSR19gFVwU8O1l1IulHkdqFOBqjpFrqvfwpXbox9+DYyDxPh
	 FW5saxeQEE529tWjo2KHGZlX/Ia+TNO01axJsHdfRB9hTHGzo47vxnrdCk6ST4xtgz
	 ckbnLHjX8/crg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8DD98C43444;
	Wed,  1 May 2024 20:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8] Bluetooth: compute LE flow credits based on recvbuf space
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171459363257.6729.7784993602551923019.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 20:00:32 +0000
References: <20240501100859.175690-1-surban@surban.net>
In-Reply-To: <20240501100859.175690-1-surban@surban.net>
To: Sebastian Urban <surban@surban.net>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  1 May 2024 12:08:58 +0200 you wrote:
> Previously LE flow credits were returned to the
> sender even if the socket's receive buffer was
> full. This meant that no back-pressure
> was applied to the sender, thus it continued to
> send data, resulting in data loss without any
> error being reported. Furthermore, the amount
> of credits was essentially fixed to a small
> amount, leading to reduced performance.
> 
> [...]

Here is the summary with links:
  - [v8] Bluetooth: compute LE flow credits based on recvbuf space
    https://git.kernel.org/bluetooth/bluetooth-next/c/e8dda7907df8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



