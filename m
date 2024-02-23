Return-Path: <linux-kernel+bounces-77800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877CB860A64
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D3C1C227F1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B128511CB3;
	Fri, 23 Feb 2024 05:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gt/n62Rv"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BD511714
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708667206; cv=none; b=Z1Vn0BwRUV0DYyfrjtht6s2vCdM/4gdT39Lh6nBnQnY6sPDwgRQRXKLsV75esRr0fsJF4wNyE4abDLCmQEGEoFxF5Xwm2ghg29s56UwSp+h4pZD+caSfNl2RbSOnElebujxkWG5xVsFc/ZuHe+6fRFJSsVY65HuhX0m1fd+e4o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708667206; c=relaxed/simple;
	bh=4Mu4qmwx49radwsw9Zn2ZibeKAoCXrGL3lkngY9AxYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIKkG6h+G+tR4rBFBZX37wkiOt4Sxi9+v5iddK3yZaRqCmNn9zMmc7Lm+I9JsKLR5sX52m1ogJ+iTrtGLdq0bNhH8ukQHs8d1BDKT2GuqqYJhXCJhgUK9SWV2+lGjadP+AsBEhqFyIs97N9lXmWCIOpEZR8U1K0kekN4a37WUrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gt/n62Rv; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so4682685ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708667204; x=1709272004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKWLjdfN8Ehk7HwAVlBv6yJ4PkNk4ZJz+47JdgnyFdE=;
        b=Gt/n62Rv9wZOXUjDqAHqjOc+X+xnC//b81CmNKofGIjBPqcLKyv8JLe31+MS9b9siG
         N3sPHLu/T3AfsMeFL/YzPb66Rh8+cMgWq4Fy+d7N8wLyTk5vsTSK9JSAyf627OM3pYHD
         tnO0nd8kOfK1Rxif007sQSYPzg7xCH9Kb+kqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708667204; x=1709272004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKWLjdfN8Ehk7HwAVlBv6yJ4PkNk4ZJz+47JdgnyFdE=;
        b=UE0H+9n4u52ctkdEP/TCwdXWbvTNQT4MySffQ10bJ6kskjNZW7xBzJG8wrMXQ9pT47
         0vZkwzUrWzPOKBP2E8qU2zkMliL0pta6cqES1QNIylh06XehtYh3RROsREs8vE+ls8Ou
         9f28ZA24Ob3HS3WeTsvEsw7WYbhgOaOoaA1GfSwkT0B9MBEoe27mTfVyDgH4MFqykqwp
         fBDZbuMuTdAzpEBp9Y9DsdOrIrlkPq762eRzeJaCfbCWrH9OR4kKXvPOybSO6xM+OEzM
         o4AA9/TOF16ur8izJXVl+X1YZUv9W8nzIflv8vL4v9kpeyCRMFa/y0hhqJA7bKEdN3q/
         aZmg==
X-Forwarded-Encrypted: i=1; AJvYcCXgKB/kIN5S0t1nKUknCt6utSiVoyzSeXLQqVNmgTL/lsB4oMk6+iwArH9gTGffv06Ng861EmflwvSHG175x1pow4CPZW6zJ5Yr6kFj
X-Gm-Message-State: AOJu0YzT6eJtY/8NInDvu8qYyx5Heo4yLM+aD/CP+1cxxPlgi8wxS74p
	/0ymgGotVmVIsC9xPkKNSWnRpFbjtdG7Fzrqio0ks/0TP4zmCdviIkhSJn9r/g==
X-Google-Smtp-Source: AGHT+IEiLZGLwKMLXTLaHEiIR+kZ7kw4Yt20s7QGaBDlCpi9CHBJhrq9LdUapKOE8n6oq7H9K2vs7Q==
X-Received: by 2002:a17:902:f689:b0:1db:dd24:9962 with SMTP id l9-20020a170902f68900b001dbdd249962mr7934359plg.21.1708667203952;
        Thu, 22 Feb 2024 21:46:43 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b194:4f71:568a:eeb0])
        by smtp.gmail.com with ESMTPSA id km14-20020a17090327ce00b001dbae7b85b1sm10817704plb.237.2024.02.22.21.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 21:46:43 -0800 (PST)
Date: Fri, 23 Feb 2024 14:46:39 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: hannes@cmpxchg.org, Andrew Morton <akpm@linux-foundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>, nphamcs@gmail.com,
	yosryahmed@google.com, Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/3] mm/zsmalloc: remove set_zspage_mapping()
Message-ID: <20240223054639.GQ11472@google.com>
References: <20240220-b4-zsmalloc-cleanup-v1-0-b7e9cbab9541@linux.dev>
 <20240220-b4-zsmalloc-cleanup-v1-1-b7e9cbab9541@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-b4-zsmalloc-cleanup-v1-1-b7e9cbab9541@linux.dev>

On (24/02/20 11:44), Chengming Zhou wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> We only need to update zspage->fullness when insert_zspage(), since
> zspage->class is never changed after allocated.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

