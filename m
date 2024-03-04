Return-Path: <linux-kernel+bounces-90326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799F386FDAA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9CE1B23ACE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22B9249F4;
	Mon,  4 Mar 2024 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="vbtjW0GC";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="h7rmg+v+";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="L8PbEoDI"
Received: from e2i652.smtp2go.com (e2i652.smtp2go.com [103.2.142.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0545018EC3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.142.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544428; cv=none; b=XR0tGJTprYQpFSd9FiTrrPmloYDodk9pP4bYbEg9Vi73AWua/AaKW6KSjFLVze8fDxp/vn62B/VQ7x12d3Z9PKCS9Bodij+qRUh3SI8qX5U7QzcUKTuPR42ws10p/BhIH6KfiEA+x+d/WHV2hCC2S2vx338CDANcLooN7PRuGXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544428; c=relaxed/simple;
	bh=7VDmsob5dJwaz3X9qMt+VxPXL/JvM00gxmRyrpIxXqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUqh1CEJHM0+v9Mq1axaMhXAq7HkAsmy3fbhpgxoVzIivJIUEYrdPvuK1Au3GKXfgcGMltyYWAIV2TsO3xPEu5yL7Ykg6GqxRx6ngkRJLvb2Hn2wU3ZtLtLBqxdcF41YyTqxLbJ7+GKUkeB22Av+fH49881mT/DgO7faqAp/I1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=vbtjW0GC; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=h7rmg+v+; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=L8PbEoDI; arc=none smtp.client-ip=103.2.142.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1709545321; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe; bh=dSA4zZatV9UqbY6asTaR1XvA3gHAvLPK2adXkrBBVSE=; b=vbtjW0GC
	BLX51jz5AlvSmVa9hxalu5bVfHkoY7HGoIrewuPL/QxFmgTWWF6UFzcuLCN7zdLPrR6oeQbuKsOHc
	WnFPtI45ZXjQ73Av4CRhx9u7zVPQE4yW6e45l48Hx3fLWk8XgOWkIwoxdj7cONC09ksXZRQknPxuv
	7Yawu+EtK/yQxhraMD6c78DQkBRaVgVNvAgAsGpIAxTlB4LxgDZfB9fFogZmvLZb/bBZMUzvPE/+S
	DTZw3C9o4deBKxKx6lyPQpfKIReUq2/wJv2EHOcLVGTrPkbeRXZbPWMAMgKi79dEzjOVupi5/NCc4
	yP8/xr710koUPV52vScOVz9+5g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1709544421; h=from : subject :
 to : message-id : date;
 bh=dSA4zZatV9UqbY6asTaR1XvA3gHAvLPK2adXkrBBVSE=;
 b=h7rmg+v+J6WpSvdoVzyIetOFgvNuRDdmjJG9QNLUeWOSskxmzsbxAlmVV6sBAdm22hvEP
 kQBWENGBMaXaC1UmCroSvHliGhT8rdjKbo+pPbVkh5ZnCN4rj1VdNusvaA2/enkR0UoBwpE
 62J41E7Jro7XdoTOTdFjepH54mf2qYiI1sX7adz9xT7UGOZUuK0PimZyphZLoYm7CkPsl+n
 t/UU5C2QNqC4HKZLr+y/1Ha/9U8dMsNW6DjBUoSUO20c5kayidqdxMZuuOlNbc9J6UXH2kb
 V5Gv+7LQkUkkk9u/GczdSLogR6Bo0IOZenPc2Wmmy+SOMAK99RnXPnNNefxQ==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1rh4al-qt4Jyi-NR; Mon, 04 Mar 2024 09:26:39 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1rh4ak-4XdKRo-2S; Mon, 04 Mar 2024 09:26:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1709544397; bh=7VDmsob5dJwaz3X9qMt+VxPXL/JvM00gxmRyrpIxXqc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L8PbEoDIRyhOAJsNNVtfEGp7Kf/YyPuMCfIc/ZbYWls23k8CexemOWoOVkteqmQV+
 u/aXJwND072hSFMlOdTCvXjGIp84hoX2VkIE0nN8MLQqYZq6k/HfIzMsB9ON4P4VjA
 cAu3YCePvRfbpxtgFMOjN2F04gszsBWfMy3+Lfmk=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id E94683C312; Mon,  4 Mar 2024 10:26:36 +0100 (CET)
Date: Mon, 4 Mar 2024 10:26:36 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] kconfig: link menus to a symbol
Message-ID: <ZeWTzJK8rX35tRnJ@fjasle.eu>
References: <20240303040035.3450914-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303040035.3450914-1-masahiroy@kernel.org>
X-Smtpcorp-Track: 1rh4ak4bdKRo2S.5leN9HMjaWrVc
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286syjhgZ2FMH
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Sun, Mar 03, 2024 at 01:00:33PM +0900 Masahiro Yamada wrote:
> Currently, there is no direct link from (struct symbol *) to
> (struct menu *).
> 
> It is still possible to access associated menus through the P_SYMBOL
> property, because property::menu is the relevant menu entry, but it
> results in complex code, as seen in get_symbol_str().
> 
> Use a linked list for simpler traversal of relevant menus.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/kconfig/expr.h   | 5 +++++
>  scripts/kconfig/menu.c   | 4 +++-
>  scripts/kconfig/symbol.c | 4 ++++
>  3 files changed, 12 insertions(+), 1 deletion(-)

Thanks, the whole series looks good to me.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

