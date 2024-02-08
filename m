Return-Path: <linux-kernel+bounces-57696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB99684DC77
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921A3283922
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9296A8A9;
	Thu,  8 Feb 2024 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJqxXesc"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5962A67C45;
	Thu,  8 Feb 2024 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383455; cv=none; b=WP3JnNsY9Katc6YuEM2fWvBpUsu6CfYHm0Gic0N9Y1Xi6+tRwOWScz8MeoyuODalkgr8Mg2Jj/GbjVMpTtL1mymgP5EQjdzi0Ph1JMPrBwxsx4nRJKQU76V6DsqKH3uZER3v2m+qv4wOSzEHrTVrYr5zm636tcL6AUKPfse4zZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383455; c=relaxed/simple;
	bh=D/s7pmIGgrVodZoP/OSSpbEpMsrvZGwdi6k5iDsU5Rg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MP6DagXAI5D3+/VGWklDnXdXRCvW1asD/O39zie3dGKYQptrNsm1q0Ltu485USvx0kGUmMBgkFsQsE31CeBlmA6VPeLwlju3bN2h3A2BGzuwLqMtleklm+8aIUxurw3ZKICrweG7vSwXYGtEaaDVdAnqAD9EO3hgS1CBWl1gu3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJqxXesc; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a34c5ca2537so208589866b.0;
        Thu, 08 Feb 2024 01:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707383452; x=1707988252; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7Jb5Dug4kD88qLV++4VIsrhuZEsQ7qesE5FGrVCgbU=;
        b=AJqxXescdQMlfcdZEA6tPQQDsvoKi6qgn+GPDmehSBtT04tOwqBzngi5Q+RcEwRTdZ
         BI9tgydG5FrtT3Xa8zG0J7UJGyBT2gcTQ3EYinCFr6RBRm8kpM9CRh2vQoNJ/QvzGowX
         fcRC6Llb7rLf649Q1Cz9ZfyP8xW8QylcKiHS0WyVu2pmB/93flm4TqlOaW39pwshIXDF
         oDnHMd33YHVFHrfkbhg41LJwjxZbkRMIW4iFWBHnMpz6cMCN7Za37/Caq1ZujKIsAsNN
         r4HaQpYbM/WJZFWHf3qjUy/kxIX0C8zRFli66EjEODt7z2ZAoxkQ2RduMU43G3bslFKi
         fHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707383452; x=1707988252;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7Jb5Dug4kD88qLV++4VIsrhuZEsQ7qesE5FGrVCgbU=;
        b=xASciahyuw9hs+EYWJWsFR1RVXeVVcTrBOoi64OQMhnNZHjgn1xRymxsH4Q1/HVmtF
         soCJn2FIjXfwOkYPbbSEQoi+YX/3qPobOW/r9vZw9DxysV3HKlyRTWcqjh7yVO2msADj
         Hn0AYZb03t2jzvCC93fbb5/oN2L9cG4PsSq9iGjGTDE0ZtEVMtPtlKkGNrJ5kkejvj1w
         SMsdNrjc5Vi5weKk/AstJvXJh3m1ts7f0VFtzp07G2Nju9i4RzEUfsNaINMMb1AlIyMv
         Bh5KKE4f62nkQmHntEgQT9BwVQ5bS/YMHhinEWmv8LzSh0z9gUV0N07IdleZ8ljoWPaq
         sjvg==
X-Forwarded-Encrypted: i=1; AJvYcCXmUoE8jaPxDE+JqzJ3QcvcABHmXnznXybUzefaOnagGi7aL3Sbig/t89A3rBezC8Et0iQqRxpgEYt2zcDx6S6Cj+7VNXQ4RIaJiUUR3RcohWAnPpNHhAJqvpVK4u5hl0TD/+Xt8ia34/qCP8ZE
X-Gm-Message-State: AOJu0Yz2uqbKer84WVTsJW7WpNswpWh4ltkfJYDPtSbm4rv7fRV4DTxe
	dOV/x3I+uyCrS/gpoIsfQrGvLjCiMiuM+R0zdpfecv/YqHVcxD5nk8uZPXEb
X-Google-Smtp-Source: AGHT+IE4wxLZYuh/JldJmOmzEER7pyGidQnzyVpPKb8o3GZctekF6Pt9Bb2ShhbQySvBLyGkk1Kjyg==
X-Received: by 2002:a17:906:e290:b0:a38:67df:b858 with SMTP id gg16-20020a170906e29000b00a3867dfb858mr3240502ejb.76.1707383452004;
        Thu, 08 Feb 2024 01:10:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWvS9mNWKcfEHTgGqWEIrboBbBjniox2qLI+xsnefMs0IBa9al7Cdhn8eyMbBfQfsbhEuKP+9Bl8U+kTfMvCVsfz1HiRmaTM+nYRzqGyS2OkB2Fjj1CU4uEi4IfZ3u64rviftamey9Oc+FoNgRDl171jPrTY3JHnR+2Geiz2ukPtOc3W3oEqOHud58mMfc4HZF9FXLzxHcyW60htAQK
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:f81c:5b24:d269:24d])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090646c500b00a38535c6be0sm1691887ejs.16.2024.02.08.01.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:10:51 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 0/2] Drop obsolete configs from hardening.config
Date: Thu,  8 Feb 2024 10:10:43 +0100
Message-Id: <20240208091045.9219-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Dear Kees,

here are two patches cleaning up the hardening config fragment from obsolete
config options.

Feel free to squash them if you think they should not be two separate commits.

Lukas

Lukas Bulwahn (2):
  hardening: drop obsolete UBSAN_SANITIZE_ALL from config fragment
  hardening: drop obsolete DRM_LEGACY from config fragment

 kernel/configs/hardening.config | 4 ----
 1 file changed, 4 deletions(-)

-- 
2.17.1


