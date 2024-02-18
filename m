Return-Path: <linux-kernel+bounces-70309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB268595E5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B7E281E88
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941DD12B91;
	Sun, 18 Feb 2024 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CfENhN4+"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7723BF9D6
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708247221; cv=none; b=bLGmomVxC8pHHtLrivercYyF0X745H/xQT6WBJ3ci1lNqKVxzuc5U/0WG1fmtJGP9lmQlr/B0xtw1z97ONdHh3zMwe7+IBZOjbUl3mt3QoOO/t1P1P0ePovggzC5iYOvvKuvXRpt93zInDl/QIdhn30NQrl6mokevzmequMo9Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708247221; c=relaxed/simple;
	bh=HFou+Ynhj8r45qIYynVJq3BPxFIXGbuKAoHIGhaH17M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCS94IVQwQ1f5AOzhQKdgAHMh32ai8XLmDn9uAaDUetLUail8v+/kV3J+fHY/HZA2GAixvJFkkrx4CrVNZuGkrjIpU1f5DEksZL6HSsCNcHEI5/Ti9TL2Mc50H3V6p442xEOBNgdUao3VrXgGnyZZMeKp0HtTPP2u679jbSNqTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CfENhN4+; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso1714460a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 01:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708247220; x=1708852020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+pYjP8Elq30R0i6ycDkBbNUM938GG/2nOBO34J/gBts=;
        b=CfENhN4+7of4UE9gjPzdZOhi2bMwCVSCAGl3GBKhH6SFsZ3u62gWEJ7wMEaKRfaDW6
         wphwf1ieqcQmWlzhDt2mCiOwZEouB3WdlTyC+jmN+megcEs8dqAltFuoBSrzJr2MXp1n
         G2xrB4mxSKP68DMz3akurQweDLE3bw8eeVlwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708247220; x=1708852020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pYjP8Elq30R0i6ycDkBbNUM938GG/2nOBO34J/gBts=;
        b=ukJrcOj1kVLL7YnM0Grt362q/G825JzOBhTj7nm9//4DvsCiOaZsy1dyh2vo57JEZv
         r7k87sGtmGM6PXMZx8rTny2jZskPCSI3zW2lVDCMa2EGrQLDRM6eNYy44AT+BacnGarQ
         p9Stnoj/6tkC6xQfv3KURYdeSn+KPMYp0DYVxWb860FocAX+jMchepLBkln4y/x+GoPo
         El4J68bfOfODi1oicWQDq52x59JZtcLXg72VCQkBhi5Z5HPMQceg5HKnr48UHT9UPQvN
         vazgJWnOFJxjRmdaCVvViPZxXaZ4qk82qr1BqA3J0lZbr42JLhr+5fVjE+eVjOgwflzM
         HYoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtPXiIevCT6ZEVsr4Ux/yPG0G/iNV3w3yp6zdFw0lI9szLIHxyROedTNIwQ1Y5hvK6vfHDcPW2CNVT/E/Hq57m6woT23xfNsky3qp6
X-Gm-Message-State: AOJu0YyPIBPJcQFne6PxWazPqgGKjG3ohr/hWxcO5RJQ/JlUu9uOB9dG
	V4cYqkLiJW1RBbMvoyTK6734pDs8HbqNvzVjK+auBuwELYLMaDvrZd6zupn00w==
X-Google-Smtp-Source: AGHT+IHE3MbZ/4iRpYOBLF5b91QTfJN5jdx5IDOudYN6UjSGzsBL2ieEcjeoydWDpFek6WFz9QfxRg==
X-Received: by 2002:a62:cec9:0:b0:6e4:1a29:732f with SMTP id y192-20020a62cec9000000b006e41a29732fmr991819pfg.12.1708247219780;
        Sun, 18 Feb 2024 01:06:59 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c18-20020aa78812000000b006e1464e71f9sm495605pfo.47.2024.02.18.01.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 01:06:59 -0800 (PST)
Date: Sun, 18 Feb 2024 01:06:58 -0800
From: Kees Cook <keescook@chromium.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] PM: hibernate: Don't ignore return from set_memory_ro()
Message-ID: <202402180106.25E08136F5@keescook>
References: <be49c794567f3bd00ae16e91b54fe8cfe6cb4999.1708245599.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be49c794567f3bd00ae16e91b54fe8cfe6cb4999.1708245599.git.christophe.leroy@csgroup.eu>

On Sun, Feb 18, 2024 at 09:40:58AM +0100, Christophe Leroy wrote:
> set_memory_ro() and set_memory_rw() can fail, leaving memory
> unprotected.
> 
> Take the returned value into account and abort in case of
> failure.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

More set_memory* consumers! :) Error paths look good to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

