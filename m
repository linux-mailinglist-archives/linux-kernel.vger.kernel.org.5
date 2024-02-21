Return-Path: <linux-kernel+bounces-73849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD3A85CC84
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB6D1C2262B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F89110F9;
	Wed, 21 Feb 2024 00:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o24ozIJr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533C10E3;
	Wed, 21 Feb 2024 00:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708473876; cv=none; b=W2nQK4TWSRKmeNLlFvQ30bAdZ/YY2gbQLRLGxB5Py89kXRoOO1B0Z9yB2vdikcJnXJurt7x5F6NJU3+7iu0o5zwPvvAZsn/fR36a+/Z3GftOPS/x1/62r5npPL5ZXpncGhsxsLSH/fUPV8KJFgiiCx3F+pnDlcN8iN/vSvZL/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708473876; c=relaxed/simple;
	bh=yHSwjKDW7Fem/+5K5TCpb5s7RYKmtxARYO2esnCgmpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GhQCT3Hh5JNW7k7vveOGraDFtxF3s6u5xUqnUhmcvHv8bn55w0GGHrnoxNbVQGuxnM36upp+ndH9aqbqPnV3ofjUrmIhSNb3rbcjMxRKFJSjIxEMvgJm0dMNA7Rthv4IIBdr/0/kzA5XqGdbDgFPYGWKT7SDwAHe6fuyrhgheLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o24ozIJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A708C433C7;
	Wed, 21 Feb 2024 00:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708473875;
	bh=yHSwjKDW7Fem/+5K5TCpb5s7RYKmtxARYO2esnCgmpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o24ozIJr3Jg0cR5vDtFHoouwPmJ3pivfUX4a4AT/sKKxXlc5he8SAd+/usGIkx2RK
	 VG/BXswFC/k8V1HrU6LH6xkanfqksVX+LeaixjDj0KHFSHYxpMAjnkEun9RdLkmXqv
	 pJ3s73eXWZ4ghwTkTdshsroAejW9GEURe55LP/fJ1G3ytXu6MEck2vm1E/yHeRhqcK
	 CpLcGyADPebNq8u/pDhcWDJ5sb1dbnC1hh2lRSWqx2hi/hGjScGDiAxCQgxeB2/lZG
	 Ui5Cyp6Jpsk7j0GIBfZJhkh/oe8pT2X/wheU6aSswf4pP8xIAN2e1MSH3qMvpia9rq
	 B4Q/JDHCVCweQ==
Date: Tue, 20 Feb 2024 16:04:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: kovalev@altlinux.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, edumazet@google.com, laforge@gnumonks.org,
 davem@davemloft.net, pabeni@redhat.com, nickel@altlinux.org,
 oficerovas@altlinux.org, dutyrok@altlinux.org, stable@vger.kernel.org
Subject: Re: [PATCH ver.2] gtp: fix use-after-free and null-ptr-deref in
 gtp_genl_dump_pdp()
Message-ID: <20240220160434.29bcaf43@kernel.org>
In-Reply-To: <Zc5NP/5Eyh8bsbH6@calendula>
References: <20240214162733.34214-1-kovalev@altlinux.org>
	<ZczvJKETNyFE5Glm@calendula>
	<a4463193-fd73-eca3-616b-d75176d947c6@basealt.ru>
	<Zcz0tG9XMqLHMKs+@calendula>
	<1044d472-c733-3901-9df9-41a29b2c9fb4@basealt.ru>
	<Zc5NP/5Eyh8bsbH6@calendula>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 18:43:46 +0100 Pablo Neira Ayuso wrote:
> > Yes, I can prepare several patches with the same commit message. Is it
> > better to send them individually (like this patch) or in a series with a
> > brief preliminary description (PATCH 0/x)?  
> 
> I'd suggest one patch for each subsystem as per MAINTAINER file, that
> should also make it easier for Linux kernel -stable maintainers to
> pick up this fix series.

Pablo is anything expected to change from gtp patch itself?
Someone (DaveM?) marked this as Changes Requested but I don't see 
a clear ask, other that to follow up with patches to other families.

