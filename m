Return-Path: <linux-kernel+bounces-118911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFB688C10D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5EF1C3DAEB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D505A10E;
	Tue, 26 Mar 2024 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="XpcSX6ST"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563785810C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453441; cv=none; b=il2CmTcqguOyZx1z6tPd7I/U3+Xr7IDwK7UqDHM55cy7b8mUXNGjDYkr7GKLMYJa2SEv1XEpNGWetO9kasEMltvOH1c9EoeLjJYnEz+eavXdVrUnACihmHgmr6JiSZzW6aLNdNMkB6GJmurjQgbm6O5n7oKG/uym6l9UYlFEay4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453441; c=relaxed/simple;
	bh=qmQ3LlhXY3QFRm9L41Yx5MepVpD7ltyOzolfuuDgGaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fZl/bA1yJ98xgDqpnieiQT+DEEN8rgSFityc2NUF5wxUDGimdv03I6XuKRU6P/y9tCL/bYCJOuVjYcsRAmw2Fbmp+9M9oA9S/usqmoaQEDI5kyY5fGuWA7pGUzB/po1pFELRpdDNKOJV63kEGTrV6lJCZZLAZgux8AiEzBxznt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net; spf=pass smtp.mailfrom=iwanders.net; dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b=XpcSX6ST; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-612f318d421so4082187b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 04:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1711453439; x=1712058239; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qmQ3LlhXY3QFRm9L41Yx5MepVpD7ltyOzolfuuDgGaI=;
        b=XpcSX6STeKmKsij3Ow8JWbz5LKK67NkPOmptzCexmVMaJiVkAUuMpgbKE1jjiQWiXX
         qf4PnWbrzge7zMpN92Kxh40uHH5+XUE1gmIY/hefS7EDLJ2wWikROhPnozZfc+sIvkZl
         S30rb7DfD8CLyAezwjReqAwawuFYIB1I9HEsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711453439; x=1712058239;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qmQ3LlhXY3QFRm9L41Yx5MepVpD7ltyOzolfuuDgGaI=;
        b=GdUiGUgnQ8o5mYv650ysWqAy6HuromBx7hOnF8r+y8T4Jkd64wqgYTfUvHiU405F3U
         0EI4aTIWF2aoMXcihCRFv11OjuSNhQj9lVRF3MmvS4snM4j+Ei0C+o7k8T65ZgTuG0Fv
         zpnf424ciuTe2aY5GopKBuoLdkhzscjJzeefCbo4pRglD9S3EjQltBskaGw3VmWgpY0s
         G7L8ilbNNrBA0YH0o7c/wBl26IzKxTl61TC8f1iyRyDP+Cf+Dpp/rMVut+udRjaZmpUp
         ftU8+uEFk26//jiMRQfv0ztPdZU0n4HySWEP7DHPLTCe853JgnRVy/thISR+9n6OeRKl
         ANBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWfwCkkTbaUOKFR8Z5PK7o2A9xdkJk1yWFA0Wj3inJAKxSJJI0rCuJymWBPjlYCXS7VCzlSX3Wy3qr6HbNC/oQ1PF+9H+mCe9BnN+Z
X-Gm-Message-State: AOJu0YxL4PzVb1iRyBGeqsxYTik3PJdEKKex/uNnyipoBGoi9nCBE8gs
	3Ey4TftGo+EuECRZJojmll2nalBueJ9cmN1o+Wp7rs/uOf7RzvATHvpi4rXBcV8=
X-Google-Smtp-Source: AGHT+IF2Cs0FGB3Z/PMvHAv5nLPWR4QtgOjqxm1/pnuQbMl02laaQ/7QbkJIkoTRm+6XIUt+SciZbg==
X-Received: by 2002:a0d:e28a:0:b0:60f:ddae:8236 with SMTP id l132-20020a0de28a000000b0060fddae8236mr2553848ywe.20.1711453439239;
        Tue, 26 Mar 2024 04:43:59 -0700 (PDT)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id cx7-20020a05620a51c700b007884a54ffb1sm2918486qkb.135.2024.03.26.04.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 04:43:58 -0700 (PDT)
From: Ivor Wanders <ivor@iwanders.net>
To: hdegoede@redhat.com
Cc: ilpo.jarvinen@linux.intel.com,
	ivor@iwanders.net,
	linux-kernel@vger.kernel.org,
	luzmaximilian@gmail.com,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/1] platform/surface: platform_profile: add fan profile switching
Date: Tue, 26 Mar 2024 07:43:55 -0400
Message-Id: <20240326114355.3245-1-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <aff161d5-cf6e-421b-8250-35e724397dcf@redhat.com>
References: <aff161d5-cf6e-421b-8250-35e724397dcf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.

Sounds good, thank you for describing the process.

~Ivor

