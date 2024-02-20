Return-Path: <linux-kernel+bounces-72148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFE985B005
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7481C223D1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4E128E7;
	Tue, 20 Feb 2024 00:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W0kpbdAO"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEF82566
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708388822; cv=none; b=Cgpm0GwusIvvEHI6xXVxthk2cVm06LcbJ8UCdMesrDZBXYBuGHcgkmBTk58U6Li2GwqBzN3vzqnkWRzaIo5cTxtYDCqWBrvYCq04hs699A/F2AXqSz9F6B3J0S0jp18NBk5Qaj9RC+VZXCClbcWlM1A6ei4OhvGS0DDAeXD/Mw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708388822; c=relaxed/simple;
	bh=GOTO3nqAu2xUV0AHupZUceg/KPwmZbYI7ilu1XLWtjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdK7GucnUzPqTQXHUOgCkLlUx4ln1oIBrPLUjErpERXhvVeqXDHk3+d5fPqH2kGcCZAWtSW3jaBaRYxZmkN/Up+rhqKgqeDEnLhJDzpkPZLRec18HrsQuphNCAo7naNwjS974OAw3PusQaYA6lJxGWCfnJAaH300sIA4/hUgsRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W0kpbdAO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e46b5e7c43so623793b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708388820; x=1708993620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mP/xSl1882WwATp59ncaWn0Lw/3lgwrcW2cFzjqwTTg=;
        b=W0kpbdAOoELIfw/KdzFynbl1xQ958lp6FNv3vZykrNJ3mftQzvLSh20Ss+0bNQLzRV
         DCdVqgidZQ4VvH08l2/swWygQFOdSPeHcAtXY4w6MtnenXRT80BLWno1Tyx7DfzROpC/
         i44zZaTxYKY9g7YJxQpkVYhi8sGFyuDXtR2Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708388820; x=1708993620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mP/xSl1882WwATp59ncaWn0Lw/3lgwrcW2cFzjqwTTg=;
        b=vE8Gyr2XmUlH3BYA2iz8c8/178ftyxdj6v3KdoH1kIcmYgUoakDAir8cmPTjoS8IMT
         DxMwSPYVKbq42XU51uN7ZNFPXubrWe3RljrOhjA6ctCCahHssPcv4pdE0L7t+Vbtesaa
         5I/Divg73fD2niqZDTwLrWkuT/R9fEDJoLqVe7jYkko2d9wRA867oWfb0vFpRjOasThR
         FHrkdU3zZQkpB/piTW2sTnfoKTuedfVM/HmENlGy23FTiq3Sb/qS3l7+D25aGCAbyrrN
         DGxEK3k+1wjBaaV54XFHKUyE7ORlxtnImJezl7iAL7a3tTp6R4U5pce8GkVTGMLdaNxE
         cB2g==
X-Gm-Message-State: AOJu0YybgFNFc4E7k4fsmix//Bd1ScVJBDjq+iLKe4vcgN8AXpZW0PZJ
	eyAdma1jLSu1sTA0pf4oyOsbY0hQKkqy3HZUzptH78g1gQP/9tIS1uUluM19HQ==
X-Google-Smtp-Source: AGHT+IHlTGgbw96DiQJKz11Pn4Y+ryn9bcOD8U9q/kugUbnuSLqNRlbeFVzojTklWZQifuHkychXMg==
X-Received: by 2002:a05:6a00:92a4:b0:6e4:6122:fbb1 with SMTP id jw36-20020a056a0092a400b006e46122fbb1mr4858124pfb.32.1708388820648;
        Mon, 19 Feb 2024 16:27:00 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s5-20020aa78d45000000b006e1706f8b00sm5343120pfe.78.2024.02.19.16.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 16:27:00 -0800 (PST)
Date: Mon, 19 Feb 2024 16:26:59 -0800
From: Kees Cook <keescook@chromium.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH 00/10] vdso: Misc cleanups and prevent code duplication
Message-ID: <202402191625.BAD1F3CE6@keescook>
References: <20240219153939.75719-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219153939.75719-1-anna-maria@linutronix.de>

On Mon, Feb 19, 2024 at 04:39:29PM +0100, Anna-Maria Behnsen wrote:
> Hi,
> 
> the vdso related cleanup queue contains two parts:
> 
> - Patch 1-3: Misc cleanups related to a comment, a superfluous header
> 	     include and ifdeffery
> 
> - Patch 4-10: The union vdso_data_store is defined in seven
>   	      architectures. Make this union available in a generic vdso
>   	      header file to prevent code duplication and fix the
>   	      architectures one by one to use the generic vdso_data_store.
> 
> Thanks,
> 
> 	Anna-Maria

I do love a good clean-up! Thanks for this, I looked through all the
patches and they seem correct to me; removed definitions are all
identical, and __page_aligned_data is kept where needed.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook

