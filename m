Return-Path: <linux-kernel+bounces-109294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9117881755
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49EB7B217C1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33B67992D;
	Wed, 20 Mar 2024 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M09ebZgi"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD99578B5C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710959481; cv=none; b=GqWwq0ZjdUMEHlK+OuTt1NPigMyalMqTwxKZlHtgxysA/apFwtUURiLYK5Pa78gUsKJcV9PI8hAG6o7M3Z65W31952CpTMujmnz1g74A/R649FYkzqG18Xr6pp4WCuZYwC46SKhr4Tnu6gFt1Ha2J86inef9LouDxIYegejdnnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710959481; c=relaxed/simple;
	bh=DSs966mJjsiG+7AQTgBXXi34pMgfUEsx3ESCD1Y+zng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+N7fOzhiJ9tTXrbkos7pcrBojjgim0wwupL7IYQSST87rcyTWrWh387sY+OxPQ3iIEgMcd4DYiZph7UtXlkVDdP7ut/AVLxTt2EK++P3zbs0yqrbcfw2UGHuiKSxX81ng4ahsBf4E653KbcHk7KQNOgtd7URhTdX57SBHO5IAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M09ebZgi; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6098b9ed2a3so1053847b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710959478; x=1711564278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K68ya0JqOFHoBU4O4OIl9a5+/vzjyqM9x6q+SdVkY0g=;
        b=M09ebZgirwU6fT+GoG9XMG7f9JVBpGvPlGkIP2vVyAHPbTfgF9ulgP9HPxRYwSk4ij
         YDE42WQNivRMGLvJeZlW9LmT1E0KNtZ0bltyIa2xkTYDNSSy2i9TGBJdjaENIqQ3uVZO
         v16sl9zDVzjUjbnG65Wt28/rdraKvNPZEebxaS4jEN2nL7zLA8baKcBYy/f8vfv2TyWM
         3q0fuGnSifmVLPW5XeFtOZQYCX9zcP8nY+RmFuI4CkjCGKe36ZG26VLQTs8lr7nRk2l7
         rtid4sx3dYZrDXXWZrp+0GU+9Z3fsjofaTGwakKBicCuPkddKptIsGcu3+b6mRhCLEZ+
         igoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710959478; x=1711564278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K68ya0JqOFHoBU4O4OIl9a5+/vzjyqM9x6q+SdVkY0g=;
        b=DkERwS7xWe6Hr+YnSIm+3aZgZ74T3p7EdS0bdBJkuNBjiUV+E3y5KzF6oRIEkE/DST
         1P+IQ1m0ACJYKaijzxJbpxZo2Y8I0bUzW7EaDe5K9PUabweSS0htv2jsW3sQMb4NTWxH
         I4Z6mFCJ33tk2sv7tIeNcSma3HI+xTFYBnr5I4QJHtgI6frOr4wP4wgYgyxZbsfITr9N
         2qG3+UPsj14wxkd9DxOF5e3ZPpyn6953pZ2MQq4AUK11gNdL0gb4+QTKIlKDdAoSezDc
         asCxvM0Tx6s+5Ujp+TOXuENrzEkekQUuhyq39NqHFnuDg7Pg8X0byPViSciZHkMprbKH
         bNRA==
X-Forwarded-Encrypted: i=1; AJvYcCWwlGPCuL+A5SSWUR2GG2Pq+yPOaFloPdQRbjkdMuO2HaKjDnWKRse/JpOkYViQD2bfsZZS/vvbow183IY6hUITYo5Rn3dKL3X3EH7Q
X-Gm-Message-State: AOJu0YyJd/oFdMnn9tQuDy9rGFuRW6aoq1PU47/XtB62RRLhvMkvgvTG
	tgtFKZaPBrrfj8tbBoCK1BN9PzH1iLDQruhAh5x23az9J/bBjvse
X-Google-Smtp-Source: AGHT+IFpokRYuZBJeyKANNo1mgKaUFSLfzKJJYxsqMuCigj7vZ7mfpM7dNgEOXyAj1sk8+CqM8xRZQ==
X-Received: by 2002:a81:5342:0:b0:610:b259:fa65 with SMTP id h63-20020a815342000000b00610b259fa65mr11616658ywb.48.1710959478540;
        Wed, 20 Mar 2024 11:31:18 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:a6a6:49c0:6a02:df54])
        by smtp.gmail.com with ESMTPSA id n16-20020a81eb10000000b00610bdea0d08sm1591215ywm.62.2024.03.20.11.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:31:18 -0700 (PDT)
Date: Wed, 20 Mar 2024 11:31:17 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, russ.anderson@hpe.com,
	dimitri.sivanich@hpe.com, steve.wahl@hpe.com
Subject: Re: [PATCH 1/2] cpumask: Add for_each_cpu_from()
Message-ID: <ZfsrdcUOsNp7ATjK@yury-ThinkPad>
References: <20240319185148.985729-1-kyle.meyer@hpe.com>
 <20240319185148.985729-2-kyle.meyer@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319185148.985729-2-kyle.meyer@hpe.com>

On Tue, Mar 19, 2024 at 01:51:47PM -0500, Kyle Meyer wrote:
> Add for_each_cpu_from() as a generic cpumask macro.
> 
> for_each_cpu_from() is the same as for_each_cpu(), except it starts at
> @cpu instead of zero.
> 
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>

Acked-by: Kyle Meyer <kyle.meyer@hpe.com>

> ---
>  include/linux/cpumask.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 1c29947db848..655211db38ff 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -368,6 +368,16 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
>  #define for_each_cpu_or(cpu, mask1, mask2)				\
>  	for_each_or_bit(cpu, cpumask_bits(mask1), cpumask_bits(mask2), small_cpumask_bits)
>  
> +/**
> + * for_each_cpu_from - iterate over every cpu present in @mask, starting at @cpu
> + * @cpu: the (optionally unsigned) integer iterator
> + * @mask: the cpumask pointer
> + *
> + * After the loop, cpu is >= nr_cpu_ids.
> + */
> +#define for_each_cpu_from(cpu, mask)				\
> +	for_each_set_bit_from(cpu, cpumask_bits(mask), small_cpumask_bits)
> +
>  /**
>   * cpumask_any_but - return a "random" in a cpumask, but not this one.
>   * @mask: the cpumask to search
> -- 
> 2.44.0

