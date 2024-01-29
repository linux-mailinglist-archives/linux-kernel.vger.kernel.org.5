Return-Path: <linux-kernel+bounces-42232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EA183FE4A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209641F2266F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE504C610;
	Mon, 29 Jan 2024 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kRB61PCh"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CB04C3A9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706509653; cv=none; b=camHyUiYKbBDc5At6hbb6sUSwnjL6tXX7iCNKbhu0J598N3cfgtYgJYAPEG43bw//yh8huW7eXcnbHrP2pxDoGHP7zN9zorU+OclpcLgeavlp2xbf4SX+pMkNhG5of70imGZ8yQYnH0oU2Uwhq0sMTxyfc5sdzeRtNa/fJbzpIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706509653; c=relaxed/simple;
	bh=hcGmZ7/kauprUFA9fmX+rybUuwydMTeCbv3H/HMqJrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3+kD0GpvujPKwfCJnQfIv5h2NSbVe/oDYls7lxZXKPKKyLpaHQr+RAsznMmZtXZX8aWudgjMO3sW049zSk16guFbwBcpzL/anWCf+7Pj82mDt0/ZYQdhlvkY/h2/2hwxDqAsCS8B7Ds1YFTul+jj0S3LhD+J0DkuJnbrv817RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kRB61PCh; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e11283948eso717211a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 22:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706509651; x=1707114451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EDxbu0PKWqjMPM0OtvTRKUw3nFg/Z8Lcou0xHo9uBJI=;
        b=kRB61PCh7hYyHcU3H3T9Cc2M8+gK0s5S7ysQrxdg7XtafaxO4gLJgXWEjIgrKzBC3d
         /BbHwnovt37dPfmzlHf3t+t7rxd7gtELskay3kMcbTuaYEUvwxLx76sCS9G5exzI3g/J
         FHnEvCjNpl7SJmQyybwJOtZO40DBPMGuJ/nQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706509651; x=1707114451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDxbu0PKWqjMPM0OtvTRKUw3nFg/Z8Lcou0xHo9uBJI=;
        b=euZFGAY4FL7JlAIsCvkg9rNQP/uedmTTyeCM0dq4ITl8C4ndpBf0+62zrVYb8VXJsI
         8sws1xJGyP2sRKNOQ9VcNQEVCx95LN5YJiPPVtCopv+GyH6P4jSMI1sk7iH4EMsnMUvT
         xDFVNXFqqmMTFzN0wGrLiXGegsb1iKY/fOXm7+Tyzo0pPG755t225O7T3kGYqRwkvSQL
         PR10U4Jj5VjoUda5yKidTTtjJuqZS0GrGPzdV+ep64qlkOPuK9j/wtdsrAbnsGtTXnlF
         gGedg2tZ4jrGEooOvT4z+SvO1lRASyVOISgBndV1dD9AWT5mxSeukvyrYdmbImWQcH5D
         lsSg==
X-Gm-Message-State: AOJu0YzXCjJma1SjxaoABAV8B6MkXjXEPs5eUphKxDBfbFO3qJR8XrAf
	AFZIH8emru4ul7rPnD3XrjTChTLPJ0OruntbxmLNQCUVOx3MOZq+8evYqtIn9Q==
X-Google-Smtp-Source: AGHT+IHR0VdJI7aAKAeSSYv8772Arwr20uBiO19FH978QHyj5alwAO2XhzCftoYqEsMh8OmLG+g4GQ==
X-Received: by 2002:a05:6358:7581:b0:176:544a:4ffe with SMTP id x1-20020a056358758100b00176544a4ffemr1998434rwf.13.1706509651420;
        Sun, 28 Jan 2024 22:27:31 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r20-20020aa78b94000000b006ddddc7701fsm5063741pfd.4.2024.01.28.22.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 22:27:30 -0800 (PST)
Date: Sun, 28 Jan 2024 22:27:29 -0800
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/82] overflow: Refactor open-coded arithmetic
 wrap-around
Message-ID: <202401282226.A4C1153769@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <Za-K-3aSBULf4NWE@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za-K-3aSBULf4NWE@FVFF77S0Q05N>

On Tue, Jan 23, 2024 at 09:46:35AM +0000, Mark Rutland wrote:
> This also misses the include/linux/atomic/atomic-arch-fallback.h
> implementations. Those are generated from the scripts/atomic/fallbacks/*
> templates, and you'll need to adjust at least fetch_add_unless and
> inc_unless_negative. As noted on other patches, my preference is to use
> add_wrap() in those.

How do I regenerate the header files using the templates? I found a
script, but its use eluded me, and it doesn't seem wired up to the
top-level Makefile? Maybe I missed something obvious...

-- 
Kees Cook

