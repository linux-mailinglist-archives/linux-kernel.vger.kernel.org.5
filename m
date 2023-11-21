Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E483F7F39A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjKUW5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbjKUW5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:57:20 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF5FD79;
        Tue, 21 Nov 2023 14:57:06 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5c19a328797so4134139a12.3;
        Tue, 21 Nov 2023 14:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700607426; x=1701212226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUB8aiMyKPdcNoGbVDTIzMhhz2GFj5TGi/+7tX7WmTs=;
        b=gMtgFjndQKrbuWk+cdt612u0wgegfbby+5+WhsNvo2LUFQwnOp0lUQPs2JAUPe2iSm
         i8oq2Vi+sslnQlabivkhKO12kZ2a2WkmotbsuV5wBoMZTr9sSn/d1Js4w6oQDiSYIngo
         eqbqUonWPMGNs3+b4WJolNR/DPEsG3eZm9qY6N739TKISHz0DLo+0jVTcPjY81+EKsZu
         dX8H7nykmIXB0MRz97Jk6oGgNNBan/rWmYsTCEoaIDA1HU78lSQLvOyHIwoaAWTNblh6
         ERlhbsAKjybI/TQcDyfZh5Xo+BkjIjucOuFWeSNQx+nPEduXqZZeSqXV84NcVG7fYqgS
         OYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700607426; x=1701212226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pUB8aiMyKPdcNoGbVDTIzMhhz2GFj5TGi/+7tX7WmTs=;
        b=LKaLBphJ0Ow+6rLaliJfxNL4yq3/i5YRQ8Bt/AqqrnkszN/q6dm9gPOfZzlUWrHrpJ
         K/Ct+VNpKrx4RHqg8KrynlRrgqeJ/HF/H82O7Dj/m6FKnccOFMXSst2HTuc+9vpbh1Ak
         WywP3axm87c3dOz+oG5/5C3tQzmGaBkfq3fszXRSBmaH4kFUB0juXSjclyvN/UXk3Ijy
         7oXGosUTdviIuVOlbcUuLwlKC+BLbv6WK64fOnF6+7HYdmVWQjXUEArGkcNhlXvzJSNL
         kJ/7wDVhwOIisz/klvbbxreiXjDGV08YhtBXjEWhKGsL3GaqyYQMCKQCPp+1PKv2Q3rw
         AGfA==
X-Gm-Message-State: AOJu0YwElfQDwWlMmKasSlbHRyvjSScC14WefRaGSGSB7IoryweaACKG
        8uH0ZqL9LQ4ihX6YX+3aH1w=
X-Google-Smtp-Source: AGHT+IFOoKR4bAPmPtEg0J1rk7cUJZS6KvmsJJw4OiZCu5FrFRTeXRbhe42UStdDdc3UbrVjO7RALA==
X-Received: by 2002:a05:6a20:a129:b0:18a:e262:d15 with SMTP id q41-20020a056a20a12900b0018ae2620d15mr579453pzk.54.1700607425835;
        Tue, 21 Nov 2023 14:57:05 -0800 (PST)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:7377:923f:1ff3:266d])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709026bcc00b001cc47c1c29csm8413189plt.84.2023.11.21.14.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 14:57:05 -0800 (PST)
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
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 11/14] tools/perf: Update tools's copy of x86 syscall table
Date:   Tue, 21 Nov 2023 14:56:46 -0800
Message-ID: <20231121225650.390246-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231121225650.390246-1-namhyung@kernel.org>
References: <20231121225650.390246-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
        [0] = "NORMAL",
        [1] = "RANDOM",
        [2] = "SEQUENTIAL",
        [3] = "WILLNEED",
        [4] = "DONTNEED",
        [5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 2a62eaf30d69..8cb8bf68721c 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -375,6 +375,9 @@
 451	common	cachestat		sys_cachestat
 452	common	fchmodat2		sys_fchmodat2
 453	64	map_shadow_stack	sys_map_shadow_stack
+454	common	futex_wake		sys_futex_wake
+455	common	futex_wait		sys_futex_wait
+456	common	futex_requeue		sys_futex_requeue
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.43.0.rc1.413.gea7ed67945-goog

