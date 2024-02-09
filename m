Return-Path: <linux-kernel+bounces-59962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5878684FDF0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090991F2217A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C8512E52;
	Fri,  9 Feb 2024 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CkryVHF2"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C702DF6E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511813; cv=none; b=AqNHTBKtQiiSsNGOBHXUZsdfbufoq2BrCqtOLhbMusqExKitn4Lx2hFFRIH0SL9kzK3XVMbtNaA8W3XMGThdm4VYcDTCGTqx0ggFBFSZLl4eNSlB+2lyUhIX6e6GV3v/ex70i2q5Xum7LLCtHSQoRgNRLTSugD2N+Tek6bB2umQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511813; c=relaxed/simple;
	bh=dTqv/ElAR7jF9GPXK0vEBpGKVQd4I2e0pjKYqFqLypE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ER9G97AAdfd+BlGTSdbYymOGHcQdElp3oxE6+nMzRINj+jy6n1+FbqTD/ccdK//NGF29tTedp2fhrP+bPsNuKngqQmMiMfSUGQLg68zrk5Vht5vnSOxwsUnBcSTYMZzVmX6caH2NoUnheVPB+c5boWtStOjUfnsQ8j1LOrBVb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CkryVHF2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60482420605so20747827b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 12:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707511811; x=1708116611; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMNJNpeOWO5Ji5jMn6B3E094OE7OuzEg0rGAuJgRsjI=;
        b=CkryVHF2T+fABMveDwIW0pX1m6Jt6eszA1YExxr+Vi+GREEbKypdu2+iXoYH8H+/k9
         dJJ56Vfmbl+PQAHxZevvCzchOqeCVDW+uXWDjGzpbTmWTalAdMA8YEd6Cb0spdamrUUy
         zto7tF8d7KVWGZQZN+xM2DFluk8quqrKdv9pRV0ZTG2xyO4eHYC6x7ggzQgwRpwMv9Lv
         Nh3dpXsj+mFJXa+en2FNL7HykT2pe2bTDm9Nc1nF1skPmgvaUyMNacNog09K3tK2Oiji
         KGMgF5fvHUk8UfedHofkYClcKjFzVCh0BHfaYjC6/Xja9EqKKdxF0ENPrD9BulL0u593
         QbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707511811; x=1708116611;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMNJNpeOWO5Ji5jMn6B3E094OE7OuzEg0rGAuJgRsjI=;
        b=FE6DaZhGQiOFr5TD/F1ToumeLxNxnS1ngR9tDiuK7qj4WZ8On+I2YYxJOox8U7eChV
         DuM7+NuRZIbHvqiuTQxydr5zkeikJY65Ixyf7xYx/3Evfj3hWU5IXcZ9eXgvO1qvVsdN
         F1mtASuZQZSWDHu8QsIvGEnfqCAf7AF8b2TR4z/jJgdy5QaVpYc7dHSS77nZ0+v5DkeH
         4wHwnVLyFMkeri7y4LG7qHsVhhia8oPx1CGed1US5H28MBtIPAYRvTDaU89MvbCKq/4K
         GXjGP+vWuZR4AG8rm2x8mVsBHA7Z+TfDXyx1BRCnfe47sylwCCwZPbZR2Qu1k705dXry
         q2TQ==
X-Gm-Message-State: AOJu0YyGgSvI7w5SBZMa2K1w+kgMnhaGMfb0PJozQ7ztatI3n3g4vSFg
	B35sUq1ZGBWXBJeWjmqtQOvX477bGBbEqhrFCPRBZ+nE3HhRogCLP6nsyxGjlFBoLTSaqoGp0l4
	QKE7hlQ==
X-Google-Smtp-Source: AGHT+IESHNgzcmy9Dgs8JyJG8x+qRNOJl7CHBKaOnWWZ6rgcH4i+s+zgGZxx55zQzzsJPt1MajG6rFnGg8iV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:877:241d:8c35:1c5b])
 (user=irogers job=sendgmr) by 2002:a05:6902:1007:b0:dc6:e20f:80cb with SMTP
 id w7-20020a056902100700b00dc6e20f80cbmr5981ybt.3.1707511811233; Fri, 09 Feb
 2024 12:50:11 -0800 (PST)
Date: Fri,  9 Feb 2024 12:49:44 -0800
In-Reply-To: <20240209204947.3873294-1-irogers@google.com>
Message-Id: <20240209204947.3873294-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209204947.3873294-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 1/4] perf expr: Allow NaN to be a valid number
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Kaige Ye <ye@kaige.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently only floating point numbers can be parsed, add a special
case for NaN.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.l | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 0feef0726c48..a2fc43159ee9 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -94,6 +94,14 @@ static int literal(yyscan_t scanner, const struct expr_scanner_ctx *sctx)
 	}
 	return LITERAL;
 }
+
+static int nan_value(yyscan_t scanner)
+{
+	YYSTYPE *yylval = expr_get_lval(scanner);
+
+	yylval->num = NAN;
+	return NUMBER;
+}
 %}
 
 number		([0-9]+\.?[0-9]*|[0-9]*\.?[0-9]+)(e-?[0-9]+)?
@@ -115,6 +123,7 @@ else		{ return ELSE; }
 source_count	{ return SOURCE_COUNT; }
 has_event	{ return HAS_EVENT; }
 strcmp_cpuid_str	{ return STRCMP_CPUID_STR; }
+NaN		{ return nan_value(yyscanner); }
 {literal}	{ return literal(yyscanner, sctx); }
 {number}	{ return value(yyscanner); }
 {symbol}	{ return str(yyscanner, ID, sctx->runtime); }
-- 
2.43.0.687.g38aa6559b0-goog


