Return-Path: <linux-kernel+bounces-123696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE8E890CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47EB628E1C4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A53413B599;
	Thu, 28 Mar 2024 22:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AIrnUct4"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D1213AD05
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663226; cv=none; b=phE7f3EJoijYFfrXlKPKMfKcHgr7sHbit8zOKTHnwU++HdOzECdRtTDz7AhFbdZkbbBH1bXW0SGtCw4tizD4wTGN4qAuwpiokJyy0l/ijYnMEWOA+eCLEhHV08lEyZ+oR2Ryn+/V83JspR2RRGwdb1nUyALstwEpENPuHgaxrGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663226; c=relaxed/simple;
	bh=lrccwVtv+VocI+uwu/BvfWqKKPeev9lYSgNhYKLTyE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjsLN9AxnYbma0z9PnHsr6rqw6Fi0fF8mSSFYAPPCiiSkB0Y3Z8L2ltSuV1s4iR4vPv1+KTLVHIqbOHkSXTbX6Vhnx7i/q+ijq3o2ydB0QqD1x3+D4QWGJ9jWrCo/3i8pkF9Uh2CP2hdOTQAtPVHroC/nHMvDXL7rC2Pa2uev00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AIrnUct4; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6f4ad4c57so1209243b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711663224; x=1712268024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FaPCK81jh5rDMWrdjvIXeW2FJ9AEoWipgE6tUpqU2c=;
        b=AIrnUct4+Erby/pTfP7TPIFcTUbf7ryccap6plIeh7eaVx9bFm/abQgI/al79y4mom
         yn4UcIJL7gXXDR50hIZnxeEiXiMZA1GhRqMq0PdTjszmyKVWaZuVBgFyXYn8FU8SPp2V
         kikuxkTFDjs6nxnPVrmKV13ViHf/xfN1YFRgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711663224; x=1712268024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FaPCK81jh5rDMWrdjvIXeW2FJ9AEoWipgE6tUpqU2c=;
        b=oLYaaSqK1k+TrK45Ka+0pODAkrIjbrxiR1ahqTF4J/bYQs1qB7+2f7T3gV0BMh4k4f
         lH9xQ2GjXSfbjWuz4YpvqBzO8XMy5JrpQ3bfdoFUv7BSDNdJXJcLYXg4tEI8aZjape7C
         4iIM7p4wW2Qf0LEh16sWY7gma8MrCoWGNEB8ePh6+cidJTsC8KkakDzOGHHvDWiK7984
         wYVP9lZ9FLcbUuV0UKwAgbn/g9xbfSAij/XHJQ6su76LdlWrxiG8cuWACMFKg67g4Wsg
         ZL4s+OjozSlOWRsaGkCI6fvCBdcu05jOJ+cR5yE9Hqt1Eg8fbIyfVLPYmU0a6ML1CM9r
         +7jA==
X-Forwarded-Encrypted: i=1; AJvYcCU0tn3T5YbDvKSyiSBDWRyFYWWGEtokEbREUPGl3EMpyTio2mfg+mrA7CgrZ/EU99NwdCVs6v/isfAQyBD1vAubM2zQda0bJyQVdLj9
X-Gm-Message-State: AOJu0Yy1M0EUdu1/BpntQ4y0uA+rXHvy65Z0ZSfn1eqxwchsFqog3XHu
	C1m+rcl139FUyoGb+8kZoQ6jVfgDSu0lnVkSiN/KMrhIuMGTatob8Bk55GyqRw==
X-Google-Smtp-Source: AGHT+IGAvQSMVMQ6rhnfGZcLmg0Ya4IeauYf8sBbn6Gqrr7pSRnfaVTTChCQ8UobeDDw2+pbEWza/g==
X-Received: by 2002:a05:6a00:991:b0:6e7:3d21:e629 with SMTP id u17-20020a056a00099100b006e73d21e629mr631372pfg.32.1711663224651;
        Thu, 28 Mar 2024 15:00:24 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c6-20020a62e806000000b006e6c5cbfff7sm1862314pfi.169.2024.03.28.15.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 15:00:24 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore/blk: replace deprecated strncpy with strscpy
Date: Thu, 28 Mar 2024 15:00:19 -0700
Message-Id: <171166321787.3580825.614329784153739643.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328-strncpy-fs-pstore-blk-c-v1-1-5748cdc22a53@google.com>
References: <20240328-strncpy-fs-pstore-blk-c-v1-1-5748cdc22a53@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 28 Mar 2024 20:54:16 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We know that info-device should be NUL-terminated based on its use with
> strlen():
> |	static int __init mtdpstore_init(void)
> |	{
> |		int ret;
> |		struct mtdpstore_context *cxt = &oops_cxt;
> |		struct pstore_blk_config *info = &cxt->info;
> |
> |		ret = pstore_blk_get_config(info);
> |		if (unlikely(ret))
> |			return ret;
> |
> |		if (strlen(info->device) == 0) {
> |			pr_err("mtd device must be supplied (device name is empty)\n");
> ...
> 
> [...]

Applied to for-next/pstore, thanks!

[1/1] pstore/blk: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/80b735d01bbb

Take care,

-- 
Kees Cook


