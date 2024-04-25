Return-Path: <linux-kernel+bounces-159175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684DD8B2A40
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98950B237F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF1A154C11;
	Thu, 25 Apr 2024 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FCTssiGF"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE12153582
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078680; cv=none; b=iCy5ZH1BbDdVKPjB6tziOiSF+bBfI5KC6mfOyHDrKraR6PKmmcxdkNFVXKB0iudgdNcn3WfN39tNgN3+dvRb1RaN03sv8R90gC6rfutpoff+VxQjUuZHHtb0TICjFpCTmr8KpO1B6+xMqqf1C8b/9ubvrGvQLeSeaxSHObOG6zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078680; c=relaxed/simple;
	bh=5oNgEmljdB6NKphOsBQ2rXcl0qZAFG/RxtdNV0s6mYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdU0g262NE4rvzco2RZwRhgPtubNy8uou7d0TgdoIv94YXK/k7VITpb6AJYrz2ppV6cQSulkFCsej1k4sC0yorAylt/FMePbTqLMsVS1GyPO3sfV/f9LRt2Ml2BMvUEwBgBAfzgW//DColET1Z2CCXuO3YZFBpwVsh7MiZGtG64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FCTssiGF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f28bb6d747so1358657b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714078678; x=1714683478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gZcutr+DBU8+7Q1m43Njo0i1Yp7GDDxZafFN7u9zRq8=;
        b=FCTssiGFEiHsTjRsr84PBt+Or5GPUv7EZ8Y9DroxVfP2ckogf2pbChiFcPYFxelt5J
         xqxWIp7T2F87TH/eF4NoDfaEHIOgLrlE25sN1Su6EcCkY8lQWNwsOY8o1y+B4UJFXUFS
         JJmFK7U4ZoTgCl7D9lDhGakrVLifM9kgORAdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714078678; x=1714683478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZcutr+DBU8+7Q1m43Njo0i1Yp7GDDxZafFN7u9zRq8=;
        b=aj4S+LnFD9Tp/MG07Zda/aaOWUvpWBpPTpOkaDHtgog3EoQeRzin4ismk/oGNnzpts
         LOwCRpefQaX490LY0IvklpKnU4zuhkdDHoU3gzi27dcg5YdjC1hJMHiCKjQds6AaT+IM
         lVOo4vkxvc7KHKQA/BDzkOqTY800pyET1INnNDzy3Diuz7+vOx+2tOEWbgfnV83IEVYH
         YKh8ZTR7DD8VehB196zi6bJkRyO+82JXGFj9QiQJulCzNtVpQNxNSm63Rj5NZiwH9ANO
         fPgwzzFk3M/5AH8J4xTYtGmaTT/KRgmySLSHnBxkKATnKBDc89VeNJfa8DQHBDwVmOQ+
         azJA==
X-Forwarded-Encrypted: i=1; AJvYcCXOZW2Zig09x63bfxcXxsJhcADWmMjZk3VswfnHjixO/JaidT5VInQjF+mtElagPUtQJn4WTGRdsB8zZNbqfUGZBiPtpV3OT14Bh2Oj
X-Gm-Message-State: AOJu0YyuWubDRd4Nj5wFpJvtv6LuRv97eWx0BTQr9oPbqtTzp0SnjNF0
	1zMUTWK+2aiK6R9NuMXyrqBxRGOVlL06Loe5mTmcrWeu2tjYgjARCVoA5V5H/Q==
X-Google-Smtp-Source: AGHT+IGfz5Rebw0b1ZhwK2xIUu+dXp0C650WMXHqzg55TZk2O1Ojuq+nNXtUUs8X9rCbcPWJ63x3NA==
X-Received: by 2002:a05:6a20:1581:b0:1a3:ca86:be8a with SMTP id h1-20020a056a20158100b001a3ca86be8amr1084537pzj.57.1714078678515;
        Thu, 25 Apr 2024 13:57:58 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ix19-20020a170902f81300b001e895c9ec6asm13735852plb.152.2024.04.25.13.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 13:57:58 -0700 (PDT)
Date: Thu, 25 Apr 2024 13:57:57 -0700
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-ID: <202404251356.F694909C63@keescook>
References: <20240425200844.work.184-kees@kernel.org>
 <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>

On Thu, Apr 25, 2024 at 04:45:51PM -0400, Kent Overstreet wrote:
> On Thu, Apr 25, 2024 at 01:08:50PM -0700, Kees Cook wrote:
> > The /proc/allocinfo file exposes a tremendous about of information about
> > kernel build details, memory allocations (obviously), and potentially
> > even image layout (due to ordering). As this is intended to be consumed
> > by system owners (like /proc/slabinfo), use the same file permissions as
> > there: 0400.
> 
> The side effect of locking down more and more reporting interfaces is
> that programs that consume those interfaces now have to run as root.

I'm fine if you want to tie it to some existing capability, but it
shouldn't be world-readable. Also, plenty of diagnostic tools already
either run as root or open whatever files they need to before dropping
privs.

-- 
Kees Cook

