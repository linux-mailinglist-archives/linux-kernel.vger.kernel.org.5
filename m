Return-Path: <linux-kernel+bounces-50613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A38847BA0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4157328377B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D35383A0D;
	Fri,  2 Feb 2024 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HXUFANsc"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE6481749
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706909755; cv=none; b=Wqxz2hLz4k6TEL/GzwwvbZ5ZwrUb5DuowIe6wacuyJsVEuhmo3lm9nacltgLYtCJkIiaRRmjxewjzlAFcTw5Uj05g58tO1xCItS7X+oSFjypnAoDiktq+8MDVJTDHMxkFwvymFxUdf65JlJNyVKXPdyT7SUpDCz1mCOI9BAYFwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706909755; c=relaxed/simple;
	bh=RGM5E3YeJnLOgvuaD6zH9937ta8vUAwmXTpn6KrvYZw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mhsTNTF57yaKHZbjDIk40zbCKZnYl3pNjMoo+jISm/UTWQynJFQ5o9/hQfrtyQL5YEW27lbp1ZV4x647A1Ksi2utF09QAIIxenED2dKZmBLiJpHD1tRqCs2RWYjmpG9PWh3O+0bavWY+XuemxphC73NQLHJgyQSsNy2P7zKtA1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HXUFANsc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40f02b8d176so21183075e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 13:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706909752; x=1707514552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nO1fetZcYPYS16F+FnCHvn9Oo5qFEOK62Q4RUHfo3ms=;
        b=HXUFANscG6NQNRKq5PSSkOgTp8L3Xhdu+Btiy7/FT+T9g8NakrffNx/8QyGu5uTdZX
         fBYpOPNjppkLGJkBelIb0k/quUDKM6lZ73wwO0Vfs6rJPzc49FvE+gHdhYsROyJxfRuU
         DS7hbmjWgVcJzl35NJ5ls4ZaIEL5Aig6ooU8OXxB0fxV8jcfsVxq4McmLebQPbUWE9Hx
         pRV2g5cb+nWOd1JSdJ8Ve2IbeKkWuCjYWuR72/bVNmHOrxxc9clYNtbEdaqfMyQwuaGZ
         Pk+wrsnQuVcvIgOOehFI7wvAfQBDcpoqE0vkiQSj5Fzs4nd/0jhiH8sM8tfBH8MraMhA
         2V2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706909752; x=1707514552;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nO1fetZcYPYS16F+FnCHvn9Oo5qFEOK62Q4RUHfo3ms=;
        b=vJ3gRaqOg2B43zYxAn5mgZwZwaNp2tXYYjvM3N4+6fFKi7w7YA8x7OIVcAosGVQ6AP
         dQfp3STf3iSyZbvD/Xjri9JUwYqPnkgXxLUpoi1pC1v4YmgaVI8+JAPN3tKOd9xUWqHf
         A6CHxvDzE9qyyo7+iQkBwMXr6TE146IXznfiN6Ok9X/MOL/vSPT1YYgH8/Jh54p4a67u
         P5DwwmfNRnHJKCxaWVtxRONfsN+9phtL39c7uvoI75dz8Ygh45BVL2y1aVfBs5h3ewMq
         kfEHaeSx0HkPV+dnkOSvSazPJjfVLpUv46paFvlEQRlKGV/Tl/WHYwkoy3MH3o8s9YMK
         SUxw==
X-Gm-Message-State: AOJu0YwGH+zTGcrdsTKWi1BeAD4FPMnizGRTEW2AIyH31WQWc6HsR8RM
	fDYxn9C4SAvIUupfK+XteTDNINhOBZqn4PvUi1JMrb79hJM9Oww5RhQ+wtFljpM=
X-Google-Smtp-Source: AGHT+IE8WgnK+R36YliQYflwys554C0Uq81Kv4S0tDt/z9xl5R/3b54s/0x3BUa44bWaFs9otZ6GXA==
X-Received: by 2002:adf:fd08:0:b0:336:71a9:4ba8 with SMTP id e8-20020adffd08000000b0033671a94ba8mr2526848wrr.2.1706909752122;
        Fri, 02 Feb 2024 13:35:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWjP/nk1id5gn7p+rnSsPZoZX9Px0Djry6vhKM9vqrjVWL93ubkDT2LrR9CN4v1Xdgds+WoZWEtgztllE/PwMvJB4AdWvkAwqQEO3BtzIFKet+kDm4cUcohtpxbAO6Rg0WZAvEP2QidkjuHQDMRymJEaEYtwLSr65aXl1r+toP4vazcKhId0f2ZOpFJ5O9wOP04ETKWXp7KgEVg1nsncw1suDRR8Ztb2LVsUY/N9u9CPMsp8/dLEkPfxtBgdtkXZfZgBrNtZ+q2oVBzAl6TZZIkrTGyIHE/mZjZpWXajGgGBoSQMg7qi7QFbYG6vBszTum3lzOfo09+WhqoR7qofh+YN/x+L3BQsNjV/Ni+OiPGb26dtA==
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id q17-20020a05600000d100b0033af350fb88sm2687201wrx.25.2024.02.02.13.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 13:35:51 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: quic_abhinavk@quicinc.com, Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 quic_parellan@quicinc.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240201-visionox-vtdr-prev-first-v2-1-32db52867624@quicinc.com>
References: <20240201-visionox-vtdr-prev-first-v2-1-32db52867624@quicinc.com>
Subject: Re: [PATCH v2] drm/panel: visionox-vtdr6130: Set
 prepare_prev_first flag
Message-Id: <170690975131.3073109.14083509927248220761.b4-ty@linaro.org>
Date: Fri, 02 Feb 2024 22:35:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

Hi,

On Thu, 01 Feb 2024 16:10:15 -0800, Jessica Zhang wrote:
> The DSI host must be enabled for the panel to be initialized in
> prepare(). Set the prepare_prev_first flag to guarantee this.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/panel: visionox-vtdr6130: Set prepare_prev_first flag
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=0581bcc48048924f021fa8fae54353402c5d3740

-- 
Neil


