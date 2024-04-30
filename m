Return-Path: <linux-kernel+bounces-164127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868238B7965
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D3428177B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE62177104;
	Tue, 30 Apr 2024 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9n7KDEa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F28770E2;
	Tue, 30 Apr 2024 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486831; cv=none; b=ONlKh8fNAp1uqMQI06JVMSDM0ku4tJ1pL0k/MoF2aa/oZxjkBlIKeHfOiYETVwz59H3tHAK1wnEgcPwXAjXXIf0hwnLVZzKUWCeqiVtEPibMYK1Kkb8ctElnHsVeZjirVQnSc6fPX/uAGeLji9c7JX3pEJjL1vtNJjXXftj0BKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486831; c=relaxed/simple;
	bh=QAeY5ocwzegncSsujzGKPVRaz8ywLVDgq/hjOYOJcL8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NX2UbOykSuGBKGB3NM/Pf6fLfrntCs2doz0cb7GlywiCE45lPibcW9jYx47GGIva8Ui7T4mLv6Def0QUY63OE+JSif8ULXStPHAuz94LkD+dHySOtytso268+xxHkNDcJgHV8QfwGmS9shu56np0Fqh5FyBVOssh+KSmaOEBpPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9n7KDEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FA2CC2BBFC;
	Tue, 30 Apr 2024 14:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714486830;
	bh=QAeY5ocwzegncSsujzGKPVRaz8ywLVDgq/hjOYOJcL8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q9n7KDEaUmPbAt4v+JMTA8oGELxB/aWQi8JNehikfz5hhGogEkTvNOzetTH4L4Jh2
	 csh6WSotXFgPyDTM1OKxJdClIZt9S4bCXC6D8leMop5atUlUuMHHCkuNEIUiUuvo/y
	 rPRf2EYTsVJHripfYcJMwPZBtiZBsx5Z1qt1WRxYihE7IecYb4YIssqnjBBwKLIaau
	 hoLl7oPVb2u6sYMMb8fDMB49LwE7cafwPsa5aCGUfDL7CmoRM+C5noOl6JINdECa+g
	 3XvESQMwHudA8A3/YzbUdk2QNh9RCbz9Hu4dw20UPyG/yARSJcnYVp5d50PuhQBwKr
	 0/wQQQIycjaUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5ED2FC43617;
	Tue, 30 Apr 2024 14:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix slab-use-after-free in
 l2cap_connect()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171448683038.20667.12009081489317667942.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 14:20:30 +0000
References: <20240430063209.584244-1-iam@sung-woo.kim>
In-Reply-To: <20240430063209.584244-1-iam@sung-woo.kim>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: daveti@purdue.edu, dan.carpenter@linaro.org, marcel@holtmann.org,
 johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 30 Apr 2024 02:32:10 -0400 you wrote:
> Extend a critical section to prevent chan from early freeing.
> Also make the l2cap_connect() return type void. Nothing is using the
> returned value but it is ugly to return a potentially freed pointer.
> Making it void will help with backports because earlier kernels did use
> the return value. Now the compile will break for kernels where this
> patch is not a complete fix.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_connect()
    https://git.kernel.org/bluetooth/bluetooth-next/c/6a39d26feb15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



