Return-Path: <linux-kernel+bounces-74408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5718D85D39D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4E92B25D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0207D41776;
	Wed, 21 Feb 2024 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9pFYzKQ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB4A41233
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507711; cv=none; b=K0oAiVXvy814qPIYpg5UxuoMdUoiJY9r36pi0z+g69Yld2pZKh7aA9XDDwJN34kfIRyygjmdo7KFPh5uEJs0igN8oV33Ehrh9Wnivz3Us3d4OCejEeNoN0rCJ9YuCFLkwmbzH8DQSreQPJXn+hjppN9HqGHh6u+UwPmbZCdw2kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507711; c=relaxed/simple;
	bh=Mu+X+yYW4cvmC9NQvhPl5vvHTK1CoiY4aafGL8tDBao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FjWjTuObmtveXLPtY2wB9htxiFkdNUS3s7XtAnfwNI/UuB08OaaV6qJTerbKicXAkRUMZrm0fKAnC9hP1QUO24L36tMU9c2qlvtMZst5SVkFMmCxmupMz4m6aDBqMPRwfAoIhm9/fXRhFK4cuYSU4GA+FghK53jBpERZDa2ExUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9pFYzKQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607838c0800so82851537b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708507708; x=1709112508; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l+N/x8q0XM6q/oxl++oFE/zLIduvg/H3kbNqGrSm6L0=;
        b=q9pFYzKQA6kltZmFbrzdKjQhTTjCVsENKULtAAj/is4cgaEBuvUDnYYrgrPATdGfB4
         B5Izv6MUwuUJKl8ix+oHSB+9Nw+86DsOuPgccNKWV2pQ1UU1aRfLgtg4E8b90VNoCCKy
         d7XE4OZcNf+5/3lL35N9TygGamSl6fDjeFX2mQYhPl4B8Dletz4oaSgrB9296lEPkcXY
         sJ7UaiDAy8j1lvsSqqD8h84HPlnsMJ6pfpPEq3hrqI0dnrJAzY/ZQgR6bJ8do1phyOXO
         257g9vZ1ZsDgd8wngEQP7Fimbkj58R5r9iMN1WDcE+juk6m2yIy+3qnnYreQC153EZsU
         GEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708507708; x=1709112508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+N/x8q0XM6q/oxl++oFE/zLIduvg/H3kbNqGrSm6L0=;
        b=QGUUM3dTzWBVQYDR4CZPy6A+dvCIy/G3SaqnbSiPUcHMXDi5JPUOwR5CGzKWUDq06J
         FIx3MGhhe023DhkJkpAggtz2SSvcTO3fm6ZuA20AgJOKdUpQWkRIeiFZxAWLG6vfwvLp
         b8Ay0bL9KMBtV855Q91w/nmYS4OIDD+fkCR/Nvp5mnYbQ+YTA+YTTmREwFJJCSuXM2as
         ejJ5dPQz9QwTOcOXn70nZQaq4Ke7RnKFKng178DWIDI7hNF7R/n/k2SpzDC2TWJF7nzz
         BjiP2dq1SsD75Yh6RH9K+CnehJSccmsK1Ud+NaRVvgRA3TbnpJPEcoPKWML1TvBcFWGD
         x+8A==
X-Forwarded-Encrypted: i=1; AJvYcCUtKGisNQ7iLJfqD9Anxxnv6NrqIpsLg+8xhGsnWJNFXkXGGdu+DJt8Ia9bt3AmxKZcWcDjbr4F3TOlXSuR2P1hkYZf/EwH0THqcxJK
X-Gm-Message-State: AOJu0YxmH4C1Trz+hXKBzUFWxABM59IEb0NUn+4vpzNu8XU0sbllpkDZ
	kV7jAmj+Wf2Uh3TeO6oVPLAXrVwcxlZ+yMIcZ7noggUtDudG03l0JRAFRgpjZ+dQb8KBQUHoBrL
	CmYge9NSm4g==
X-Google-Smtp-Source: AGHT+IGujiTgGmrs6aB7MYtXNm4zgRA3Zr4vV9toQOw9f+upbD+oRsb+6ooQYjPHHocWRD49vELQV317edlmfg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:1081:b0:dc2:2e5c:a21d with SMTP
 id v1-20020a056902108100b00dc22e5ca21dmr5584522ybu.6.1708507707855; Wed, 21
 Feb 2024 01:28:27 -0800 (PST)
Date: Wed, 21 Feb 2024 17:27:19 +0800
In-Reply-To: <20240221092728.1281499-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221092728.1281499-1-davidgow@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221092728.1281499-7-davidgow@google.com>
Subject: [PATCH 6/9] net: test: Fix printf format specifier in skb_segment
 kunit test
From: David Gow <davidgow@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>, 
	Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Kees Cook <keescook@chromium.org>, 
	"=?UTF-8?q?Ma=C3=ADra=20Canal?=" <mcanal@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Matthew Brost <matthew.brost@intel.com>, Willem de Bruijn <willemb@google.com>, 
	Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>
Cc: David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Daniel Latypov <dlatypov@google.com>, Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, 
	Maxime Ripard <mripard@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, linux-rtc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

KUNIT_FAIL() accepts a printf-style format string, but previously did
not let gcc validate it with the __printf() attribute. The use of %lld
for the result of PTR_ERR() is not correct.

Instead, use %pe and pass the actual error pointer. printk() will format
it correctly (and give a symbolic name rather than a number if
available, which should make the output more readable, too).

Fixes: b3098d32ed6e ("net: add skb_segment kunit test")
Signed-off-by: David Gow <davidgow@google.com>
---
 net/core/gso_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/gso_test.c b/net/core/gso_test.c
index 4c2e77bd12f4..358c44680d91 100644
--- a/net/core/gso_test.c
+++ b/net/core/gso_test.c
@@ -225,7 +225,7 @@ static void gso_test_func(struct kunit *test)
 
 	segs = skb_segment(skb, features);
 	if (IS_ERR(segs)) {
-		KUNIT_FAIL(test, "segs error %lld", PTR_ERR(segs));
+		KUNIT_FAIL(test, "segs error %pe", segs);
 		goto free_gso_skb;
 	} else if (!segs) {
 		KUNIT_FAIL(test, "no segments");
-- 
2.44.0.rc0.258.g7320e95886-goog


