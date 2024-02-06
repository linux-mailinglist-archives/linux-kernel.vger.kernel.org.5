Return-Path: <linux-kernel+bounces-55595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D71D684BEA7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D856EB2549D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459AE17BB4;
	Tue,  6 Feb 2024 20:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ctp5v05F"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148F417984
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707251164; cv=none; b=CwKG5sMXo4+vBHd06DIBrF97PEuMmzLgUScI3Zq3NNr7qpI98LE9EPlkVkxFPwNmMMhKQedh43ON1k4z14VMibSqp5eFd86qILMCl40pAv5O0SmrieLgJervuG8YmBPK64sBfhXesfmUp3DM8Um/epUUDCJh1eBPxYLMHQdAnqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707251164; c=relaxed/simple;
	bh=Ghs4X5Z4uaDPsHxV/feRvgYyfkXvpu0EVlBeG8RyiRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIZ7x40I3iWPhan6LPwIw7aTCue9w54Way6ZpwINUWUn76zf/iHQdBeMO8GomT9iNRbLVwwZjaNLTFZctBYuqqeJozk/kL/ioACgpQPcisJKJybOW2nz6qVt0e8sqRDZsDRuV+UKj70L9ZFYf5qQM8sCKtwOCOda44HJXYcsnFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ctp5v05F; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55790581457so8299261a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 12:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1707251159; x=1707855959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YwtIzhAiy2OFPeE0oz7wdt1s11jK3N9K451uGmCEVik=;
        b=ctp5v05Fpan0LWhLCd+3uAGYViKogXIPrRELIgs4mczaxdC+5BMM8dgen4FGPHJZGX
         mplI7vkjOAUhUot1lVAcYZYnpiTtAZ/tTX0Ccjdf43qu7QMbXoE5818OOWs2JqQxKIrL
         fQ+97rvs5WU+duO8cGQ7W9yJaCEB3QYYxwuun6c0vpYQhb9grZYGtWvSezpEC1rYYDmC
         1+lPHbV5lRMhOObscLDwEeuB+I4A8gTcksw7/QKFa0FyWROh8ZrHyKsGMq0Ok9WwsgHt
         Bb0HpvoAFoLfNI8M/E1OK7IRturoSVe6ldYHU/Fn0PbvlCResZVmkVWUHa+sVtiH/hi1
         HP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707251159; x=1707855959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwtIzhAiy2OFPeE0oz7wdt1s11jK3N9K451uGmCEVik=;
        b=j4J/FDmEfztGqyuxGGDL92LVMIvzYQleysCwtAifUdVijLh7v5gKCEjKp/NnrqDeEN
         /snUjASJ7Eafper4Jjmf303GPt9E5a6oMn24qb44HnmzQEYi4izHO3QcpYl6T9rMVY0e
         Gfwn+/P13lOXzOpBuofz5VYPL6HmKsTeyqHtrfcg7pTY42jwJoG4XnMDNf1mGE3Aki6b
         1KFU19RCASvh4U/nzQYYMK4T9wJI5BGcHdsuzaIrQbUIW6oUxPnQZlxT33yoku6tPUjp
         TlKYle2O4c2KsrRdOcSV5//CKrUypv6SUtBEI5YDDqyOb2zCJDsyryVWCrPqhYhb6iO6
         qFmQ==
X-Gm-Message-State: AOJu0YyrOhFZtIMFdp7zegn0QwGQQyAMb3N4ebTitdKTwQyugvfDUw3F
	Qls1sF9C0lY5n4RlClHWUlZ+v8r+Pl1++CM1WvgxV36IHeTMTYbCA4Pw+z+a6Ko=
X-Google-Smtp-Source: AGHT+IE1UiyTodSjKH1Tkre8MM9UHYNFhBNNoVgxVEnfIgU1bruTp6wmQ2UfA4ann7ZNIB4jbDxIbA==
X-Received: by 2002:a05:6402:1a44:b0:560:9906:9f31 with SMTP id bf4-20020a0564021a4400b0056099069f31mr2373550edb.27.1707251158950;
        Tue, 06 Feb 2024 12:25:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXPltIihHRLzcF5QXjWT//awDFYCEqWMC0FhMBFpODWm/w5KtLtbCaexX5AE4L5lF0nan8HUaRQiY+gM8OAiN/QXwekWpuoWqBTyBh7TgNCQWbek0pXdUCZcxLIX3tvC1R/+x/GDh4TZqqj6kA2Of5uC4hocyIZZp3QlaSJwuNkwEmiZEnZAwe0iKaN8ZWotY2GS7DMh8kw0rssHlD+cWvKXLxsMnlNEQ==
Received: from localhost ([2a02:8071:6401:180:f8f5:527f:9670:eba8])
        by smtp.gmail.com with ESMTPSA id cs14-20020a0564020c4e00b005609f388ac1sm1159680edb.43.2024.02.06.12.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 12:25:58 -0800 (PST)
Date: Tue, 6 Feb 2024 21:25:57 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev,
	yosryahmed@google.com, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/swap_state: update zswap LRU's protection range
 with the folio locked (fix)
Message-ID: <20240206202557.GB97483@cmpxchg.org>
References: <20240206180855.3987204-1-nphamcs@gmail.com>
 <20240206191355.83755-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206191355.83755-1-nphamcs@gmail.com>

On Tue, Feb 06, 2024 at 11:13:55AM -0800, Nhat Pham wrote:
> The if (folio) checks inside zswap_folio_swapin() is no longer needed.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

