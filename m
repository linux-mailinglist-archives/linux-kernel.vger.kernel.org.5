Return-Path: <linux-kernel+bounces-166311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3E98B98EA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B781C20E85
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032BD5CDE9;
	Thu,  2 May 2024 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qa7nz5OS"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00CA58AA7
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646198; cv=none; b=prsSEkz7Wfhiysqk8NYxqqV2GBQ/m4THndjSBGhL5mMgQnWsCgtSVDehpvdwajM7GdEIQAdlWX2gd7OUE+KbO5ZwA4mSUac/NstKDlcoB5n/NO4/nOvVLb/AKndHOlR5nQrLEgsjVApv1L4PpOOeDQw+bw2xFe+saHZVBc7rN6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646198; c=relaxed/simple;
	bh=/zGsIykk65WVpAFZVbjM/CpjTuEb1xY+qrTEEH5Hcvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dMc4rAH7vRE+17EFvMVE6BumOt4lzDWVVxawHsMwqQjylQkcu7j7teEVT9hOjhUTGaknbiyUO5624M3Ej8YUam3VaeEKQ3OTCZQCb7yTg1HRoF30ZXQMzE9wICwyW+uw1vEPE/WkLW3mblQ35qMdeBBxNz7XDSlK5cccxtJ1NHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qa7nz5OS; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2dd80401e81so16638931fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 03:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714646195; x=1715250995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FT2Vebyh1FWwMJQubPeWb4xwvsvNpVAsZHgyxB9GdA0=;
        b=Qa7nz5OSMDsGVA/0sLywI19wXNmK4cXmqpiYVx1pCl7dVv8wWLqIZaBA9wnQlgZNuC
         ZygBABe1RjxmmU+h7UcvEphrsFGt5t8xenkze/qTLk0dVsJoRZVFr8+Pxykr/5wR/kOO
         ZsdHH8rCBQQnWoOMGx0uzd4NNCnGfUoDHSks76sDtkuBbxLkrBhmAdKa/KGlK96bf9nS
         iDml+sWPUJgAGaVtGlFOaC0ev+VzZVhk4siI1jXPB3cJzcm4zVEEAGJjZw7srxaq6tyZ
         f0TFenhKKTG4Ho3HAYeL3PAeqcrrg5iKpulOWIrOTnAu3gllaocUuhI0iwtwDFbMTB15
         oP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714646195; x=1715250995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FT2Vebyh1FWwMJQubPeWb4xwvsvNpVAsZHgyxB9GdA0=;
        b=DSi4ndw7FPxxhVQb7EPNBPlaDUfcj9zpAiEbW/huvS0ew/Ucynq2o5oPoY4QyRxOYx
         DWX8ME2ZCF45JyOCnSitZxDkf19yJuXE4HT6YHsx6M2q19AJC0EOJPaj9CYd+lE0B+4i
         sIC3bYW/FgINzrxsIkOzzIn9AGk7hxazEXGXyRaEFcCVhkRwI/yWSZeUwNU/kQ3O61ZW
         cyPOfv2H3cC6T4yZL3T/CrNF0nbl3LQ6Qu4E3HaYQmY5rATftCMLLjWUVrmHsKMB0cf5
         zbBg/+3wuSVEZCzc0ZeRw1cadPlb/EaCCLJPAPzLPXH105cPANn9naVhaOELRWRRS6hw
         kxFg==
X-Forwarded-Encrypted: i=1; AJvYcCUbsJhmOqifYnTsJsisIYW99eCtpAa935arHGzX0jYNV2rE06N1O8DashMX/Ob7a1DR5Wd4WZTwvkQ9/tjTVGbZnnzt2pgjmb5WbYX+
X-Gm-Message-State: AOJu0YzclbgMOavdWKfHFDBUgJskZ1mHlc38Ru4+YGEMZ4CC0SVzbpUf
	+RRyYkwzTUOo13yB+lFFYF0dv8iaYN8fAblgTBcmKiYszz9Xy7/J1u6lYXyb
X-Google-Smtp-Source: AGHT+IF6z5Prb/zz+BTozZr6JQYkXzLArcZTkDyBdDQRPe4LSx9aMuoUBBv13IOxRD7Z4PR0uozM+g==
X-Received: by 2002:a19:ca44:0:b0:513:ec32:aa89 with SMTP id h4-20020a19ca44000000b00513ec32aa89mr2847492lfj.2.1714646194515;
        Thu, 02 May 2024 03:36:34 -0700 (PDT)
Received: from dmitrii-TM1701.. ([2001:8f8:1d3a:4eb3:9dcd:1735:fcaa:e2])
        by smtp.gmail.com with ESMTPSA id rn24-20020a170906d93800b00a52433f0907sm402630ejb.37.2024.05.02.03.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 03:36:34 -0700 (PDT)
From: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
To: dmitrii.bundin.a@gmail.com
Cc: airlied@gmail.com,
	bp@suse.de,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	gongruiqi1@huawei.com,
	intel-gfx@lists.freedesktop.org,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	michal.wajdeczko@intel.com,
	rdunlap@infradead.org,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net
Subject: [PATCH RESEND] drm/i915/guc: Fix UB due to signed int overflow
Date: Thu,  2 May 2024 13:36:18 +0300
Message-Id: <20240502103618.129017-1-dmitrii.bundin.a@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240413031747.2416581-1-dmitrii.bundin.a@gmail.com>
References: <20240413031747.2416581-1-dmitrii.bundin.a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix compile errors of the form "FIELD_PREP: mask is not constant" caused
by signed integer constant overflow. Files affected:

drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c

Reproducible with gcc 7.5

See https://lore.kernel.org/r/YkwQ6%2BtIH8GQpuct@zn.tnic for the gory
details as to why it triggers with older gccs only.

Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
---
 drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h b/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
index 58012edd4eb0..8814d4cd371c 100644
--- a/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
+++ b/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
@@ -29,7 +29,7 @@
  */
 
 #define GUC_KLV_LEN_MIN				1u
-#define GUC_KLV_0_KEY				(0xffff << 16)
+#define GUC_KLV_0_KEY				(0xffffU << 16)
 #define GUC_KLV_0_LEN				(0xffff << 0)
 #define GUC_KLV_n_VALUE				(0xffffffff << 0)
 
-- 
2.34.1


