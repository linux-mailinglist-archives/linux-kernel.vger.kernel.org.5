Return-Path: <linux-kernel+bounces-103575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376B287C14E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642861C22140
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDBC73526;
	Thu, 14 Mar 2024 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S/yGJD/7"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DFD2C9E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434008; cv=none; b=C1behVTUowqEw/wG4cIBDXXSgSzqCvRVzHAxOCY5SPz+femqbUO1SJ8ACHJrWnldjfLKiP4s2dNGomWjsH4e1CKNt3svocx8SRuldu0fBjWy+VPfuO6RGEgJLEnJk02jdJDvcZj0/p/SP9vuYaHGImgETB2liVOIsIRO5HC0pkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434008; c=relaxed/simple;
	bh=laj4/2Ta/6zoeesVHXZuRjjKYv/zbHf7v1TjbkX9Mu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GvL5mg5Ig5S9NwXMFTg6MNILa8JZN27SSjT8CyIFJBuxyPYoJfRlNKDffcZ6ETP/W/K373k4RLNoaeJvvUu6czWDvuTAnd2rV6JHKlRxVNgDIuUHpfxX9nVFLE3BORhPcaWcOuy7vfc8zLNfZBkNERJNob8t7z8TmABfZ5h9b9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S/yGJD/7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc09556599so8999905ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710434006; x=1711038806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CE8ADRjpPfrMA6NXBAJYOXhafaKS1dalAtgZ4xa896A=;
        b=S/yGJD/7LKO7MGJ3KdgbCpntApjkutIWqV2PN7HHoC6n7xwnKWhNxUZgkdCu2yjAA2
         hToESZPNrzm6PCyjPU2pc89ifjV5j7QiwgPJPTp8mS+qJsZm+XHYtKeSIwzzodayIezB
         23I+DhlYa/GK/bx3CWtFnIf6AFwSudGWAAGMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710434006; x=1711038806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CE8ADRjpPfrMA6NXBAJYOXhafaKS1dalAtgZ4xa896A=;
        b=i/CqeHUjAH1mwcPK9GepeGv+ajf8cQe72M2T/6gtV2eZHgo5CMMc6xmoSVPDdKA0p3
         7e72mlfDspiLgFt6aw76b1Ry6Wwl/BISki7IqhW6jS6jVAM06/T7YkoW01aax/93gBQ0
         CLHpicol0jfGXRMb1IXNLPmRk8MfsJ3Db7EscM9jSjK7xNjj5e5k150yQ2cWp/v41nq0
         OrBdkpdevJ3OIVN5E5zMc/5SZvgVVukdGt+lpLjj9KZmML6Yctn/KTdvxt+PhVmUKNa6
         ARQUPhhAtjl0aU/z9c8ZM7shP0aK2JYqdfNA0sGMNz+pFhWi2P5ZH2DL4TXb4HjOAm5h
         j4ew==
X-Forwarded-Encrypted: i=1; AJvYcCU/Q2sWfXWbWzLiCByQleUpagjJeY9nCU5FZYYGkJT/HSTfLKKnYrzHdDUsjUGYVf/h6PrHjwSctVy5nZmv9dkt5YoDkW5DHFxWhOH1
X-Gm-Message-State: AOJu0Yw1YCiisZrYyWCxEhguWUqmQZGGCsaZMyJACjMnOKfoA3vHntKh
	xVmycHqBzHauTI2cNpwZgF4f27+yKVGHGrW1d2V3inw2lcmvxmCS/QF30l/bBg==
X-Google-Smtp-Source: AGHT+IERozHbz5wbMDxAK/gfUW0Fun+dSMaITpM0oaIDgkfK9q2EIS9FIrj68HO+iD78LMcOPU/HjA==
X-Received: by 2002:a17:903:489:b0:1dd:9de3:f3b8 with SMTP id jj9-20020a170903048900b001dd9de3f3b8mr428005plb.36.1710434005843;
        Thu, 14 Mar 2024 09:33:25 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kt7-20020a170903088700b001d9b537ad0bsm1899994plb.275.2024.03.14.09.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 09:33:25 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	David Gow <davidgow@google.com>
Subject: Re: [PATCH] Revert "kunit: memcpy: Split slow memcpy tests into MEMCPY_SLOW_KUNIT_TEST"
Date: Thu, 14 Mar 2024 09:33:22 -0700
Message-Id: <171043400016.1293887.7920201355998547764.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314151200.2285314-1-linux@roeck-us.net>
References: <20240314151200.2285314-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 14 Mar 2024 08:12:00 -0700, Guenter Roeck wrote:
> This reverts commit 4acf1de35f41549e60c3c02a8defa7cb95eabdf2.
> 
> Commit d055c6a2cc16 ("kunit: memcpy: Mark tests as slow using test
> attributes") marks slow memcpy unit tests as slow. Since this commit,
> the tests can be disabled with a module parameter, and the configuration
> option to skip the slow tests is no longer needed. Revert the patch
> introducing it.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] Revert "kunit: memcpy: Split slow memcpy tests into MEMCPY_SLOW_KUNIT_TEST"
      https://git.kernel.org/kees/c/137ef32afaa9

Take care,

-- 
Kees Cook


