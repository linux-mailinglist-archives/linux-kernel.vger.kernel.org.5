Return-Path: <linux-kernel+bounces-53191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E2784A1E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85181F243A7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF8E47F52;
	Mon,  5 Feb 2024 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aqqnWbDj"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131F647F71
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156929; cv=none; b=m89JiCyC99VIsiZHSkWptXEA094okNgLnD1J7cRx30zM+79UOlFdYl8I7UFT8YBgXhgVBt7GJqW6QGZ2JkzlYfSNG3gtJE1GatVoC1nV0OFaDnuejN+eTzrraPEcJ+Cfzxr8Qgp0mLFLzZf6oj0xuRc0XPIQBx+qrYuNsmoRJD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156929; c=relaxed/simple;
	bh=FyCREsOOqtnuvOoqGa+Thr/EI1MAjxJC1gzLyFekjtk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DIWBP46NgW+Ts9DVOy4Cpws3merVnnM362+mMLpoziBnSxiF3EoI4l5C/AblPK60xj1I782iHHWoY3ZLPsNtIwGLvF3kewBkUrNL4uQKXX6HXFmlaJrUdhASecY8bmvyqFbuw+PTVi6wTCunGpN5SuTlECqPurc/cXgr3IaiX8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aqqnWbDj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d93b982761so32795ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707156927; x=1707761727; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hMMhCHPdnY6a53r0AdRn2ZwMuoekqmZTBFnKYjfzR8k=;
        b=aqqnWbDjvZTJQ4w9J32nnn5C4bBIeOz/x/0V8+U9GHmQLEvt2B+6uMA5aCawO/MAIK
         E63FooVEqrNtYkHh1lSIONbgLUzFf/gu0GdQl12dhS8AWvcc50f+lLJnNKDeEsPmrAYg
         39i+YfU3vy/e9lKrUyWmzN5D0qDfcJdbfY4CJZZgADFQj8/698EADEIA/BDFQIsnBtgj
         EHYO9/6+PusZIq7ByU8RFN1x1fHFyuYtGfdnezcRemOBQ3zRqn+I38JnhAGzkWqejiFy
         1mNHFpaVKnOzmJ9uc24myJpH8MKwxV8faSn72MLXxpjAkgmg3T1GIzhnScVOL92i1c8F
         GhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707156927; x=1707761727;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMMhCHPdnY6a53r0AdRn2ZwMuoekqmZTBFnKYjfzR8k=;
        b=irNlbmYNKLi+q/Y0BPQen/6u1wX+Dh5Ur/XXm98FIBkedzRqv0pDwCpVyqfJUaPnD2
         TswBq5/2mWY/dKULZdTJvQHKuW1U01vmiiTagEs9ZesYYOLywHcYHaV/apoGmQvd/Ngx
         BZ4bWwuS+GIjytcE7IIKGwBTdn3IB1E87OKQ9CiB6iRtX3Dg8pH87TRIE4OCiquge0tV
         IThmYxnTkq3jPXeQI3bBBsksbHSv8CaV8qmnX72SPgzMgdYF+pfg9SyHAy4V4wLs1t+Q
         b+tu2n/CHaDa+zH4JhufOHB0nE2IInD4M8WU6QY5ZsrNQnP+qyGQHHTzWm27P55oAqX+
         Ewmg==
X-Gm-Message-State: AOJu0YyHiJLjJH2+ke8Ke4jHzU7R3nPFNyz7dE9v2Dn1Z+c2pHKwrsV9
	66u0hEo0EFRVkTtADilzR5RgUKFEKXFgsIhRt0xxhyKio/WLrBnbnIiwzUhP6g==
X-Google-Smtp-Source: AGHT+IFmTazqpWxkymD9klp2+KFfWCRx+EupD0mFw2cWZMoCAXLe/HcNB61W1KMXdPfJpDeeBspVlQ==
X-Received: by 2002:a17:903:22c4:b0:1d9:7a7a:3cf6 with SMTP id y4-20020a17090322c400b001d97a7a3cf6mr27342plg.12.1707156927140;
        Mon, 05 Feb 2024 10:15:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUpktWhh0NPQ9FcoM14zHXRSVA+RTqr1vPpQx8XPTdbH/a9BsBmFFWsoICE46TUKEz2jnUcs0RApYUBIZO3cT84iftmz8MttslQPRRdCYheYhXIe6a8hD1DwQlwkCsTYZnlHAbBRnlI8tntWDUXpCoiJ4Ken8Pr+/0KjyKOIAhjGiomQTQRlXCWtaCsPPcC+JIrdNOLcNagrcQTtqRKcttUEj55yLcKaYXkHiEgvvcHdB6EAdtODlFokODt1vWmC2pvRz7B0RQhLIpQYdsQbc8WLgjK
Received: from [2620:0:1008:15:1e99:232a:d721:3dff] ([2620:0:1008:15:1e99:232a:d721:3dff])
        by smtp.gmail.com with ESMTPSA id ka5-20020a170903334500b001d8edfec673sm159673plb.214.2024.02.05.10.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:15:26 -0800 (PST)
Date: Mon, 5 Feb 2024 10:15:25 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: joro@8bytes.org, will@kernel.org, pasha.tatashin@soleen.com, 
    iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    yosryahmed@google.com, john.g.garry@oracle.com
Subject: Re: [PATCH v3 1/3] iommu/iova: Tidy up iova_cache_get() failure
In-Reply-To: <ae4a3bda2d6a9b738221553c838d30473bd624e7.1707144953.git.robin.murphy@arm.com>
Message-ID: <9a779ae8-c965-b2b0-6f94-865f49ed0e9b@google.com>
References: <cover.1707144953.git.robin.murphy@arm.com> <ae4a3bda2d6a9b738221553c838d30473bd624e7.1707144953.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 5 Feb 2024, Robin Murphy wrote:

> Failure handling in iova_cache_get() is a little messy, and we'd like
> to add some more to it, so let's tidy up a bit first. By leaving the
> hotplug handler until last we can take advantage of kmem_cache_destroy()
> being NULL-safe to have a single cleanup label. We can also improve the
> error reporting, noting that kmem_cache_create() already screams if it
> fails, so that one is redundant.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Much easier to follow :)

Acked-by: David Rientjes <rientjes@google.com>

