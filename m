Return-Path: <linux-kernel+bounces-21598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2248291A3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B4F28947D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DC52117;
	Wed, 10 Jan 2024 00:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSPXFFhO"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBD710F4;
	Wed, 10 Jan 2024 00:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3e2972f65so13371185ad.3;
        Tue, 09 Jan 2024 16:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704848088; x=1705452888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUAmEyvrvXUUYoLPkKlVlKT7WzgASUYWdOtqQSWK2Gg=;
        b=XSPXFFhO5ix4P9+SyO1DUbIfusqQND4TVsw+r57VOlvcJmFYRKjZlW4cOWKTu6N6FF
         exQ3dKlaJ5v+wDGT/xXf2rOjAR/Zykxxxndh1bVOPdZydQ2hfh4n+BLcFcrmYCnYnDJx
         PzHp8aU4y0PcsXLd9zhciMUPnvYeywDs6Cj6rF0pa+K5A3C64IjQdNdE6qJdgpQY4dWP
         GlggrvWix1XbheVepHhZTS+4+gAZ+K7sZ1RO75G51Wl6f7N4PlaYD32ssg9y8cqC84kF
         mu3z75UzCHSxzZof7a7q9dO/KBrsKr+uh7VYq32K52w+StXhmwj0LEIn+F2C7qzW04lj
         W8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704848088; x=1705452888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kUAmEyvrvXUUYoLPkKlVlKT7WzgASUYWdOtqQSWK2Gg=;
        b=OqZj6I6Hh7AWdmigFMoGJgM8lMG6u0KAruAUlP3owK0eqla3JylV2IH3PYf4vL7YlD
         KJP5qEHAOjhCfuDt0RjYqs5TIJBKLIW8JhSVHeW1rv9+w+qAXiBgIThBrKwCE0cDiUT5
         l67wie3Sc+1ZkdhmQvcANRSdpJgAvqj9Q+oUWe3HIV5ZYgezlGDqt5VKIuY9CUae7aLu
         DzQ4kWbhcffMdbnqVvVf5Xrf65SSW1rSlrcaEbjMLJ8DW5nSOfR60iOF0nxJiFSrlrK5
         NkE8M6dwxNn8IQqEqGsQA0Fckuk5Dlvr/SVos/LJQ3lFTUM5NWr831CNAxW6cvQahpMf
         zFIw==
X-Gm-Message-State: AOJu0YwZqNtN/Zy/LMe3mnyYsRPxAYg9h2cMGHlftUwZhJuQKZGMr+5J
	mwyMtpjc3d+b0hu1awSB8dM=
X-Google-Smtp-Source: AGHT+IEJePtVNNWUxJ7FN7Yu64O+pPupYhq1OEjqD1rlDBveArBfAeQmEXJLlZ6hlNffZ0u7k5dN7g==
X-Received: by 2002:a17:903:32c3:b0:1d5:4ba:c0d1 with SMTP id i3-20020a17090332c300b001d504bac0d1mr254711plr.103.1704848088217;
        Tue, 09 Jan 2024 16:54:48 -0800 (PST)
Received: from bangji.roam.corp.google.com ([2a00:79e1:abc:12d:b923:c723:30c0:8cd9])
        by smtp.gmail.com with ESMTPSA id t13-20020a170902b20d00b001cff026df52sm2396147plr.221.2024.01.09.16.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 16:54:47 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Steve MacLean <Steve.MacLean@Microsoft.com>,
	Pablo Galindo <pablogsal@gmail.com>
Subject: [PATCH 2/2] perf doc: Increase the jitdump version to 2
Date: Tue,  9 Jan 2024 16:54:45 -0800
Message-ID: <20240110005445.490058-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20240110005445.490058-1-namhyung@kernel.org>
References: <20240110005445.490058-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The specification says it's in version 2.  Previously it changed to 1
due to the mismatch with the code.  But I think it's better to use the
version 2 to indicate it supports the unwind info.

The version check code in jitdump.c only checks if it's greater than the
current version so old data with version number 1 should work too.

Cc: Stephane Eranian <eranian@google.com>
Cc: Steve MacLean <Steve.MacLean@Microsoft.com>
Cc: Pablo Galindo <pablogsal@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/jitdump-specification.txt | 2 +-
 tools/perf/util/jitdump.h                          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/jitdump-specification.txt b/tools/perf/Documentation/jitdump-specification.txt
index 5c3fbbbebf14..863b35d4ad4a 100644
--- a/tools/perf/Documentation/jitdump-specification.txt
+++ b/tools/perf/Documentation/jitdump-specification.txt
@@ -37,7 +37,7 @@ III/ Jitdump file header format
 
 
 * uint32_t magic     : a magic number tagging the file type. The value is 4-byte long and represents the string "JiTD" in ASCII form. It written is as 0x4A695444. The reader will detect an endian mismatch when it reads 0x4454694a.
-* uint32_t version   : a 4-byte value representing the format version. It is currently set to 1
+* uint32_t version   : a 4-byte value representing the format version. It is currently set to 2
 * uint32_t total_size: size in bytes of file header
 * uint32_t elf_mach  : ELF architecture encoding (ELF e_machine value as specified in /usr/include/elf.h)
 * uint32_t pad1      : padding. Reserved for future use
diff --git a/tools/perf/util/jitdump.h b/tools/perf/util/jitdump.h
index ab2842def83d..4e3f6702d919 100644
--- a/tools/perf/util/jitdump.h
+++ b/tools/perf/util/jitdump.h
@@ -22,7 +22,7 @@
 #define PADDING_8ALIGNED(x) ((((x) + 7) & 7) ^ 7)
 #define ALIGN_8(x) (((x) + 7) & (~7))
 
-#define JITHEADER_VERSION 1
+#define JITHEADER_VERSION 2
 
 enum jitdump_flags_bits {
 	JITDUMP_FLAGS_ARCH_TIMESTAMP_BIT,
-- 
2.43.0.472.g3155946c3a-goog


