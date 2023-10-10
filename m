Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B6E7C45BD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344244AbjJJX4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344228AbjJJX4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:56:18 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D708794
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 16:56:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-27cfb8442f9so482233a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 16:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696982176; x=1697586976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SdPr3RKtwxQhWuHnqZTk9V1Z28AKlq2nPJ/l3gwUyjE=;
        b=m427+hn96EjA9k673xw/YA0i4csQFSbT/Hq8f9wirAjqlOyW7qB17FdXINXZ9nUwq1
         NYj6f0XnuvwhsidixeHHgvqdNQpaOkpyGrmQsYuuyha15E9j0A7t5KMgRjJDVfkqba+6
         GX0iFcxYS4yicR2YLmE/TbWHqP1HlIpUkwjYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696982176; x=1697586976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdPr3RKtwxQhWuHnqZTk9V1Z28AKlq2nPJ/l3gwUyjE=;
        b=aznihZX0AWj+MzLkLIV5nfNnhm+udLNbEDT0xgVYijKO+c0YjTiA0xjG6vATuv+uAP
         XAFA/xcyrLeYS4ET2SqUdZ6PkxIiej2xptZcmRPZl3pug6w7SygJpmP7XrqJbcxUaRpy
         TjSJBOJ3z7VYLhZtR0EoblvDAMTvVlEEThm5j/zg8YvEne9Z8km6Qm9mfrSQ2jNRpIjn
         qh0O82lJlB8x33cvMyBdd5TC3PodJmIqlZVSkQ1t2A6PUnRtLS/VmJtK092Nq7kMsQNJ
         oNedNaOyljw1T+rst45wZJOlrzUEcKawuoZ48F65tLbRXcYHNUlF+nBlIsxB11IyN5fy
         EN3Q==
X-Gm-Message-State: AOJu0YzmI5fAO4ljgInnOi30GcLrz/Kg5GepkjkbkjESHrIEMPX9H8h5
        OruvP8KQ3K7be4dhi3xPUmaL8w==
X-Google-Smtp-Source: AGHT+IH+WJmRWraSjOLt34ZIr86Kq/Dgp8sL08aDaqHDiZLwRxz3/4ptFPF/mx7+YDgup2PbusVYBA==
X-Received: by 2002:a17:90a:d804:b0:273:efc0:33eb with SMTP id a4-20020a17090ad80400b00273efc033ebmr14987050pjv.14.1696982176352;
        Tue, 10 Oct 2023 16:56:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fa9-20020a17090af0c900b0027360359b70sm12746037pjb.48.2023.10.10.16.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 16:56:15 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Kees Cook <keescook@chromium.org>,
        Brian Foster <bfoster@redhat.com>,
        linux-bcachefs@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] bcachefs: Refactor bkey_i to use a flexible array
Date:   Tue, 10 Oct 2023 16:56:12 -0700
Message-Id: <20231010235609.work.594-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3104; i=keescook@chromium.org;
 h=from:subject:message-id; bh=NfdMvLiG7AP1UedLusFnQqnFA5ZiezwfWaxIM+i+tRA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlJeScSUyz3NZfxL43a/8LlJ7zzNz0b3ul121Gl
 upxtR3bHn2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZSXknAAKCRCJcvTf3G3A
 JoNbD/4whEZUDyONG/LAxsYi0gic1AeiW2Z37d9rJL7Rfib1H9dD+bou+gfPycZoOl1o5d0cZCY
 bCtHhYf5PFfCLaRRmUGRKtfc41Wgc1b3VFfadHluT7vP26PMUnNlvw7NFYJvT4/LDXDBOML20YI
 iYnbwgq/WlTapLBDULe9PutZ67M7Y4f6g56i2801W0pQwW0v1ue08ShxGEvHdCFLwJMYTHjFfJi
 27ylDaeszwHHC80vtS9UAnrpllO5aXideMB2wAg55qT8J+LoxVqoixEcJ9vwiK9p/7bn78iJjWS
 uYDQV24ERXP/K3lHSAuuqhi3PMGtiCBvyZvI0aUZmV0buzqlcN4AuAEjBhrGlxRoil/KJrPKfbI
 UEj7HsIliQ5cCGXEXwaJPzifXGa10MgWAJSBlOUfpzkUMrwVyMDW7MwRkayQ3M8bOAnhLFYqnq1
 Io+kKq29sLs+DBo9vTApgL4Rod2o+uFrF2EIDI/jrl+6pqBjxojxCzNVgH7AZzixKBFq1VSjw2e
 e9Ff+cEZXZ878o+k81FTz42FxT+DT/zlqiD+/KGPhOnj5J5LLXILogAps2eLpfi2B5fm5Ty4Hbj
 GsfXuU6y0XIX4wDT8xmB+O5SzFTAaDeSvb/Td4xmnQmqhxaVyonefLCpkR+kVcyX6nDGtEo6ZV4
 hPufHRL lXjHsLzg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 fs/bcachefs/bcachefs_format.h | 5 ++++-
 fs/bcachefs/extents.h         | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
index f0d130440baa..f5e8cb43697b 100644
--- a/fs/bcachefs/bcachefs_format.h
+++ b/fs/bcachefs/bcachefs_format.h
@@ -300,7 +300,10 @@ struct bkey_i {
 	__u64			_data[0];
 
 	struct bkey	k;
-	struct bch_val	v;
+	union {
+		struct bch_val	v;
+		DECLARE_FLEX_ARRAY(__u8, bytes);
+	};
 };
 
 #define KEY(_inode, _offset, _size)					\
diff --git a/fs/bcachefs/extents.h b/fs/bcachefs/extents.h
index 7ee8d031bb6c..6248e17bbac5 100644
--- a/fs/bcachefs/extents.h
+++ b/fs/bcachefs/extents.h
@@ -642,7 +642,7 @@ static inline void bch2_bkey_append_ptr(struct bkey_i *k, struct bch_extent_ptr
 
 		ptr.type = 1 << BCH_EXTENT_ENTRY_ptr;
 
-		memcpy((void *) &k->v + bkey_val_bytes(&k->k),
+		memcpy(&k->bytes[bkey_val_bytes(&k->k)],
 		       &ptr,
 		       sizeof(ptr));
 		k->k.u64s++;
-- 
2.34.1

