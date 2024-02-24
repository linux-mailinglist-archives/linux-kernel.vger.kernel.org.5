Return-Path: <linux-kernel+bounces-79334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FF38620F2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70983B23A9B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8410F2;
	Sat, 24 Feb 2024 00:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RyjJkMUy"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ACD38D
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 00:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708733064; cv=none; b=ZHw5WxQUyOSlcp3ORI78BzeQ+Y8iE1zeEU8Ku4pzpdqcOXzl2L7hlkC5szyC7uOb9Q66bGJPvK97o+LDiKAcLBEhvAUkHLBfoqr9sI8tET7F+L/VfIoY0PILfv0fZJmohmd7B0CLOfpdbJPZ7OoNhtG9V5rbL+qyrNEWSP3SM9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708733064; c=relaxed/simple;
	bh=0ds54stYRJYXdcupiGXNSBbXhWKSZRXX9xz6jkYlvbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wg1IPLaKeG75FD5k1hQ+qeJ/5NPyQV7sD7HPjVIV+b5RNlCSslPM1WEhZia58FaSZmCkiG2drI6aBWIZ49PE/qjE55QpBIpSeJcF4jHCtej8mhK4tPwsijrUNnDJrvFbLMFCF3rfN7rlYL/eAOejoq4vWsCrzSRF5imokxBNy+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RyjJkMUy; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e4d48a5823so1247864b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708733063; x=1709337863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5zKbRfawyxNOTLG6sLvZY1qVECMzEB4oUCp6oCLj67s=;
        b=RyjJkMUyBvWNJHKolip2EkDAn92pF2xO7O7uTFhIE1+BbOVWinvPSfWRTBeTP01+Nl
         8rNWJYATufI/XWMRuMPEMgof5lNy1LMWB5gGyZ6eWFEFgOzwxWe9B6xeo+Rukwx2PPtq
         Mh+etN7MVMG0RAhY4Ur4Gt2vmPrXu26JGQ9vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708733063; x=1709337863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zKbRfawyxNOTLG6sLvZY1qVECMzEB4oUCp6oCLj67s=;
        b=wczvD5DVlRnsOWmNccaXokAWVHsD3+8+L3swtD4fnMY/+STkuVBjavc0pVs7cMyyQz
         /g084hWRgIji4ZK38zSP4lGupwvwMlSswaHbteRHDkz2TIiNhfBJfnt5nC7l80sH+nLd
         EnRVxGuJjku8vaqcBN3zg8mOYH1zZtKikdwUyCOfVcoAbljMFhD5pzjgxQXB4KdCnp7N
         C/YThhz7uL9GDj3oNAtpZUxia5wtpU9zZQ6YczQ/R6UMJCZfXDBT2qr1UlIMsG+ju17y
         XXPvnMWN3tQucDIWASp5BL7UdvdAMI6uTL+4YFk7voHGnSljJLT/k0qnT429d+79YYd4
         1bIg==
X-Forwarded-Encrypted: i=1; AJvYcCVSaiVcenMjqUMPGjlY5X2tFC6z3X45r9FQsIK9xJgzVObT/KvivNehfM7BROOJeR+BvjW3W27ftWqWiQVp8wfFBpKqiu6wPR3XsvOa
X-Gm-Message-State: AOJu0YwP8ripH+K6xIszFFNF3aOLErUVCA84FZIGn323WQOsaXviZukz
	gDw9eeDb1HmLL7VoDhZawCih8UfojDXs024G3ktyoG7/Y87RLiXHCWUfFkfeYg==
X-Google-Smtp-Source: AGHT+IHo5R8UEkP5waaUA9rFjuVosSU5ZEjKaimTg1nvTAlM5UVPe02qZg/kFBCfFuPu/PquVW6dIA==
X-Received: by 2002:a05:6a20:d393:b0:1a0:a43b:cbdb with SMTP id iq19-20020a056a20d39300b001a0a43bcbdbmr1502973pzb.27.1708733062756;
        Fri, 23 Feb 2024 16:04:22 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f19-20020a056a00229300b006e3a9bdeb99sm46910pfe.40.2024.02.23.16.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 16:04:22 -0800 (PST)
Date: Fri, 23 Feb 2024 16:04:21 -0800
From: Kees Cook <keescook@chromium.org>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Justin Stitt <justinstitt@google.com>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saurav Kashyap <skashyap@marvell.com>,
	Javed Hasan <jhasan@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	Don Brace <don.brace@microchip.com>,
	mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	MPT-FusionLinux.pdl@broadcom.com, netdev@vger.kernel.org,
	storagedev@microchip.com
Subject: Re: [PATCH 1/7] scsi: mpi3mr: replace deprecated strncpy with strscpy
Message-ID: <202402231603.152B165@keescook>
References: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
 <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-1-9cd3882f0700@google.com>
 <512c1700-b333-8aea-f19b-707523ac3a6e@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <512c1700-b333-8aea-f19b-707523ac3a6e@linux-m68k.org>

On Sat, Feb 24, 2024 at 10:58:07AM +1100, Finn Thain wrote:
> 
> On Fri, 23 Feb 2024, Justin Stitt wrote:
> 
> > Really, there's no bug with the current code. 
> 
> If (hypothetically) you needed to reduce stack size, just copy the char 
> pointer instead of copying the chars onto the stack.
> 
> If (hypothetically) strncpy() was banned altogether (rather than merely 
> deprecated) I would do the same -- but I'm not the maintainer.

I'd agree. This can just be using:

const char *personality;
..
	personality = "RAID";

etc

-- 
Kees Cook

