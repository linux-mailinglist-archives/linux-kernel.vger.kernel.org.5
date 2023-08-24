Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09342786EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241338AbjHXMSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241327AbjHXMSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:18:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10D9170F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:18:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5925fb6087bso18323537b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692879490; x=1693484290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8p4eP1h14QFMqmWjHAlDpl9k137Tq9L6HI1RUlUFcRU=;
        b=bAe+LE47owmSvY4yrd1nhijVG3xqAl4ofPuwuyuSsz+sa90SwcXv5VlvGcsn7obLJi
         DmvcBWk9fg23EM3JnDwQXoHRlyr9sluQI5XMhy9gNI6ZzoaTTlq63XFNM0UeSgIWNDH9
         stb2f2hKT0guOgKSanGzIZyiymFz+L6GT6jJN0yZnJXQOoiBUo1vwkcdrZe1lF04q4Yt
         KnirdG4q72l/h5vMcTpau/bHEynbkZbXtI6nf/rr3eKs8IhTl5CwCvDXmtm+P5m1JTey
         eDXNOBQfz8ahbtT9VkwGnbUPyGP823wo04s9D+H11eguDAnMJGpiZqIxK33rwcljoc0e
         RFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692879490; x=1693484290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8p4eP1h14QFMqmWjHAlDpl9k137Tq9L6HI1RUlUFcRU=;
        b=EHW89Ja6zh2RAfPNK0fzoTuvZ+Agv7QTR/FXT9/CbUWiAe2U1e0V/4nhSicjgmiAs2
         M1HXwAz0P6tADysblha2V7oNZTLVbPq00uG2ETw2sARVo3bYuQzRxYlSxpiOy1iXPSTB
         rYRj1iHoW6Sqaq8w80c+rMru33yF7wbyj2Mx3g3TDwOQHWfZ7xzT8gfr3BuYvvfV7nBb
         HbE7yFSBkFtQnfjYNxXq0uGLFobMuNyf4ZTgyFB7/ZvqqWvptsgwgY3jUUkw3ViKBotE
         6K93RQtRkE+jP9fZig4jar7eAywZpNTGAD3jOSArniPlh4J0HGff4/TGRjVXrvlI5hXD
         5N5Q==
X-Gm-Message-State: AOJu0YzypMZDFggY3mnzbZx81RFS7sVCebYnLsmQeFE/L8S1NrrB3o96
        TNu2uixfHnTsQR9Hh0pfWgD+JUt9y/h42N1ULM0=
X-Google-Smtp-Source: AGHT+IGKgWqctfFTT+x7LlxxuuSo9bGGRF1PasrpOpaIVfxKr+wreeVqCWz0GZVTWjlWdozejvRBzcQptBHyhPLCOKc=
X-Received: from anikett.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:2551])
 (user=aniketmaurya job=sendgmr) by 2002:a81:af59:0:b0:56d:1b6:5360 with SMTP
 id x25-20020a81af59000000b0056d01b65360mr255962ywj.5.1692879489980; Thu, 24
 Aug 2023 05:18:09 -0700 (PDT)
Date:   Thu, 24 Aug 2023 12:17:50 +0000
In-Reply-To: <20230824121750.1673566-1-aniketmaurya@google.com>
Mime-Version: 1.0
References: <20230824121750.1673566-1-aniketmaurya@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230824121750.1673566-3-aniketmaurya@google.com>
Subject: [PATCH v1 2/2] mux: Introduce optional variant of consumer APIs
From:   Aniket <aniketmaurya@google.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, joychakr@google.com,
        Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional variant of get APIs for mux-control,
mux-state and mux-state-array.
These APIs allow client drivers to not fail in
case mux is not present on the platform.

Signed-off-by: Aniket <aniketmaurya@google.com>
---
 drivers/mux/core.c           | 24 ++++++++++++++++++++++++
 include/linux/mux/consumer.h | 22 ++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index e4e57847e904..a6772f23ef6e 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -379,6 +379,9 @@ int mux_control_select_delay(struct mux_control *mux, unsigned int state,
 {
 	int ret;
 
+	if (!mux)
+		return 0;
+
 	ret = down_killable(&mux->lock);
 	if (ret < 0)
 		return ret;
@@ -414,6 +417,9 @@ EXPORT_SYMBOL_GPL(mux_control_select_delay);
  */
 int mux_state_select_delay(struct mux_state *mstate, unsigned int delay_us)
 {
+	if (!mstate)
+		return 0;
+
 	return mux_control_select_delay(mstate->mux, mstate->state, delay_us);
 }
 EXPORT_SYMBOL_GPL(mux_state_select_delay);
@@ -440,6 +446,9 @@ int mux_state_array_select(struct mux_state_array *mstates)
 {
 	int ret, i;
 
+	if (!mstates)
+		return 0;
+
 	for (i = 0; i < mstates->num; ++i) {
 		ret = mux_state_select(mstates->mstate[i]);
 		if (ret < 0)
@@ -477,6 +486,9 @@ int mux_control_try_select_delay(struct mux_control *mux, unsigned int state,
 {
 	int ret;
 
+	if (!mux)
+		return 0;
+
 	if (down_trylock(&mux->lock))
 		return -EBUSY;
 
@@ -508,6 +520,9 @@ EXPORT_SYMBOL_GPL(mux_control_try_select_delay);
  */
 int mux_state_try_select_delay(struct mux_state *mstate, unsigned int delay_us)
 {
+	if (!mstate)
+		return 0;
+
 	return mux_control_try_select_delay(mstate->mux, mstate->state, delay_us);
 }
 EXPORT_SYMBOL_GPL(mux_state_try_select_delay);
@@ -528,6 +543,9 @@ int mux_control_deselect(struct mux_control *mux)
 {
 	int ret = 0;
 
+	if (!mux)
+		return 0;
+
 	if (mux->idle_state != MUX_IDLE_AS_IS &&
 	    mux->idle_state != mux->cached_state)
 		ret = mux_control_set(mux, mux->idle_state);
@@ -552,6 +570,9 @@ EXPORT_SYMBOL_GPL(mux_control_deselect);
  */
 int mux_state_deselect(struct mux_state *mstate)
 {
+	if (!mstate)
+		return 0;
+
 	return mux_control_deselect(mstate->mux);
 }
 EXPORT_SYMBOL_GPL(mux_state_deselect);
@@ -569,6 +590,9 @@ int mux_state_array_deselect(struct mux_state_array *mstates)
 {
 	int ret, i;
 
+	if (!mstates)
+		return 0;
+
 	for (i = 0; i < mstates->num; ++i) {
 		ret = mux_state_deselect(mstates->mstate[i]);
 		if (ret < 0)
diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
index da15d0542008..397b1c5848c7 100644
--- a/include/linux/mux/consumer.h
+++ b/include/linux/mux/consumer.h
@@ -63,9 +63,31 @@ void mux_control_put(struct mux_control *mux);
 
 struct mux_control *devm_mux_control_get(struct device *dev,
 					 const char *mux_name);
+static inline struct mux_control *
+devm_mux_control_get_optional(struct device *dev, const char *mux_name)
+{
+	struct mux_control *mux = devm_mux_control_get(dev, mux_name);
+
+	return (PTR_ERR(mux) == -ENOENT) ? NULL : mux;
+}
+
 struct mux_state *devm_mux_state_get(struct device *dev,
 				     const char *mux_name);
+static inline struct mux_state *
+devm_mux_state_get_optional(struct device *dev, const char *mux_name)
+{
+	struct mux_state *mstate = devm_mux_state_get(dev, mux_name);
+
+	return (PTR_ERR(mstate) == -ENOENT) ? NULL : mstate;
+}
 
 struct mux_state_array *devm_mux_state_array_get(struct device *dev);
+static inline struct mux_state_array *
+devm_mux_state_array_get_optional(struct device *dev)
+{
+	struct mux_state_array *mstates = devm_mux_state_array_get(dev);
+
+	return (PTR_ERR(mstates) == -ENOENT) ? NULL : mstates;
+}
 
 #endif /* _LINUX_MUX_CONSUMER_H */
-- 
2.42.0.rc1.204.g551eb34607-goog

