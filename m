Return-Path: <linux-kernel+bounces-100439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF77879796
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3D43B22EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAF87C6F6;
	Tue, 12 Mar 2024 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7rNhgdZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC877C0B1;
	Tue, 12 Mar 2024 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257492; cv=none; b=PDcmbigm6gLf/0KzztvCMIQVSQFt+lUW9VHT0U0JhtNKi2VqNXJnT1JkyGuEAhS/yFucp1u1HSLa+/MZCJCadiakvb7VgKmqVXtUo3pTD/n7uRv+LRRprfzhuGoZ3+0un2pgjD/umT0WrYvb/rlsYkzjraSwTnV0NN/aRdTuLTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257492; c=relaxed/simple;
	bh=AB3f0oe5VQwbDBA3sbXZIh/T3+n5F4eIfPvO3h0claU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=n1hvjMwVjtZuMk4rTNtCm4TNXMl6qd7zZFx5nLOfMBKkQg6rkHq786jhwamHtOAKnyO4a3rbHYaCH2Xt6KyEXZIM5sXM6y15+3bZP/+7uObYornx7e28i0uaLgSsrcXLa10R0IIULbyRx46zagJkkBhL4F9LlWI3aR/IypTLmN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7rNhgdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC41BC43394;
	Tue, 12 Mar 2024 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710257491;
	bh=AB3f0oe5VQwbDBA3sbXZIh/T3+n5F4eIfPvO3h0claU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=s7rNhgdZJeuIPZPdWpCxscx0yw/uvXTi2/htWFXHogJA1V1Yu2orZwspE+XQJoSc3
	 o0UBmjo+iPmz5TVxBs2Cs8JhkiOk5rwX/ixi+AOn5ng9+czTiDVqFBhHNhTKs5lzlN
	 B2mgr88HhOcTJUU+H0JdWPYr5OcfrvUwSL6QoxZKSk24djs4lPonhFLmlgt3izGrLe
	 T3mpPxqK1Sp5X2bAq9aYa93duF5xUqkgFJi7xmZ2aCnrDD754Ohr9mib0hQBGnXMO1
	 b+VpbKxNx24JRf+IFBc0KfsTufDIAO3Rj9M/H5aK5O2Lj4K0kXoQC2Wjj8hjkbz9vE
	 tyF/bmUakCKTw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v3] ssb: Fix potential NULL pointer dereference in
 ssb_device_uevent()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240306123028.164155-1-rand.sec96@gmail.com>
References: <20240306123028.164155-1-rand.sec96@gmail.com>
To: Rand Deeb <rand.sec96@gmail.com>
Cc: Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, deeb.rand@confident.ru,
 lvc-project@linuxtesting.org, voskresenski.stanislav@confident.ru,
 khoroshilov@ispras.ru, Rand Deeb <rand.sec96@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171025748752.1969294.6301568129349383051.kvalo@kernel.org>
Date: Tue, 12 Mar 2024 15:31:29 +0000 (UTC)

Rand Deeb <rand.sec96@gmail.com> wrote:

> The ssb_device_uevent() function first attempts to convert the 'dev' pointer
> to 'struct ssb_device *'. However, it mistakenly dereferences 'dev' before
> performing the NULL check, potentially leading to a NULL pointer
> dereference if 'dev' is NULL.
> 
> To fix this issue, move the NULL check before dereferencing the 'dev' pointer,
> ensuring that the pointer is valid before attempting to use it.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Rand Deeb <rand.sec96@gmail.com>

Patch applied to wireless-next.git, thanks.

789c17185fb0 ssb: Fix potential NULL pointer dereference in ssb_device_uevent()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240306123028.164155-1-rand.sec96@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


