Return-Path: <linux-kernel+bounces-162627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 853C48B5E45
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ADDBB24BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBA2839FE;
	Mon, 29 Apr 2024 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CKK2lQoL"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAA582D9F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406220; cv=none; b=Xoq98kV5NUgs4SuwvO0wzyv9HZ8bR2Nylv8TsGCWFWH+weHyNba1Cm+KLiTwHb8GEi+5H4a01X8gcHfP0J1/vRAsdhuzwJic/p6mQkOHPJ6N6TXgnKhyk8RVJmgcIIqLLvAD/aaRxxlkWXJL/NTggyiOkZbVK+t56IPHZfoMGZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406220; c=relaxed/simple;
	bh=ln/ctlMET0+EokkOHdYMTIPRVvXKe1uFuslZLmp/Iu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qy9CW4iERipy8L4POyGSZA7RWl+gKLwrUJGhHZ8E1vWjIggGvVfafWCgeH1aM2BBAg4LFAAVVHAuH+vr64QltmPsxtDBHtf+Jgqexk3p5L/jaO8JPl915Tm5esNoJffrKOiSid8tJI12HyqdqSBTWIMSu4SujoSQ0UpAGbsPj30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CKK2lQoL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f0aeee172dso3205281b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714406217; x=1715011017; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DjewcbYIq7c/TPoADj3iJGWkV17y2Ws3yovJos8PGaQ=;
        b=CKK2lQoLapZiR/sNUMRqFNiCKE5Y7gkoPczJm4eSU7aBUdfsxtUpPcuQU9Y86RAtbF
         cNkyh3H3of6pMiUZhFBHVGswTgQmz5/fgQHbJecGA8TahkDaBqhKhGXozT3WMJtX6hgK
         i2DisxyggRAuHUFGDMO1Y2XhBGmgroHf5liwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714406217; x=1715011017;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjewcbYIq7c/TPoADj3iJGWkV17y2Ws3yovJos8PGaQ=;
        b=gWb+lo+N71RdnEIcPtbgOLJJbUijv9FMuVwwJ9QMS4KqVBPgCj4suXcT9rFp6G4l1g
         BpZMEUGbWjag+EIgvu4s8vehxbyTGJXucB/hCk37Fb7r1xVVpwz/IT7f8bsdYW/skcVA
         hvX1t7WefbN8ltul4VaiRkEXJqSp4yDDiux1pDFwRVpwX4qhsnPG2Ri+HD/TE4xa3DZY
         oaDmJRM175e0ERZ3kUB12kNKzWfID/2GwkYQBcDEphLPTVQURydzvGJEiGtf+TpEbRnt
         exAFhb79mkVlSDF631HNIJfrVq+LDiesKCAVZXKAzkFvD3y1RVraM6kboZcQE+2UmTmM
         g+tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA8e7fiV37JEIrH3NQFRhkBjvzV8q8qYJ5h3yRaZCzafjcVKcN4j980++Ge1VOXN4SrT9CRJyji5Rl5rL8JSZpE7dhbo/VyB7lNhJ0
X-Gm-Message-State: AOJu0Yz9eVqqSMxOWQxfrQJDlS19LNtOlFrnm77umxaGNbAaUf2JFA+k
	gXQrwB+IdjUgK+9nC/zCNJtVoHoTIPEn4QcWhBi7YsWDKKUvqAyLLy/M+66E8g==
X-Google-Smtp-Source: AGHT+IGtX8s9RQQ04uPZujtZP7zzSJsOPnFU3xFcZv3k8VNpW282v6ntNSFT3IphQP9NXnShf8WEJg==
X-Received: by 2002:a05:6a20:9f86:b0:1ad:8f18:8625 with SMTP id mm6-20020a056a209f8600b001ad8f188625mr57193pzb.28.1714406217557;
        Mon, 29 Apr 2024 08:56:57 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b19-20020a056a000a9300b006eae3aac040sm19436778pfl.31.2024.04.29.08.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:56:56 -0700 (PDT)
Date: Mon, 29 Apr 2024 08:56:56 -0700
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 8/9] selftests/harness: Share _metadata between forked
 processes
Message-ID: <202404290856.494B7F8A@keescook>
References: <20240429130931.2394118-1-mic@digikod.net>
 <20240429130931.2394118-9-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429130931.2394118-9-mic@digikod.net>

On Mon, Apr 29, 2024 at 03:09:30PM +0200, Mickaël Salaün wrote:
> Unconditionally share _metadata between all forked processes, which
> enables to actually catch errors which were previously ignored.
> 
> This is required for a following commit replacing vfork() with clone3()
> and CLONE_VFORK (i.e. not sharing the full memory) .  It should also be
> useful to share _metadata to extend expectations to test process's
> forks.  For instance, this change identified a wrong expectation in
> pidfd_setns_test.
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Will Drewry <wad@chromium.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

