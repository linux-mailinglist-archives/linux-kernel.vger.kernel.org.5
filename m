Return-Path: <linux-kernel+bounces-100042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E917F87912C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E181C20AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7445D79DD3;
	Tue, 12 Mar 2024 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cJizL0tL"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F6B78295
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236514; cv=none; b=pLd6dyB63FFKKOlfACuV/or0fSYIvkHXeKBbUoSrONkQGUWBH1/iPnDL3yklCrsRwJkSrgI4fkUZtRUYspstg6E4MT65TAuxl7lNsGAJKRwOvDjus581zqgZCTW8JD4S0zCSPbvlWv2a7eZt0l3Zs/BDVXpS/nxU4n9ud2gAYBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236514; c=relaxed/simple;
	bh=7E++P3NE3gX/uG8sJhez163L//hFb7dWE0h0h4Q6OTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0VPzO4f9e49k7KxSFoFBV45lRaLKTEETpoQvBniHcaGbsX1MBIz1wJEzM/LraZYZk6SFet0pHHf+wRC00YtC0K2+PWJp9412LZVdkOCWaEvdOUhT+C72MHgoZ/Wo1T/ktxCK3dw2QCy92vaeacxvN5rND2wXGsfUPx7riW67lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cJizL0tL; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5673b5a356eso5698344a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710236510; x=1710841310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL1pmIo7s1MX4N9LU8kIbt0i/wU5mZK2rTJkOzRk4Zc=;
        b=cJizL0tLRNPBnW2KUbcF4XuuG0UxvAbO5W7kReIyc692B52VNoFHQQtxhea+zwX2s7
         bL4hZprBO+DI4aOzo5SW7UcbpHR9ZbBwO/HFYjTKBqYPiUDA81ms/s8VIsIH/i+81Cri
         /EeybGAv10jftyZNyvkGFPrgELRB0mh7fsNvrcDOzBzVVQ/RAEHlTqdht+tPns3rnDBm
         zAyA+9g3GvUfY3QDArWFQOwaISYIfIzPQUp8mrzGuzfr6YeTs9ImCftsQEDB6sBAUCzq
         ODEf9i1bFToNmOz2H054PvltuhMfE36pjrmeCieqOEfJQIXUyMLkNkwwCSQmsrzdQFdH
         0gzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236510; x=1710841310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BL1pmIo7s1MX4N9LU8kIbt0i/wU5mZK2rTJkOzRk4Zc=;
        b=DYvVBwmLie3+kE6PKVCMp1vKILgh77/c1SE7m1KNSUnu+6b3j74w7ysakYjoSfs3Xi
         6jKpa1zkVzZP7q1CgfaRZLbdYz0KTFoUSIHcxy6QFRsbeBHN0r2LU0BznNHeKSmU+exm
         rYMy2oLbwEpo4BNN7klt9AmyTAr24CKEwBGiDar/0EU1gmYsA98IzGOU9j7raHaQEuxG
         f8IHGHu5SX2yBOtOjIL9D45YSMMhob/flQ3kmvBM9oc+kQ+jBzzr5N7lF2p/71jhO7Mo
         kWF1CdLPr+9/pVoo8eWxuwEUX/iGWFSDT2fdJY/50iW01sRCXfmDyWV785QkrFhdewrf
         0m2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWel4YGqcnTvP6sQitAjfg2D81US2Mq6dnuVyZSurJVfZYwyz9/zfKpDRUEMjJjR5Pe7SBSGaBTuSNt3bEXPb+1sIO7rUEg/b0n0fWi
X-Gm-Message-State: AOJu0YyzWzmvwX83G1EyJKHxB5nSUz8nbmndSdkNn/K9zTF1YiMLy5Zr
	+en72Ag5E72ozUC5ZyT0nVw0WVTBgSb9/+GHo/OVU9MWWM+xdm2uoeELX0ave5k=
X-Google-Smtp-Source: AGHT+IFSzWKZX27uBwzNvn0on/otGZNxxkMdnvFDf8T+nQ/1Mylgu1PLZ/eWjNO9eX/pEk0r12IZeA==
X-Received: by 2002:a17:907:d049:b0:a46:1e17:fbe6 with SMTP id vb9-20020a170907d04900b00a461e17fbe6mr970350ejc.9.1710236510553;
        Tue, 12 Mar 2024 02:41:50 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170906e95600b00a4623030893sm2091961ejb.126.2024.03.12.02.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:41:49 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 02/15] include/drm/drm_gem.h: add poll_table_struct forward declaration
Date: Tue, 12 Mar 2024 10:41:20 +0100
Message-Id: <20240312094133.2084996-3-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312094133.2084996-1-max.kellermann@ionos.com>
References: <20240312094133.2084996-1-max.kellermann@ionos.com>
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


