Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D487CB541
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjJPV1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPV1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:27:47 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911CBA7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:27:44 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57b67c84999so3328009eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697491664; x=1698096464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hPgMlBTFx+2I9248zEaT5u1u+rLOVrvQ5zC0LJfwWQ0=;
        b=SyF8p1sIKoQrRUTRh2B/L+4Sp0wytVvB7HernGTi975VcWIE9ml0f93H6nv67nbAKw
         9YI0PQPayOpDkaRrxlHfBNQLEeRpu+RfifMWJ0lEbmZJWJJG1qKccfvPhoufh1rIPlVO
         IOuKXrFwzd5Ny2c28x5IguUtoe0XaZLn0cK6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697491664; x=1698096464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPgMlBTFx+2I9248zEaT5u1u+rLOVrvQ5zC0LJfwWQ0=;
        b=b0GVsFn8T9cre7MDukSFUzyVQxgA/jfXAg3q/R+ji4Irjore2Y8U/moMRku8kWnbPA
         hM+EGihNio05LYUoyhYh2Wt3RSERbU9KIcVy6cHqrMl9ebE0QO3r/JC0jSwASqBHlsaq
         lsGGwVjVvLpC6CHC4F2PevCBQ9aBXXZMwRftPv660wnNQlZRKIYb7ETANtf/RIot5j1u
         f73zbNah7EDNAM05BkqJytf+9kBX29yKiP7OYcMkriea8nvyCQ3ZNlbDDwSAdPvS3eJg
         aT2J742nLpgUwX7V4D2h7hLxSlTCPmVRFXkKgdqwWeIgPOk9n3Q1ScSE6HqtwBQBj0XQ
         QrIg==
X-Gm-Message-State: AOJu0YxeJeQunCnVlspFcKFnzVPphAVGy2KZkbpNV1jRih4qEe/frI3x
        7HsPn1AgAeWy8Tuj9GchNDJwZZDxl/KCnZpVv2k=
X-Google-Smtp-Source: AGHT+IHrSWO54ZLXcXmETNNfpII8DusFKgDllyqDq/ZSWmhM7sp40S+wVHfc12SJxO/WdnVmkePGgA==
X-Received: by 2002:a05:6359:5ea0:b0:166:d379:93c1 with SMTP id px32-20020a0563595ea000b00166d37993c1mr587200rwb.20.1697491663843;
        Mon, 16 Oct 2023 14:27:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78e86000000b0068fd026b496sm30364pfr.46.2023.10.16.14.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 14:27:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Kees Cook <keescook@chromium.org>,
        Brian Foster <bfoster@redhat.com>,
        linux-bcachefs@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] bcachefs: Refactor bkey_i to use a flexible array
Date:   Mon, 16 Oct 2023 14:27:39 -0700
Message-Id: <20231016212735.it.314-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3237; i=keescook@chromium.org;
 h=from:subject:message-id; bh=ZFVX4Et7GPEikNCf0Ix6A5YSoE2Mfb24IGbRkCLbcNc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlLarL3fT0ZlYwcbjnSnTWM77NW/ozenkBQEVl3
 aupJJB3LnOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZS2qywAKCRCJcvTf3G3A
 Jse1D/9vmoEVewSjtb1/R8Ur1UqM8PbdX33bLxi16QrR0H+U/mxcWnnEzugwd0LqR/HJBaNordc
 w/uC/7a8P2f9nW9QhXS6j2wo3U59Kexpsd5S60GxyiLtEwJA51JOEM/BHu5AreNoUPVivpINC0M
 gY+EsSE7uvNa0Wm+ZF22AmwcY2pTf+qUyy6uK6tPsaCevoMDKpFEbgxVp2MkHaUfOCb7hNlj+r/
 lDmfxxjxpW2IqKxQnsBbnjL9Bdq0+9Bw3j9K6Mi8s8ElzAZy4v334yhHKxuF7fm+8vU8S+oPIJ1
 16XKru1DChGWe8pxxL2Li1YuXsP8F1BkGwBdWpfcWLVeP08Fat82dEWXYfaBx6f2Xrb4kVGPbny
 LhvjATPEbg2T2q67a9IfEEMt7eCqcYR9uvd+D4zQkby4rYdx1eSawPu6QM286GD/wift69yoAXl
 OdbGYJIdw8Wk8Z2FBr3OunPOk1yKD8QrVUoV3fdPxBgIDLtqxdNAQTzosswze4be0ozl2oXYf+s
 Uy/zjenXqlJT/hNQT1IcTU2UvriDo+0V58793WA77lHpT9+Zfps2oL911dWUDMKXAukmVbOLR4P
 T0Q3FE/nRDAYEQCOTCxskheCOAFJtdykoWuhGgSgzcvqWGTGMR/WpHj0JK2P7T2GRovBLTMo2Ft
 n0ZmyMs Pc1bRs0A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcpy() in bch2_bkey_append_ptr() is operating on an embedded
fake flexible array. Instead, make it explicit, and convert the memcpy
to target the flexible array instead. Fixes the W=1 warning seen for
-Wstringop-overflow:

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

Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309192314.VBsjiIm5-lkp@intel.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2 - Change flex array name to "v_bytes" (bfoster)
v1 - https://lore.kernel.org/r/20231010235609.work.594-kees@kernel.org
---
 fs/bcachefs/bcachefs_format.h | 5 ++++-
 fs/bcachefs/extents.h         | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
index f0d130440baa..cb1af3799b59 100644
--- a/fs/bcachefs/bcachefs_format.h
+++ b/fs/bcachefs/bcachefs_format.h
@@ -300,7 +300,10 @@ struct bkey_i {
 	__u64			_data[0];
 
 	struct bkey	k;
-	struct bch_val	v;
+	union {
+		struct bch_val	v;
+		DECLARE_FLEX_ARRAY(__u8, v_bytes);
+	};
 };
 
 #define KEY(_inode, _offset, _size)					\
diff --git a/fs/bcachefs/extents.h b/fs/bcachefs/extents.h
index 7ee8d031bb6c..896fcfca4f21 100644
--- a/fs/bcachefs/extents.h
+++ b/fs/bcachefs/extents.h
@@ -642,7 +642,7 @@ static inline void bch2_bkey_append_ptr(struct bkey_i *k, struct bch_extent_ptr
 
 		ptr.type = 1 << BCH_EXTENT_ENTRY_ptr;
 
-		memcpy((void *) &k->v + bkey_val_bytes(&k->k),
+		memcpy(&k->v_bytes[bkey_val_bytes(&k->k)],
 		       &ptr,
 		       sizeof(ptr));
 		k->k.u64s++;
-- 
2.34.1

