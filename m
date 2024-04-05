Return-Path: <linux-kernel+bounces-132331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1373E89932D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B16EAB23BDD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A072C14AA0;
	Fri,  5 Apr 2024 02:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="g2ttrr0Z"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9765A12B93
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 02:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712284522; cv=none; b=P3ZW1iPlLtMz2CTAgoa3rINYy9d4vva2SiWPKHjEPlK3SrtpAHkKkYOKJue1WyCGVEKCGLXCnX1+u++79wNOvI1ZhnovR6uNTOq1Cu2BUfiNA5nt2Xn75nYfQst2+4hmqeGHP8wWd7LwoZvpGRyf/qXeH/HICLNiFGF5xeCr/JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712284522; c=relaxed/simple;
	bh=oOJ3pVruGJwxJj72BbZBEj9WSxFnrbaaregTL2WEje0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYJTaquJViSlsDP0B9efIy1Iwov1b8vb40lVWcv8KELmr6XhvljKPUMOvY8lKbVXcaPc+FTcsRdgsVlFtdpbMajyDQ7La09IAzFupSQww9Zxrp75Q6oBF0sLWvR/IY1HRPynO8/N3KYZuknRQkzd/fNkq4DOy9sXXV0P7CCWG8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=g2ttrr0Z; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78a2290b48eso91443585a.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 19:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1712284519; x=1712889319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qsXw1YjFtBVpFJsnCpS/NSSje6hdsmMH5gSMa3z1yUc=;
        b=g2ttrr0ZwU74bp6l/Gprv0kCmVPqRht/HwjHoQkpZ6pQZTKMI16gbW7eHzy3EZWOqe
         ArPmOj6eiHQa1g+NpwFmo9qSGf9wk+j69zB1KxF/7Pgot7Wqnyd9gQPnJVgPNtFzPaJS
         EDTTztohfDiNHqx52CiAoU38eFi44D5BmvERZcQOdUgP77VvZ0RfUOFxfO6WSFqXhjHP
         e0oPfuJvAUb3FF4A3G5Uwhv2OTIbTt2yMDuUuc61cJBRDPglxYdtYsLdwE5yK+CYND6t
         zjFGcZSTD4FPp+Qtw3ZeJxwQtraDMJNj1GjfJgdH+wQOS97VWSq2UPmvDzFSINkQIRU0
         j99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712284519; x=1712889319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsXw1YjFtBVpFJsnCpS/NSSje6hdsmMH5gSMa3z1yUc=;
        b=kp8G4+btbmU1eAVzZVuYdxZ55mC6+W5UIU9+ThDXmmG268RyCG7xHsN5bTwmqKXUTR
         gbNIEQ/hJX6Ld1rspNsEEo71Nql3IoOsTGFS6jkYz5zIlpYbxxSmBy05d8Kz9yjHfN3Y
         TGllFFI2uuKOEqY1WfHzhAQjow7+gUzeZmLxL1B/sPw4U9fGdCIY/semfffUYGzwjQu3
         lppWeuFzaN5DlD3lcMlr4qvcCkwTOtX5EsuHtKsm+vXi5BBaHLe3Q6jhye4c+JLVc0Li
         KKU5OM0PMmN7t7etlfxLjWOs3mpgtmW/eFpPI+gNpKReREd/XmWp8Miszp6RXwuY7bII
         WLZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkK2UNZwAaOSgS1bS0oybDXPtAht+p3gDibamjnvHl4qCzen9e0nqfgi45I2WvooJbpw3tv79bhzIBcMgxE7nekU30CIK/EgOZ3+ib
X-Gm-Message-State: AOJu0YzKT+vBAyrLbUITPiPOPB+3dt/JOVbJgvdffa6SqxZOnHPt8cGk
	eBeLtJKJQO8jx4W47YswuYpO3zzlGMi/HCjorWZTVPkeSzYlijJDesXW40CpRVc=
X-Google-Smtp-Source: AGHT+IGYRZr/XEasYFH/50SUHDXr3rg18tBDjPJJuNetj3fKiojsslA3nXYE+m6tc+Plzh6L7Bpe7w==
X-Received: by 2002:a05:620a:4152:b0:788:267c:8a1f with SMTP id k18-20020a05620a415200b00788267c8a1fmr198433qko.58.1712284519423;
        Thu, 04 Apr 2024 19:35:19 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id x12-20020ae9f80c000000b0078a35fc488bsm268911qkh.52.2024.04.04.19.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 19:35:19 -0700 (PDT)
Date: Thu, 4 Apr 2024 22:35:18 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/5] mm: zswap: remove same_filled module params
Message-ID: <20240405023518.GD641486@cmpxchg.org>
References: <20240405013547.1859126-1-yosryahmed@google.com>
 <20240405013547.1859126-5-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405013547.1859126-5-yosryahmed@google.com>

On Fri, Apr 05, 2024 at 01:35:46AM +0000, Yosry Ahmed wrote:
> These knobs offer more fine-grained control to userspace than needed and
> directly expose/influence kernel implementation; remove them.
> 
> For disabling same_filled handling, there is no logical reason to refuse
> storing same-filled pages more efficiently and opt for compression.
> Scanning pages for patterns may be an argument, but the page contents
> will be read into the CPU cache anyway during compression. Also,
> removing the same_filled handling code does not move the needle
> significantly in terms of performance anyway [1].
> 
> For disabling non_same_filled handling, it was added when the compressed
> pages in zswap were not being properly charged to memcgs, as workloads
> could escape the accounting with compression [2]. This is no longer the
> case after commit f4840ccfca25 ("zswap: memcg accounting"), and using
> zswap without compression does not make much sense.
> 
> [1]https://lore.kernel.org/lkml/CAJD7tkaySFP2hBQw4pnZHJJwe3bMdjJ1t9VC2VJd=khn1_TXvA@mail.gmail.com/
> [2]https://lore.kernel.org/lkml/19d5cdee-2868-41bd-83d5-6da75d72e940@maciej.szmigiero.name/
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

