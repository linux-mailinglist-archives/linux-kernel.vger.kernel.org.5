Return-Path: <linux-kernel+bounces-65846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A261F8552C4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82D19B29E89
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16BA13A26B;
	Wed, 14 Feb 2024 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="apMZOWPT"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E681139571
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936921; cv=none; b=ns82qG83geCya8cHTxmK5pTfb2EkoThL7T4pHtpQa0DTE1KAZ8jIX0Yejkc498HacmMc1ith/aTZNtIiVnAwxq5daXmXXHIOncs8TPdHwx3EBbxOwynn/ipiSvSjrnOsqaoHb2uQu3keJ3D2UjEIrByR/lL8Qa4Ihz6r9RbSWFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936921; c=relaxed/simple;
	bh=E7A23eVB+QcyjJSOnbTsqesKEv7J7rv4FPLXbNWF3hQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqQy4JB0w7Dor0DLXqsDSpCbsR9mFRRDXaqEaYl5hl/xbvihoGyjOeD5kSgJwVV4cmqU7FYT9ioI8I22EMyCXeIzHDVs/ZXtNweNN11uLyvGQ2w2PhPhHWinBp5TJdPP+Oyu1eNBzz2u+5RSvuOV4GsWnF30QcPCV2buti/w9pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=apMZOWPT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d95d67ff45so300865ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707936919; x=1708541719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8pBojG5Ph+1av2r+/vw8N+d3NzUsR2t80fTE8XJw6Q=;
        b=apMZOWPTwgeOLexNgyWnsfghV1LNjfW2KFmLSFsB9LClBl+Stf9Rm43fz2mKAazusc
         mLcOABBdvdeJKeBUX2a4eKdaKG2eMiubVJ9ul5zl+J4dn7LcnSLiqmY1Kc0rS6K37llp
         l4AqlGgGVaypx6ub6O6/AoOaGrKmT6+EPcEq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707936919; x=1708541719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8pBojG5Ph+1av2r+/vw8N+d3NzUsR2t80fTE8XJw6Q=;
        b=Re5MuTnaR0DX8ffJevKxmsbbOG62x13XewxgXangLQ18hakbWRd6AwRlftG1f9d1za
         bGO9ZPEXxFMwg7q0KgWxFq+LlCBKWfWYkn98q8BTfoxr0/z5DCLHCPBEQB1ul+CQsmaT
         JLvYH6pCBQ35cjjizHPDU2rBezRcnnmfy91oIAI7yWBpYec+h1Csf83kCXxzQ5KT7Dgc
         nrDGmD71Up4UkTFaBTqR7aifApG6eeY2jVwyvZIe57bkaK3SCWnZ5jMJEBLJ5wH28Amr
         4DjQD5nOLpnGDcONLa5cdvVZOr1prXSAOu0AzM23ApvLhE2ScUrlh8JQmCSqlOXaK1fh
         +3Gw==
X-Gm-Message-State: AOJu0Yy/CnY8QKvFOmqJQiTFj7f64rj+3tQ/TDHVE8tnmAmB2wmRim6e
	mUBIEOqL54XvnFnBbcR4AkCEV141EruP4n7aTNYe1L053oSroLCOIuPa4sTaZQ==
X-Google-Smtp-Source: AGHT+IGuQvVjir3zyUTAuYH1w57Im75dP7/2K5h6iQ5XXa7YHY20PGQitQTuG6BoZCd9FIry7YOeng==
X-Received: by 2002:a17:902:7044:b0:1d9:ba26:effc with SMTP id h4-20020a170902704400b001d9ba26effcmr3411990plt.51.1707936919056;
        Wed, 14 Feb 2024 10:55:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIb5NLL6559qfZE28qLRIzmeD3VhVml04Dzqs16AulJBMBcmPRRCEnoPRpLkvAc2kYT6ICn4/qJtTFoAQVBsBdr+P0Dbt2rNWUVM0ETBARtBPEiQwG1/l1XL6XnCWWKdB+mutCCh4IUN0ddAmU
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r10-20020a170903410a00b001d8e4de7a44sm4035449pld.127.2024.02.14.10.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 10:55:18 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Move upper_*_bits() and lower_*_bits() to wordpath.h
Date: Wed, 14 Feb 2024 10:54:58 -0800
Message-Id: <170793689581.601125.11846352168094586184.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214172752.3605073-1-andriy.shevchenko@linux.intel.com>
References: <20240214172752.3605073-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 14 Feb 2024 19:26:32 +0200, Andy Shevchenko wrote:
> The wordpart.h header is collecting APIs related to the handling
> parts of the word (usually in byte granularity). The upper_*_bits()
> and lower_*_bits() are good candidates to be moved to there.
> 
> This helps to clean up header dependency hell with regard to kernel.h
> as the latter gathers completely unrelated stuff together and slows
> down compilation (especially when it's included into other header).
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] kernel.h: Move upper_*_bits() and lower_*_bits() to wordpart.h
      https://git.kernel.org/kees/c/9aa3bb490404

Take care,

-- 
Kees Cook


