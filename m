Return-Path: <linux-kernel+bounces-76450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AEF85F77A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56EC01C213EF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8DD47A64;
	Thu, 22 Feb 2024 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Rt81lnVz"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A0741C64
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602668; cv=none; b=PXVEyjXnqhzWLCMwRUpWXI5fri+LDrynNhnljxS1Sye/o93LZcYyIJDfkU0N3TJqJwUb46N98POSwlUnTpQp0JNdLVGmsuZKAWfy9ECI8YRDcTOCETmBxB0fpQGpPJXLtQt2tk7LolEVBxvNogSFqhPBzc9AzVad9vsY8Rt4as4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602668; c=relaxed/simple;
	bh=7E++P3NE3gX/uG8sJhez163L//hFb7dWE0h0h4Q6OTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcY4/5dCUpTKnMCXWokVxct5vgjYYEh6iu55Q+75pt51QRWnA6ty7dADHc1mdtF+XsaXfKXN3WAGHqlzbrU0CiE2k33NbMeBTRJSLWjFzYej2HAatxk7QSlVaYA1G8FjMdfRx64o21IbHHQyPJ5G7Hny624qTQEVKmNkUObITNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Rt81lnVz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3394b892691so434512f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708602664; x=1709207464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL1pmIo7s1MX4N9LU8kIbt0i/wU5mZK2rTJkOzRk4Zc=;
        b=Rt81lnVzkwe7EDCA6zC/ONS8lDJJpxCT2WZq0l30xixTiOsGtYJttDV0TJCnG9pS6u
         WPq6YFR6VYGRlR5zao+ZT+CU3xwUFuWufowP23EYujpRN1el2fvdK2cL4iVUAlGG8I4i
         vxjyWWAk6KvbbD82fd06O5Sc3mdsJEG58XA5zEVoWecW4CEPhdTifBxt9SGuH9+xgiJz
         naYE0zyXtfBGb4cQLNkU3zjSiuFrYioY1iIYDLDyBvy6pH0AiNiBZnxo3JWI9iUFobhZ
         4WHZIMyp3jUMQldOHyNeTfT9GVbuiiPh/RMT86CIEgpXMIwrxmKb4VCk862d0p58IAeA
         swGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602664; x=1709207464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BL1pmIo7s1MX4N9LU8kIbt0i/wU5mZK2rTJkOzRk4Zc=;
        b=ZhaHro8n4JUeQcyzFdIgaJ5yyodmnPGUd7wdleucNZQhw49B1FHxFBRpk4hNE0vDUL
         BkhLQFvqeayGYepXXrx62PFR+Fo0j41AltK9PaAscmnekPLgLmjFQBuE9T+IutVI0em+
         CS7nEVsB0Z1XIuom6CBm6w1kJ3Umi0R4TqUvvLuL78tH+QSkMGDaZl7ucxrNXyG/z9Tb
         1/8onZLoYXgygXrTgzHtJCQQaOgOi9JxAijiNlEkg0VzCuvFZZMFH+lNx1/ywLO979Uj
         6l4nMFSRkK6iJsDps/YtqxJ3LUIxVSudbE4zsoOkaUNLFzOaCvTuPpLHZpTQn4C3h1D+
         TBQw==
X-Forwarded-Encrypted: i=1; AJvYcCWfDrWVQjZlS6+k7MXt+JzckrLou2BqshpTxOB+9f8d5KUyGJm9tNkD8XMq5ZekNEfttDlcfb1UMXiDjeRRxa0TG6dmyHEAQXRNs/JC
X-Gm-Message-State: AOJu0Yxu9O1BrzszElQhxqSITMib5qzFBRW/dUb3BsVynOqI0/sStUz8
	O1e6/uLwoYGxBPhmDMZJBopbq3dzGsfPG3sBnhel9VA7yiGCpsgbgo+H0z5KCsmvt1zloM2eDYt
	P
X-Google-Smtp-Source: AGHT+IEdqTZyHvawG3jnqE6QFiaRjzUOCgYFXRkgDA6AoYo7c6Ret0m4HwidPTuLwONlXP4untfCBA==
X-Received: by 2002:a5d:404c:0:b0:33d:64a3:9bc6 with SMTP id w12-20020a5d404c000000b0033d64a39bc6mr2229571wrp.4.1708602664281;
        Thu, 22 Feb 2024 03:51:04 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id co18-20020a0560000a1200b0033d4c3b0beesm15044920wrb.19.2024.02.22.03.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:51:03 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 02/14] include/drm/drm_gem.h: add poll_table_struct forward declaration
Date: Thu, 22 Feb 2024 12:50:43 +0100
Message-Id: <20240222115055.1172877-3-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222115055.1172877-1-max.kellermann@ionos.com>
References: <20240222115055.1172877-1-max.kellermann@ionos.com>
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


