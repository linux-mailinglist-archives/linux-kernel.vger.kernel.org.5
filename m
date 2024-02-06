Return-Path: <linux-kernel+bounces-55463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C181D84BD01
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63034B23B98
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEB7134CA;
	Tue,  6 Feb 2024 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLaygOzJ"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D92E134C1
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244808; cv=none; b=CSOokpRTVOb6jRfbdukvdS0jJ642ZcrusgxQXQM10iFBr7kltJSi5D/JVt5HWL9cuMVuTNLFuweAufeNKbgYU6EJ2Hz8KYVAqebqd23P+o+HUvLQc77rSgT26m27cZuM3KrD42WBAHAlXimoTw9ENG7CyNfU7ZYU2jKt5QHaPYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244808; c=relaxed/simple;
	bh=HQkw7mTZSNtSp3ECi/w7EovzA9NrGOLGl247YlLjDtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VM1mV4NpY1jfwNxbFMpRbEAcvONV3Hu4lj+dPRHuvkqUOghvIDojHUI7wlKRhv1j1rvY+p4qC2PaAepiE1qo+RKHAaW7DborpCzrP/nsBOIbViGue7qes/36hoeUOugcKr1WGtUrW5mFDDLqOr+nNXqjhBhKdo048dr6a1M+vyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLaygOzJ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-785388b3281so302615485a.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 10:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707244806; x=1707849606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tg0CVSBv+xoGoElg8kJxZfAcsPJiN6TNon4snqhbaEE=;
        b=FLaygOzJYjBIl4Nl8r0W3di6xpjU6nnjv5ilD1q42aa/Z8Ov731imTP6CU2D8GheZm
         StECY09WhRoRcKP3giW426oZLCL/ZL7filhxB2/8ik8iewFZC3neUy3Wz7Q7SiVM39C4
         z0/VruGWUTiQQLc0/FFIFj34SMc7fCpzFOYjtqANs+TN8hT24CEscB5S7VA9Rx1A/o/w
         wzu1DR+jNpiwAH0M/s1B7AR2xLvAscR+TMs241KRZDSQ1EAnuq3zAbeH2FkYhHGc2DiE
         al4ESF0DgO8Ia2nkLNK86D+CHlCfQRZNN2dDqXAgfg9EQEt0Qu3WnkH3qB4Ug59XWujK
         Rzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707244806; x=1707849606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tg0CVSBv+xoGoElg8kJxZfAcsPJiN6TNon4snqhbaEE=;
        b=ghwc/rugsxrYJpAwN5DRSDyxVL3KtS46tF5P4A4Tib+/0ktbSKaXtZfIIqbY8F3eXd
         2mPwt+AdlPki6AyPB6DpepRkYnSZ6j4eAtoKFmNyKZEUiyICnphY7EjNXyx3s62ALiSq
         mcMnQVakf0pgmrdRLO7mivz1uXiV2ZkNGS09IcGWDgTVpoYVv8VQa2xmCWR5QieP079C
         wZBNuobTLFK8NtETZaCuB75yqYgVxtgjLRaI7buQ6enkz5zlbrjY9UzIMCCuaSXgLfu4
         Mg/dV6xl48IQPtwdj1Cr2R3XUHIWrWNiDpOXNncwDgA1WtTXoQX7At4OY3hZ6sHVSmQr
         eHbA==
X-Gm-Message-State: AOJu0Yz7u/jLt9VjqjgYQnTjHzx7WOtLt39w4EeWBoJIkKTAU6Sxwmk1
	fZhqfVv29GqYcI8hSLAdef6K2BhY4eIsCXTLlDxgqZsvVj0tuN3V
X-Google-Smtp-Source: AGHT+IG8dInuDZ8/scwe0fuRvLQdZjWQTOUHTE3wTCQbrFava9WQsuir8SFiLFCuItppCnBYaIQvbQ==
X-Received: by 2002:ae9:f311:0:b0:785:45c7:db3a with SMTP id p17-20020ae9f311000000b0078545c7db3amr3421661qkg.20.1707244805933;
        Tue, 06 Feb 2024 10:40:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUt31gn+axJVGLSBQzKnP1K3TMND+Q44R0gMl3YWBNGpMB8Z2a48K0f7bbMAqSxwRUbYnFrSIG1y6hylLwTcBapkdLiuuZllJH37Lzo6mwU9NWtLIcdaS/AROwbplEEbtwqnUPAZToigQodzYoaHgfBwK3j+jOOl5k9qA3gfy+nFelWalDQagmNp+9DYOfKjY59JPbVKuz0+H1oXRXDUdeLz7WuRRfy0rqX/jMfB77YnlM6+amatduBgnAiYrsjqEHm/WGUeA==
Received: from localhost (fwdproxy-nao-119.fbsv.net. [2a03:2880:23ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id m10-20020a05620a214a00b0078552b5e161sm1146822qkm.78.2024.02.06.10.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 10:40:05 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org,
	boqun.feng@gmail.com,
	frederic@kernel.org,
	joel@joelfernandes.org,
	neeraj.iitr10@gmail.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	will@kernel.org
Subject: Re: [PATCH] locking/atomic: scripts: clarify ordering of conditional atomics
Date: Tue,  6 Feb 2024 10:40:05 -0800
Message-Id: <20240206184005.4125128-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240129122250.1086874-1-mark.rutland@arm.com>
References: <20240129122250.1086874-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let me bring in some beginners' perspective :)

For the most part, LGTM! My only comment is regarding the conditional
atomics with relaxed ordering on success:

/**
  * If (@v == @old), atomically updates @v to @new with relaxed ordering.
+ * Otherwise, @v is not modified and no ordering is provided.

This is technically correct, but it can be confusing. It reads as if
"relaxed ordering" is much different from no ordering, since we are
juxtaposing them when we compare what happens when the condition holds
v.s when it does not.

This can be potentially confusing to unfamiliar users. I consulted
with Paul about this, and he suggested this rewording, which I like
better:

"Otherwise, @v is not modified and relaxed ordering is provided."

With something along that line in place:
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

