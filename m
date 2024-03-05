Return-Path: <linux-kernel+bounces-92861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD016872710
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A44628C885
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1531BC26;
	Tue,  5 Mar 2024 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcB5d5/g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FB118EBB;
	Tue,  5 Mar 2024 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664954; cv=none; b=uMg6OfRcYIQw3ygUNTD+u7N2L26n5q+uJbm/9JbYHxyQniMhxlX6dvCFd/Va/Jv5z4mPdN88EOfTAafV0lVqtEwoepKwStMo1xOx7jGuf9Ljivd0iwfrdmvCzfU//fzpvv6N8YWbUl3zmYca+vAy8MNG1058bk29C6mdW34Pe3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664954; c=relaxed/simple;
	bh=XbKyIseOs3O4QkGJj/50dL2guXVpKbgyIoIhG/Hnj94=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=uFuLlvCDoiV579UNyNEbAkRqMv92QMFCGGo1u59AXaO1hkbEHJwnA+iE6VIXRucIwfUfOlvefw4sKro+nbJHeGybB/bueKvCdZhoK82sWa8TZXNY5zxW0p2iU4qrCXFuVdZYJRpUC6LUaJHrSJ7O9HUpwCKn2j9Z6grbG+iOHoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcB5d5/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A119C433C7;
	Tue,  5 Mar 2024 18:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709664953;
	bh=XbKyIseOs3O4QkGJj/50dL2guXVpKbgyIoIhG/Hnj94=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=CcB5d5/gC/g7UDGwpgMmsWBxKTt393MQDmK+u2fOPmGvTSYmsvd9J5VcWSEf7Ep43
	 2ExA/MRqBN1q1sR8wTMH0PAIOVnd6yvGLcyY3QReg6O10jvB1gqItvtd1MzkIJPtKx
	 rus55E01v5sT3ZMuYdBhC+QOvIKkftrtIw9Zlto69m0XSIXVqwmGk2Z4KaEucCPzJk
	 19IPcmjncZTJLj2Z003d2OMfw4l59oeaIcEKge5pKboGfWkC01J1p7IXbm5nLzIceU
	 6P7wHM2PF0VB/TgDbgSM7GWMGCmMjYteChBNC1M87VwfKlHESU0nzKqrYbrg3OgrlX
	 WpytybP7fYk8w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ssb: Fix potential NULL pointer dereference in
 ssb_device_uevent
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240229093756.129324-1-rand.sec96@gmail.com>
References: <20240229093756.129324-1-rand.sec96@gmail.com>
To: Rand Deeb <rand.sec96@gmail.com>
Cc: Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, deeb.rand@confident.ru,
 lvc-project@linuxtesting.org, voskresenski.stanislav@confident.ru,
 Rand Deeb <rand.sec96@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170966495037.424347.1344425289163744212.kvalo@kernel.org>
Date: Tue,  5 Mar 2024 18:55:52 +0000 (UTC)

Rand Deeb <rand.sec96@gmail.com> wrote:

> The ssb_device_uevent function first attempts to convert the 'dev' pointer
> to 'struct ssb_device *'. However, it mistakenly dereferences 'dev' before
> performing the NULL check, potentially leading to a NULL pointer
> dereference if 'dev' is NULL.
> 
> To fix this issue, this patch moves the NULL check before dereferencing the
> 'dev' pointer, ensuring that the pointer is valid before attempting to use
> it.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
> Acked-by: Michael Büsch <m@bues.ch>

Failed to apply:

error: sha1 information is lacking or useless (drivers/ssb/main.c).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Applying: ssb: Fix potential NULL pointer dereference in ssb_device_uevent
Patch failed at 0001 ssb: Fix potential NULL pointer dereference in ssb_device_uevent

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240229093756.129324-1-rand.sec96@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


