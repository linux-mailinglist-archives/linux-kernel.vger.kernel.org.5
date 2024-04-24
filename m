Return-Path: <linux-kernel+bounces-157862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2478B177E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490FC1F24983
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151BA16F273;
	Wed, 24 Apr 2024 23:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GsOTU6iI"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DF116F270
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714002882; cv=none; b=kztjh4qf9ZTTVnjIA/TO3X8mFfdoqE6nLvhmoAdmK56TGGm0Derl41czzk1cQixs7g00n92Bbo7wj7thPDq1DUnC2qd2/2VX70YK7PWVlZnJj0Kt92GuAw5usppJFt4r3ZlV2LuqWA8raTztOI0nEN9UvKHG45ZdTKk6hb/yLk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714002882; c=relaxed/simple;
	bh=GEa2ZZcswa2yayVTkrguSe3T/Bw++ZP/2k0w7gp61Hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pIj8AmF12t8mjZhcVvhagp8lE9sTvBEMHzN+EXyINOd1mMNVNK6+wZbP5WMUPjmD+tSKBNdYhuDYWJ++cfpKwTIjRH+9VF/0abOnlqIoEzTR65kgYvPIIn1el+ak7nFe7NUvI9za5Mt/YcheJEjwj/vkTotEDChyxDyMiEDl/4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GsOTU6iI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e411e339b8so3285615ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714002880; x=1714607680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRGfGFhxMGO87Ym6B3ZK7JbNCdjQxIkX5Cn9r5KkMlY=;
        b=GsOTU6iIlhdQB00mtAG0w8yWkUCDfutUP1lyfAw0uVZAKeGeQ1bVm5intlssmI2rE7
         zhO8ZtWL2qaf8z94M1ylNniAIu1wnv3Gg9mzTwCmg3ew2Yk25YEzMH7EFUWyX/c/dOZ8
         e3Goq2bRuOJe8ZbnyaJbXVAn1SfNu52hht9Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714002880; x=1714607680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRGfGFhxMGO87Ym6B3ZK7JbNCdjQxIkX5Cn9r5KkMlY=;
        b=C9whKgih/yl7L6ICjkVIb8UoT82O1d3KRFVveMD4YaXtjYj/kDXhbD9/q3Qi04z2RH
         Y5iEHg1Fzc7V7ME5UlNSh7gdyfyJftKHx3FYIzeOCXh9NJWm3U+wBgcZmHfaYaal2bOZ
         Gg0CAAZu+ITHCEl81cWBNlHI7TW9ZfGgGlatsgEkdEPoqfzBFnQjgW2XWkC7gcGZ7u4j
         V3jHKGXu6HquuMCP8ALmWhQHDTjOxYE4M3QPmuGvDI4la42gVA+H8gFVwkQzkLy4Hn+2
         OcBFwywCgj3155c7mZrbZ7c6WuteCDnX6tlJ4Dy9pD90g70jvaC/MBUR+CDs6NTzmwM9
         djCw==
X-Forwarded-Encrypted: i=1; AJvYcCUvgfSWuSN8MYqA8CdAnJhyAWSDUri7/mQRXvRh12TGJoVi4/uJBO5j9C0MD956IHDCpX0iynNaW+3S4G7dk2n/skMZ9CrKJQYQJYs/
X-Gm-Message-State: AOJu0Yw0LDVwItiHcbOgvh3iupT4tdAJzEGhpMoAJfr7GJJw8pyX3+QI
	CnoIaqTyNGEBUDOlJK1Wu4Bu8MinqsKuo3JK3aWKDm4M4fB2MFFO4UtkItkMVQ==
X-Google-Smtp-Source: AGHT+IHMLS91nPElw1j4Z3TJXSibZSykMsVKUeVDsltSJMSa1Mx8j3+oOp84WzCpWz0Y9FSuW5lL6A==
X-Received: by 2002:a17:902:e944:b0:1e3:dfdc:6972 with SMTP id b4-20020a170902e94400b001e3dfdc6972mr5720392pll.9.1714002880472;
        Wed, 24 Apr 2024 16:54:40 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t1-20020a170902e84100b001e8ab7c8071sm11182093plg.111.2024.04.24.16.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:54:40 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: reiserfs-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] reiserfs: replace deprecated strncpy with scnprintf
Date: Wed, 24 Apr 2024 16:54:36 -0700
Message-Id: <171400286686.3283788.1185955927816230605.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328-strncpy-fs-reiserfs-item_ops-c-v1-1-2dab6d22a996@google.com>
References: <20240328-strncpy-fs-reiserfs-item_ops-c-v1-1-2dab6d22a996@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 28 Mar 2024 21:16:52 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Our goal here is to get @namebuf populated with @name's contents but
> surrounded with quotes. There is some careful handling done to ensure we
> properly truncate @name so that we have room for a literal quote as well
> as a NUL-term. All this careful handling can be done with scnprintf
> using the dynamic string width specifier %.*s which allows us to pass in
> the max size for a source string. Doing this, we can put literal quotes
> in our format specifier and ensure @name is truncated to fit inbetween
> these quotes (-3 is from 2 quotes + 1 NUL-byte).
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] reiserfs: replace deprecated strncpy with scnprintf
      https://git.kernel.org/kees/c/ba287092ae90

Take care,

-- 
Kees Cook


