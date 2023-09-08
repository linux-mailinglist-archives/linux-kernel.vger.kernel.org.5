Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692AB79867B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 13:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242807AbjIHLcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 07:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjIHLcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 07:32:41 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAA61FC4;
        Fri,  8 Sep 2023 04:32:28 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50091b91a83so3186488e87.3;
        Fri, 08 Sep 2023 04:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694172746; x=1694777546; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6PPorl9wVbuo1uuAa9GCQe4GH/N/mOgDSgRVOXiC4Xs=;
        b=A7smgSqU4Vd386QnVTV4gVRiZrPnAOGPJOm/ioCkIRKcBoHfXLLows9ESUDmFm0cwA
         sqoNr1lrNek4DCTW3aGQiX4VtyVsgmWzeC7y+KzCnsU4jrsESy0A3N8i94OjZ+sVLkNf
         dwF5PUc1lLmnhaBv1TpSpLdPT083sb4iQbF/gx8IHxY1N5WhLNl52dEB6+L/nC9G//rA
         tSdJX3uapc1NfzVk41g8ERcFUJnKSclL60F4N6bwy0JMGGSVmGxOymEzB/UKSIZBlNaH
         bIZoBk6xHTH/pn+5NB9Y4KdG46K7uC28vR0kY/NlmAXcaRuwpJedFm3xcirQJ0ayphxt
         hL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694172746; x=1694777546;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6PPorl9wVbuo1uuAa9GCQe4GH/N/mOgDSgRVOXiC4Xs=;
        b=Z0zM3U46h8Crk5kBhEGD+qOxJGHQMlcDq1H3VztuicERALwYxLlihUuR/t3UWWD6ND
         HlW0dlGLOg9I8baGU0WxtG4Kyej00gwssxvgKE+oPBfsc2znqA1ErxPC0P4pex1A6O01
         i1H9Wi70iekKgIUyGf2WT1CHeolCPYo+EuOM45rtWqS8EkJ0NYgVPdTVJLDl8VT3UheL
         EUGqxqZN/6JUkEV/Ju8upj5laBxN0dqqIAPAuU0TTny2ro7UR5vwFWjASki+8uVw5+IM
         QT8j/5HPxu6b+Qpe0EcT/fO47233TQdsz0P61ieI05MjwSfeJvtmhQ7SoSiLbM4lM2Dt
         zYiA==
X-Gm-Message-State: AOJu0Yz58OOEIiNkKCO8g54dkfiJ0z2kzHY7IO2N6OMkosZrG9zqJGfZ
        VPlLinoQM3h2yNMUbig4uQ==
X-Google-Smtp-Source: AGHT+IGrGaZ8RhXzHMLdtMpLJ3Qoxz38b3IriqqoFf+vup6bKImDxsxT8iGV8piZim5JOxtSjE73KQ==
X-Received: by 2002:a19:6503:0:b0:500:8f65:c624 with SMTP id z3-20020a196503000000b005008f65c624mr1351524lfb.53.1694172746216;
        Fri, 08 Sep 2023 04:32:26 -0700 (PDT)
Received: from p183 ([46.53.253.206])
        by smtp.gmail.com with ESMTPSA id s6-20020aa7c546000000b00521953ce6e0sm906185edr.93.2023.09.08.04.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 04:32:25 -0700 (PDT)
Date:   Fri, 8 Sep 2023 14:32:24 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        keescook@chromium.org
Subject: [PATCH] uapi: partially fix __DECLARE_FLEX_ARRAY for C++
Message-ID: <930c3ee5-1282-40f4-93e0-8ff894aabf3a@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__DECLARE_FLEX_ARRAY(T, member) macro expands to

	struct {
		struct {} __empty_member;
		T member[];
	};

which is subtly wrong in C++ because sizeof(struct{}) is 1 not 0,
changing UAPI structures layouts.

This can be fixed by expanding simply to

	T member[];

Most of the usages still be broken because of other C++ shenanigans
but this fixes simplest usage: 1 flexible member at the end.

Fix header guard while I'm at it.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/uapi/linux/stddef.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -39,6 +39,10 @@
  * struct, it needs to be wrapped in an anonymous struct with at least 1
  * named member, but that member can be empty.
  */
+#ifdef __cplusplus
+#define __DECLARE_FLEX_ARRAY(T, member)		\
+	T member[]
+#else
 #define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
 	struct { \
 		struct { } __empty_ ## NAME; \
@@ -49,3 +53,5 @@
 #ifndef __counted_by
 #define __counted_by(m)
 #endif
+
+#endif
