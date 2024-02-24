Return-Path: <linux-kernel+bounces-79384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B16862174
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B803FB23D85
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF914A11;
	Sat, 24 Feb 2024 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GpVX60LN"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B6D46AD
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708736901; cv=none; b=jSpKWz/6P/FIMAb1Pl1b5+So3OeTs1QG06U4a0Mgkgu7iDRoQyHw766jQC1reAZxyBPxOsrW+4RkOf/s2GwpxmEgFP0fhmR6stfIXKPrTLoP6Qzqnj6Pe3/WP/rRbSXoBj25oTMomixIO1ExRcAMKrYpqk2e00fZlexbokYd514=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708736901; c=relaxed/simple;
	bh=p5ato4DMryYVxYzXnaJl8fYJ34T6J7eCWMst/m5g6WY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/3tyemWdgCwOj5CgQekFiKmycSChOFMm0+G8Pw/5/3m/fvb1DZtxOPzWWFlYkhnHQVnDGUCFLu0pLWz7va85dj/GzLVaxhM4CASjCVb6XrK1XKSdWnNDHFpoPrjDzRb+RFpiZVJ+fewkME5z6BHHgwZuklsfTTxdgA/zwseAaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GpVX60LN; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso1226558b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708736899; x=1709341699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPbEpUgR3RJJkrT8w1u3P3Cf+PMMA1sVgxWxYwB5BwU=;
        b=GpVX60LNUfW8LZUQX8gTOYL70/+NdMxb5pOYbi00Df4ixjfdkSSt8uxx44hUlc8NEQ
         T1rnJHuJFy9Wcy6dC+7e3wpd8Pf7M1vpziND2d0NZSuaKjT4w1Jka8IdOjgZZxUggeQ8
         dUVkm168EqmGgRvYcBUZ7JqoQKUbhZKsNi5/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708736899; x=1709341699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPbEpUgR3RJJkrT8w1u3P3Cf+PMMA1sVgxWxYwB5BwU=;
        b=C9qNNW6GCmJxMPwb9ZQO6f9n7PrRBGkO6zehh7qcDIamm/33CgPzS3FDl/2gmZ79zS
         Gx85owZZxKzdSsJ5VYRsW7lkJ4qBT5ykTINczEnWt5xL33j3NEdIlQDPzI08w8JK5E+9
         6eytgirtp3/4eLkHPuIPVcRaSay13J0tay3DC9wQ3WLfclczx2uBmRk/VH2NuIdwpjfr
         E+t2c91sqz+Ru6VPV8jutFoxCf4iQr7e0g1/wlneocX0fzF9wHRZlnQRYWk6Iqgf09iY
         g/Q87XIGc7eQ1NskvdJLcc8ScDK0yPkeHN1XPcSZeVJebFt+egyIxMySrkiIsXny1Wlk
         FWcg==
X-Forwarded-Encrypted: i=1; AJvYcCWCP0njo7zzburalH5mfaFKrtAjoN0WwsfTKo5lA2w3mJvrUIB0WUiplpHbLC3CwY+GLIz6nnHa5iPGhnlYMHUgpMHKv1iPvpHEWmfx
X-Gm-Message-State: AOJu0Yz8hZ+5HIznlbASFw4cwxqr48iAr05D5E4Jn9GwI0HDrDm0dogf
	UhgBOwiEfmnmYbAU9chF1AE3q20WjIYe/M02o6l0NoHqQ0sbJcBRNVsAG2IkHA==
X-Google-Smtp-Source: AGHT+IFGxAKJP55TZNONgdna+0WFrYvk9AiEzOU4vrvn+NI6VUCOuTPWb5QURWSnotnP6aVhVFRPBA==
X-Received: by 2002:aa7:8883:0:b0:6e0:50cb:5f0a with SMTP id z3-20020aa78883000000b006e050cb5f0amr1649876pfe.12.1708736899436;
        Fri, 23 Feb 2024 17:08:19 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w27-20020aa79a1b000000b006e4891d0e2bsm94905pfj.7.2024.02.23.17.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 17:08:18 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	ebiederm@xmission.com,
	Li kunyu <kunyu@nfschina.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Delete unnecessary statements in remove_arg_zero()
Date: Fri, 23 Feb 2024 17:08:16 -0800
Message-Id: <170873689406.2130928.12246723166795978039.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220052426.62018-1-kunyu@nfschina.com>
References: <20240220052426.62018-1-kunyu@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 20 Feb 2024 13:24:26 +0800, Li kunyu wrote:
> 'ret=0; ' In actual operation, the ret was not modified, so this
> sentence can be removed.
> 
> 

Applied to for-next/execve, thanks!

[1/1] exec: Delete unnecessary statements in remove_arg_zero()
      https://git.kernel.org/kees/c/d3f0d7bbaefd

Take care,

-- 
Kees Cook


