Return-Path: <linux-kernel+bounces-60602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB1785076B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293011C21AE1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63B46216E;
	Sat, 10 Feb 2024 23:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="InQ0Ny3W"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9813B61690
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609064; cv=none; b=c6SsVd722LEuFaqN0OqREyI8VMPuceF+L4yTLiNkyiaRWaTMhVXhPg76QOemJVNVL2m2pP17cGm2Pp//qM6yMetPlZn6FwnbRC2mcWBJkCXB+Id3jFtzAh1FfegR55tStJBEFrxBtlA+qOarv39I4HWEI/mCNLdODh2e9DTYea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609064; c=relaxed/simple;
	bh=nXECD65rD0s/P1xvsdNfQSv3wCJRkijHf1Q3X+aDxVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJM/pvSsyhwBgcoK5Unx2HPkVBnJXdz/t4V3lpYBAdz2wBWkBL8YcVnSI/PAbDcDt8FpzvvtGmZMQbpSlLZ3pbuR4mRSPPjCbQJE/TQ8K2IUpaMvx2vMf5ejyqdSiILJZVEuztr4uyJUBxSeEz3TwsSFDikPbv8QJAPPrmXtJ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=InQ0Ny3W; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5101cd91017so2348537e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609061; x=1708213861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87LdGKdo1o52qqAOMkU7XUi8d7iSZPf2NI4GoJJh05A=;
        b=InQ0Ny3WiA2AX0cY9AJSXCQsAT8+oL9ynyFUM2gwDvCaGl+RLZpIyx4LPjKrwzjJMt
         VA1vCRmvrotwX+WgLPty8kb2XIdk91O5VC93PJDB0M0aSYRfEw/nBo5Yrh5e7hJ3ngbp
         a7nguu46RnboBWEoLeCi1aFAFOf10964XjlOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609061; x=1708213861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87LdGKdo1o52qqAOMkU7XUi8d7iSZPf2NI4GoJJh05A=;
        b=cIysG/J2S4uk3MhTS4TWXg3MMQO4ud0fcN919nuejquwSvlVtyGHbLkzpIqnAygwWB
         I0gcfCrs+Rqjd94o0TiDVGrcR/ICDWV80Fm/PIbVcYUI46yafCrtpsMkq1MJofGZmexc
         7NYRVXhJhqEU696S0nBEw5FQWfqHFtd+qQhYk824x6X5ZzbYejW3UpTiSCmWSJJl443u
         oHxi359JnguYE3gilzdTvbjKDneqkYyLCBHSVdY6VW2F0XGaXEb7AQEGnoNzAqkdhehd
         yjxkp96PBYM4Uv9U5CAP9zuDyX/7tSmwR7PC2AyXC+ybOs5Ynp4yzeuh1RBjp0fzWcuv
         S4Bg==
X-Gm-Message-State: AOJu0YygGFeboC395oMjwFBj3PcU3AtjWEacs84/k8Zb9yFtiFM/tT2F
	/Yw6iqge+ulrpD4iseUoJScDRg8WygbKbzm1nq2o+yFeEQ6tIkhN3vflWXnt
X-Google-Smtp-Source: AGHT+IEq7rY3VNv6LC2Taafc3eFgdH5XqlDlGxX7dfLuO3JpFXeqCj1t5ohnogVe1UA7pi42lTDFfA==
X-Received: by 2002:ac2:43d5:0:b0:511:4eda:2563 with SMTP id u21-20020ac243d5000000b005114eda2563mr1744694lfl.69.1707609060849;
        Sat, 10 Feb 2024 15:51:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYfeFXNc7BY13yOy/AaBbGoVRDaAbyI/u972bYmkBYD3ubr80foQ0xWNpFyqSy8H4iUDoKibWQ2Wb2pSv+sdq2XstMdzS1skZyxrwy+y6jYySz9/1MadhsyKafE0gPqKgcbVCkVEYUglZZ0yJ12yrJEWaGrV+vPL4+SA4hy7yQIciI1njiyhZrzp4uJ57qdaFdc92ckoivTd6t2r7xcWSNnNnps8D5GrRz0pZqPCk9hTZ3XWQJ1Umg9huBIsZYJeXMxxidlZAkUtEArXutsJZwB7AlIsdHiMtIKaflYXXP4MHOEV1xiDi86eOumYiGpjqzZRMD0MXP+/WJlBtm17IzR8PgYVNpkI1DabfLIoUeAmDMjWq6MM25EuAE/qvp5JEAP5hK90m4M7QVaaoPvV+zkaT2ZHM8CnTXSOUzPYl8D+l6fCcaoQAkgPPfKV9ngznFQQfSxBC8pYz/boHlenlHSbGk+Lds03vJ8S32oKdBfYy5kkwh4EclDUzVDV3Vg/P02+JJUYCMtna6OHznYulnu7mSoYVUqOHg4bL21dW5TSCQjsMBrpJD9CriGBwRD9susUUU9jSpedBWWpXY15vfnu9W5+F/01Hijx42Kx7E/TYxKA==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:51:00 -0800 (PST)
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
Subject: [PATCH v4 19/39] dyndbg: fix old BUG_ON in >control parser
Date: Sun, 11 Feb 2024 00:49:49 +0100
Message-ID: <20240210235009.2405808-20-ukaszb@chromium.org>
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

Fix a BUG_ON from 2009.  I have hit it while fuzzing >control on some
other patches, and panic from user input is bad.  Replace the BUG_ON
with pr_error and return -EINVAL.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 17df4bf6863a..20bfb6de2404 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -682,7 +682,11 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 		} else {
 			for (end = buf; *end && !isspace(*end); end++)
 				;
-			BUG_ON(end == buf);
+			if (end == buf) {
+				pr_err("parse err after word:%d=%s\n", nwords,
+				       nwords ? words[nwords - 1] : "<none>");
+				return -EINVAL;
+			}
 		}
 
 		/* `buf' is start of word, `end' is one past its end */
-- 
2.43.0.687.g38aa6559b0-goog


