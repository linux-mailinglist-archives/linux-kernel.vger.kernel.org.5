Return-Path: <linux-kernel+bounces-60613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8231D850775
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83488B20CB7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B441364A94;
	Sat, 10 Feb 2024 23:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mVuHWRt4"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4930F63503
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609083; cv=none; b=LaoQVlxPVZSKQAtQ3cqIkbnRVrVSsxQTDPOJ5PioFSywp/z0yyQGmZf7wdd9EVgKGcfHQ5h93VhFJZat6aQZYssaDqvctaJ8DXG5HKXhzIR98VQUZpQemy8byayIOy4dldVKgJaJ5iEhn1PbaUznk8P/QcLCZZW0ycGhoFfhMNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609083; c=relaxed/simple;
	bh=Eb0O+yG3cASWAUgAki6e+Q+mBl3FxWbfK/o4/1Bntgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXyZLBKGccIArOci96MkErmtjr+s/8O/5i0GQvbQv90+zdtJNHzAYcbFXaJKduUL5uRFefbcDIxTCMQS2JSEt4sPM/LNICS3E/6AdcJz1vBkbvTkFnbiPrtsUFG71drRO/MMGyEp0nIgmMla4Ijmz+L2TcBnINZdXOk35PFwQaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mVuHWRt4; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d0cd9871b3so28962561fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609079; x=1708213879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5K6yqpYI+XlAR2tTr9L+vlvA6I/X8z92c+InJNhe9bo=;
        b=mVuHWRt46n8jwzYw2+fAqbeawf6r5rjeycnB+sT3UkEl1LqWBnbRTKqx6ZwIHPlCa4
         eXI3E29Eoubmt+jJvwReZzQ06K0Odhgcy6oMzsdFsLl8GBdRvJ6P+FwKY135VITlu32B
         bdzm2sv1qNcXfAt584B2zlu3yOIol7tIEhII4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609079; x=1708213879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5K6yqpYI+XlAR2tTr9L+vlvA6I/X8z92c+InJNhe9bo=;
        b=AP3p64nO24LTW35D6A5eyY9+F4M0/ktIxukYPARwxk96zMw3JxfgurpfIo28ya3K2M
         6oSmzQEFJNqF8T4ihB7mNd4asnIxRvr8HqkgtQ2cgxLCgotOJWiM1ZGXXI4WMCKAjBWH
         rorlcAKgjwCIj1uFWOmXEy/kePi/hBDov3zCpIsbcC7bL+9pcoEk/YRCMihYRWhwscXs
         yaX80OE7lF0IM4uNatkZNkVzs6xPqcGGe7R7aRHtJJyhF/RYGyqm+YMjXL4SblMOuotw
         kI0kqhahAIZdq64qU341OPfxF7ttXFnbDBNv6VXWZhS5zefcoBkfoqowBP/+6cZczmO6
         iw1A==
X-Forwarded-Encrypted: i=1; AJvYcCVfdnCQPVQr7gilOoFZ0UsGE2JSkBMtP93AksgOW5ubduutZtFaXhCnKZNwxox8pGGKVnrNiBFv0TKH6/tg99rLcOUG8sQPwhupocdT
X-Gm-Message-State: AOJu0YwyZ2LEB/Hw+Taxl78T9aIR8zKUBp/ZH5/bC/o/GpfkcXNWszkK
	VH7Ur7t3PRZicAL++y4mqldg+KeaXQmNJnGoRlRAGTGfMSVYAj4+ReLQeO2s
X-Google-Smtp-Source: AGHT+IHo9+rl4MNm0PdlYyl5NSp4pGVFkPuTzx8AD5BNH/kKYJ8JzsKk5cBxNvfDehX4m6dD920t3w==
X-Received: by 2002:a05:6512:3ef:b0:511:7303:7ddd with SMTP id n15-20020a05651203ef00b0051173037dddmr907178lfq.22.1707609079610;
        Sat, 10 Feb 2024 15:51:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGBVCu0vK0QqCmJjoomO3zmXV/S04S8NcctTEN+wop+TRxVlhvW1Ey+W/HOAnw7liXiw03xKb07g6385AUX0mMam/1kl8kbfTDkT2lskluOirb1cfgS6jf3vSliAsEnWzqZKfHByHsK9X+TS1NJL9WDcnaEZdHbBBiOpwYyK5xWvxMUiZGC6Eq8amkUSUdNBQDso2MDztT/6MZpd2Hwic8yaX6sRNHBBXpDkWstJda6fiIbtY9HRxSZYVA8sOQguUuF9iOFEdk45wgDga4J3J+gdHzXruGWtrcg7CQWfOox9MwV1L6pfFn0CTqL6T7CGzK3wQXjYZRBaB/h0bVgDqeH0MuK7cl6tI7dWriVWxDCg0wutOPaXpOIyZuUcLbDxqVbHcd8qEj0x6QJWSVVJaNvszjGet8cegWBbW5UigCnudydUtFet1A2MLJwbZUsQCUX/F+3ZPQzKQObnXEwxtO0Qcf5+50WHwSlPh/K9V6KrKo4TZPtnAVqOwgSex6/aH67U9BzyyXgKf/BNgX/Wroc83k35vKd7/IISPfHQZ6W5kv/g7bb9Irsfwvnj7AqEP5g51n6yElNd6BcSa/DtLgIgjiI+A55YmoogPaGaG3DspHnA==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:51:19 -0800 (PST)
From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
To: Jason Baron <jbaron@akamai.com>,
	Jim Cromie <jim.cromie@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Guenter Roeck <groeck@google.com>,
	Yaniv Tzoreff <yanivt@google.com>,
	Benson Leung <bleung@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	Sean Paul <seanpaul@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Simon Ser <contact@emersion.fr>,
	John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	linux-kernel@vger.kernel.org,
	upstream@semihalf.com
Subject: [PATCH v4 30/39] dyndbg-test: fixup search-trace-name help
Date: Sun, 11 Feb 2024 00:50:00 +0100
Message-ID: <20240210235009.2405808-31-ukaszb@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240210235009.2405808-1-ukaszb@chromium.org>
References: <20240210235009.2405808-1-ukaszb@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jim Cromie <jim.cromie@gmail.com>

The recent change to do whole-buf search (not just single line) had
the side-effect of printing too much $output, which hides the
information in clutter.  Print the search pattern instead.

Also add -v last arg handling, like in check_match_ct().  This lets a
single caller enable verbose output, to see the trace-bufs content.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index a48cb57aa5cb..d1f447eef4c0 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -159,6 +159,7 @@ function search_trace() {
 # $1 - trace instance name, 0 for global event trace
 # $2 - line number counting from the bottom
 # $3 - text to search for
+# $4 - optional -v to see verbose results
 function search_trace_name() {
 	if [ "$1" = "0" ]; then
 	    buf=$(cat /sys/kernel/debug/tracing/trace)
@@ -179,8 +180,9 @@ function search_trace_name() {
 		    in line '$line' or '$buf'"
 	    exit
 	fi
-	if [ $v_search_trace = 1 ]; then
-	    echo -e "${MAGENTA}: search_trace_name in $1 found: \n$output \nin:${BLUE} $buf ${NC}"
+	if [[ "$4" == "-v" || "$v_search_trace" = 1 ]]; then
+	    echo -e "${MAGENTA}: search_trace_name in $1 found: \n${YELLOW}$3 \
+		    \nin:${BLUE} $buf ${NC}"
         fi
 }
 
-- 
2.43.0.687.g38aa6559b0-goog


