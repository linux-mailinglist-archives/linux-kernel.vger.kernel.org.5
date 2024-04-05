Return-Path: <linux-kernel+bounces-133259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0520889A14B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DA01F21CCB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C159217108C;
	Fri,  5 Apr 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lmXj/IMF"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E6616F917
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331178; cv=none; b=a+mVfoTSvGDsRzJF3zu1BLDhoYvfwfDNCmz0DAo3IGxT27tUT+kiuzshRCXYTGlToTxaH9Mgc17lF9tO0mW9fgOrv6D6YUc6DuNyYp11PC1Qjj/irH37NrR7DmwzOYMgZoTFoCoOaf9txUV8NAZLfdBGxnBYP24v8AE/W38ZIAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331178; c=relaxed/simple;
	bh=yBWl+5MwWbl7Q1sVXG/qocl0ZSbSVgqv15hiru/Tetw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+Y5Bl2s2J40wN7ivqDVl793ls5qY2hvY4oAivvq3mB8bhkBHotF23wZDL64RqrvMC+7DzXJXEHuchX1tuoV2KAGymf8CUyKyFVJGXcDhBabMTUHTUaROKMmeZUoxgXXwfHXBdvEg6AgAUyIgTE71LxGwwjgFPdwamebKnNbAvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lmXj/IMF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e2bbc2048eso16136545ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712331176; x=1712935976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SS6FB8GMGclDd7kSPRtPPPk4CddaIuDN7vp4ZcGd1Sc=;
        b=lmXj/IMFkTaL/ok6mwOwz7KP6xzDoulFL/kqNXDjSo9aR248uHu46l6Dqwmja+31on
         MGgjq4aPg9TO7OZTo46QcG2wtEq/EeQZ0u+I34nNJ6FmkRKQv3qLtIPuhDsWTPrrszaZ
         aF9ZAVdzXdNK8MsTsg7fX41t4eUQQObRV0rOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331176; x=1712935976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SS6FB8GMGclDd7kSPRtPPPk4CddaIuDN7vp4ZcGd1Sc=;
        b=XltyXMc7+ap6T35i2ekUqh4xgAGi0lt9zAPqvAvXBq/GEXJ+ZmulXDhJy49kjMAURP
         aS6306xTuttWsBfkd/uP0wNEwkLXDihb2kKpb8/d8eg3Mkdr6q1XMvxmJWwXq/aCZX31
         Y6qSfw0IWoQgCsYgWGxL80x3h0mUEdjtK/gQO0nOQAjzbcXxKWZs1VcPnniEBTdnuum8
         7oJQ1nAoQz6ZfXb/z0dI+qt3iqBLLiOQ7S6V4cehzrNut6QjIXrLObhykkzLtdLdl+6R
         CNiTMKuLk5YJ8ldnJcEdESBKEQxvjoPLwaF/PoFvsDrO0eK4Yx22mRPfbZZX5ZORnnoU
         7omQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn0mykak9c8rNpGciUu+2vtgV93TDPGMG5ZyENpeeY80kkFW0d0kuiiy8rOqR1JukPMoi7frmvNDU8lnpfPhUKL0pm+fJpfV+o1YhY
X-Gm-Message-State: AOJu0YwszCwA9kuKr/X/+UZmIZnkIwmgF/DRCJiR/y09MIJFdJ8dWL4g
	O9BzMsI3d+TLA5Myt1AES4rbbX+Q7XHN1Gmbs0EG4okAPTd7QoHVOpOOdXu7XA==
X-Google-Smtp-Source: AGHT+IFjfaWn4WDeCb/ACnVGExCKrHZllNuvtdBAbn2V0PYaZoLURGRgHj60A1D8IRxS1YdRgkOCsQ==
X-Received: by 2002:a17:902:ef51:b0:1dd:dde1:31dc with SMTP id e17-20020a170902ef5100b001dddde131dcmr2469998plx.26.1712331176080;
        Fri, 05 Apr 2024 08:32:56 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kl11-20020a170903074b00b001e223c7d8absm1722935plb.174.2024.04.05.08.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:32:55 -0700 (PDT)
Date: Fri, 5 Apr 2024 08:32:55 -0700
From: Kees Cook <keescook@chromium.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH 2/2] selftests: Remove Error/Failed prefix from
 ksft_exit_fail*() usages
Message-ID: <202404050832.EA0C9D5E@keescook>
References: <20240405131748.1582646-1-usama.anjum@collabora.com>
 <20240405131748.1582646-3-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405131748.1582646-3-usama.anjum@collabora.com>

On Fri, Apr 05, 2024 at 06:17:48PM +0500, Muhammad Usama Anjum wrote:
> Remove Error/Failed prefix from ksft_exit_fail*() usages as prefix is
> already present in the ksft_exit_fail*().
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

