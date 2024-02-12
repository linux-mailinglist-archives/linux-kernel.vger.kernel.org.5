Return-Path: <linux-kernel+bounces-62360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2C6851EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E7B0B20FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D104C622;
	Mon, 12 Feb 2024 20:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rV9G/aKR"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4A84C606
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707771392; cv=none; b=vDMuLjt+qSXOnELQHatSUL8/JMoYIrGkM/2z3mb+hGsEeXUmvjht2V7ZpCKQVN8mPHlLFMzqOyAXRd1a4csBOtCqz5ojCKl2YeaUnPGhgs+k3LwPJzPjrsSF1/jRclUxUPnRZaEhZdhG5fNm9v0C/ExgOh19yUqA0MIKH7fr98c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707771392; c=relaxed/simple;
	bh=nioYI8QzAMJASNr/swtGxAoJRoICVkBq70p7F3S641g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ty9DlIAebzOznovwhI9KDZJgIoYlZ5BaX3D6Mtrvd0Edv/g5bEIOa/wF2pv4JstkUHUV1y75q3B07zfW9Nbbjg5wknvDbrmS4P03RgyPuNddqwejybqwQMI2j1wqxAMErPDN+DTTU0BMSmTvjboy0XN65pqyv12av1huKx4PrBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rV9G/aKR; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707771388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oO68mIHZbHwg1QujSUyddQTzN62mxLj24Qcfye1RG6k=;
	b=rV9G/aKRuZKpoHt0MZ0FBk8TLUAHSaC4X2CCjHf1tVsuGDYJrG2vw3qotTrhAacseXRY8L
	py/DofBCE/YUlC4HR1owo7xGWGDc78VgW6PPKsNW75BIP91Lv/PH81HmBnt+3+Dr0duNpH
	MKK82nau0tnZEh82YnmcGWg4qcACbqQ=
From: Oliver Upton <oliver.upton@linux.dev>
To: Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] KVM: selftests: Fix GUEST_PRINTF() format warnings in ARM code
Date: Mon, 12 Feb 2024 20:56:08 +0000
Message-ID: <170777114723.3090079.16291479870607585815.b4-ty@linux.dev>
In-Reply-To: <20240202234603.366925-1-seanjc@google.com>
References: <20240202234603.366925-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Fri, 2 Feb 2024 15:46:03 -0800, Sean Christopherson wrote:
> Fix a pile of -Wformat warnings in the KVM ARM selftests code, almost all
> of which are benign "long" versus "long long" issues (selftests are 64-bit
> only, and the guest printf code treats "ll" the same as "l").  The code
> itself isn't problematic, but the warnings make it impossible to build ARM
> selftests with -Werror, which does detect real issues from time to time.
> 
> Opportunistically have GUEST_ASSERT_BITMAP_REG() interpret set_expected,
> which is a bool, as an unsigned decimal value, i.e. have it print '0' or
> '1' instead of '0x0' or '0x1'.
> 
> [...]

Applied to kvmarm/next, thanks!

[1/1] KVM: selftests: Fix GUEST_PRINTF() format warnings in ARM code
      https://git.kernel.org/kvmarm/kvmarm/c/06fdd894b473

--
Best,
Oliver

