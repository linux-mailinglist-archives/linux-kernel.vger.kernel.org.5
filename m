Return-Path: <linux-kernel+bounces-34468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0650C837CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8BD1F29085
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B41146905;
	Tue, 23 Jan 2024 00:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QEWQMC5L"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF4A146907
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969714; cv=none; b=Rvp0UQ0IjGgkjfk82zdUdmVla0iJsQxe1UycjifYDTY9RHduu3TWpdw0Et7S/Pwa/SnAZ//Vdzmy19lBp0Srq+RWAWntIh3PyQYJyWwpkz6qihiAbMyJgk4cilEoN8oNmHaq+Z4txPqWi8+u/qw/mYs8Ce32VdjCh0jERzuan6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969714; c=relaxed/simple;
	bh=rI7XvXs0gE8oB6y5lNdVJ89YzOLiYyZbayu1rCEj/HA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ap+MGQosqGp4j9as1XN56oBHoGAwayVhsBRkhrikfH37oswox0hVnPokubkcWsAdQzBON0Mad6qe3A3NwzV+d/uS+5k5fMHYKI7FPOXXvLfakvIN3gpYJSrkKoXYc/vUX8/WCAHm14bN+//jQ8r2htkYTnnxT45xx0TIKepKoFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QEWQMC5L; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dbb003be79so3306489b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969711; x=1706574511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbPotP79yOptpL51tkgqhJq9nf6NFvv/p0BjBr/SdFE=;
        b=QEWQMC5LHFnUI+r+14MQmsNOrLfCXht+qZM2//2CWY2bxzWYDXkWdgeVHjhgOCoGVp
         YGizMpAGSsWnjQNPyR0jTpsRSJMmGMBY7UIsB9sfR8V82eLJefcWhydIfHO/aLo/bNyR
         IW52hKRTOAH+A/jFdd4qHndIEkwODR124a34Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969711; x=1706574511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbPotP79yOptpL51tkgqhJq9nf6NFvv/p0BjBr/SdFE=;
        b=SgeL5J4KBXFGgU9h7Sv9GGM0A/fvMGGl/+NbmpSKh9UIixYSkFdHqtUTuVpmymPD1k
         WCUulnHcEwEvrTnCjIIP57CneEMUZnom1csxv84/ys2cMlJKxdjs5sN+LqtBWkZMLsS3
         sc1eKobTMH3HxecHk9/NZwrt0Z45thvZRNxnt2QAtfy7GxM0XxCICHFnoO9Zaz27I4RE
         G+lQNTusYBet81j5avOxx7R3hBCQj+9K72x5a3JxZdWs1m7QJSCYJAXxe4+L+2Yrpyae
         zETPh5QdrrH9BdJc/svev8X0vEQMcy0D6MiEBEK2VO+8D2PF2noyMrtoWAvNkFZQnUMx
         0mRA==
X-Gm-Message-State: AOJu0Yyt5Lu7sR3b/6iWbKPlJ0zt8h3aZW5/xGDq+pi6stlYkf+apact
	iTvjT3K2ebsgUl2bp4ZOGsnY41YQV1tzZKptj6VKMKAk2FAt7CE4C3viTue5IA==
X-Google-Smtp-Source: AGHT+IGPGv7p6wvj5GKtaQOd4/72upnUNocrxjYTuU99MLscz+94FIEj/N+pJTtauYagf7uJKA/myw==
X-Received: by 2002:a05:6a20:d046:b0:199:fffd:a3e3 with SMTP id hv6-20020a056a20d04600b00199fffda3e3mr5559743pzb.52.1705969711526;
        Mon, 22 Jan 2024 16:28:31 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 10-20020a056a00070a00b006dbe1d91426sm2202104pfl.84.2024.01.22.16.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:25 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/82] overflow: Introduce add_would_overflow()
Date: Mon, 22 Jan 2024 16:26:37 -0800
Message-Id: <20240123002814.1396804-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326; i=keescook@chromium.org;
 h=from:subject; bh=rI7XvXs0gE8oB6y5lNdVJ89YzOLiYyZbayu1rCEj/HA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgE/Rg2DOBwpGm23xchVNBK/FIvMg7Pi7tuc
 hrgqGce9zOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBAAKCRCJcvTf3G3A
 JpK6D/4k9MYFmrgc6c/TYlvkWlxk7cgUas0VJ225O0PQXNgzPrwydo5r9or8JHba1AD9K1lQdyq
 iY/c00/ng+L0pXMnyUYZ5RlfA76Q9JVIOFl2227BDoVAwb8sQ3Xlwhz/+p860wwoMqwno5TxLPM
 iEVrs2M2EZZo+enpPucZmQra1oVUfjoTc4LBwgzW1f4CO87CyxlQo3WW1qqFcQKlFDx9qK0bhpw
 KTu3fyF0WBOF1vHOAzXRGacuCBEbmLPsDAiDI6spRQTRIheANwd4kr0s5jXyY4d32MNm8D6kCdw
 6o57Cm5NgRuXHzXB1diePd8nslD5neVySw31GHfZqmj9wMhnwKXi2lEZ/wqk3TO9hQ8l3WcSa0O
 AtuJ/dQI0LMgGmHU9s2J6rb3+sZYro4mWaVm09UCM02cSGj62u7H1KH/vj6Zw6MMiJ3GVmZomD+
 JkjQ5AmlveqxnP7sv/7BdpK866HqpW9PimFvELyrCATtMf206HO00xxjv5an7q1CRv9KGSi3Ifk
 lVlTmvb5GZS8sUdV+rAqL0M0E7Q+RrNmT6cRlRLqCdAdwUOiUblUXUkpg3CEifH1S3OVgJzSHbq
 bM1kAoa9NqEH8gQAHKfJGo01p01MIhMFhfpnhrorrnpTBOFCgnmxVLdlC8Wzo7PaLcqetog57uK SjUZaEfaNTdpghQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

For instances where only the overflow needs to be checked (and the sum
isn't used), provide the new helper add_would_overflow(), which is
a wrapper for check_add_overflow().

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 099f2e559aa8..ac088f73e0fd 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -108,6 +108,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 		__builtin_add_overflow(__filter_integral(a), b,		\
 				       __filter_ptrint(d))))
 
+/**
+ * add_would_overflow() - Check if an addition would overflow
+ * @a: first addend
+ * @b: second addend
+ *
+ * Returns true if the sum would overflow.
+ *
+ * To keep a copy of the sum when the addition doesn't overflow, use
+ * check_add_overflow() instead.
+ */
+#define add_would_overflow(a, b)			\
+	__must_check_overflow(({			\
+		size_t __result;			\
+		check_add_overflow(a, b, &__result);\
+	}))
+
 /**
  * check_sub_overflow() - Calculate subtraction with overflow checking
  * @a: minuend; value to subtract from
-- 
2.34.1


