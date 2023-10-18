Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FB57CEB93
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjJRXHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjJRXHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:07:37 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA20511D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:07:35 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6c4cbab83aaso4865826a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697670455; x=1698275255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R431Lu2tyoC4sIz15EV5lX3ZFyKeoePoEoVt0MO1dUs=;
        b=E3WI12tem9fzeK7acuEp8Jv9PXa9v2XEn2Oh+tRw3Y7LC5FJ5wmZrKS/ZEwHP8TVv+
         2ETWN6j+oh2k1ClVWgU5xnyB/mIZRG8w9rhpVxNM8FUniMp6KYV7leHBrWXk4L13pGDX
         yVGX6psT0iHLCjBpw+gQwjpCyPVqVMVlBGs6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697670455; x=1698275255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R431Lu2tyoC4sIz15EV5lX3ZFyKeoePoEoVt0MO1dUs=;
        b=F3rwA+Fh5tW3WNMK1OwhVrouY9JZXu8MtggTRWXaMpteOeIbrNP0jrRPCtrmJwYgHB
         2Zw5INy3nWN7OMNKn/L0JN1NrZkdItrTRblT3w+DBJqgLsVxRqM+T4re/DOnC2lLwUyv
         xiP2PVm6zb6l4EoAsIJgpbzXU9/edtMc+Ut2b7NZsxOVfvVpWlnE3SJpmKv2hrcuC+96
         UEAJUfpT5lgHb1IfFq+xFF+cn+kJ2tXtGGLd9c5IJRSOCBoNzdeQE+jL2T+MkdjCTb7k
         C70KO8fAPnyjtIONwK6GkTkPEgyoYrAjPqMFgiPO3HZGPL5M3VKP1sp++r7IZxmST61f
         aG3g==
X-Gm-Message-State: AOJu0YyyF5+pUvN/vXacOp3Ny+UTqNoitK86YExsMqOzvaTOtEZYKAci
        oUSso2Uj13zkml8oWwOmWkeLNrx7pg30pvqsu6s=
X-Google-Smtp-Source: AGHT+IF3l1o8rnoXWzBQ5ngUxNd+m7JAJxDs38rwbAnd0+vl2UhgreEri3gVW4CW5vfmJy2e6n0rHQ==
X-Received: by 2002:a9d:7f94:0:b0:6b8:7eef:a236 with SMTP id t20-20020a9d7f94000000b006b87eefa236mr705148otp.30.1697670454973;
        Wed, 18 Oct 2023 16:07:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y3-20020aa793c3000000b0068c006dd5c1sm3865865pff.115.2023.10.18.16.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:07:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Kees Cook <keescook@chromium.org>,
        Brian Foster <bfoster@redhat.com>,
        linux-bcachefs@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3] bcachefs: Refactor memcpy into direct assignment
Date:   Wed, 18 Oct 2023 16:07:32 -0700
Message-Id: <20231018230728.make.202-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3451; i=keescook@chromium.org;
 h=from:subject:message-id; bh=QOcpNZ6xFBgRbLuiJg0LPhuBpkNCtaZvPdWptQoDmGk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlMGU03urZWFhgQiQ2LDQ0Ox3AGDcKzzHB8Q3MX
 409RL/kBM6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZTBlNAAKCRCJcvTf3G3A
 JqxqD/wPtqLQa0jzyGwwwgqEZQ4N5/Pw5OcTTKA7fZIIvyL4397i3HBTmDa9mMLGT8LGy103Twn
 rNZvDnb0URpsmGcOMqAWBSCoex23cZ6iNWxD76GBtzZFqfMVHigvL/k3Bt7UkwXQHLZ3BD8CWcd
 ytB2bvjJPhmDm3OrzXGULnOX9Kido2hJ/DFt2Wfi2eCokXLCP7QCKwUhFZj2iKN3K5WS+2JOacO
 So8cTh39uBnfqOXN4exT18uiO6h124qo2ANCVtDk9tQRTPderFoXcTErXU8ESPtd6w8Z8eawJoi
 dydY4j0O3dAL+oX+K3hAhqdFdVYQIva0jot6N7vbAR7LG84Z49KnXiTVy903qk4pa+jftmD7wOL
 ejxI6qVvY89+CRR3YYrf/4CoXJX7HDsuOJx8I49u84Jll3/JuDcGLl1/Cg+1vBaND0eB6fpVjx+
 x4BoIohax7tUq39iyA3XyIJAUweZKDNu0QBiTXxQWkdXZEA9DZIVvSiSv2GEtDxUhizeXwh1FrT
 QFmkJBkJPNeAEd/OecShQTl7yvFoAGGUn/n2oiH1SMjXQs/0lyrMFPdkS8SO/gh3HLpgNuMryCj
 Rt0MEUZfYWzU150+1Eke9ZNRtVpqy6QJ0o8Qxqu5yAMmwsQmSrOu4/9s6g5nnaXBw2YDiZVVh6V
 1wPLewj lwH1uSig==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcpy() in bch2_bkey_append_ptr() is operating on an embedded fake
flexible array which looks to the compiler like it has 0 size. This
causes W=1 builds to emit warnings due to -Wstringop-overflow:

   In file included from include/linux/string.h:254,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/radix-tree.h:14,
                    from include/linux/backing-dev-defs.h:6,
                    from fs/bcachefs/bcachefs.h:182:
   fs/bcachefs/extents.c: In function 'bch2_bkey_append_ptr':
   include/linux/fortify-string.h:57:33: warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
      57 | #define __underlying_memcpy     __builtin_memcpy
         |                                 ^
   include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
     648 |         __underlying_##op(p, q, __fortify_size);                        \
         |         ^~~~~~~~~~~~~
   include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
     693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^~~~~~~~~~~~~~~~~~~~
   fs/bcachefs/extents.c:235:17: note: in expansion of macro 'memcpy'
     235 |                 memcpy((void *) &k->v + bkey_val_bytes(&k->k),
         |                 ^~~~~~
   fs/bcachefs/bcachefs_format.h:287:33: note: destination object 'v' of size 0
     287 |                 struct bch_val  v;
         |                                 ^

Avoid making any structure changes and just replace the u64 copy into a
direct assignment, side-stepping the entire problem.

Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309192314.VBsjiIm5-lkp@intel.com/
Link: https://lore.kernel.org/r/20231010235609.work.594-kees@kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3 - replace memcpy with assignment
v2 - https://lore.kernel.org/all/20231016212735.it.314-kees@kernel.org
v1 - https://lore.kernel.org/r/20231010235609.work.594-kees@kernel.org
---
 fs/bcachefs/extents.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/bcachefs/extents.h b/fs/bcachefs/extents.h
index 7ee8d031bb6c..8c09c527fc4f 100644
--- a/fs/bcachefs/extents.h
+++ b/fs/bcachefs/extents.h
@@ -632,6 +632,8 @@ void bch2_bkey_extent_entry_drop(struct bkey_i *, union bch_extent_entry *);
 
 static inline void bch2_bkey_append_ptr(struct bkey_i *k, struct bch_extent_ptr ptr)
 {
+	struct bch_extent_ptr *dest;
+
 	EBUG_ON(bch2_bkey_has_device(bkey_i_to_s(k), ptr.dev));
 
 	switch (k->k.type) {
@@ -641,10 +643,8 @@ static inline void bch2_bkey_append_ptr(struct bkey_i *k, struct bch_extent_ptr
 		EBUG_ON(bkey_val_u64s(&k->k) >= BKEY_EXTENT_VAL_U64s_MAX);
 
 		ptr.type = 1 << BCH_EXTENT_ENTRY_ptr;
-
-		memcpy((void *) &k->v + bkey_val_bytes(&k->k),
-		       &ptr,
-		       sizeof(ptr));
+		dest = (struct bch_extent_ptr *)((void *) &k->v + bkey_val_bytes(&k->k));
+		*dest = ptr;
 		k->k.u64s++;
 		break;
 	default:
-- 
2.34.1

