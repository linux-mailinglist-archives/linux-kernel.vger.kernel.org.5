Return-Path: <linux-kernel+bounces-74651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CAC85D745
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C803FB241D5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C70E4776E;
	Wed, 21 Feb 2024 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="ArEgsrUE"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DD83FE2A;
	Wed, 21 Feb 2024 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515610; cv=none; b=JOH/A7KpUmWkiLzOnZ35jIFJfkyBR3mDirU2YA3EjzvAzbAgnNaeGmYmcTjbZXuhbKR3g0HYeXHl7hwow6PaXAs3ldOT8ENOELn2khpN8MmNkIIPHYe3qr0wg2kT3SWEAVSGma41N/JOL/aSmlS64M2baGX1rOoeInHv22TkUgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515610; c=relaxed/simple;
	bh=+eM3L2jQ1c3/EkECcIctZhwAG4oNsnSIQ9tvDOA6y24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFzZ0aRElIP2Xr9whxg5R7OxcuI1RL4IhaxZace1Mremi3fPTAuxXFMT6TV2p0TyOMLl+3LkdqgNO5EAoNdfimD5PWjPBtZ/3pKxQXNnOaz4tTEdxO61ohB3q2ZP+6z0BR1UTnz7xv2ug35rXxgQ+ILmCR/2LLQCkmOcAfVHg8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=ArEgsrUE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d93edfa76dso40933275ad.1;
        Wed, 21 Feb 2024 03:40:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515608; x=1709120408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yl4Yd7l6TYZU1Jog2Q2J8JIIFkiLifa9PPpHpro0uUw=;
        b=BTRG9uhd7QbzaEktClEFP3s/t3efrtBzDDGQOLk8fXz2Hh4UuDn3p5innpT18ql5sq
         WgFxf2JQ5JOhiytaGwVv/yEM9Up8lqZ0QMaU7bMTif3ypXM0kbtzRiSplOfuLaTIE6wX
         v3O/wDEVmvZ3GqR8gpu6Be0WcEm1VulHYakl5DjIC5ucxcQIAikma2z9Xc8G1Z1CT1BC
         1AWoVNofEkQBUcycrxlbHTUCF9nEZQAxG7XHLfdcQGspli3MNsgaXXGOmfDkqpwA+Nqn
         KC9NtnvV9W470ZaPr4Za6zo7QK63vUa3nsuFH60F4Yp0rcWY7cqQ6KdCgZeD8sszltE6
         kGuA==
X-Forwarded-Encrypted: i=1; AJvYcCXErYGq1/mex/aL4aFQgAvBgecvMadbVm733vnbjXPYZ8vQ1SozlHViX6+o7q/Kq6XyzzRNPxM23dNiCQn6cDbdyJp8GLELAgpbg2vO
X-Gm-Message-State: AOJu0YzSb88jdzNkBJ9aDdn9JUo4X+rSKolKTYtw8aA5Wb5byjMpxE58
	niu2O9yWL3uDpf1CPUPhG05td28O3WAUZrsqjjswGt3trlIuvsU/H+G/2VY1RGgxeQ==
X-Google-Smtp-Source: AGHT+IEPh87FxIADyrDGjRgnUG3+jpMxIwnao9q6vRGyJRhoL9lQkvY6SbdjyiuWReYJnELCQoxmbQ==
X-Received: by 2002:a17:902:e74d:b0:1db:e7a4:90a5 with SMTP id p13-20020a170902e74d00b001dbe7a490a5mr11000670plf.12.1708515608093;
        Wed, 21 Feb 2024 03:40:08 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id kv8-20020a17090328c800b001d9641003cfsm7843102plb.142.2024.02.21.03.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 03:40:07 -0800 (PST)
Date: Wed, 21 Feb 2024 08:40:54 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708515606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yl4Yd7l6TYZU1Jog2Q2J8JIIFkiLifa9PPpHpro0uUw=;
	b=ArEgsrUE3uaLXti4ONyWRuNkizyUNaFbYpUr3birHmvyTHjvLoOd8gyw0ZAXpTykQuJZu9
	FO79KxOpiZD+5N8VL15K54WCLzXFK8AoKL5W7Ovr0bZqFAMEHKaoEdMYJbUV8lgWhAQVsz
	ARLgxn7QtCjz3S0BJuWflLR0Lmxo7gexui2FHiFEUB/A/4Afc+5Q2EjyNDb+c5LwXz2Yh1
	JBq7wE+2kHzkQ6QRKYJnpBX3EqFmnJK0RaetamMcRAjXdXbrOMMyzlz5cYoWrQomGq5tvJ
	LjBUcVymVohS72s6BRgaSa7T1OC89I1+/DPh/+gyNd9VxrpIZ9Icw+oBR3HEmw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] power: supply: core: make power_supply_class constant
Message-ID: <6zdex6yenicex5mjtqkshtfcuauqib64wmjvfzjpdo5xvkk22b@ljakfogmvuwg>
References: <20240220-class_cleanup-power-v1-1-9ef579404351@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-class_cleanup-power-v1-1-9ef579404351@marliere.net>

Hi Sebastian,

please disregard this patch, it's missing some changes. I will send a v2
later.

Thanks,
-	Ricardo.



