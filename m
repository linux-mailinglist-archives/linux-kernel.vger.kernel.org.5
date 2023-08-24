Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99D7786EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbjHXMSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241379AbjHXMSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:18:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F8910EF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:18:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58f9db8bc1dso82101967b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692879484; x=1693484284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0vOYxGK8LX/cV5k4gTSBXuorx7IhaaE1lnGQ1Odm1SE=;
        b=xd+lCiVyQzhEx/p/bpyURAxztpZwJF8yzbaYFneXbr4b6r/g/4xXIep9MVZFI/sDU2
         glWCTGXk4FJ+3pNPKMe/K/wfkYmqfZClWc5F8aR413AKqPCFcyB2wpXyuMY4Lbv6QAFF
         3hRTlht2opQSuBZdg6TtDnQlSjXqikbzRicRgWf0VaWeKzpwm018XBPgvwsAvuE197BL
         jxDbakU617zyQmDFRbCEsrMQmdm1oFeW4Yr0DF8QnJ9OXzysHNjUJ39VidVTADXzh3Kf
         tl51/OZFHX2NpuuLibEVb71kJdqmz6psC0s4F0AysWHL431aP3N1vLxy3Mch9EV1W1UL
         SHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692879484; x=1693484284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0vOYxGK8LX/cV5k4gTSBXuorx7IhaaE1lnGQ1Odm1SE=;
        b=CD/C9kWZR88L5l1n+QHwCFiY7i9dWEftqL8Mwxw9YaVGppJNujZujsMhcMoq0CgeDG
         kSRnsixxi0LdF6VCEibSRZMynUT9gNOAF913rYKv7v9/m/hHn0LJmRj7thJUSZxLMwBa
         Hv5MRf2wFpmCVWhem/LM9crvlkp4Kd017eKV1JoJTx1tm+XgPhW4VL/r6enU4ykXnX3O
         w1AnZM30SoZVoPrIftR5d7toS7oohdHb+xn+5ei2xW/iTT+MZD3CxEBGCz5EsOTi+YrK
         Usqr1sQDSAWf5j0iv6abXCk/ZhFEis0U3TztM+PDjLgMTOP7FV8i3HcHOTnKoW7Qn+Ui
         cX+A==
X-Gm-Message-State: AOJu0YxGfDQbamnMraP0x1NnaC4/xAk+4EhVDzs2CN52iwkAVTCEbNQb
        lRK4Spr4knM1XDprsOz7iUetwDUTtrKFPVVVClk=
X-Google-Smtp-Source: AGHT+IE/zaxCN5ez0VrtY/hjhlbCvv+NBrf/ugGdZTAQGzZHLKPBlCKcxpu9no3FjkfZzH9mjVHcxDf660TMyjSIu8U=
X-Received: from anikett.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:2551])
 (user=aniketmaurya job=sendgmr) by 2002:a81:430d:0:b0:576:fdbe:76b2 with SMTP
 id q13-20020a81430d000000b00576fdbe76b2mr220141ywa.3.1692879483884; Thu, 24
 Aug 2023 05:18:03 -0700 (PDT)
Date:   Thu, 24 Aug 2023 12:17:49 +0000
In-Reply-To: <20230824121750.1673566-1-aniketmaurya@google.com>
Mime-Version: 1.0
References: <20230824121750.1673566-1-aniketmaurya@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230824121750.1673566-2-aniketmaurya@google.com>
Subject: [PATCH v1 1/2] mux: Add support for handling array of mux-state
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

Sometimes consumer needs to manage a number of mux-
states, so it is easier if they can control it using
an array of such mux-states.
Add support to devm_get, select and deselect the array.

Signed-off-by: Aniket <aniketmaurya@google.com>
---
 drivers/mux/core.c           | 161 +++++++++++++++++++++++++++++++++--
 include/linux/mux/consumer.h |   7 ++
 2 files changed, 162 insertions(+), 6 deletions(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 990e7bc17c85..e4e57847e904 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -43,6 +43,16 @@ struct mux_state {
 	unsigned int state;
 };
 
+/**
+ * struct mux_state_array - Represents an array of mux states
+ * @num: number of mux state
+ * @mstate: array of mux states
+ */
+struct mux_state_array {
+	unsigned int num;
+	struct mux_state *mstate[];
+};
+
 static struct class mux_class = {
 	.name = "mux",
 };
@@ -408,6 +418,44 @@ int mux_state_select_delay(struct mux_state *mstate, unsigned int delay_us)
 }
 EXPORT_SYMBOL_GPL(mux_state_select_delay);
 
+/**
+ * mux_state_array_select() - Select the given multiplexer state.
+ * @mstates: The mux-state-array which contains multiple mux-state to select.
+ *
+ * On successfully selecting all the mux-states, their mux-control will be
+ * locked until there is a call to mux_state_array_deselect().
+ * If a mux-controls is already selected when mux_state_array_select() is
+ * called, then caller will be blocked.
+ *
+ * Therefore, make sure to call mux_state_array_deselect() when the operation
+ * is complete and the mux-state-array is free for others to use, but do not
+ * call mux_state_array_deselect() if mux_state_array_select() fails.
+ * If a mux_state_array_select() fails inbetween the already selected
+ * mux-states in the array are deselected.
+ *
+ * Return: 0 when the mux-state has been selected or a negative
+ * errno on error.
+ */
+int mux_state_array_select(struct mux_state_array *mstates)
+{
+	int ret, i;
+
+	for (i = 0; i < mstates->num; ++i) {
+		ret = mux_state_select(mstates->mstate[i]);
+		if (ret < 0)
+			goto err_mstates;
+	}
+
+	return 0;
+
+err_mstates:
+	while (--i >= 0)
+		mux_state_deselect(mstates->mstate[i]);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mux_state_array_select);
+
 /**
  * mux_control_try_select_delay() - Try to select the given multiplexer state.
  * @mux: The mux-control to request a change of state from.
@@ -508,6 +556,29 @@ int mux_state_deselect(struct mux_state *mstate)
 }
 EXPORT_SYMBOL_GPL(mux_state_deselect);
 
+/**
+ * mux_state_array_deselect() - Deselect the previously selected multiplexer state.
+ * @mstates: Array of mux-states to deselect.
+ *
+ * It is required that a single call is made to mux_state_array_deselect() for
+ * each and every successful call made to either of mux_state_array_select().
+ *
+ * Return: 0 on success and a negative errno on error.
+ */
+int mux_state_array_deselect(struct mux_state_array *mstates)
+{
+	int ret, i;
+
+	for (i = 0; i < mstates->num; ++i) {
+		ret = mux_state_deselect(mstates->mstate[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mux_state_array_deselect);
+
 /* Note this function returns a reference to the mux_chip dev. */
 static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
 {
@@ -522,19 +593,19 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
  * mux_get() - Get the mux-control for a device.
  * @dev: The device that needs a mux-control.
  * @mux_name: The name identifying the mux-control.
+ * @index: Index to identify mux-control if mux-name is NULL.
  * @state: Pointer to where the requested state is returned, or NULL when
  *         the required multiplexer states are handled by other means.
  *
  * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
  */
 static struct mux_control *mux_get(struct device *dev, const char *mux_name,
-				   unsigned int *state)
+				   int index, unsigned int *state)
 {
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args args;
 	struct mux_chip *mux_chip;
 	unsigned int controller;
-	int index = 0;
 	int ret;
 
 	if (mux_name) {
@@ -619,7 +690,7 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
  */
 struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 {
-	return mux_get(dev, mux_name, NULL);
+	return mux_get(dev, mux_name, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(mux_control_get);
 
@@ -676,10 +747,12 @@ EXPORT_SYMBOL_GPL(devm_mux_control_get);
  * mux_state_get() - Get the mux-state for a device.
  * @dev: The device that needs a mux-state.
  * @mux_name: The name identifying the mux-state.
+ * @index: Index of the mux-state, to be used when mux-name is NULL
  *
  * Return: A pointer to the mux-state, or an ERR_PTR with a negative errno.
  */
-static struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
+static struct mux_state *mux_state_get(struct device *dev, const char *mux_name,
+				       int index)
 {
 	struct mux_state *mstate;
 
@@ -687,7 +760,7 @@ static struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
 	if (!mstate)
 		return ERR_PTR(-ENOMEM);
 
-	mstate->mux = mux_get(dev, mux_name, &mstate->state);
+	mstate->mux = mux_get(dev, mux_name, index, &mstate->state);
 	if (IS_ERR(mstate->mux)) {
 		int err = PTR_ERR(mstate->mux);
 
@@ -734,7 +807,7 @@ struct mux_state *devm_mux_state_get(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	mstate = mux_state_get(dev, mux_name);
+	mstate = mux_state_get(dev, mux_name, 0);
 	if (IS_ERR(mstate)) {
 		devres_free(ptr);
 		return mstate;
@@ -747,6 +820,82 @@ struct mux_state *devm_mux_state_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_mux_state_get);
 
+/*
+ * mux_state_array_get() - Get the all the mux-states for a device.
+ * @dev: The device that needs a mux-state.
+ *
+ * Return: A pointer to the mux-state, or an ERR_PTR with a negative errno.
+ */
+static struct mux_state_array *mux_state_array_get(struct device *dev)
+{
+	struct mux_state_array *mstates;
+	struct mux_state *mstate;
+	int num, i;
+
+	num = of_count_phandle_with_args(dev->of_node, "mux-states", "#mux-state-cells");
+	if (num < 0)
+		return ERR_PTR(num);
+
+	mstates = kzalloc(struct_size(mstates, mstate, num), GFP_KERNEL);
+	if (!mstates)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < num; i++) {
+		mstate = mux_state_get(dev, NULL, i);
+		if (IS_ERR(mstate))
+			goto err_mstates;
+		mstates->mstate[i] = mstate;
+	}
+	mstates->num = num;
+
+	return mstates;
+
+err_mstates:
+	while (--i >= 0)
+		mux_state_put(mstates->mstate[i]);
+	kfree(mstates);
+
+	return ERR_PTR(PTR_ERR(mstate));
+}
+
+static void devm_mux_state_array_release(struct device *dev, void *res)
+{
+	int i;
+	struct mux_state_array *mstates = *(struct mux_state_array **)res;
+
+	for (i = 0; i < mstates->num; i++)
+		mux_state_put(mstates->mstate[i]);
+	kfree(mstates);
+}
+
+/**
+ * devm_mux_state_array_get() - Get the all the mux-states for a device, with
+ * resource management.
+ * @dev: The device that needs a mux-control.
+ *
+ * Return: Pointer to the mux-state-array, or an ERR_PTR with a negative errno.
+ */
+struct mux_state_array *devm_mux_state_array_get(struct device *dev)
+{
+	struct mux_state_array **ptr, *mstates;
+
+	ptr = devres_alloc(devm_mux_state_array_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	mstates = mux_state_array_get(dev);
+	if (IS_ERR(mstates)) {
+		devres_free(ptr);
+		return mstates;
+	}
+
+	*ptr = mstates;
+	devres_add(dev, ptr);
+
+	return mstates;
+}
+EXPORT_SYMBOL_GPL(devm_mux_state_array_get);
+
 /*
  * Using subsys_initcall instead of module_init here to try to ensure - for
  * the non-modular case - that the subsystem is initialized when mux consumers
diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
index 2e25c838f831..da15d0542008 100644
--- a/include/linux/mux/consumer.h
+++ b/include/linux/mux/consumer.h
@@ -15,6 +15,7 @@
 struct device;
 struct mux_control;
 struct mux_state;
+struct mux_state_array;
 
 unsigned int mux_control_states(struct mux_control *mux);
 int __must_check mux_control_select_delay(struct mux_control *mux,
@@ -39,6 +40,8 @@ static inline int __must_check mux_state_select(struct mux_state *mstate)
 	return mux_state_select_delay(mstate, 0);
 }
 
+int mux_state_array_select(struct mux_state_array *mstates);
+
 static inline int __must_check mux_control_try_select(struct mux_control *mux,
 						      unsigned int state)
 {
@@ -53,6 +56,8 @@ static inline int __must_check mux_state_try_select(struct mux_state *mstate)
 int mux_control_deselect(struct mux_control *mux);
 int mux_state_deselect(struct mux_state *mstate);
 
+int mux_state_array_deselect(struct mux_state_array *mstates);
+
 struct mux_control *mux_control_get(struct device *dev, const char *mux_name);
 void mux_control_put(struct mux_control *mux);
 
@@ -61,4 +66,6 @@ struct mux_control *devm_mux_control_get(struct device *dev,
 struct mux_state *devm_mux_state_get(struct device *dev,
 				     const char *mux_name);
 
+struct mux_state_array *devm_mux_state_array_get(struct device *dev);
+
 #endif /* _LINUX_MUX_CONSUMER_H */
-- 
2.42.0.rc1.204.g551eb34607-goog

