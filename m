Return-Path: <linux-kernel+bounces-164260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26BF8B7B79
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7AE284EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6B2140E26;
	Tue, 30 Apr 2024 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mossMODi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A70171E75;
	Tue, 30 Apr 2024 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490839; cv=none; b=pBPRDHyJhs3Y/ne/XXCUhI7ztVg/JF3Aps4wGjfzkqdlARVJePuoyBM2I3/DkcASeOP7mM6Sv055JizGcVUlwaTm4Ja6Pco6xAECDKV0lavZUO2CqBan43Ng6cKPZUbHCg0hcEU6VY/UHNetJoAobE334cwkx2DwcpQyioqFD4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490839; c=relaxed/simple;
	bh=CkP4kGQkUb9bwINA+s2FGC4MkUQIgOZ+AbJw8o/rX64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ue8F4q0ODpnnwQsTWF+//IS44Szva908m6V3RRgQKg6AvnVJKhBgAuXtiRdh4fJX1qVuhrTiSk4NWJF3fKAkL278U1s/prJnBhXmj58EvhlCj7TtM+NuvCu9IH1nAeSiouZd0t0GhaKsC+D6zlH8+QZsN5vsdVgST0Tg81nlxmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mossMODi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB7BC2BBFC;
	Tue, 30 Apr 2024 15:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714490839;
	bh=CkP4kGQkUb9bwINA+s2FGC4MkUQIgOZ+AbJw8o/rX64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mossMODiKr/2Om6tkOVagDUv4i1kljFeDt/qXxBNxfWo0SeBgESu5dRHsagblsPFI
	 p5mld7EY+JKLy4ORKCBX/ghKwNJL5/F4/iJGtwmmcD61Mr2ccjmyPbIstv1f4uQ2UO
	 z0gYHiOed5MukvURJnyLznjyyk1Z8gDnZ00Z0Vp3V8DEOTvl12pE2MpUxkOpYm25SY
	 MiNtUPURc4SQoQc7vpzrrvHiKnZ+hpJ1epRMhnVvr9WSSrLh8THKPJmMSeTsg+S0EH
	 vbzxwDXvIUXaX2Czk5+yEtG2RjzYOHl3pNMHqKMQ7hqwaOdHGA5SLYPXpMcs9/MEh/
	 61uK4pKxwlnGw==
Date: Tue, 30 Apr 2024 08:27:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: jtornosm@redhat.com
Cc: Isaac Ganoung <inventor500@vivaldi.net>, davem@davemloft.net,
 edumazet@google.com, jarkko.palviainen@gmail.com,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac
 address before first reading
Message-ID: <20240430082717.65f26140@kernel.org>
In-Reply-To: <hzhomd7d7uc4dcnpvd6ki6v2f6camzm5ufqp2syqudrvzzfxi4@ykcirhonbqql>
References: <hzhomd7d7uc4dcnpvd6ki6v2f6camzm5ufqp2syqudrvzzfxi4@ykcirhonbqql>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 18:16:05 -0500 Isaac Ganoung wrote:
> uname -a output: Linux hostname 6.8.8-arch1-1 #1 SMP PREEMPT_DYNAMIC Sun, 28 Apr 2024 18:53:26 +0000 x86_64 GNU/Linux
> This is Arch Linux's kernel. The patches applied are here: <https://github.com/archlinux/linux/releases/tag/v6.8.8-arch1>

v6.8.8 has 56f78615b already. We need another patch, Jose?

