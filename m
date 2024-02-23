Return-Path: <linux-kernel+bounces-77807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AD8860A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31AF21C22D48
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C65E12B9B;
	Fri, 23 Feb 2024 05:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I3EwbpEL"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D906125AF
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708667333; cv=none; b=PYSfbK/J2xZ0Nb3zrKPE43nhdjAb7GnswB74exk8z6yvpi68nWy4pYP2epWZE0/V7vWJGfLmzjSPjVPlOE94vWkEim65gTa0uLmQlWjftSqnbi/bWF98D1GZyCRjURNMsTscJSfHI+SN/tWZ29c+FxTca+dqW2rSYRFC7+Tf7dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708667333; c=relaxed/simple;
	bh=YvqTVBGdA4TkEjrEGc8jrgNKj9WgC1hailOG84LaDyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNOZjk/WMCZ6U9cr7TbylrWGmVp2wox6ec73TkFl4zMA+HYHIyn6rCDtUATJi2UMuC/mGjIJepcaIh15sHXY5cdkRGW55cbai45PXy0rlXHJJf7ggbyqHKxHawXGl2b6/XH2JFmguYbzlCTGcRg/lEL0qat94mSe5WqBG657C9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I3EwbpEL; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso358716a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708667331; x=1709272131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+iMLOG0YNrj8W5POWDY0W8AqRXR08VTXCk+0hnG8vyw=;
        b=I3EwbpELIzpWrsEJTSjob3VNIIEijTlWWcjexlGZIYi0R9cqaai7/zm9pk9jMDQu1Q
         cUYHsQtoiFV2X9sgmLSxpU2kP3BeX606dcXMGLq8i2vXfvPK0ZfboiaYeC91IYvyDqdl
         aA+Y/WXHEaET25ZMNNc7id7Qejm2HW8BQE+yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708667331; x=1709272131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iMLOG0YNrj8W5POWDY0W8AqRXR08VTXCk+0hnG8vyw=;
        b=uajsBGZUjUnzLoP1rmWEDYTJ8jRfx041a0IbNRg7oU5ruJ5NjSVUCtrWltohsjq0De
         NUC1Uvh++YlZiFbJCH0YImEkEqw9ORdws90YyRdLJKwWZbrN3/a6RkHdYT2aN49o2TLm
         g+OYvOA8wTE2tl9KY6KGbS6B+rPOjEEwKQrf8tp+E+MFXVsoWgdBruyssu4gmJs7KoIz
         ue2/5qgnCzq2rT8nmnGBmsW6FZ9hKGmhbFt2waPZkezQtQlljtpJWhMNuKHcLIrFJYoQ
         5FpqkXryAqqXWsmgldqdh+nDEudXN0ayw1CajAuv11+h5T2+qtLmLP6wQRzUYIT6xcrB
         BLtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPPUs9xzkP8rmAxkkkWq9UNOFgxQn2/2vTNIr6GubWoB09XGyh476AZ98R0peaLcYj1qkHABjsc6/0P6TzVrG/lIvsiFCiwuBorlPB
X-Gm-Message-State: AOJu0YxEG7v52gvBD19dFWp7epjgsU0ZwRNyaoMOr/RVttS8qw6ClB4a
	smIpoh6aPEj3cP8vih5yxEDPq6u3I/vE6uW1hgWk4zz8dRAcJiZrTu4L0fikPg==
X-Google-Smtp-Source: AGHT+IEtOskVc5laQXTU6Y8W/mg/KfvsSYoM2fvLEtL1FBDUZbtV+LE9j/gGPLRLaxKzAJYH10ET+g==
X-Received: by 2002:a05:6a20:3a88:b0:19e:3b15:2176 with SMTP id d8-20020a056a203a8800b0019e3b152176mr837311pzh.38.1708667331454;
        Thu, 22 Feb 2024 21:48:51 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b194:4f71:568a:eeb0])
        by smtp.gmail.com with ESMTPSA id kn14-20020a170903078e00b001dbbcff0b5bsm10757324plb.232.2024.02.22.21.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 21:48:51 -0800 (PST)
Date: Fri, 23 Feb 2024 14:48:46 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: hannes@cmpxchg.org, Andrew Morton <akpm@linux-foundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>, nphamcs@gmail.com,
	yosryahmed@google.com, Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 3/3] mm/zsmalloc: remove get_zspage_mapping()
Message-ID: <20240223054846.GS11472@google.com>
References: <20240220-b4-zsmalloc-cleanup-v1-0-b7e9cbab9541@linux.dev>
 <20240220-b4-zsmalloc-cleanup-v1-3-b7e9cbab9541@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-b4-zsmalloc-cleanup-v1-3-b7e9cbab9541@linux.dev>

On (24/02/20 11:44), Chengming Zhou wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Actually we seldom use the class_idx returned from get_zspage_mapping(),
> only the zspage->fullness is useful, just use zspage->fullness to remove
> this helper.
> 
> Note zspage->fullness is not stable outside pool->lock, remove redundant
> "VM_BUG_ON(fullness != ZS_INUSE_RATIO_0)" in async_free_zspage() since
> we already have the same VM_BUG_ON() in __free_zspage(), which is safe to
> access zspage->fullness with pool->lock held.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

