Return-Path: <linux-kernel+bounces-104416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2363087CD7A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91A61F22A27
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499E12577C;
	Fri, 15 Mar 2024 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KCmSqt4G"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B5F24B26;
	Fri, 15 Mar 2024 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710507267; cv=none; b=YGhMn57Rn4SQYXQNVtDyq+57hPmIJMhH51zz945yBHY2sB5g8oG+65OoQNfxP0+ASLUi5xBFcOmOCfaunXC3r5g50TdOSVy8oGRM0MPXnXBTbv71NHkHbOZOYaupbkoVRDnU6Omi6f80f7UIS+tLtRdqeafh8QPohwLDLAr3LP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710507267; c=relaxed/simple;
	bh=E4oIpGUjcQSTl3JXS+C6RTIuU3+bX3dPPhcam3xldJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVbJkMgEkkGfJQCfOeQ+FKhuxGLFEDDTqA1PfytWr6dGuTWtH3O/WzpamVtQJVhlAgXK3+e9bqYp4hnkQi89jY/bCyjHT3jaAIeFH7K5bBuT1t3lHAhmDYDwvPZvYQNtno4WRhxgtOHoxRU4GsbBeYMksBUzn9cQey6OMsfL8kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=KCmSqt4G; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512f892500cso2335411e87.3;
        Fri, 15 Mar 2024 05:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710507264; x=1711112064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuxIbiM+wW54yLy6pCcfPUZ6XhpT22cxtXLZoX6Fib0=;
        b=KCmSqt4GwEN4HF7hVM+gVJRr0R1dU68e5PYqe/moC9xY/FJ8RKA67W332tcB4wLX4M
         WDcf3iheQ6Xi08nGoELdt3TlJvP4oz/odEARt13Lp8Y0m6MQysPakR3APLgYF4iDeH46
         Dec9cbHe5oYmLFIcvuCmMlRLrpl2SatDOGRLV/9z2c1qg/X5IOSEMn0JUaubbtgy5iaE
         E/7snpEmprE6ST/xD472MZErUBp4TVG110BcX+g1uEfGP+ARxsKZtFOYrMWUUISv4m7n
         gx74Dd6crtBU3s0JchQq5q4tyHlvk7ixEPrMbFLu6UAopqSiG42HGm6HFKCelXBhhw+w
         hsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710507264; x=1711112064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuxIbiM+wW54yLy6pCcfPUZ6XhpT22cxtXLZoX6Fib0=;
        b=pzKKwA2tsQHauZPdn0SVHgb8ErzgkFpK1gWv1598X90CXSKSEkpvXqPEHdwEZhRz9T
         iIPw3WdxJBjASHbv0bCiDGAf5j1nJK+lPwFgsUqghlEzZtKCSee7GE0EM9+XagtGhhcH
         eRlRToE+9p6tXF1oHBN6hLAQPBt4afpJPzveyZQFtSsJOhy+UkjyJSqYKx2K9rSxaecP
         isn6062py6wkuS1/ZqHEB6FT/BuxODTpR4H6zBoaQ6gagqwCEtfl3oNHnZH8tDjZd06t
         LGKljsImivWMP3VrV/VlGZ1I/Fr7v0tF8rsEcNKsCa0R3IYPMSfrtfDeeUzFoctUYbv6
         EBHA==
X-Forwarded-Encrypted: i=1; AJvYcCWvgfrRHqVwb7mNnRvlsSM/DXpBi9hLy1hhluYj4YlUGzgVuDmWE5wyHhxStTyUEy74jzcPRLg+scrP3so7u1x7ltWnpuWh665cg4Y1
X-Gm-Message-State: AOJu0YwwtkntOhcdN0sEZpSwUhXXIeNGhMyadgRgpm4/4QRkShAo1e5z
	5XKhL9gTnqZZDzquxwE7XMtpC4le/lZhA46Vu+kPWLzHsxLcH//3rTJtbdeJwkbkhQ==
X-Google-Smtp-Source: AGHT+IEipLGp08bHsPqaYMLKMTmQa7twuXnXbiBCI11NzLPgQFcMvL99rM4y7LCVzfirSdXt0hWWMQ==
X-Received: by 2002:ac2:5b11:0:b0:513:d030:f313 with SMTP id v17-20020ac25b11000000b00513d030f313mr2548364lfn.32.1710507263882;
        Fri, 15 Mar 2024 05:54:23 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id r13-20020a170906364d00b00a465f8259c3sm1672917ejb.125.2024.03.15.05.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 05:54:23 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: linux-security-module@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] yama: document function parameter
Date: Fri, 15 Mar 2024 13:54:10 +0100
Message-ID: <20240315125418.273104-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315125418.273104-1-cgzones@googlemail.com>
References: <20240315125418.273104-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document the unused function parameter of yama_relation_cleanup() to
please kernel doc warnings.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/yama/yama_lsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 49dc52b454ef..f8e4acd41b72 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -111,6 +111,7 @@ static void report_access(const char *access, struct task_struct *target,
 
 /**
  * yama_relation_cleanup - remove invalid entries from the relation list
+ * @work: unused
  *
  */
 static void yama_relation_cleanup(struct work_struct *work)
-- 
2.43.0


