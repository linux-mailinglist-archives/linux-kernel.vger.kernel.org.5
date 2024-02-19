Return-Path: <linux-kernel+bounces-71678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAF285A8E6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5091F25302
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BA63CF48;
	Mon, 19 Feb 2024 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D2omGwdW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yG0eL952"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206B3B7A8
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708360047; cv=none; b=MqJ1zMgDzIPWKKvzxqmlSHp26/E5VR9TpD+vwHtdtMLXlqkEk7LCHZ/Xk/LxjUDIPEYyoR7SSG7EW1+XWJNKgunDpltjZ5HJpLgcR0IFoWztbRHSHFTZrDlZZMzzW19jWW5FDD3Pam4JQW3V08cmlWs1hqVlpeyXEuEiNXHCdFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708360047; c=relaxed/simple;
	bh=0WKoyUwZfSN+jy/1SBRc5fcfwEO+gVfUEGfbdYyo47A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nOcsXflnZ+G0UJqQIMhTC3/OijUboBm5ndbOYJaWkHxCCIzI5eFz1GkDSohyz7bmWrCf3ZS+RJlYmf4PAgCd2v587nE9eTCATRpAgo/NJjg8ebyVMwEdn7ftfK5JbHP6EjNUcNlWi9gwrURS+bmDPoZvZbb8wxtqNPxKp+c/28w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D2omGwdW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yG0eL952; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708360044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0wnEv9kxLoT40w1a0mZFLRikbwdLlcNnWdfNV5ZzzAI=;
	b=D2omGwdWGdogDFA/zEPqayLYHMv/nChh1p7Jwp8paj+HlGowPulvmn/CHoEB5nLmklgMZQ
	p9eMAMxgLjCk3psjj/1v2F9XMbxHSdMubpwj1eCcb0L2lJQQoIEkrezt0EOpn5tQ3Sn0SI
	+R84PfZOKojBr/QmxxSZefCjdxTmtJCYCYbTK1I8p9OTb2oTCkQI3N1yy/EiC3zXwVwCzY
	QqtzMwjabT6bcdV03ltHxcdHxhHbrOnuuRH4TWTtwyI81t17v1MNBqTVTNvEx9dq/kWobU
	Qze4tko6fqnFebD05jebWZRXaLMuzrDcSMlIkpUrMWXy1yZXe11Tc3gRw8t+Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708360044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0wnEv9kxLoT40w1a0mZFLRikbwdLlcNnWdfNV5ZzzAI=;
	b=yG0eL95292BrSGe+jw6Vu2uL7KQMppirlE1tSi8E2LrEmsqXutHj3tWAn9bceSG84IB+rD
	Zw2FUY/x+ze1EdDA==
To: Costa Shulyupin <costa.shul@redhat.com>, linux-kernel@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>, Waiman Long
 <longman@redhat.com>, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3] hrtimer: select housekeeping CPU during migration
In-Reply-To: <20240219143301.4174966-1-costa.shul@redhat.com>
References: <20240213164650.2935909-3-costa.shul@redhat.com>
 <20240219143301.4174966-1-costa.shul@redhat.com>
Date: Mon, 19 Feb 2024 17:27:24 +0100
Message-ID: <875xykju6r.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Costa!

On Mon, Feb 19 2024 at 16:33, Costa Shulyupin wrote:
> During CPU-down hotplug, hrtimers may migrate to isolated CPUs,
> compromising CPU isolation. This commit addresses this issue by
> masking valid CPUs for hrtimers using housekeeping_cpumask(HK_TYPE_TIMER).

Review feedback is meant to be addressed. I fixed it up for you in V2
and told you what needs to be changed and you got the fixed up version
in your inbox. Feel free to ignore me, but don't expect me to mop up
your stuff.

Thanks,

        tglx



