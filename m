Return-Path: <linux-kernel+bounces-108807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B04DB881047
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34A6AB237AA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA4A39FFB;
	Wed, 20 Mar 2024 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sFqWfsiA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fSa45An8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC73238DF9;
	Wed, 20 Mar 2024 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931927; cv=none; b=Potd+Hy/ViuDvaYeRLfbspn8Nuob+PLBFoX/0mpSoqckj83Kuzr4rdxcJi5eXPnqhgHo3qIVADk9uNb0TwdzL2Vu5dk4vYd6bBrWvIzTk6o7afkx9GuZWS80TXuHPRQUwOO4xLkBJF6h8vWMVQU11cjTu31e3toTyfZ4Ot9R2uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931927; c=relaxed/simple;
	bh=CakNBgJk9vDeqbzefxMLt7ID2KfM75MwAL8Qc9sUo0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fY4dhpSirPoowAkHFOxdPiGKeBhgmnM3eqor0eyH0wzdGJzOXiIDC7luqh6BIBkirxoGLGG9zqPYYWlY0TQh53apT+NP6EwIiCoQrDKnI18CC7Uvfc/scz6L3HL9PFpywFphaKbeK0wvnQqHK1IWmTaVtsR3sJ0aLHk7OwWWeDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sFqWfsiA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fSa45An8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710931923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VO4zCDGYT7oVV7YkUdlk1cK7JA0FP1l7EU9DjR4c6L4=;
	b=sFqWfsiAwAqMKQvGDFhMWWsieJ9mOGQwqjuFZ/LEWVEmpK7lukEmGtG7cnFQD64uikElRh
	piiJrtFEq6FjLawtq7pJ5yRXCPLcMWcFsuoy70NwpA6NclalUa3EeX3k45mYLmYeMVyg0E
	90JDRH/d8PLmY0LvumU8AvcP7OVb5ya0rWiHGE89vrH9DbGXA3Xl/Cxh948X+xqOQm92FN
	PbSJnnNzzs/wSHEyiecj7LEu9XGhS187pxsmuI60JhOG+7DhYlBor8eqgtrdWy/nAO350y
	9iT/Zo7zSozGFhVdiIjyQK9GeR51dx8dIlcGHPBplqi9+VwTcAekA+iOq28RWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710931923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VO4zCDGYT7oVV7YkUdlk1cK7JA0FP1l7EU9DjR4c6L4=;
	b=fSa45An87J9XDtQV6/KHdqqR2/tb7tvciBwo90VhwS1JvVHPQDqterIX5unF7czEtTKFyd
	yHAOFZmI3xD1iyAw==
To: Tianyang Zhang <zhangtianyang@loongson.cn>, chenhuacai@kernel.org,
 jiaxun.yang@flygoat.com
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Baoqi Zhang
 <zhangbaoqi@loongson.cn>, Biao Dong <dongbiao@loongson.cn>, Tianyang Zhang
 <zhangtianyang@loongson.cn>
Subject: Re: [PATCH V3] irqchip/loongson-pch-pic: Update interrupt
 registration policy
In-Reply-To: <20240319124629.23925-1-zhangtianyang@loongson.cn>
References: <20240319124629.23925-1-zhangtianyang@loongson.cn>
Date: Wed, 20 Mar 2024 11:52:03 +0100
Message-ID: <878r2di3ak.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 19 2024 at 20:46, Tianyang Zhang wrote:
> From: Baoqi Zhang <zhangbaoqi@loongson.cn>
>
> This patch remove the fixed mapping between the LS7A interrupt source

Please don't use 'This patch'. We already know that this is a patch.

See Documentation/process/

> and the HT interrupt vector, and replaced it with a dynamically
> allocated approach.

You explain the WHAT, but you really need to explain the WHY. 

> We introduce a mapping table in struct pch_pic, where each interrupt

s/We introduce/Introduce/ See documentation.

> source will allocate an index as a 'hwirq' from the table in the order
> of application and set table value as interrupt source number. This hwirq
> will be configured as its vector in the HT interrupt controller. For an
> interrupt source, the validity period of the obtained hwirq will last until
> the system reset.
>
> This will be more conducive to fully utilizing existing vectors to
> support more devices.
>
> Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
> Signed-off-by: Biao Dong <dongbiao@loongson.cn>
> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>

This Signed-off-by chain is wrong.

Please see Documentation/process/submitting-patches.rst

Thanks,

        tglx

