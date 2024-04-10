Return-Path: <linux-kernel+bounces-137749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB41989E6A9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB691F22318
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A33339B;
	Wed, 10 Apr 2024 00:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x3D1SZ/t"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8EC19E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712708064; cv=none; b=PXhhNlcXOWQt3cXQN36eUkeyIy/5Jy+bcK6BGwpbmYxPXmlgoNwD2DSH16AiSXFSsO+LPY7f8Z8ZkLLycs2AKX5NGrdgeGvvXilUFgJnH9a6R5NAIk/HlndEmRvhvD4i+TJhUu0LNjB2sGORKgzCufrhN4gv1tsH2oL69Bd36Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712708064; c=relaxed/simple;
	bh=hylFjz6L+qK3LEVxEOjE2ZqRGFqT9dpT501eKt8B9PA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ls0rmk149vvBMtCDAStyHP1Vz87dQCQPUbL9YtGtGHhbrL3JYCWVlY68lmc1FyQgDzzExMrsqfYWdQRLFsu/DCIvrl6PY4I7olvMyKpgmZD70fSPmMrjdsMLMs2/izGo6UIuTRwjMcAdW51PJ2h4mDADMt0IbWJvGtXbZFK8CzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x3D1SZ/t; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dce775fa8adso10539435276.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 17:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712708062; x=1713312862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dIbdZOv/vPHtFRzVH0oN0bjB08U1X8E7O8JyibswoCk=;
        b=x3D1SZ/tm/b6lcE9oe75iRwX77MvvB+e0T+DR4Xme8AcZHUUWGYtZdklaP/LifLzHM
         VUhc6nuQuufAh2mjYyN0bNa2yh03h9PI7ACLlmB687eDxVNy5z4DXD/YqMFNBMNVnMgc
         zP4HeEceBlOL3KrEaGBrQONMGVA9DMhUCuV56xN+AZaT4QajHkOWjPH7ycJk9UhaRfN3
         WXXIS/NClMxdK8UKfqbanDLDQfIhAmtWYIzclEjsmkTB3PcftmRBVeXWL5LcUC2ZKt7C
         cCpfgbgrZkqj3pxzmgNt12DhJ+9Rm2Y01jatMPtEDjNQZhZ3LSCB3wMyjQB6T6eb6Lid
         /O9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712708062; x=1713312862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIbdZOv/vPHtFRzVH0oN0bjB08U1X8E7O8JyibswoCk=;
        b=Ib3V0l19bGPY6socz9bOR7BxDdLxkydCacQax844N9gGUwW2KOwz8o/wqPsC19dBbB
         hRrdUaq41GM3hf2FPNMqEyPSxI0bDWSut5KEjTJESQLHmdAiIU78rzWXOT1NTxdzpdSS
         Of7yun66rMsTBcJ/OsPYMrogk21vCaOaYVKDdMfFYeBe3BKiDNO/jLGYOcVu5j1D/XHj
         Aiva1Dr4GX7gU1E/lxT3WHLe6VSfKl1U77LROF3EpaejrXLGbA5aHNQhRH7FIABAzejm
         uaJSmtwo4kVB7KZHA0vIlQRemfEmLtbozHaR6IYnWw1ewwZRS6hr0o9gJ9EYGh3R0zTC
         qP1w==
X-Forwarded-Encrypted: i=1; AJvYcCVSanc0hSji46rbxx4wXkJLEFWEhlNFfHvDfCTSzQNYNyekduwsJtCECq4ih0EWN8VnajMOO3KKiiP1lq1loQ8jnQXFqJ6IH3nBI1hb
X-Gm-Message-State: AOJu0Yxz2yBvwAIc7Sm5N5fMZxZM2xQ0jlzI2RVrhVtYGU7NAMzQGxI9
	zkMsbHYCjAzaCOcfZmb65lzf/nA6lqCrBsJFJsSo40CHC1eWygXJ0Qbt416eyLw5hCOuE2sUnmm
	j9g==
X-Google-Smtp-Source: AGHT+IGGO4GWmzQYviQp1CVozWMLXLtrysbsNAF3g8Mrch1Hg1xHRMGTrIYNUcBplo2kcfvLH30UdpXAvJU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:f82:b0:dbd:b165:441 with SMTP id
 ft2-20020a0569020f8200b00dbdb1650441mr387148ybb.0.1712708062334; Tue, 09 Apr
 2024 17:14:22 -0700 (PDT)
Date: Tue, 9 Apr 2024 17:14:20 -0700
In-Reply-To: <20240409160920.3bfe3eeb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409224256.1581292-1-seanjc@google.com> <20240409160920.3bfe3eeb@kernel.org>
Message-ID: <ZhXZ3BEcbtoJKPFM@google.com>
Subject: Re: [PATCH] selftests: kselftest_harness: Print empty string, not
 empty fmt on PASS/FAIL
From: Sean Christopherson <seanjc@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 09, 2024, Jakub Kicinski wrote:
> On Tue,  9 Apr 2024 15:42:56 -0700 Sean Christopherson wrote:
> > -	ksft_test_result_code(t->exit_code, test_name,
> > -			      diagnostic ? "%s" : "", diagnostic);
> > +	ksft_test_result_code(t->exit_code, test_name, "%s", diagnostic);
> 
> Have you tested that to make sure it doesn't change the output?
> 
> .. warning: ^^ leading question ;)

Heh, I was *this* close to adding a blurb saying this was probably only compile
tested.

