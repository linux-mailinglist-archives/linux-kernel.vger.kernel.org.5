Return-Path: <linux-kernel+bounces-106716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C00CD87F258
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D1A9B2180D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E04D59B42;
	Mon, 18 Mar 2024 21:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IdRQZEnJ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D11A59166
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710798056; cv=none; b=HkOaxlsN996EU45eQX2to927iHZBgU1x7yYF69sbOCSVg5p/uODmddKztXR6Msg9++L9Us4+T5vmZLwLbsB83DD/flBn6ou+BvQvNkmLVpSEioO33JpsVhgpQhN9g4nEgae6ufAIAM6KjPUo937rvAw67qBVa55Hpel2uwq2UII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710798056; c=relaxed/simple;
	bh=J+IhkS5/3GB8AkkrIEaDcDuTxZrz47RTosu+l4UPPvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiL1LQhCaleEZg3e7XaiADEsFah8zUvHX0dQzd5DkAPf4o4dVP76K/YNLNCHNQqZ5thIQF8eH0z48byvKW/cHQjJQn1jzwOYOWfPQDNOoIXZEICri1QGdHxXDdDcbocZyEtkGcvTIaMxiAcLe+7d+prP+k4HuM0wEr1XD3xLO3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IdRQZEnJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6b5432439so4702868b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710798055; x=1711402855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ox9bH+gD2CktkBBcZmuumQXprDslbo3R8UFvF8ORQTk=;
        b=IdRQZEnJvNQ0SHwxPQ2UqtPuNNu/c0KjC9U3eHh0jLLvlDXfwCo9WCG1GKeURR41Um
         wjwGQ3PzRuPHkEHVkuzI7d0mPOwaZtKCbFUfSeH90Ef5wkMELumCnN11Gf/jvZ6mG9Hn
         URRD43gGj9de3/hvLkZ/xYinZNw1PcbnD04Ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710798055; x=1711402855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ox9bH+gD2CktkBBcZmuumQXprDslbo3R8UFvF8ORQTk=;
        b=QYJmmVmW/NzAfPSpNlkBjjoiGCZtaYi7myUeV/3Xq9ZTJyaqs8ikghFOsgbCMTw8fa
         NpjXgihjBtvGEPBXZgitpf0kL8p6rT6a+Au7X6xPSKadad88Q51GHuMwjyBy3S8dx7MD
         03rTp9/x9qDAKBBcClkGRlkSUPxaTkfsk4Mj50hjWAf1rWveVoyRKdBmaEmijsBSkuhz
         rF3FIUpMG5PA/ubN/0/me1XN7EAUq8IIGeZmPfHcJWFmBWODkahbvXjtO/GPb5ZyZOpk
         zwxbJkQoz4fU86UkS9Lut2eFZLg8lDK+i6FvEsBqSvlDKb07mXGu4nPWUehNdEmrtYGt
         THtA==
X-Forwarded-Encrypted: i=1; AJvYcCXlptoQYOL6wLXSgOKE4t8XRTkKppqDkY2j9fqKxCkcAGgui5QHUY5eoRA5rhM+P96fxsbdiTmf8V5mEVJ6zygsY53GdHI5XI0Lc50v
X-Gm-Message-State: AOJu0Yz5rA2eEcofBIq7kA0tMfoZ5CChj9lQPsJ+aQrilUeQbFHkXuw3
	fGLL+DGu7Mbp1UvYMB0Iz8XsBSP1tOorBhGHGyU+NHYVeBzszWSDC+n5fYehxQ==
X-Google-Smtp-Source: AGHT+IFe6QahzPvTukwCFb5ZRJ89e5PnJMyxdpOlFYZOabfXqy0xcp90SRTv9mIL4Cxopz1dwnGsiQ==
X-Received: by 2002:a05:6a21:3a48:b0:1a3:5e13:6922 with SMTP id zu8-20020a056a213a4800b001a35e136922mr5593119pzb.20.1710798054851;
        Mon, 18 Mar 2024 14:40:54 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b19-20020a639313000000b005dcc075d5edsm7365705pge.60.2024.03.18.14.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 14:40:53 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: tglx@linutronix.de,
	Guixiong Wei <weiguixiong@bytedance.com>
Cc: Kees Cook <keescook@chromium.org>,
	jgross@suse.com,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	gregkh@linuxfoundation.org,
	tony.luck@intel.com,
	adobriyan@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86, relocs: Ignore relocations in .notes section on walk_relocs
Date: Mon, 18 Mar 2024 14:40:50 -0700
Message-Id: <171079804927.224083.15609364452504732018.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240317150547.24910-1-weiguixiong@bytedance.com>
References: <20240317150547.24910-1-weiguixiong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 17 Mar 2024 23:05:47 +0800, Guixiong Wei wrote:
> The commit aaa8736370db ("x86, relocs: Ignore relocations in
> .notes section") only ignore .note section on print_absolute_relocs,
> but it also need to add on walk_relocs to avoid relocations in .note
> section.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] x86, relocs: Ignore relocations in .notes section on walk_relocs
      https://git.kernel.org/kees/c/6ba438a29b5d

Take care,

-- 
Kees Cook


