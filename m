Return-Path: <linux-kernel+bounces-77802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA9C860A66
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F55C286CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CFE125AD;
	Fri, 23 Feb 2024 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VgwsAoo3"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C3A125A1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708667274; cv=none; b=ZbamnBbMUO47yQYfG6BNPF6LAMjszNiSF5QyVvJe7orycTqf60y/eGmEnUi6BIABiGys5WxmYMyJafBWw/s2+oeuYE2yhwh5JeyBmbvaVB0nK3knqLy8CoBJerZ/BczAx8podpZIo5aytdvVHXrE+jDRBVz2MKOyfh8YzP/NWvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708667274; c=relaxed/simple;
	bh=7iHj8FnF8qOYSqO3SQ/uX8AyqMoQwBVtuKeJJZPr+XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAE7s3WxlNrfzaoDBCKEUdL+sY5ldvUfFoH9j1ymFKV41LS/HgqciM+D4xZi0gXsMbcF4lCKeen8c97AXV2Mv1gPcF7JqorA2AEbSRDgQolSD6Sfu9et/4htH2No5wWrUe58KpTS8Y+6W18I3ywMAwr1NnIQIId5yqh+dJIMO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VgwsAoo3; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e47db45ae5so2306a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708667272; x=1709272072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FLgAnoMtXtOoP/MT58Z1R1M569JvS4pDWEpHe4CcF8k=;
        b=VgwsAoo3TbcUNr//x4Pu9f5GOT2JFGENJDr0M+2pYOEF+J+iwmjvbX/xJNp7h7nIlK
         UWcZUpRL0MNxHzi/+2OCGI4OIeSloWxvV3pDjpcfO48IsQhhCwRq2YT2uLLloRTZhHs7
         qGC5BElFXty1KcXXW2i4xr+WfCpxpYtcWcum0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708667272; x=1709272072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLgAnoMtXtOoP/MT58Z1R1M569JvS4pDWEpHe4CcF8k=;
        b=vhArMhnu7GzpCeWzSnCeufxkhVdoaRfeJ74l/Sck3ZcvygLzuAzSIvzhG9GC5TMt5c
         s/k5308TDga74jiCccqDO0JCuuj5v9dZAENOiGouNxAK3MG1kceHl/ZsVGsC8dXV520A
         jUK6Qr3htQAEN/KlI+DWrJerkTfYZ+qtIxvo0WgfMedq1lw3kFj9OQ4h1xqcswr456G6
         dflBtXpqX2y/VfD4iR5QvJ1fr7X6wbUeMbImHjA63SMOmOYXQrLoj3q18WWTV182mjjd
         rrT9upnU5kvDruh1QqgPHYEBAbI5NBQix6YPtzdPcsmGYtu0s9ztK0im8yJ7hCocmnQh
         0FRw==
X-Forwarded-Encrypted: i=1; AJvYcCXETFT7kZ/aXNlMRInJbsp2gEUK//vNEot8CIF7M7wkisZCl18Q8iIiJB3ywwJ116hWaH6bZGzTmL6/MCrz/Wi3H7B1JA8Jro0DROkI
X-Gm-Message-State: AOJu0YyFPW5Ky5jG4OyJbSkj13i+KfnvqhBRDZvVgdytUqOTBaSqgvYu
	TBj3DrIFe557oI1DmDGIRVeXlMq58HJ2d9bycJGfNkYzSu1B1VHxh3gliJbJDQ==
X-Google-Smtp-Source: AGHT+IHydtXEXOJOkOEsS/0xDSNfyZrAJ52K/3jKLIdNjUlnKorgV/cu1obnaaqYb2QdX7dGJ84kIQ==
X-Received: by 2002:a05:6830:1e2d:b0:6e4:3e64:b0b with SMTP id t13-20020a0568301e2d00b006e43e640b0bmr1203384otr.12.1708667272328;
        Thu, 22 Feb 2024 21:47:52 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b194:4f71:568a:eeb0])
        by smtp.gmail.com with ESMTPSA id s2-20020a632c02000000b005dc98d9114bsm11471557pgs.43.2024.02.22.21.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 21:47:52 -0800 (PST)
Date: Fri, 23 Feb 2024 14:47:48 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: hannes@cmpxchg.org, Andrew Morton <akpm@linux-foundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>, nphamcs@gmail.com,
	yosryahmed@google.com, Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/3] mm/zsmalloc: remove_zspage() don't need
 fullness parameter
Message-ID: <20240223054748.GR11472@google.com>
References: <20240220-b4-zsmalloc-cleanup-v1-0-b7e9cbab9541@linux.dev>
 <20240220-b4-zsmalloc-cleanup-v1-2-b7e9cbab9541@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-b4-zsmalloc-cleanup-v1-2-b7e9cbab9541@linux.dev>

On (24/02/20 11:44), Chengming Zhou wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> We must remove_zspage() from its current fullness list, then use
> insert_zspage() to update its fullness and insert to new fullness list.
> Obviously, remove_zspage() doesn't need the fullness parameter.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

