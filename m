Return-Path: <linux-kernel+bounces-118470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C018188BB6E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D83C7B216B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA0D1311B9;
	Tue, 26 Mar 2024 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SzBX6cyn"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58371839E2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711438678; cv=none; b=oeBd/rMydfJCtJon5ZqMG+jKNVL/BUMGF+02vNZnCRXl4xqDBGaxhF4XATiz4rduotV5lPvIgonul83XfFl1Tcx5bw+yud7gfVJAuzVym+YOJP2JT/ZhSJ9BJHLNoB7DtUpJmv5i4yx71DwWQM9ZikMLKVFse9dwKXsVEUBdyV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711438678; c=relaxed/simple;
	bh=KB+GwC/75TtI91xEhdpED2/ssvEu+EzqIjo+lj4Zexc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XuKaDaMpH7516HSHEZbKUtXDKh8X9z0SvkECKl1eRIFAXSd7KwMLtsxRfALI1nLyAZbo3ZjHAE/EAuXwJFpKma7KPyaA4fF2L65oMnidUGaGJNt0zFsQpZSS+WA2MWgVszNuVapV+GNrQ3c+gCjTkqKWimcrfwsC2Cp511+Oee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SzBX6cyn; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd073522cso94800027b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 00:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711438676; x=1712043476; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yYWj2Gn9osrAFD6FEND6e5qyKYrw3yLcAlVsmaICSiU=;
        b=SzBX6cynoSTpgVdTZUXxhbTAg1NHt+japd5IL3WTlwnYGyU+Sxd+1cPjWPjBZ6vTXz
         vtqdQ+CPP1fc3GxlOMMFAObyCytMUI+9xcJ6GuyaI+9ABv4kjGDNNmAIOOe72MTl5JqO
         Z6dizp1Aujl9zckKJy022U37kYl7Cwwu3Gfr6MCuCkRRop2N0o+AtKvjjsLVPg3ZmvV6
         BxtDdYRxkhnPVfQzW7/wMav2Y/BpPyAz0HM31osBxD5P9EkozDWP55dOEseimHDH0+Yn
         MHi6FEm2AuSBUZHJGtu96nyFXDrNdBryu6HfwA5vTISA8WWCYoLsI37EMq/TC08oyYFf
         0QiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711438676; x=1712043476;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yYWj2Gn9osrAFD6FEND6e5qyKYrw3yLcAlVsmaICSiU=;
        b=Rz/C8ld1g9xBfCd/yV1P3V1pPF1CRmpeF0NdOPEog4J+CHunl+9UCQAsRmOuQLcS8C
         rUJfbfD670MByQ61HwR4mYh2Wml48BernHImKiRxurm7HXNdyWxzHxZGQ9L0FmaCLa4p
         fNu5MklQSzv7CCaBksdqymo2vMjtLuvzCYG32MOZAYbdVqa++BobYan0QIQth0QXT452
         gP8IARv2Z5Dcb/HP2sL5zKMCKcUwXtGAxviKj2/4PaBDUA2ujZTH0msIwwDjBSyufISn
         b/NulT39QMpWmMhv32npxVB4OPTJAfHuB4+6yu19B7Sitp5vU2G8KK2EcnPAn17En8OP
         7opw==
X-Forwarded-Encrypted: i=1; AJvYcCVDJ7BL9ElLZ9u6P4LDe6uehYK3vVF8x7i8eNIKLh37jVBb+6MSrMRRzOHp4OFwZGlVT5Wpl0AT4lGdANXBci9CR7HvM+VHlXepg/H7
X-Gm-Message-State: AOJu0YywyGtWLPzrWMW9cYh82Oq7dS92R/G3Rrpe7BAkkEJVFa44lDfP
	1OAMIsGZHOvypmEJ2ZV1THrWOpEv/+HVcyUKZz5AaPOo3ELf16CZTI+XFBDETaAWqRGoHYDjPqJ
	ppg==
X-Google-Smtp-Source: AGHT+IGPHjQo87+r2zhqmR6kCCDNQTsYC+f2ZCJS3JAQtG++EJPcIBJevN+jcis5On9vmS24q4aOrBZ/Y3Y=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:f77:52ef:ebeb:2cec])
 (user=surenb job=sendgmr) by 2002:a05:6902:100a:b0:dc6:ff2b:7e1b with SMTP id
 w10-20020a056902100a00b00dc6ff2b7e1bmr2849789ybt.4.1711438676435; Tue, 26 Mar
 2024 00:37:56 -0700 (PDT)
Date: Tue, 26 Mar 2024 00:37:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326073750.726636-1-surenb@google.com>
Subject: [PATCH 1/1] arch/um: fix forward declaration for vmalloc
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: sfr@canb.auug.org.au, kent.overstreet@linux.dev, sj@kernel.org, 
	richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	surenb@google.com, linux-mm@kvack.org, linux-um@lists.infradead.org, 
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patch [1] replaced vmalloc() function with a new definition but it did
not adjust the forward declaration used in UML architecture. Change it
to act as before.
Note that this prevents the vmalloc() allocations in __wrap_malloc()
from being accounted. If accounting here is critical, we will have
to remove this forward declaration and include vmalloc.h, however
that would pull in more dependencies and would require introducing more
architecture-specific headers, like asm/bug.h, asm/rwonce.h, etc.
This is likely the reason why this forward declaration was introduced
in the first place.

[1] https://lore.kernel.org/all/20240321163705.3067592-31-surenb@google.com/

Fixes: 576477564ede ("mm: vmalloc: enable memory allocation profiling")
Reported-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/um/include/shared/um_malloc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/shared/um_malloc.h b/arch/um/include/shared/um_malloc.h
index 13da93284c2c..bf503658f08e 100644
--- a/arch/um/include/shared/um_malloc.h
+++ b/arch/um/include/shared/um_malloc.h
@@ -11,7 +11,8 @@
 extern void *uml_kmalloc(int size, int flags);
 extern void kfree(const void *ptr);
 
-extern void *vmalloc(unsigned long size);
+extern void *vmalloc_noprof(unsigned long size);
+#define vmalloc(...)		vmalloc_noprof(__VA_ARGS__)
 extern void vfree(void *ptr);
 
 #endif /* __UM_MALLOC_H__ */
-- 
2.44.0.396.g6e790dbe36-goog


