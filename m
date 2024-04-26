Return-Path: <linux-kernel+bounces-159514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 355778B2F9C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C55E1C22C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0597613A265;
	Fri, 26 Apr 2024 04:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzsaTIjd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DBC13A248;
	Fri, 26 Apr 2024 04:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714107542; cv=none; b=J9OHDOCfs9D1u1g/bl51wLnI2ReEhQccglYHhhRToBlLT45uMPBUR2sNM3ObZahL6P7yHsb9jxAViRUvzX9oFJ1j1kjJkvQVd/rqwMJ83mVLBOtUbKgYXd5k/XvurJaUS3FHaddPABSc4DOO+FdOCnmjykPMqsWW1Kch7f+6MKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714107542; c=relaxed/simple;
	bh=5Ymgj7dGlmkWAAtbJ2XFFjc7REuiKwuyHSrZtJ96KFs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=CrOk1Ay3rLlIBTH1KsE3qXnx/by4AuLDlzralm5/X59C+xjVlblDQrx0tSEOo0NHPootDSYkjwXPnekBAkJcZTsBL9e3WpMXGKlW5IClysEfyVzZm8a4/G7zKjo4ycgmm1tnO82d1uBiM+Py24lxRNgz6IfFm4SiX8EUU40uCF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzsaTIjd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377C4C2BD11;
	Fri, 26 Apr 2024 04:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714107541;
	bh=5Ymgj7dGlmkWAAtbJ2XFFjc7REuiKwuyHSrZtJ96KFs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=WzsaTIjdJGw8U8smgREwvDcRlknOL9ZSN1WEjIEZIxLBYi6m0olUMv2Emu7DqZAH1
	 eojBAXE0lu9HgcP1Z+RH8MDu3NFb0udiR9ljIuDk/jxSapzGkK+l4bV/G3vTKgKCOd
	 kVOp0K6rJ+QW/4VvXxgGt5QwTIgnbaXqV/NfM/xU2pcTMzPluzH/95ciSo2xBp1y4Y
	 x94WiIwYsirR16xxjYMGvRleJ9UE5TmFApmROcJh9dY3JrCPR/JNrw/4QRiPH3t/Ef
	 wcDGzNB8zaUi6yWA1PvIc38nAb0MXYNWrZiQVXpQNuOSlF96LYbF3pPO4E9IqfkZfi
	 dwLnI8zt7An9g==
From: Kalle Valo <kvalo@kernel.org>
To: Christian Lamparter <chunkeey@gmail.com>
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,
  syzkaller-bugs@googlegroups.com,  lvc-project@linuxtesting.org,
  syzbot+0ae4804973be759fa420@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] wifi: carl9170: add a proper sanity check for endpoints
References: <20240422183355.3785-1-n.zhandarovich@fintech.ru>
	<ccbdc170-149d-442c-8167-2b05c8cf93b2@gmail.com>
Date: Fri, 26 Apr 2024 07:58:58 +0300
In-Reply-To: <ccbdc170-149d-442c-8167-2b05c8cf93b2@gmail.com> (Christian
	Lamparter's message of "Thu, 25 Apr 2024 22:37:04 +0200")
Message-ID: <8734r8sorx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Lamparter <chunkeey@gmail.com> writes:

> On 4/22/24 8:33 PM, Nikita Zhandarovich wrote:
>> Syzkaller reports [1] hitting a warning which is caused by presence
>> of a wrong endpoint type at the URB sumbitting stage. While there
>> was a check for a specific 4th endpoint, since it can switch types
>> between bulk and interrupt, other endpoints are trusted implicitly.
>> Similar warning is triggered in a couple of other syzbot issues [2].
>> Fix the issue by doing a comprehensive check of all endpoints
>> taking into account difference between high- and full-speed
>> configuration.
>> This patch has not been tested on real hardware.
>
> Oh, I've tested the original patch on real hardware ;). You can remove that line.

BTW I can remove that line, no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

