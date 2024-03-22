Return-Path: <linux-kernel+bounces-110903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309F9886573
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC96285ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74CB53A6;
	Fri, 22 Mar 2024 03:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RPBxHOiS"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962114A07
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711078261; cv=none; b=BbJGYydv6CtEPTHlTUR16hpCc6wTA1uy+TKGyJ34wvx8s4gAN20mtseeF0wW3VFtou3zftxSjzn94e/CrQSu8iqJ9HT/pevfJYKIvDc7YDXwQ2ffRw87t+dC6InmYDNW/IpWNBzXSm5NUSCBVliDM7F6jQ634i7BIyO5idO/H+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711078261; c=relaxed/simple;
	bh=qvJ+3YFxfDePmsCIW4PY238+EQenGMVU9ozMZJPSRfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KavDYfpWfOhh8jQLccnCBgGuELb5zbQfMtNMlaLTW4oBEZUstL9+e4IrmlgjJr1u22ko+UaSwRKLnTIBUw0huXAfoeRXs/d+qIvvG/sc2LbyEllRm7CG/ZgjNZyIRafR5po7ugpIm7W7JQ3nH0SQX1UF7EAGq52Ar4AQOkdB8yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RPBxHOiS; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78a2290b48eso132370485a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 20:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711078258; x=1711683058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AV6vFBRCysrecCdTrQzr9r0j273jT0maLCCHGnLq8AA=;
        b=RPBxHOiSvG7Q90j9WTx/GlJ4IgKUhnA7rzew8VWQaDn5Aod9WFr2bxlO2wAJLCTNuk
         pzoMC1QGF6CCRYZaiEfmNcdXdphxPxCuh0Ab5O8RDtzcnSjKEcEc/mBz6PAHKvShawQ+
         5/LEVdIZFKJK/fpZEgt1G9ZkituI90kIFQoxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711078258; x=1711683058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AV6vFBRCysrecCdTrQzr9r0j273jT0maLCCHGnLq8AA=;
        b=oHMiD3xz0FeUW0FErVybVI03hroMZMpqk9rvbN+aEzb3pbkbX9hRWOE1sr5m/n+o9h
         cC70uYOgc8O930m46mGnm7hsk4VEGA34vw3z6Ky4ba03ohMCiJdxSbNK5U9bydIS8bcd
         7qv7g0j7EYMydHzG3YGyYi7xBEsaxFaDQd67cRIAzTQz07OmDH7sCPlr2XY23P61m13n
         NHvHlY7o97Xn+oBs3DXxYSrwGqfn05RHK2xgJy6fJ+/lnLM4Lss1ITougyUrwmBVsynz
         Sk4UZPJYJcOY5zGn/St5bIVKZC+z6ir2z8bnUc3bJ3uvFOSy+GYiGIJFYPkcnurq4wx7
         T9xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgIjC7SxZflutf6scLJ8Yg3Bw5RM3sO+dqHDdFk8Cr/kZCqZNawwrgXTvHSIVHpB4/aT/Aw6LSQr0o3snT28RPN+qxnu36AItUxezQ
X-Gm-Message-State: AOJu0YwYBZ9g1iKzY5vxKOOJZ6cyg4In9yS3tp7GshwaYcR3ym8sOe9v
	TulVpooMaXzRPC8SzZH7ryZMQdpiH9fsm8e+h/Hp5+66ei8InyaHhzqejmI6/Twjv+gu9j6szxg
	=
X-Google-Smtp-Source: AGHT+IEys3W9wGHLskR2Zg08t6A2fKR7mvDlrO3Ptg9X+wIwXdgzLVMAbC9r2tAMxNwMcoP2Vea6dQ==
X-Received: by 2002:a05:6a21:9994:b0:1a3:3064:9931 with SMTP id ve20-20020a056a21999400b001a330649931mr1699512pzb.3.1711077791861;
        Thu, 21 Mar 2024 20:23:11 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bb2-20020a170902bc8200b001dd876b46e0sm669300plb.20.2024.03.21.20.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 20:23:11 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] binfmt: replace deprecated strncpy
Date: Thu, 21 Mar 2024 20:23:07 -0700
Message-Id: <171107778560.467582.4496512848388862288.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321-strncpy-fs-binfmt_elf_fdpic-c-v2-1-0b6daec6cc56@google.com>
References: <20240321-strncpy-fs-binfmt_elf_fdpic-c-v2-1-0b6daec6cc56@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 21 Mar 2024 20:04:08 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> There is a _nearly_ identical implementation of fill_psinfo present in
> binfmt_elf.c -- except that one uses get_task_comm over strncpy(). Let's
> mirror that in binfmt_elf_fdpic.c
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] binfmt: replace deprecated strncpy
      https://git.kernel.org/kees/c/5248f4097308

Take care,

-- 
Kees Cook


