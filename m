Return-Path: <linux-kernel+bounces-102734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E145187B6AD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC0A1C217A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAA146A0;
	Thu, 14 Mar 2024 03:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VFHE9Ulf"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4BBC15D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 03:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710385481; cv=none; b=EhdIOqzVcGkfHLaztCAms0QTW/H3qgmBUJxZLppQOTqHjAb608BfALC6+rwE1OwpEFcKzS9cPKpDB/YusAM0k2r82El/V/FTWRdvpiP5tt6HRDds4Ufa6XqGEkE6IZ8/6mQPi3K/y78nDdfDFj6hbbhScxAlMYpyexxF+P2S5dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710385481; c=relaxed/simple;
	bh=bJjBwjuhEPyH1J1zFhdFWl6hJIg2k+e5LEAbP8QrZVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHgnyBZmRTPSZBOAQfoBhfFY+9hXfWuJkTGhAFe+ICW1OhipOlALUwFiODg4FJEFoBuqwzcX74g2leOb4o5KcvY6hSRTup6qVLt+3vpIlIddtsenRQoFWl3tWSzkaBEmjSzlSEKv+C1Fjustrt165a943EvJhjVua9gnkGrThZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VFHE9Ulf; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c19e18470aso428563b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710385478; x=1710990278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7M92JDTBKJBnzq2c5WZ2iPAaVSzm7Qg8SLrpTCfSZTE=;
        b=VFHE9UlfrI4SWRGUmDdXLzy0IUnnrDDfGnSo/2JniGXAXU1NR3G1k0IpW7O7zu5Etu
         1nvVq7RyjH52cH7wo3wQYinrQNrJHOWhm0rs0lPayPuZgqB24m8pafzDFwha1T9etv8c
         Gbiy0eZluBo22TJ14OVQkirt0N4k2/oM8B8rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710385478; x=1710990278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M92JDTBKJBnzq2c5WZ2iPAaVSzm7Qg8SLrpTCfSZTE=;
        b=im5DH/zM9cm4aw8CODf4zFiHjlkeCVJFvkubt0m5qvkceAdZG6dE2dUL3Mxa2AkZpS
         nW5BnuQ8Yfrclro58y5uUgdRXongOY6+rrZvYcrISopxaZg9NEd67627ukKtI3430kFr
         oR8F00wndQMb8yMvQ5Uuan/hyEy62mKI49XbqVit/6pORhY5+AVZLb7Wyo/jQuMFc3Vj
         KcLMylNsrNW7jpVkK4GwgcKNwJpyC/BQp3kqgof1R3O0eUHMfQUkrh4rinyk6pX2E5Zm
         p2ro7XH8wFequXg0rdTuNIqGvLwsYMHcCPHbA7IQK/Fvb/TMPaaXxFgyXDnwxoqBalb7
         +/MQ==
X-Gm-Message-State: AOJu0YwW7j0MO5eZdRX0Aoj6ekmAEf0Z4kmpXE1CJPfOCjF0fwA8flI8
	fKsU68/bPXulx+qjhgKaV88iVRO/w4dHTnXpw0gKOovVp+VjXIUXg8/UcYX7nu3v3dgXTi9bkKA
	=
X-Google-Smtp-Source: AGHT+IGX78gwvPQsRfMbGbqRKOXXJL6wFsOcabHKtVC9b8pu0uClVKBZQQGqmmU0LqjpbUu+LXJxlA==
X-Received: by 2002:a05:6808:11ca:b0:3c1:cb6c:8ae5 with SMTP id p10-20020a05680811ca00b003c1cb6c8ae5mr540662oiv.25.1710385478594;
        Wed, 13 Mar 2024 20:04:38 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z25-20020aa785d9000000b006e5359e621csm329271pfn.182.2024.03.13.20.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 20:04:37 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:04:36 -0700
From: Kees Cook <keescook@chromium.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5.15 64/76] proc: Use task_is_running() for wchan in
 /proc/$pid/stat
Message-ID: <202403132003.BF9AF5CA@keescook>
References: <20240313164223.615640-1-sashal@kernel.org>
 <20240313164223.615640-65-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313164223.615640-65-sashal@kernel.org>

On Wed, Mar 13, 2024 at 12:42:11PM -0400, Sasha Levin wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> [ Upstream commit 4e046156792c26bef8a4e30be711777fc8578257 ]
> 
> The implementations of get_wchan() can be expensive. The only information
> imparted here is whether or not a process is currently blocked in the
> scheduler (and even this doesn't need to be exact). Avoid doing the
> heavy lifting of stack walking and just report that information by using
> task_is_running().
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20211008111626.211281780@infradead.org
> Stable-dep-of: 60f92acb60a9 ("fs/proc: do_task_stat: move thread_group_cputime_adjusted() outside of lock_task_sighand()")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Looks fine to me. Can you double-check that commit
54354c6a9f7f ("Revert "proc/wchan: use printk format instead of lookup_symbol_name()"")
is already backported too?

-- 
Kees Cook

