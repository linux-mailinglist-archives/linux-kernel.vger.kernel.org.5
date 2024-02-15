Return-Path: <linux-kernel+bounces-67443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDAA856B99
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB3728406E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA4F137C35;
	Thu, 15 Feb 2024 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQdQ1WMe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2A613667D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019499; cv=none; b=QmSO+lLIeXwRV2AzAxFSIFyjIs8JLW0F2HYy7mkbTnbonwuTVSPAP35KsTywyEOeNWKCMDCs3NbBPaMogoC4QbBwUzfB28CMolhQYAhDHliDeqZ65hXyTuHZNVUFGBo5uPBxaIxbxoQGhnVm18gANE/PWzpo5AN6rfsdHh8ghns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019499; c=relaxed/simple;
	bh=uWn7JPvg51SksgaZWGKJtP5oLBDREUXXipDxKopFiXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzNdezVq31HWnUKV8G8N4BQNSYknVZDO67itsfHwBusPqT0G85pRqIAVXZPEVULPHcAHLe92349yMui57YT8fvyrzcffBRXgqICzIiAVAzJ3pcBEjfY8AsEKYoIwxENUi6w4B3mTubp+oiAbOrklbY2jymCGw+AQVBasRSI4Qfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQdQ1WMe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708019496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GG6Ulxh+r2vwDrd1myPyHalaQeRg4IYOcP2tfu6yPes=;
	b=QQdQ1WMeJI9SPRyYPtGFFwhbi9gv5jn5FfjLj08+880+kHEyPJw7aLHyuq+zf9xSevcTcQ
	5IazelkOpQviVjf/BDG0/bFJGlQcE2wrx/LSA8+uq+/g2pN6XcKfJWb4Y4UnqucOW7IcQl
	X9bNT7yx0wr6ppkRdf3Yos8J1IyoxlY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-WaAN2ccvO1q6c7KHKvc2Xg-1; Thu, 15 Feb 2024 12:51:32 -0500
X-MC-Unique: WaAN2ccvO1q6c7KHKvc2Xg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7C20185A780;
	Thu, 15 Feb 2024 17:51:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.56])
	by smtp.corp.redhat.com (Postfix) with SMTP id 3AFE3492BC6;
	Thu, 15 Feb 2024 17:51:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 15 Feb 2024 18:50:14 +0100 (CET)
Date: Thu, 15 Feb 2024 18:50:11 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Russell King <linux@armlinux.org.uk>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: ptrace: Use bitfield helpers
Message-ID: <20240215174945.GA29299@redhat.com>
References: <f73e6deb1bef9696661a62498ee5a56ac9a389ce.1708005130.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f73e6deb1bef9696661a62498ee5a56ac9a389ce.1708005130.git.geert+renesas@glider.be>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Sorry for the noise, can't resist...

I am replying only because I wasn't aware of bitfield.h and useful
helpers there.

Thank you ;)

On 02/15, Geert Uytterhoeven wrote:
>
>  #ifndef __ASSEMBLY__
> +#include <linux/bitfield.h>
>  #include <linux/types.h>
>
>  struct pt_regs {
> @@ -35,8 +36,8 @@ struct svc_pt_regs {
>
>  #ifndef CONFIG_CPU_V7M
>  #define isa_mode(regs) \
> -	((((regs)->ARM_cpsr & PSR_J_BIT) >> (__ffs(PSR_J_BIT) - 1)) | \
> -	 (((regs)->ARM_cpsr & PSR_T_BIT) >> (__ffs(PSR_T_BIT))))
> +	(FIELD_GET(PSR_J_BIT, (regs)->ARM_cpsr) << 1 | \
> +	 FIELD_GET(PSR_T_BIT, (regs)->ARM_cpsr))

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


