Return-Path: <linux-kernel+bounces-164269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDD18B7B92
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D56A1C22BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BC8172BCC;
	Tue, 30 Apr 2024 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="RyioEbOf"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5EB143750
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490992; cv=none; b=knXAEgG0dnXeHAiDzSYORXfwGRk2uu4hVs1oSK+Nio1TXrrACR5OKSGMEH8QWI11VMguYW8Q07Bv/Bb5ghYxIajeAIs/LvG9ER+hEnScx4JJiabNKoG0wyskMDgMtbqdOdJqH1qNrKq2j/2I51vMdaol8HcbovC1eg+vU+lGfNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490992; c=relaxed/simple;
	bh=7E++P3NE3gX/uG8sJhez163L//hFb7dWE0h0h4Q6OTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2yFEWoPeU8CmOOa1DJyDb9kGZQFMhVPGX/hQmEdjMO8CAjeCiy4I2As48gf7Ls2GuYTwagQPZB3lnhcSSDq5prksmcXvDSY/sivTTBqg8BiovfmvIbijEFHTliU2qBhWmqntDTb7eGhy0nfvkUDEaj/chg32Ht6xSw2lj/v+Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=RyioEbOf; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5557e3ebcaso957581466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1714490988; x=1715095788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL1pmIo7s1MX4N9LU8kIbt0i/wU5mZK2rTJkOzRk4Zc=;
        b=RyioEbOfhOuUwUTTbZfuYJfVfNI8Y/V6HZ5oj6G3g76P4fl+HA3ZV5B5serMh4Pjve
         dIf0fqQKDwYCQqo6n20WsoeTL3Q0AJO6rR8TX/CEBFGtqkul/YsaOJ9wUXU7F+/JeWLT
         POq61OZrOgvqTFi3Kr9HaG4Dnzp0Pejf0uJMl49B3wL9eCmu2+rB8VMOqXSisavqNUUH
         z2agXgIsZ1UUTK/JmBO5O2sZTocYSPWdaZajLK4CTmcY2yWSd1PapGFNmTDeraUMJSo5
         PyHyunGLinx77JWwgO1SCrFKw9Shv/HpZVF/TMmtb5UK9IO5fs52iQnTIcTWeIVSmvbi
         JrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490988; x=1715095788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BL1pmIo7s1MX4N9LU8kIbt0i/wU5mZK2rTJkOzRk4Zc=;
        b=trIn6RV+qCPJlb/M2mchE4QDPaC9BROl1ExJe8m6HqGz7d/eno7AYt28mV4axm2eoN
         7/R24DBCJ6+HP5sQ2wDKTXk5Kee6Sf7baUiYqBaXQpEFNikKx7NwC1Y26mTf0fC8OVMx
         mM9J2mV/DN93kmk52OKcR2PryRAeRss0j9SI1ToqlSDcXBL5cOW2zPL8NundM8t0Djga
         r9PcT5IFKgulYq11kfEzTgcA3RmN+RgFjgQmgUJY828YmUEO1pio5aeNMnfvqs67jsbO
         BP7D5kMJU4iWFqwojc6Kk75YWSAGfvOaszmFaH1j90zG4IL5A3rASlsnzbcNa3mWhK+P
         Hjfg==
X-Forwarded-Encrypted: i=1; AJvYcCWTboxGWkZyBaZURkTT7ilTqIHrczqD69tURaujdYd+FcFZYTBJQPyepRqDWstfZ2dU1R7qOqRsX0BvYP1dbk4oATCkDHkVi2AAOdtW
X-Gm-Message-State: AOJu0YxEzT9vB4W6WnkFODXeMLKHJqHgtcCPrWSos/lAaFfy+VjVs0u0
	MGza3iIxSflIqjuP+EmvaR8BfoiRXVE7DX/eISGPLFDbM97K/VpdxeMcdkUjbxQ=
X-Google-Smtp-Source: AGHT+IEW+xyzMx8jxewoCp249tqIKHcWbH/ig6zu0O/DkMK1GMuq9gY2JfVyTZrq9nEYSpf+eKduvQ==
X-Received: by 2002:a17:907:7892:b0:a51:abd8:8621 with SMTP id ku18-20020a170907789200b00a51abd88621mr2974749ejc.19.1714490988661;
        Tue, 30 Apr 2024 08:29:48 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f06e100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f06:e100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00a52567ca1b6sm15278137ejt.94.2024.04.30.08.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:29:47 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org,
	david@redhat.com.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 02/15] include/drm/drm_gem.h: add poll_table_struct forward declaration
Date: Tue, 30 Apr 2024 17:29:18 +0200
Message-Id: <20240430152931.1137975-3-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240430152931.1137975-1-max.kellermann@ionos.com>
References: <20240430152931.1137975-1-max.kellermann@ionos.com>
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


