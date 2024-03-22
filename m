Return-Path: <linux-kernel+bounces-111160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD698886882
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D133C1C21789
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19111A701;
	Fri, 22 Mar 2024 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiFEYJhP"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD021863B;
	Fri, 22 Mar 2024 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097402; cv=none; b=S3K0qa2XzCtaMbakapyCfek/ZGo04n55db7lCR5Gu/GV3T1v0OtDHui/GPEEWuRoFhI1WBpaBmomViarosyEtTxX6ggHyiSDQfPp8jXM9vYnzQ2q6H2jyOIjw52kdbgsPV2jrqQnZliCya86hY30obxeVLE/wwbjuD4XJgIxBs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097402; c=relaxed/simple;
	bh=HJlrj6w3n1k06T38Le7twWxRKsTsn+pwv/gvS9S19DY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cSt2jarhRvRosqMQrV4heCJUvnNZIhHP80zggZ7sFu8c2kHJ3/fCJ8GiDsEn1lIwbf4PntW+CSaPoVhbdJeL17Lf8IYM9VFUceV24n+/4s/sIt9/HxZKo7bJAMWNyAdMVX6lx1fw9p3LPRm1JEQP3TgikrvLgcYchY98/AIY+fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiFEYJhP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e07cd7b798so9894225ad.2;
        Fri, 22 Mar 2024 01:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711097400; x=1711702200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUTQQORTCNkJLIqJM+PvSaUWiqWoVca3nx315DNzuS4=;
        b=CiFEYJhPiudDPazq2+chTsPGWqqN1nICU7KWt7sXsbW3p8ZJX/W+CowtgCtntU7evT
         NBushbuzJ6rN13BVMOmWBi4gAUBj2HNTA0tJsgyp0y3aCVg2SIOQTepltthNPdG+bKRP
         uU4QdAJRSRcYUt/h83LACVS9rPbG7SxLe4HKeW5+6gtvaeVO+HlQXxB3Uc32ydBRuNvT
         Sr/Q59RylcH11SMdwWg32FBLFpzxcGVFIhsJxNyrnrIoscfTd5MKVwrhHC71cTHdvUqC
         IVr4hOQOVakkcE78xIur9IV4mrxNg6rjvwSSAQ9I72GUTWtqN2N7Yq//R10EErr4pxYY
         ngmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711097400; x=1711702200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUTQQORTCNkJLIqJM+PvSaUWiqWoVca3nx315DNzuS4=;
        b=Qus1mT/R9sKOwmiLIlKM4zmdmcI30jenYvtQfTQgRKD/XDD2fNkjvNGzytP3t2KTwA
         9kjBCj26Td/pvZ8fHe1WANmY6b5nESOnQUa5MtGWg8ePBnjrOKXWMjockgr86nbN9xbq
         MMUd4li4CrCNOvzknYDf/IOIry5WbGEkWm+oHoQcWojUqmUMFbEE+cR1GNtz+flGvJ+S
         xf5tQKREQxuofgPq4fDAqbXSpcZhWbpSfoZrhDjEqP0U/jG6VzHqRsFF+8FKk/RJnHp+
         Uptd+//H9XXkuBpKzmcA1WIpliFpzNn4w8WtRhL+IzRJu9bF9Dhh+UHiypwKjSrHD0vb
         4ndA==
X-Forwarded-Encrypted: i=1; AJvYcCWxcsrh570UpEhdkH7SEcPcbdpfeXdcaiHGi0edZIYWMI/ggOIjJ/ehVJtH/dwrRw8248w7Fmu1MwaAnRuEGfCvo9Kxz4+QfbLkzUPuANPmp6CWwntmQ0c0FJCJDXUnRVY5ORFM
X-Gm-Message-State: AOJu0YyJfajOksYh1hSvyUtrRSq6IYbdwp8dVKDyZAEDqexmqiaXK2ta
	U6FJ4BuPJkrLDUYRLw8AXX6Z8srVtzb3VnlsuKxtc1c6p3OogJ4j
X-Google-Smtp-Source: AGHT+IEwAhEBj4WraWXSc21vVqo74nXhRTfrIrcdWT93FDm/yOZTJdKCBPQWzzQS0FLvhVT4z/TOjg==
X-Received: by 2002:a17:902:d503:b0:1e0:185d:16d3 with SMTP id b3-20020a170902d50300b001e0185d16d3mr2523534plg.5.1711097399842;
        Fri, 22 Mar 2024 01:49:59 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001dd5a0a20d6sm1328165plf.287.2024.03.22.01.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 01:49:59 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: corbet@lwn.net,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Zankel <chris@zankel.net>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Guenter Roeck <linux@roeck-us.net>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Mark Brown <broonie@kernel.org>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 1/2] Documentation: coding-style: ask function-like macros to evaluate parameters
Date: Fri, 22 Mar 2024 21:49:36 +1300
Message-Id: <20240322084937.66018-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322084937.66018-1-21cnbao@gmail.com>
References: <20240322084937.66018-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Recent commit 77292bb8ca69c80 ("crypto: scomp - remove memcpy if
sg_nents is 1 and pages are lowmem") leads to warnings on xtensa
and loongarch,
   In file included from crypto/scompress.c:12:
   include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
   include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but not used [-Wunused-but-set-variable]
      76 |                 struct page *page;
         |                              ^~~~
   crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
>> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wunused-variable]
     174 |                         struct page *dst_page = sg_page(req->dst);
         |

The reason is that flush_dcache_page() is implemented as a noop
macro on these platforms as below,

 #define flush_dcache_page(page) do { } while (0)

The driver code, for itself, seems be quite innocent and placing
maybe_unused seems pointless,

 struct page *dst_page = sg_page(req->dst);

 for (i = 0; i < nr_pages; i++)
 	flush_dcache_page(dst_page + i);

And it should be independent of architectural implementation
differences.

Let's provide guidance on coding style for requesting parameter
evaluation or proposing the migration to a static inline
function.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@kernel.org>
Suggested-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 Documentation/process/coding-style.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 9c7cf7347394..791d333a57fd 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -827,6 +827,22 @@ Macros with multiple statements should be enclosed in a do - while block:
 				do_this(b, c);		\
 		} while (0)
 
+Function-like macros with unused parameters should be replaced by static
+inline functions to avoid the issue of unused variables:
+
+.. code-block:: c
+
+	static inline void fun(struct foo *foo)
+	{
+	}
+
+For historical reasons, many files still use the cast to (void) to evaluate
+parameters, but this method is not recommended:
+
+.. code-block:: c
+
+	#define macrofun(foo) do { (void) (foo); } while (0)
+
 Things to avoid when using macros:
 
 1) macros that affect control flow:
-- 
2.34.1


