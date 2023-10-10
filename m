Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3129F7C459E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344191AbjJJXmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343880AbjJJXmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:42:51 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5CB8F;
        Tue, 10 Oct 2023 16:42:50 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68fb85afef4so4745969b3a.1;
        Tue, 10 Oct 2023 16:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696981370; x=1697586170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EToU3lcbSlwy9fy/0jMo1G59SHr9e1KfON9mi7yvsw0=;
        b=mS9MiL7TredmItdqwUTiYBwM2FXe0U8ZCbgIUzFg9NtLouwoRRK3uFl9SlxfAvobNF
         De6FS+S57eEWKs9+zIGhnFxy47KUX7toFdjAgceyvvj7qr/1d0GNKbu+TujB2nC6FS6l
         Bg56U/zjkKds8a5G4Vts0SqEbSYVkl7r8Z+igLPF200DYhpdirePsuZ1pH/1eOM39VWj
         qsMUl723vMjqGW4Nv50pG4IqPPiyNXizgsYvQkzmD5bjqzQ01lrSzfILGRuPnwkh6mIM
         +Z+aw741V0eAWsdia41vrjBEGWIriCOKBrqe7Ix+Ka6qPnF3QDyhA7ZfmOTXL4eE72o7
         R4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696981370; x=1697586170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EToU3lcbSlwy9fy/0jMo1G59SHr9e1KfON9mi7yvsw0=;
        b=OKXxA5Cp/P6+9xRgf+biJl9u51Ro35tsQSNbbN//i8f3xrL2tkPPguFQIOl6NY/aaH
         XqwAz+rOo+UNDF2xg90WxGa1q9/4VeJU+4kDhkvg8jJQsmV+3KwMORg5iWOa2nklo90N
         8CiUczvJlmdk0TQjY1XTBhAYVi/PdHaI0zFwcSu8TY4NWy1T0b4LkCc4F424DpA28p9F
         JZpfS9hkSWCC/cNi4KhZcLnfoZtTxVzRdJjcsRq8zEJydk5MK0abMPIurQ/XksfU7rpO
         Yl0YqG59yTs+aTprAlviJgWRXfJlr38Own9itkCroH/gm0a0yLb6DClOFTNFxWjdSdnc
         sVpA==
X-Gm-Message-State: AOJu0Yx7rb+lBNdzgAH8FcMMrJn26Ei6FFTh8Qf3ioR8j7DN5rCPrvXZ
        vZAasKNLw6YjauMxH+dWtJoKffZDyUw=
X-Google-Smtp-Source: AGHT+IGu+0+ZHZ9VhVStWuztl/a8lzxt0oDn4QWcUF/L/whuSBgOn+oTwj+AOI0uz1bk7Ajof/RD3A==
X-Received: by 2002:a05:6a20:da9d:b0:16c:b5be:5f6c with SMTP id iy29-20020a056a20da9d00b0016cb5be5f6cmr12546254pzb.54.1696981369486;
        Tue, 10 Oct 2023 16:42:49 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:f301:6279:8c99:9912])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f54d00b001c61921d4d2sm12420404plf.302.2023.10.10.16.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 16:42:49 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        oe-kbuild-all@lists.linux.dev
Subject: [PATCH] perf tools: Do not ignore the default vmlinux.h
Date:   Tue, 10 Oct 2023 16:42:47 -0700
Message-ID: <20231010234247.71604-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <202310110451.rvdUZJEY-lkp@intel.com>
References: <202310110451.rvdUZJEY-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent change made it possible to generate vmlinux.h from BTF and
to ignore the file.  But we also have a minimal vmlinux.h that will be
used by default.  It should not be ignored by GIT.

Fixes: b7a2d774c9c5 ("perf build: Add ability to build with a generated vmlinux.h")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310110451.rvdUZJEY-lkp@intel.com/
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/vmlinux/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/perf/util/bpf_skel/vmlinux/.gitignore

diff --git a/tools/perf/util/bpf_skel/vmlinux/.gitignore b/tools/perf/util/bpf_skel/vmlinux/.gitignore
new file mode 100644
index 000000000000..49502c04183a
--- /dev/null
+++ b/tools/perf/util/bpf_skel/vmlinux/.gitignore
@@ -0,0 +1 @@
+!vmlinux.h
-- 
2.42.0.609.gbb76f46606-goog

