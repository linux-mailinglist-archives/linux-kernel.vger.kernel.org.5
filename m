Return-Path: <linux-kernel+bounces-144060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC588A415E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA70B1F2176E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13D4225AE;
	Sun, 14 Apr 2024 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3zTS1ov"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29053224CE;
	Sun, 14 Apr 2024 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713085302; cv=none; b=mWObg4WQwOralBzhbfGeZigR3Lbem/8AopRFUX2VUuM5BSkjPY0cnyjqlL3hoWriN5Go9MnFaW/tLY66EQjEbAE40FSA8MTaINjtH1ctGM5ITgWOShX3Kng1RLvC7LRakJ/MZQ4aM6e1UFI5WvccwE3ZS4UktNxVnxTTax8wGZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713085302; c=relaxed/simple;
	bh=9MYRm6KdMFP9mkt1k69QH3KLYqj2zOSAwIkGTQjrBQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CuzZAxGgKk8HAHX4dQMEsZFMuNZ6pUu6sEHNg82AoUVZhYF4rbGdX78bZBJfw9VEESc6QcJ8ht9osfqIT87MwpeUO320aKUbdOm1TJSPHvXryyzwtMI70KuUWtUBWRcAlI1lQxNYAQMiCq+dsVFYfFRPrTkq2Qwf5iP/hbNWYT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3zTS1ov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49E0C072AA;
	Sun, 14 Apr 2024 09:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713085301;
	bh=9MYRm6KdMFP9mkt1k69QH3KLYqj2zOSAwIkGTQjrBQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r3zTS1ovNfI5+zeIjCd9zMKFbj9/q9UIzFGYrKr+xgxOUcmp4pao3aBFiJHZFe4x3
	 SUrXAqBgdlRP9WoM+TjJwC7/l21+pF9C9rnfp8ZHh9nVVt/rqGp9OiozGdayy5+VYo
	 5jryRMZkIylHbeUVE1xLxoPZCWi7sSbE33gPYsWN77Im1/QHV5N4e77zmGsVPutYug
	 G/0lGa6TAxn8X+JuxubLssBI/fFMtirXppMj00AIDSvAttK4F/embJnmrCDNXUB861
	 dHGSUPOKOvoDKW6MiJDBq8EWYqc6WWLZ34EYYAhrNtKnqZjvd/mV2blWoLVw4BmN65
	 JTxXhzYGrrQ5A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rvvk3-004JxO-7H;
	Sun, 14 Apr 2024 10:01:39 +0100
From: Marc Zyngier <maz@kernel.org>
To: catalin.marinas@arm.com,
	james.morse@arm.com,
	oliver.upton@linux.dev,
	qperret@google.com,
	qwandor@google.com,
	suzuki.poulose@arm.com,
	tabba@google.com,
	will@kernel.org,
	yuzenghui@huawei.com,
	vdonnefort@google.com,
	lpieralisi@kernel.org,
	Sebastian Ene <sebastianene@google.com>
Cc: kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Remove FFA_MSG_SEND_DIRECT_REQ from the denylist
Date: Sun, 14 Apr 2024 10:01:35 +0100
Message-Id: <171308523911.3831784.4456862222032162210.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240411135700.2140550-1-sebastianene@google.com>
References: <20240411135700.2140550-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com, james.morse@arm.com, oliver.upton@linux.dev, qperret@google.com, qwandor@google.com, suzuki.poulose@arm.com, tabba@google.com, will@kernel.org, yuzenghui@huawei.com, vdonnefort@google.com, lpieralisi@kernel.org, sebastianene@google.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Thu, 11 Apr 2024 13:56:59 +0000, Sebastian Ene wrote:
> The denylist is blocking the 32 bit version of the call but is allowing
> the 64 bit version of it. There is no reason for blocking only one of
> them and the hypervisor should support these calls.
> 
> 

Applied to next, thanks!

[1/1] KVM: arm64: Remove FFA_MSG_SEND_DIRECT_REQ from the denylist
      commit: ae69e7740770d8e02915b299d060c9280a3db01c

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.



