Return-Path: <linux-kernel+bounces-44593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 448538424BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001B4287B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3183B67E7C;
	Tue, 30 Jan 2024 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NqsYweqG"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E9D67E64
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706617299; cv=none; b=I5q8PU/BUsab45fBvyM0z/4DyDJVCwJz6UOh85M1O1umAlmJej7D/OXCdixpa3ELtRqxShKCzAENA8ahSubjXwcYlJAUoBCZ0GhQc2tR4SukhkKuAtywDt0oaSmmgHOObMQuv1GfshPmbw0ZuFs6UCYI6ZbbemmFC1FNgb/F0/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706617299; c=relaxed/simple;
	bh=NKLZjehvYhB/lhXWffMOazxJHtmg5/Lyk3PxTqm2ra0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaRGPRnkRsRZmEkKkNLDJ3KVQbZG3cd/eLdlAk5Icmy9RV5fXjArbq3q2ZN+6oVE3YUvVsXZk1WTzLQyJx0mvoUb7B85revzUwH/QGpf6XN0+Tlh0J9caCgmD2xRV3iF/neE08laZikhGUdpI08AKMvDrKpuoq3/bS+if+OzD4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NqsYweqG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d72f71f222so19440305ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706617297; x=1707222097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D8+4UFyRHhlEpNddltccPi9uQPG3sCghbVxOUf727vA=;
        b=NqsYweqG3dWQ2yYVkgQ6XaA5koUFjusHezkQmJG+97gGYIV4IyTEiVWwMKTC5b8YXG
         ShxBHOxsVifYeQU9Fe27DAWAUe/A9mBHAatA0XhXbWyvsntO307XDiYHiu1cY2LVxLDQ
         fQVVlK7CMSjIavmFmeHc5T8Wv3sauIDAoox+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706617297; x=1707222097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8+4UFyRHhlEpNddltccPi9uQPG3sCghbVxOUf727vA=;
        b=F7iKvynL2CORWLXVcpeaL+Mk6Du6rPXvgkN77T43Kjfov1zTc88dMlvj4jaKBtF4AK
         e0bR5YSRiL6caOMFIt2yMOoM+RBRbMKeLNnRk+NLjKl3A1C6Oepd3+AmAf7J2RGAqVfj
         0YM1mqBSLXg6oBcWRTJnz9p/xtBbX4prTP5ZhnyVpBwFLVWSIv3S+WIv5nmenRX1CDoG
         cGeubBI9JQJjiwDd226GBPL3nyQvlRTv2hbmzF36yWbwJzq34+hHy0EhUnDAM/iobg9O
         /FNQPMOG7WRRJ9IIjPSfyuQrqHtNvSU8x0m8bPUcMK/BJXMt5LRE3TGTP1joqc46+mp9
         fkhw==
X-Gm-Message-State: AOJu0Yw48u1KIc0yXCDbwGH/b+lNmKB58B+XZWg5DNvrraid13N3e9lQ
	2x5wV7lpGPwqilJJIebPHQUuBdZxxcJIN8q6jIQ55ETXuxErM7OP+kvrvvNdqw==
X-Google-Smtp-Source: AGHT+IFzPYWSqnlXBXe/yAEuLMD11R/G6uELISH0ZTJQSQlwhmX1VotK/WdsbPf4bCh86m1o3CfYrg==
X-Received: by 2002:a17:90b:3a8e:b0:290:a991:8daa with SMTP id om14-20020a17090b3a8e00b00290a9918daamr4064472pjb.4.1706617297319;
        Tue, 30 Jan 2024 04:21:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUgYwgiNATSWxyNKdGZEBcNSFAtgmCCYVevXiwoUTXpKQMXlPo0w2LEvWgP2FfHLVbVhW63eqWoOw5sEXIeUbVx0KvCuJALTDWjNEVpT0v3zV0GBqo9mxIjRJMBTGXgsSAqm7JZH4WkRjP67mwtnnz7epQjOBhOJ6to+wbTtqIUHc1bB2azSAQChBDmoGq0BNyqtzMZZdwa/x8JEY6HlilnmguF9rEauOMgfyg=
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id t18-20020a17090a5d9200b002958775b061sm3461826pji.56.2024.01.30.04.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:21:36 -0800 (PST)
Date: Tue, 30 Jan 2024 21:21:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/20] mm: zswap: cleanups
Message-ID: <20240130122131.GA9406@google.com>
References: <20240130014208.565554-1-hannes@cmpxchg.org>
 <ZbiwW5BJhFeGc2Bd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbiwW5BJhFeGc2Bd@google.com>

On (24/01/30 08:16), Yosry Ahmed wrote:
> Hey Johannes,
> 
> On Mon, Jan 29, 2024 at 08:36:36PM -0500, Johannes Weiner wrote:
> > Cleanups and maintenance items that accumulated while reviewing zswap
> > patches. Based on akpm/mm-unstable + the UAF fix I sent just now.
> 
> Patches 1 to 9 LGTM, thanks for the great cleanups!
> 
> I am less excited about patches 10 to 20 though. Don't get me wrong, I
> am all of logically ordering the code. However, it feels like in this
> case, we will introduce unnecessary layers in the git history in a lot

This also can complicate cherry-picking of patches to stable, prod, .etc

