Return-Path: <linux-kernel+bounces-104718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5F287D2B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93EA2281DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0879D482C6;
	Fri, 15 Mar 2024 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BYf/YMrU"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49844642A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523568; cv=none; b=V7nxLM3WFzTh5xDK1A/cL4DrPkgy++KKzVZSydiQl8W3YfAPygSRaPQWwHn/Qz59Q+kNCtWs94L8HpPDx4Cxp3w3z0pnL2uxKNe7aleAfU6QDrzhB9b3e+RCP6RS9jLRQqo6hRwWcTZINRsTrSIkHaC6zJKZwc+Kx9P++dm+U4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523568; c=relaxed/simple;
	bh=cFTdYcax5gRdWhzgeNIJ1mjhAy6vbDir1d7YavE2RGk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oIHx+1t1tYHfWySfSsLOTTyI6gNM7tQNu56vaTqBSZV96j43P1VZZRfqJOEaLxf63Vq3DE8NpnTid2jElb/Vjio/bw0uxKIh+DJkcYH1cm7NYVcUpec2L/n6xnqYuDbcElQqFGrNCVLoraDyKydDmaq+drZrOn2VIiin9QMFVWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BYf/YMrU; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1dd916d7d55so19993975ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710523566; x=1711128366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hvVwcEiJwAJ+sbhcH9TeiA0j2HoTmMi1pHT6QVcoQQY=;
        b=BYf/YMrUfmPrwO+TKfdeVk8e9+2FR2CJj3IHxzYPbWxrAXn4sX3YoXLBKxFNAhvaTH
         V6zPOsxtAzKai77boYNETzcnP3A1LNirQZPXTuSeOmods7mv8LBNZvi1ErNq91JghmgD
         2LbZP9WBh1t1M5XNyuRV0D8bL7IlpuHQCxvIExvO5U1h1tZEKOyLk9ez6tGZJFIM4n6h
         klQysXxlgRn8IyrcncF7DHzvP9jW7OrtsLmowHa1b0XvGtzmvi0+4H3A5t6IX/Js3eOy
         mOfpxKjOH8ZU9d5XQKHSBTc7R3Nb6bDZq3Ru7Ro7zv5N8LwvzR00fkeWtjOs1jFaaO7j
         lzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710523566; x=1711128366;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvVwcEiJwAJ+sbhcH9TeiA0j2HoTmMi1pHT6QVcoQQY=;
        b=J/BIXgVkBU3K4F0239OQgWV7WgJA8U1R9K1xgkN/MFWimyyGzssdGK2G9Gm5cHXwXz
         eu92Aowg42iaveYrmm48tSyYc1oRRSVlYoHJY8FHnd+yT2rzHDEEcS2ukw0fTouVAayf
         IDt+5XI4XMCehsmzOLmr8ADOIAmp4cgmtgdC5uzrszhce5uD0VjdNTgR+KfMm1VIlAj0
         FcWV/UCpem+/RZ1UdnPqNVcz/f8hFDDK85zR04XEMeIvdrgPchhTaizbP1xA2tWsaNy9
         jmVH8iGvE/rzzvMoopOz/05r5sIyBOoJmtRHRDl9NUl9MbIwfIR60CKMSk3R/XAm/qec
         M09A==
X-Forwarded-Encrypted: i=1; AJvYcCVJ8unGGacm4bz5BVH44ONn4fXh86cLyV453Oqzaev5OSs+InEPpyQjxKqO+MZUZA/Cc47EDbPiq0gl6brxQNS2/D4I8SJppISMIxuC
X-Gm-Message-State: AOJu0Yya7UJjIdaAyHg56xj8pR1n05HXpKdneHwTPGaiym4II1gqK7iP
	4GcpwTOHlND0XryYpeiO0zsJuumsfh3ui3ItpFk7MBUMJANsBVEz3kNIFyCOuC6uDw==
X-Google-Smtp-Source: AGHT+IG7rbyBC8cmSfSgM1ZPt/64xcQzRHRYJmtaC9Fz4S0LeyUtL6P76VYLMAsrIGzOhoP6Sg/8mug=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:e5c7:b0:1dd:dbf6:57de with SMTP id
 u7-20020a170902e5c700b001dddbf657demr46533plf.12.1710523566056; Fri, 15 Mar
 2024 10:26:06 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:26:04 -0700
In-Reply-To: <20240315012249.439639-1-liucong2@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZfNXjd1ML2WJwOKX@google.com> <20240315012249.439639-1-liucong2@kylinos.cn>
Message-ID: <ZfSErGdSKDnMpPzd@google.com>
Subject: Re: [PATCH v2] tools/Makefile: Remove cgroup target
From: Stanislav Fomichev <sdf@google.com>
To: Cong Liu <liucong2@kylinos.cn>
Cc: akpm@linux-foundation.org, bpf@vger.kernel.org, 
	ddrokosov@salutedevices.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 03/15, Cong Liu wrote:
> The tools/cgroup directory no longer contains a Makefile.  This patch
> updates the top-level tools/Makefile to remove references to building
> and installing cgroup components. This change reflects the current
> structure of the tools directory and fixes the build failure when
> building tools in the top-level directory.
> 
> linux/tools$ make cgroup
>   DESCEND cgroup
> make[1]: *** No targets specified and no makefile found.  Stop.
> make: *** [Makefile:73: cgroup] Error 2
> 
> Signed-off-by: Cong Liu <liucong2@kylinos.cn>

Acked-by: Stanislav Fomichev <sdf@google.com>

