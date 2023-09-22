Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168067AB8D5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjIVSFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjIVSFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:05:25 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6D330C0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:53:50 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bdf4752c3cso20391515ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405230; x=1696010030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cjh4soax71qXdKxx4Uo/pClvCKWvC2l7PYoorMxWqJM=;
        b=PeaIFsPV+UfCkLCRtMmx+jIgufa+thGTnpZJbcvse27KvuO11ZjLVV4By/9vLG/kMF
         gvLLjP5SKlsOqVGSDnMTxMDpx3Jznf7VOxwYBnGl36UYZwxQSvioDjHvIA8SOrplLbqG
         3MZW3w8FUvhFy6tivwMq0RhTOxsPAVbftqKLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405230; x=1696010030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cjh4soax71qXdKxx4Uo/pClvCKWvC2l7PYoorMxWqJM=;
        b=D+MpbJuC1lSPlB8Wsc9xWso5n0BbX/OgPnMdZ0ZhfRrD1bZ4ZPSYSuxSIKJZeoI4nJ
         RA2kdeuZ2PY3V84ZwXLU4MNPaIfKi7+LZvet3MQpqAPQpTNWx8tZ0yiSMjl5NBEG9TZy
         fZcf1iG3iDU/7EyQcBwCsioA56CQQFfIJHOq8pxnw7jhdDDvxqHMmQ+fZDsx4+AUZ0nk
         kgJ1YnA4BfqhY3k/d9raGPcOXZHLyjqY+//FR7u95oZ+wqcAJLQoIFLhX6gJstnblGIa
         HzL4d6OjkHw439ZtH8CEqfJD+zhbcNxm5em8UXrtB9Y6Znad32vrlb7V6rdxq08+taJP
         IUUA==
X-Gm-Message-State: AOJu0Yxh+/9RoFmZMXfjYRL7nYFs054xjG/+kcBd4kVgseoxF79DpD9S
        pLNLjNFswzQV7ye53tR1GW4fSQ==
X-Google-Smtp-Source: AGHT+IEfql7EwXLqw0RQGuj5eyDgTT4VnRITzCNrAALaQOo4wRq1XaSH0PIKfNkrgz7Ls7wJAVDLDA==
X-Received: by 2002:a17:902:e807:b0:1c5:9c73:c91c with SMTP id u7-20020a170902e80700b001c59c73c91cmr185786plg.48.1695405230042;
        Fri, 22 Sep 2023 10:53:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p21-20020a170902ead500b001a98f844e60sm3784484pld.263.2023.09.22.10.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:53:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Clemens Ladisch <clemens@ladisch.de>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] hpet: Annotate struct hpets with __counted_by
Date:   Fri, 22 Sep 2023 10:53:48 -0700
Message-Id: <20230922175348.work.056-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134; i=keescook@chromium.org;
 h=from:subject:message-id; bh=fMklDMYM+o2FhB8yiVei6HsERV+0CtPP6utTcRXMf8Q=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdSssZpoVdwFzg8xBswKKIRawVGSvV3UwBeM7
 R1x/C4Yco2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UrAAKCRCJcvTf3G3A
 JrR7EACOhs429mzPOFticPW8qF58H+j8y1aVpI1PN+aosr9aqqI2sHcYO6fGBfSPqEgIwKTgt1e
 +5SLoOtIh11e8J2Fol4nXV3mr4S9NWMAUK5hpelP4hd5ZXD0mmS5yyeiGX2r5WHcTZ8h5GQQV15
 yyT4Px1LMDIBAUuKYZfSVNRTyHzyKClhA/oRusNDybVpf/MV0j+R9uhszLuVenI+osP6Apohz85
 9LoG4NMbrt5Id+qbz8kQuHr+bUE7tFYi0sGaIZcIijAhxhxqeVRtz3yn59mOXEjQsusOoO+dkzH
 TTmDcoRIX3thpWjIal+RDLNWPXSX6fH9iarnjG3gUA4kK1Z9L8BdCVJQDf1BaASjUfA6XSXD1lH
 adXNFCefmIilu5jcGX63B3OrP/lfn4ZOQycXsUJ17c3ATAlaVODvIUe+EwKnN8h05Gfz38b6RX3
 OMY+DY32IgIiUu9SalJuVh4cneg86WUR6Y78THUT94gE1MtdD72C5hhCiJhDmY4F1oSUfhBBfj5
 Yvz1wTQyl1AFFL/ijVNOjxxwnwWHoMz3jOeq+CBkzbHo704QLp7SEKfWsE745FFoqs+4VNzGgpH
 cnynF2EJvviovzpVDnNnMAu/wZPdUaokf7qFnmGBgiG6mnzfBoz398FYvEflvv8lhtSc2L59ARE
 1abYFQx rayFkXYA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct hpets.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/char/hpet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 3b2159416e62..807c389510de 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -92,7 +92,7 @@ struct hpets {
 	unsigned long hp_delta;
 	unsigned int hp_ntimer;
 	unsigned int hp_which;
-	struct hpet_dev hp_dev[];
+	struct hpet_dev hp_dev[] __counted_by(hp_ntimer);
 };
 
 static struct hpets *hpets;
-- 
2.34.1

