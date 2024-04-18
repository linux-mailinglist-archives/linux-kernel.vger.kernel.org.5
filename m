Return-Path: <linux-kernel+bounces-150559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD618AA0E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734E71F226C8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0BA172BD0;
	Thu, 18 Apr 2024 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kc6Dekqb"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C87172790
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460596; cv=none; b=blI2qp/d/5EnKgy+ToaQZePC+X2LMTfx4cYbkzGl5jbgdqn88rfZn6wOgCtzwp03j3i4GX7h8oWPVKw7uUHf2GLidYKWuKwZU+63TisDQcQN6PhIh51mBGHKdFxrlRzvlTNwyupATr2eFvbyXrV+oA6R7AFp6e7pN1o5qRPTfig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460596; c=relaxed/simple;
	bh=Qe4POCSHxjWm3wFsaHCsEFxKNuqKh7otgYlk3HiwZ1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMuOvvhJBgA80fwOJ4dBNGOPsRhpbroV7ZrIgQqU1WhR1uX2yQx3a+taBnkxg2lAcZBttpCrUSgjc+UN98jDYUeFmV/KPd1imuzVy7Q/vFriVxIxSsKDQd4R2jAf4ru31r1VtC0hdxEo7PPhuWM+yRaR5MHZuWWZ+MuoQem4pX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kc6Dekqb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e3ca4fe4cfso9106435ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713460593; x=1714065393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/uD81xAZaCWFwuTc9j81/JSG6jiqzchn2BejnWerUc=;
        b=kc6DekqbChvvM6wPjR4T2XsTqs37gQa42JpU5Ch5an7MX7VSIgK6yfLLbEON8oAlCq
         v3zNKiCocudZsU9ATzOJL96UOg6JW3vyRyIXBlcKFZSUOKF5sM1Q0AcwmkEYt3CSpjuI
         eHlwGMOZCKwSCI2S05iKxCD8hNMzgw2yJ4kxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713460593; x=1714065393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/uD81xAZaCWFwuTc9j81/JSG6jiqzchn2BejnWerUc=;
        b=Ei3g1waXTZmf76E3XhDfyXs9xFzYxqwlB+GyJ6eIxmIoiQco282F8xfpEEBJbh8uxd
         qa4NA0PqOskbmLeAZLcjYRT2cD4mckVNxeMemutC7D+DtZ6da5w8a/qUZjfkm0UdxSiW
         gycRz4nQzGpaE/o6s4EX7M4eC006L4YpMXMybyByNZxNZ6cjX/AT40xJuhCVWuakfJSo
         i64URF8ZUa+IMX48G03OYGVIdUKx1mzY8KOPx8JA3eXybW3DCP4voDbtWyjmaw0A3tLu
         e4XZBqKOiZ0S6v/jEW5Gx69cUUKrq9myyPxWAY8vlj+IPEr/hN94d49IRyPpWKTjE+Qu
         f+4g==
X-Forwarded-Encrypted: i=1; AJvYcCWawa935lxhW3xj0mi7anrgNoQimcXkayt/8BUosyRwSSZ1HS26b0mKxYUaYhqnrp2s477Zpzb1vDZZ9/DROIcF0ueeuJqOFk9zTBwy
X-Gm-Message-State: AOJu0YzJEgdp/ipQ40K5cLbG7xdNHFYWLSNc9wrnIXjB4Oy4RoB/Bxbo
	JXy1L9GlGzj1lCtmse9uvQJjoN33ODqwSPWuepWrQ5zv4LrTvpog6kFiasDU4w==
X-Google-Smtp-Source: AGHT+IF4PJgI0BdB8W3UuYRsvVhssCDWMQrlZJDq6Ju6m2xTCnHYPSN2BvrH3mRx6EOdyhF6OdVi3Q==
X-Received: by 2002:a17:90a:f40f:b0:2aa:9738:ad2f with SMTP id ch15-20020a17090af40f00b002aa9738ad2fmr3697941pjb.6.1713460593351;
        Thu, 18 Apr 2024 10:16:33 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u23-20020a17090ae01700b002a219f8079fsm1698092pjy.33.2024.04.18.10.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 10:16:32 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: andy@kernel.org,
	akpm@linux-foundation.org,
	Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2] string_kunit: Add test cases for str*cmp functions
Date: Thu, 18 Apr 2024 10:16:28 -0700
Message-Id: <171346058636.2400104.10410975122158438453.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417233033.717596-1-ivan.orlov0322@gmail.com>
References: <20240417233033.717596-1-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 18 Apr 2024 00:30:33 +0100, Ivan Orlov wrote:
> Currently, str*cmp functions (strcmp, strncmp, strcasecmp and
> strncasecmp) are not covered with tests. Extend the `string_kunit.c`
> test by adding the test cases for them.
> 
> This patch adds 8 more test cases:
> 
> 1) strcmp test
> 2) strcmp test on long strings (2048 chars)
> 3) strncmp test
> 4) strncmp test on long strings (2048 chars)
> 5) strcasecmp test
> 6) strcasecmp test on long strings
> 7) strncasecmp test
> 8) strncasecmp test on long strings
> 
> [...]

Applied to for-linus/hardening, thanks!

[1/1] string_kunit: Add test cases for str*cmp functions
      (no commit info)

Take care,

-- 
Kees Cook


