Return-Path: <linux-kernel+bounces-7213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5E081A349
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDFB71C20A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357D847780;
	Wed, 20 Dec 2023 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfZuHwHt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D384185D;
	Wed, 20 Dec 2023 15:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE81C433C7;
	Wed, 20 Dec 2023 15:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703087752;
	bh=ljBVQFPPMODMjkz27mK+HvRvrQ2qgtBuUctiUK99lTU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=AfZuHwHtUUThfYKrshL7QiFG3Oa+621djFBCRJLsYLw2mZ5P5fl9acub90I+Zf3bA
	 7tJTOc6yxfzbk5g3EGNcC1pD2Vpb6nZWANoj20GZ3kxNbhK6n3ukliee3g80cixhiN
	 dDnlDk3EbIhQqIYKr2tGntA8o4BrtlIMkcaSC53v25SoD4M+E3cYLRM+BgX3XHcgM0
	 Ck2saQ3QgFjAEQ+co/lO0c2lXytaDXH+u99+bpc6I6S4YBI5VKV1I+PZGGwKmZ2LnO
	 BUCCYAmfVDH6+OcjJwFVZ5uEfEaq0YKfV0LQMnvwBeubrqGIzE3zLAAb7wCE4Hw8Jm
	 o1RycnaLAX5Jg==
From: Kalle Valo <kvalo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hector Martin <marcan@marcan.st>,  Daniel Berlin <dberlin@dberlin.org>,
  Arend van Spriel <arend.vanspriel@broadcom.com>,  Arend van Spriel
 <aspriel@gmail.com>,  Franky Lin <franky.lin@broadcom.com>,  Hante
 Meuleman <hante.meuleman@broadcom.com>,  SHA-cyfmac-dev-list@infineon.com,
  asahi@lists.linux.dev,  brcm80211-dev-list.pdl@broadcom.com,
  linux-kernel@vger.kernel.org,  linux-wireless@vger.kernel.org,  David
 Airlie <airlied@redhat.com>,  Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
	<170281231651.2255653.7498073085103487666.kvalo@kernel.org>
	<18c80d15e30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	<1b51997f-2994-46e8-ac58-90106d1c486d@marcan.st>
	<c392f901-789a-42e2-8cf7-5e246365a1ca@broadcom.com>
	<CAF4BwTXNtu30DAgBXo4auDaDK0iWc9Ch8f=EH+facQ-_F-oMUQ@mail.gmail.com>
	<87r0jiqmnx.fsf@kernel.org>
	<01bd8c68-1b9c-49b2-8ace-1c7d1b5192ad@marcan.st>
	<CAHk-=whDLKZZEuxU_jEhZRdeWjXAkL8=J_JRk2Ar6wp9UK3h2w@mail.gmail.com>
	<871qbhqio8.fsf@kernel.org>
Date: Wed, 20 Dec 2023 17:55:48 +0200
In-Reply-To: <871qbhqio8.fsf@kernel.org> (Kalle Valo's message of "Wed, 20 Dec
	2023 12:20:39 +0200")
Message-ID: <871qbg3m2j.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> And Arend is the expert here, he has best knowledge of Broadcom
> devices and I trust him.

But Arend decided to step down:

https://patchwork.kernel.org/project/linux-wireless/patch/20231220095750.307829-1-arend.vanspriel@broadcom.com/

And no wonder.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

