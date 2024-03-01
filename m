Return-Path: <linux-kernel+bounces-87967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B1886DB97
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E0F283227
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AB467E7A;
	Fri,  1 Mar 2024 06:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ea5rjIIl"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7041A67E62
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 06:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709275361; cv=none; b=hjz50sQ0ARWX2HP2FOrsoCd7o6qLuohCqE7Nr2e/XNMUGp1Dlps8xyjx0xts7+iyG7Y8KaN0PpBSELvSOdK1a1HiaATTg4c7enn2Wm0RBTy4KxDIuDHsuAG3Hs1/4EImK9Q0bwbsxZc63YAVdG9X7JOq4LUaQfZC6PLpzAg4m48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709275361; c=relaxed/simple;
	bh=4SgbZmarz3bEGa5kHQtb5dbrUl3+lqB/jY2lhVir90s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZ2Hg+R2FVbXiVJd9weCnFISVuTShGIhb67+N70B0AGniWizwafU4/EdK9Mi4ZPE0uf4s+qFvJMDAgz3+7ENTLvVGeyXhBNX0ekISiJIojFMOHrver7qVb7OjyNEMOvwTakEazK2likYh2f72Z6gYSytcrllGHBpGFBY1S3Jvyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ea5rjIIl; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c19bc08f96so1444138b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709275359; x=1709880159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTgLgsB01nQKRZy5LwRnCmdKhzn0b8Lgp3B2E+mHXIE=;
        b=Ea5rjIIlLlHuzGmn7XD8wE+zfzugaWZ2hPR2a9B/0Cd7H0MK0feDSRAvNeRFsuzjB/
         ROtIDsMlLuZmR48X7drHHOIUDrE83TehUPf+tBOi3kqFaQWbWX9VmZowDHRnQtvv2XXP
         PGiE5lSeqxEvkJy+JIc2o+oa59gpQ7ewjuRas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709275359; x=1709880159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTgLgsB01nQKRZy5LwRnCmdKhzn0b8Lgp3B2E+mHXIE=;
        b=cgwHLqLtFz29WwHAOxc/23bUFxHy7zwxYMqiGK7FfLFNaH7xt8fSKvYLry/6GaHty5
         QxY+guIyZlk87GnBk0KwMQylIyltKpABqFCXds7vshjDITG0LDEZhN4NmuRwETENo7KD
         ltHyHZH4KGtzoNuiHGIjXB6djF2IwZxz5xeEie+ZvIdvXsvgU4ZGUJexmfiwiePISKFP
         t1QaC+kdgAINDdmARwz8fzm6jaeZdU+xwuBY2/1eOHlL+mXm+D5DySDSl86njTYJ+emz
         hrMk6Y80imUy50wQNe6F+oOfoXUBqpOhrNXAccHHF42iSpU+AF+D1LpG3XWG/A4+NoB1
         yRCg==
X-Gm-Message-State: AOJu0Yz7zIJCs+Od500MGWKUXbcx4IBT22qLmz4ZYpbylpp6j6Jl0tqm
	8JZBPPaY1YpVSEhzLvF0D/wvabKpLN8PrZZbtXzfen7lMNCITNs2czp52FKePQ==
X-Google-Smtp-Source: AGHT+IG/rECN+/a0X1T9iD2aUHgjbJ5W6rreD/SSOxVb0zeAT5c4CQxxdznfBQ9qXg5ROUNBwtQ3/A==
X-Received: by 2002:a05:6808:10cd:b0:3c1:b34a:2e90 with SMTP id s13-20020a05680810cd00b003c1b34a2e90mr979767ois.10.1709275359530;
        Thu, 29 Feb 2024 22:42:39 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i37-20020a631325000000b005dc36761ad1sm1585521pgl.33.2024.02.29.22.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 22:42:38 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org,
	kovalev@altlinux.org
Cc: Kees Cook <keescook@chromium.org>,
	gregkh@linuxfoundation.org,
	bryantan@vmware.com,
	vdasa@vmware.com,
	pv-drivers@vmware.com,
	arnd@arndb.de,
	harshit.m.mogalapalli@oracle.com,
	nickel@altlinux.org,
	oficerovas@altlinux.org,
	dutyrok@altlinux.org
Subject: Re: [PATCH] VMCI: Fix possible memcpy() run-time warning in vmci_datagram_invoke_guest_handler()
Date: Thu, 29 Feb 2024 22:42:13 -0800
Message-Id: <170927533060.2067754.9878461569390805526.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219105315.76955-1-kovalev@altlinux.org>
References: <20240219105315.76955-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 19 Feb 2024 13:53:15 +0300, kovalev@altlinux.org wrote:
> The changes are similar to those given in the commit 19b070fefd0d
> ("VMCI: Fix memcpy() run-time warning in dg_dispatch_as_host()").
> 
> Fix filling of the msg and msg_payload in dg_info struct, which prevents a
> possible "detected field-spanning write" of memcpy warning that is issued
> by the tracking mechanism __fortify_memcpy_chk.
> 
> [...]

Since I ended up carrying the other fix, I can carry this one too. :)

Applied to for-next/hardening, thanks!

[1/1] VMCI: Fix possible memcpy() run-time warning in vmci_datagram_invoke_guest_handler()
      https://git.kernel.org/kees/c/1ce15647a1aa

Take care,

-- 
Kees Cook


