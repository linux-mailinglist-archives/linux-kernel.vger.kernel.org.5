Return-Path: <linux-kernel+bounces-133237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE9D89A107
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2AB1C23605
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032C916F902;
	Fri,  5 Apr 2024 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="m5JhaYpD"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C0116F83A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330790; cv=none; b=VTuJaGNAdxWkQ+XTrFhow+di6SB0sFTBgzupnKXZrDuop7e84EMoLo8AM/frxCy/ikF6JjDnzuxsm8jThSgSo+sBOkjOhOcuLH2H07W3S/VQRSLt+j/S2r90oc52SeGqnJz4zeoQT1YjFZfb+9o850ZtRC7KE4NQHtIGRztEHQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330790; c=relaxed/simple;
	bh=HtqAXJJnHRfT9g4LDUR7vqtulCPVoSYnB5udjgdAU5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpAd64OQiWryOjMH1WZKiOUrxXGz8Nw3NfGoxY4jYoz2PIwdy5anSf+iW7yC2uxbUJDqzdBYD5tpOAQiRNG8CBS3DKzoFi7vJs23CWwogxhYcU0I7JBATmiccGtJ2ElbYjZtVELj9FYtUe8z9dMGNRqC4qgxhTAgHvjS58W9W3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=m5JhaYpD; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6991e317e05so28607406d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1712330785; x=1712935585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7egvzgt9f/+4/rS4d4Ep6v/hZKTSJpzgLfFJthInX5s=;
        b=m5JhaYpDV+yq5+D0OB65YegkSqxbm2jDy1axWfInW6uDwHR4wPQEwFy3OCgChUzUTG
         Z4xbK2V7fc3PJJykhle2beTWjCTcGI0AK0pT6TPWfrmSQB/awY0rviAgarsQVMKzXHct
         RSBne5s1G5giPOCM+AqBlZPz3hgOq2y2XoNxgGBiMlaQTVMsfzyQ4IaNVi/ioQoaLx83
         5+4QmegK9yOrbBtxKugOnyT2zGMCBPqQwqHFlXQRjpY8mbOZ+L819L8+GnzJbaYgV/vJ
         YlqnnsOeQDtg29A+JTVw4E3sAsidyRFHQQgxLv9ktlKKGg0FgEQ2wlEdDzov/t2ITi+g
         ZsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712330785; x=1712935585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7egvzgt9f/+4/rS4d4Ep6v/hZKTSJpzgLfFJthInX5s=;
        b=lfAQVwwkEJTUnh4XYLA9x6UJ1frdOyvgEfi8ULev0IKcIOW9C7XaDNTT6PwJx+MJUo
         hvVSULre9f5uN9v2Z6RNrJp5XT818HxbJvqbVI5VLGLPV7R/eo1syZktEh3IIbZlFF6s
         lWS2GaDIw6xECZFOSFG7SJ6hnK14jwP6hkBAC2rVWRlf0c6guPFXuOdhFvtINkMgRL60
         zk6XgHXr/xgJpO0EP0KQO132Cq/zCIycW4lmdOwlv0LE/htE6vl/w61hnD5OqQXoo+s+
         k3Lq7G6PvqBX9fKWwfVi8l8BrpGEb2ieQ0tAa+oWwjD0eGXRQIrNA4RCuBEe30M9TxmL
         lXlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9Hvho2wa2/nn0bIryD8lrS+rFVv1r2edBnBse/wiH0pyKcA3OU9NgMhobkbTOJzlqWfieB4+rV91wkndM/BugzcFIwb5LJB8R/7OV
X-Gm-Message-State: AOJu0Yw2vWfdZv45MjbWKPbhY67/1mcPehH7Q+RZ/2rdP10XS1vZGvlq
	XSRewWsRaAi3X/BmNYhfKYEPDaxuajjoEHnPiwxDu5faNlEi+D5Ya2aUF0LQ2mI=
X-Google-Smtp-Source: AGHT+IFZlYtHK9H9NQkqEujS+EyV6KdvNcWq0KOgdHxCZ0lHfjpS8D/j/RpR3jzXkZX6xv5m2UAjHw==
X-Received: by 2002:a05:6214:3019:b0:699:336b:666 with SMTP id ke25-20020a056214301900b00699336b0666mr6427813qvb.7.1712330785555;
        Fri, 05 Apr 2024 08:26:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:bdbd])
        by smtp.gmail.com with ESMTPSA id y18-20020ad457d2000000b0069903c37a36sm688198qvx.100.2024.04.05.08.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:26:24 -0700 (PDT)
Date: Fri, 5 Apr 2024 11:26:19 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mm: zswap: calculate limits only when updated
Message-ID: <20240405152619.GA866431@cmpxchg.org>
References: <20240405053510.1948982-1-yosryahmed@google.com>
 <20240405053510.1948982-3-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405053510.1948982-3-yosryahmed@google.com>

On Fri, Apr 05, 2024 at 05:35:07AM +0000, Yosry Ahmed wrote:
> Currently, we calculate the zswap global limit, and potentially the
> acceptance threshold in the zswap, in pages in the zswap store path.
> This is unnecessary because the values rarely change.
> 
> Instead, precalculate the them when the module parameters are updated,
> which should be rare. Since we are adding custom handlers for setting
> the percentages now, add proper validation that they are <= 100.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Nice! Getting that stuff out of the hotpath!

Two comments below:

> @@ -684,6 +703,43 @@ static int zswap_enabled_param_set(const char *val,
>  	return ret;
>  }
>  
> +static int __zswap_percent_param_set(const char *val,
> +				     const struct kernel_param *kp)
> +{
> +	unsigned int n;
> +	int ret;
> +
> +	ret = kstrtouint(val, 10, &n);
> +	if (ret || n > 100)
> +		return -EINVAL;
> +
> +	return param_set_uint(val, kp);
> +}
> +
> +static int zswap_max_pool_param_set(const char *val,
> +				    const struct kernel_param *kp)
> +{
> +	int err = __zswap_percent_param_set(val, kp);
> +
> +	if (!err) {
> +		zswap_update_max_pages();
> +		zswap_update_accept_thr_pages();
> +	}
> +
> +	return err;
> +}
> +
> +static int zswap_accept_thr_param_set(const char *val,
> +				      const struct kernel_param *kp)
> +{
> +	int err = __zswap_percent_param_set(val, kp);
> +
> +	if (!err)
> +		zswap_update_accept_thr_pages();
> +
> +	return err;
> +}

I think you can keep this simple and just always update both if
anything changes for whatever reason. It's an extremely rare event
after all. That should cut it from 3 functions to 1.

Note that totalram_pages can also change during memory onlining and
offlining. For that you need a memory notifier that also calls that
refresh function. It's simple enough, though, check out the code
around register_memory_notifier() in drivers/xen/balloon.c.

