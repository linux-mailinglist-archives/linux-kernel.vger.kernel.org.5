Return-Path: <linux-kernel+bounces-67113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 592DC8566A1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D1D1F28032
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021F9132C2C;
	Thu, 15 Feb 2024 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Bhe1EYAG"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E715F132481
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008976; cv=none; b=VcDIuSWRaR+MM7GRLIfLE1haWKKAQZ7v1PaHYvgDE9bO/LPAAefjyWkmtLmNts3oMKURfaMyVPHOmna6O6jRejX8Q/B1GOeObTdp5ZlEOTIAfO+EobX915eywzeQtr31WZTRAJesoP0pVZi70Jpqc6es3NtGJgTrnEsZRykZSmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008976; c=relaxed/simple;
	bh=7E++P3NE3gX/uG8sJhez163L//hFb7dWE0h0h4Q6OTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHLrdRnxI5nYr5duBlBlUTOy+eN+eFGhLX8ZtIauyI6utgqR23KTM9yQV+hPuLQZWaq+mlMs2oE6aA1SV9T9WxcGjpSujtzh8wbVKLfJ+i8qPN2VyBOIZ+3fVOht3V+xd71yfJnym+OIHh56HUc0y6Qv4AD+2Yb7Z3zsQFNuZE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Bhe1EYAG; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3d484a58f6so121797766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708008972; x=1708613772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL1pmIo7s1MX4N9LU8kIbt0i/wU5mZK2rTJkOzRk4Zc=;
        b=Bhe1EYAG/YFEC6l9e6eDHNaQIM4E6E6brL7hYkz/QoGItPANmWPY/F4bLqNik2O+Qf
         +amDM8s7+GgzU2OvQp1ftfuNw85DD1Hy+6HGCq78mdGCRmx8td4wtDpstteV54gBfFIX
         VcJuXjBE4vyAJsUh4lTMeOZpWTRb3t9i4ksmZH47d76wbgxEWwzu9UXZ0UMgOc4Fkvpe
         NGSpEIDW2tJpcDw7meTyrqWfEcQnalXfTECXIePGb++CT7hf1FKVrqlk7ovgm5aJWqQN
         5x29ci9hY8LYuRUJA3ZwMAcfG9BNwGlU17UZIOpwru8gBd7GE6Z9AmKfkl0DUVvgqRO/
         aD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708008972; x=1708613772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BL1pmIo7s1MX4N9LU8kIbt0i/wU5mZK2rTJkOzRk4Zc=;
        b=i2wkKuxk/v7E81BuVK0QbP7qT7pomkqUbae1NlsXzySz4Ronobnu/6xz8eSimaV2Ec
         hx4fAX7Bxr8zTQO12i2u/RApb+XN/8Fb+QJNE1zEY3b+Bg3oQ1C3yOgTao27PceUgRy0
         R3JICojrF8czUVecE7abLp+c7jn66ZQPptgpMpTC0naMPZbD7TGGFx+P/RZeO8l45jJ7
         62Sadwa5N9w9H4gB38+vJmes67cElZKabS4UD5o8V89RjvAzvdMyAS/iBhQmBOJCbOjZ
         z0S0aYQO2MZ08CDiZOmuT6AZ+v6vaioDKagACYMlOzG88mur3J7okb/Rzw5LSY+wjHRo
         yedA==
X-Forwarded-Encrypted: i=1; AJvYcCX0ukH9GWoJvPIN23ufdKtW4VwKCzSdOIwY2G+76fPW7LZ/fEJMxY6OkrdNsfBnk1veY556chQKX8XvZHfCN+/22oBOqXHUNLtE+VFz
X-Gm-Message-State: AOJu0YytSviOHLezeIZc0qOBXvwOmq4CQ1D2Fth68ET5gYfncMkg7wxD
	QyRjtFDeblnkK4fJbSZn2QVGprqEGsylLg7cIaT5MSJP31p8iS0Vgi2reBTnFUQ=
X-Google-Smtp-Source: AGHT+IFKfxSMdDU58egMnr1nDOgEiMLO3WKEhWBKIvifvsssID7+Frq6c2q9Yzb4eyPMkscD2JQmYw==
X-Received: by 2002:a17:906:4157:b0:a3d:7ca3:fbab with SMTP id l23-20020a170906415700b00a3d7ca3fbabmr1539833ejk.27.1708008972211;
        Thu, 15 Feb 2024 06:56:12 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906169200b00a3d1897ab68sm631175ejd.113.2024.02.15.06.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:56:11 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 02/14] include/drm/drm_gem.h: add poll_table_struct forward declaration
Date: Thu, 15 Feb 2024 15:55:50 +0100
Message-Id: <20240215145602.1371274-3-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215145602.1371274-1-max.kellermann@ionos.com>
References: <20240215145602.1371274-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After eliminating includes of linux/mm.h, the following build failure
occurred:

 ./include/drm/drm_file.h:443:45: warning: ‘struct poll_table_struct’ declared inside parameter list will not be visible outside of this definition or declaration
   443 | __poll_t drm_poll(struct file *filp, struct poll_table_struct *wait);
       |                                             ^~~~~~~~~~~~~~~~~
 In file included from drivers/gpu/drm/imagination/pvr_gem.h:12,
                  from drivers/gpu/drm/imagination/pvr_fw.h:9:
 ./include/drm/drm_gem.h:447:27: error: initialization of ‘__poll_t (*)(struct file *, struct poll_table_struct *)’ {aka ‘unsigned int (*)(struct file *, struct poll_table_struct *)’} from incompatible pointer type ‘__poll_t (*)(struct file *, struct poll_table_struct *)’ {aka ‘unsigned int (*)(struct file *, struct poll_table_struct *)’} [-Werror=incompatible-pointer-types]
   447 |         .poll           = drm_poll,\
       |                           ^~~~~~~~

The compiler is confused, and that can be fixed easily by
forward-declaring the struct expicitly.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/drm/drm_file.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index ab230d3af138..f24ade9f766f 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -44,6 +44,7 @@ struct drm_device;
 struct drm_printer;
 struct device;
 struct file;
+struct poll_table_struct;
 
 /*
  * FIXME: Not sure we want to have drm_minor here in the end, but to avoid
-- 
2.39.2


