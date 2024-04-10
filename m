Return-Path: <linux-kernel+bounces-139431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 398C28A033E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E8F1F23735
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962E7184132;
	Wed, 10 Apr 2024 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BfaHxowS"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7890F12FF7C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787839; cv=none; b=ChEdd+T4ru5gk7dKNtNM7v3v9GjNGEihM0ToJoPcic4DkQsTI9xB50vfxpY4p0BWV9bxR7TlmQYSziWhkEFI1BwarpbTMqc/gMEiilNyrKj9/3O63b/FpOCaX0NudOgjdnXqWQ9lMMnPBUKEZnCPvsNmolBvIgkjZNMVvVMtXaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787839; c=relaxed/simple;
	bh=GAU+2rZNqMkHZN8SbllEOZVUOsdEVBIYY2092Hb26Gw=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=A4t0tfegm74xg2IHlzv6CEqXJP5Zo2Cz3Y9NbNF5Pm/0XJBulvVe0OxxSgEboM1nyzgbmpsyRa/wV586XvrID9Z3mXcVl5Ay7YYCXJakOS4pJ4VBhdVpLIrFkR2uXlCDlee3GicNqiKwXEWw0sRx0YNe2fqhdDkNHgI5bCvcACc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BfaHxowS; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc693399655so12815229276.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712787837; x=1713392637; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B+F+2wBjMyMgvGwjkNxLfH9Fpi5N9urgZl/EZiGxcNI=;
        b=BfaHxowS1E5//epfMSK7QJAm+KTlwWeB6m13K0yCyWVWjci28Hhj94PO6mpAh80WJP
         OafXkaVuGZ6AjoJiM5hRyscG2AmmsH3wf60Etvv3PquCF09/q8J+1J1QC0bmG1i7H70p
         +UaWZYnm7/RYgJEpsPdMc94javziLvhRJRIxaZn+oyfpJcd6vTLHODMHsEXCtl9U1YPD
         5VQOJoB9UjUSgq7F8DE1YO1ADdgspGl4CpfvzhKP0uPsygxG4fvkxAaG7Hqg36qw2Dj7
         eiT1yCnuAdA5UtNuaZ+CyW5Bo9hoTAw4+Jfo0Lb9aauMAS+DoJjYzP/158VZ01SWNGb4
         NdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712787837; x=1713392637;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+F+2wBjMyMgvGwjkNxLfH9Fpi5N9urgZl/EZiGxcNI=;
        b=J05lOYJtRg8Jb+sTImmf7K9JfsbQ9EAjZgix29TFzjVghbD3eF7a1olrRuJUqcAKlY
         a75JaxWhIFtMg4vO8J3W/P+kuoEF5MAzvkh8q/0wRi369jSsfG3dyniIHWcPuYocZBUu
         uDzJ/MjPyqcBBkfFhgmAXIK+s7+THBE//wsZ14ggUmiPteDhztfxEo0RdFgUuriIGl56
         OJthj8Mpn6rCPh46n3bqPonoPpX/T14HTR6Q025M/IMb1G0eNl4HTYBWnMIbQWMeaif6
         C3EIOsSTzy/FWdpxPj0HhStOygBDJR9f6DylmJwK+2Pso0xaLZJHDlNed4KXmH5WDePM
         tXLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqw6wfx2jdS8XKbs9Hk2QdtBWV/OLp7UFkPjj2PKz0R+2cDtRpl2I8Izm7HyDxWvbwT+Af1jgX8VLvJmIytocfvDWcyC/kQm6ilwrx
X-Gm-Message-State: AOJu0YxUljOouA3O1gR/rlRaOnTjvPP7qAMJULMuniKk1GH7mCS0my6k
	/flZk32ynQV8X4XB1Iel3dEOeUOHQa3UORPvM9qzgd8H5k/2NT+I6Ys55Piua4PnRppo6xAsZRh
	MRGlhww==
X-Google-Smtp-Source: AGHT+IGZDqrCoL9XuzYc4FDvlUWPcnEFM/Imu3Vrs1s2cAZGxjT4+opbZnt7CdVo7ONNX0j/wcoCJo1xyqWX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ed7d:1d85:433a:d24c])
 (user=irogers job=sendgmr) by 2002:a05:6902:1506:b0:dc7:7ce9:fb4d with SMTP
 id q6-20020a056902150600b00dc77ce9fb4dmr1086916ybu.12.1712787837515; Wed, 10
 Apr 2024 15:23:57 -0700 (PDT)
Date: Wed, 10 Apr 2024 15:23:53 -0700
Message-Id: <20240410222353.1722840-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v1] perf list: Esacpe \r in json output
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Events like for sapphirerapids have \r in the uncore descriptions. The
non-escaped versions of this fail json validation the the perf list
test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 02bf608d585e..9333cc64c2ce 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -313,6 +313,9 @@ static void fix_escape_fprintf(FILE *fp, struct strbuf *buf, const char *fmt, ..
 					case '\n':
 						strbuf_addstr(buf, "\\n");
 						break;
+					case '\r':
+						strbuf_addstr(buf, "\\r");
+						break;
 					case '\\':
 						fallthrough;
 					case '\"':
-- 
2.44.0.478.gd926399ef9-goog


