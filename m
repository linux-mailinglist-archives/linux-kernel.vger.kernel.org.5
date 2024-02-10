Return-Path: <linux-kernel+bounces-60210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0496850176
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE4928A324
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054474C90;
	Sat, 10 Feb 2024 01:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M8NdWIPI"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DCC1FDA
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 01:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707527808; cv=none; b=UYuZ+ZIIcne3lUGZU28Mg6N0s4dosa7N5CT6QEHsd/GuhB17EbSO50CbemO6unKIH3h2/FmiVN32GHA7PcC8BdArTzjLqlZA+DYt8rBJ8ApxZVoLErFgnSLHmxgHn+0bSlgIacI4beqQhKpYU/46h8eEQXMgcfMQtiFiB23L6Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707527808; c=relaxed/simple;
	bh=7XJjEgvqeEf1C270MBQlNS8089wSLDXw7au4fhViZ9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=omam4pYjSS+uaH3JRXtwmXFqvLe3u2etEldPDJmQ2vsBU5LHGUza1b9dsFFxefu/8pAspzL5A63I167yMK2ou50GaMBrckKM44v2lPcitP3kGoGZUijlDeeTNY7vkdrsSlascVSRHRPRQQnbbzF4aoyF3PUkr96lYeojETYiV/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M8NdWIPI; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2906773c7e9so1090561a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 17:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707527805; x=1708132605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mUvX1itSorxxJJ/u/VSZ6UrN6IODCy16GtowaQvelM=;
        b=M8NdWIPIRQmuR3ktJOzF8F+v8uc3dQaviwFg6/UH28ysFphpayPZH7Rd+fJ2jKaJCB
         nfaLk3KB6ceySGXz0NCZ5HWs5lm9bJTWLcT2t7rfR+Spk4tFhBFrD6CQ4dodX6IpXW2q
         miSULLf/BitwVsQsc0sWGHsnkix/fDPsdCdbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707527805; x=1708132605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mUvX1itSorxxJJ/u/VSZ6UrN6IODCy16GtowaQvelM=;
        b=r43Kbn09SkGm07Wf1JaZ2VxIZgQkCrgK5yVSK6LEtmUfsxxQhfi1PAJSYaUWe52rlv
         2+mysdJHLOX6MDo45Rw9CmCG5l8PqurT8w3i6+3UxUDx8WseFc8pt+SJ8Dkc2aJa6hSd
         aLA0cwjdrxRqE91KqnJSfQQMJ284f+AFJubCvzbodcJbaqbSNOKVtxaebp8hJz4LZqi8
         R1/V+nc6a0tgkSzZPgPcOeHbIEaZFVneJgJnHMOVuEUCECUGnZDzrRamj4I05u5adfQo
         SOlgYUe05FY7+vES7cp/HstSJSz8il/Nl0IkcD2DE+Rqr2ZnWLkYK8y7L9hQ1JJfoxgw
         CaqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx2Zbid/LOnuWqpMWgADdzbryJWthyLMfGH/p4N8erAcIh0sF4Ub1doTpTuM7SIHhBuxDLxXAcPvgyqmmxbcfBjsFuzRlVzPckFgHJ
X-Gm-Message-State: AOJu0YxN/4/wViDiYH+6mr3mCmm42Atjx+BK+nQbE6ax9BaIauIMQzQ5
	RyYjsk38QEfqHCGnrznQbyWbgJgt69TLL1hFHO9jfwZjOl40klp5DdIoFlg0ww==
X-Google-Smtp-Source: AGHT+IH6tbwWdPxhsZFHudRBZ6pJTFjSN4L0eEKXiYI/GL4yI3y+V2ANH7bQZbSma+RQT7XTv+6W6w==
X-Received: by 2002:a17:90a:eac9:b0:296:e219:eb1c with SMTP id ev9-20020a17090aeac900b00296e219eb1cmr535338pjb.37.1707527805350;
        Fri, 09 Feb 2024 17:16:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbfrX/vQ+BW17JmTFpCKFM+Wjbut2AMZLVfF/TwhbELBU+Y7ookg2n0ywiZ29PwM0IcVNXt5PB4F0bfr8zLEcJTjtnSFUS0AWU6ANuo9Z5Wtt+FRFxLvHxwXdQIJwAaZjRvDk9Z+RNAy2aAJ3KFhdGgakfHK0VWvSW9g7wnfMWyycqMqHESNUsVPZf/ANwPkZ0sqWJQHb7WW6JN/VfOv0ZpeLyHy8t3oKOxl+42jjjxJStyxbiKkiQMpgtLIWfZ7/ugiTTqCqoVYxSWgWMW4/Kth1JgAl2lnKtkPchsmtuMYwzrnD0l3XLLbRCdeWmkq6FYpuAZ08zEkR3AaHGaQkS7P1qzql60GE2Ul/rpAFOqc0PKfN/i8zg3kOGu9Y0PoUMwHBkEjqhJRPyorJAgsYM2ndATvIa1EOCCf7yQvrxj8HjOG75LEGkh6D2fa5I1F+SfVAYOa8hiHk6cL2LgQQgv9Qc1FwinCp2Z/23025UV911sRN8m9GwqsSY6H0K
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s21-20020a656915000000b005c662e103a1sm2171623pgq.41.2024.02.09.17.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 17:16:44 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	Keith Packard <keithp@keithp.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] net/ipv4: Annotate imsf_slist_flex with __counted_by(imsf_numsrc)
Date: Fri,  9 Feb 2024 17:16:42 -0800
Message-Id: <20240210011643.1706285-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240210011452.work.985-kees@kernel.org>
References: <20240210011452.work.985-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=953; i=keescook@chromium.org; h=from:subject; bh=7XJjEgvqeEf1C270MBQlNS8089wSLDXw7au4fhViZ9k=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlxs56b/YU9uCWyX1kD51B/7AJ32jX6Ko3rsWCD ItxtYxKnueJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcbOegAKCRCJcvTf3G3A Jri6EACJUceo9gf6zPJCVHzFHPzJ+cKBEOecAQBjsrUQfNTiy7VZT2/P2C19Wsf3zLYOvxTr22Q mIGdvbjFOPTiZ/J4cH1+l2q7zO5PR/zS/5955PGAaCdIzmp5Z2mero036OEvuYfcfiDT+HHmROK J8RgVZDHh405kaxnoIn/Qe5YdrC+0YmuXd/8fj49EHa2fQSvk/ro5hYF+k+kjYsJLNVic9ssfFc X7ch/slGcLT5b3FIBJD+C1BGZQGppSy+Wv4ySmQKtfvuHqLGKvY/sKsUPthayKuilUe3X/SdXSD PPY0X/CHnKa9btW6GjQPWb7Oa3AwSxJnZQZBaMbTZk96bDwPVFar1ztYAFVaYkZpjSWNk6WDJ75 GH9YiiSZQHY8xV14ykgbRnxyZQULRYTdzUXwuEG8ifkLYkzJCW3TmN4kUEuNzL+kiclRLw1zQqL QMOS4yGsVBOu5cK/LGbDWhFbmxBvmNcw7K35YvzL22UXMNQ9tkpMU3gxRpnqbDl9nUhKmSD8LVZ WcSZuv2omy0/5G2EWB8XBrgtdYivyhS4mjqYoBp1edS83dJrRT/78mvm56jlS/t8Twk63QIsCMk 8TFHRHIo+jlikkTi2+AwcWkbzcqCGvARwro7mke7EUP7UAN0FufGN8XIRMC+ehaX2WZ2BNwnYZp CRIiDME9BkAFXig==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The size of the imsf_slist_flex member is determined by imsf_numsrc, so
annotate it as such.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/uapi/linux/in.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index e682ab628dfa..445f6ae76f1e 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -199,7 +199,8 @@ struct ip_msfilter {
 	__u32		imsf_numsrc;
 	union {
 		__be32		imsf_slist[1];
-		__DECLARE_FLEX_ARRAY(__be32, imsf_slist_flex);
+		__DECLARE_FLEX_ARRAY_ATTR(__be32, imsf_slist_flex,
+					  __counted_by(imsf_numsrc));
 	};
 };
 
-- 
2.34.1


