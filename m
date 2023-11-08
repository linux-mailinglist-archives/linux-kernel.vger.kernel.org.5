Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE9B7E5BBD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjKHQyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKHQyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:54:43 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8830D1FD5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:54:41 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc53d0030fso8114425ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 08:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699462481; x=1700067281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+oGgPDVqvwYoEeg0MhNKCXwVyeYHtfYEuAh5Z3SzJM=;
        b=gqtrJFIetcbN1QerqKHne1Jm4KYGqXWVqTLyBpLbqPZDhV9bCsP+y7/ZAOBUr+Ft2A
         vljuJ0ID1vDyETrXTI9wCIk8We3vMn0w3xotWsOiw5eJ2k6KJW1tW4BEPB5nJrwFJ9Nr
         KSp+sBoqZMvB3yBgKRuYudtESLBOLxMPt6rgoR3jySoa8i6D1xmqWDnDn8OpOBZsoTMo
         xszjHcQ3OuUDRjo0BJcyQE9bKmPO3lE9JeI4IMpB7Z6pdVq2SennoS0vIaZxtMxrOvNd
         qFQCVV8/U9T1dKhO7CGydybDcyMarz+0UFF+QXgLhkqvXw02XFhV2qoO4PNf79VlFY/u
         rcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699462481; x=1700067281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+oGgPDVqvwYoEeg0MhNKCXwVyeYHtfYEuAh5Z3SzJM=;
        b=HPQ64EWKTLrXXeLPALPPnq5LitmwAIeaQA9TOSxXd3SyOaqCzi9L+stkTETxMAP8mw
         /T/5Ox27ofzjKCD26G6+mozaP9ICYGOngmcVCoWIf8nskByBty+KJcHQtygVp+c3MdYf
         R0zWGfvsFAdpR+W79DNT4CIKmJwiPau/VfM40VcaKrN/6j1XstabnwpeHpOPt4IjEO10
         lAziiwPYx9ZSCCc90PFlVLfeBfP2GJfcJmK5ubaptlKl2cVkHNtGNz46SqfvtNDutABl
         T2QhLh5oub8wXJWb+FLZs5J0qhirSCLr9pWwKykKwbIsrHLEXSDByNW9TpkIElbfHHu6
         rigA==
X-Gm-Message-State: AOJu0YxoiJOGgLNcIjJ1+Kib3PAxhcFO4SQoSKaN5ch3KrjgfkGUnTw6
        +3JToAZf9/t5GjHKcHMhzi0=
X-Google-Smtp-Source: AGHT+IFCexdp4RAER4K6Q6fHIXfkiCziZCFCNx6hf6En6Uwvo8ySjUJCFHMluv3skNYerb6HJ+PiHA==
X-Received: by 2002:a17:903:230e:b0:1cc:4488:afba with SMTP id d14-20020a170903230e00b001cc4488afbamr8798614plh.6.1699462480811;
        Wed, 08 Nov 2023 08:54:40 -0800 (PST)
Received: from omkarwagle.hsd1.ca.comcast.net (c-73-92-27-236.hsd1.ca.comcast.net. [73.92.27.236])
        by smtp.gmail.com with ESMTPSA id a20-20020a170903101400b001c9ba6c7287sm1966177plb.143.2023.11.08.08.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 08:54:40 -0800 (PST)
From:   Omkar Wagle <ov.wagle@gmail.com>
To:     catalin.marinas@arm.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omkar Wagle <ov.wagle@gmail.com>
Subject: [PATCH 2/2] MM: kmemleak: Add %x to pr_debug
Date:   Wed,  8 Nov 2023 08:54:24 -0800
Message-Id: <20231108165424.8845-1-ov.wagle@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZUtlwgDB1L2WVzfy@arm.com>
References: <ZUtlwgDB1L2WVzfy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add %x to pr_debug to keep it for debugging
Remove the NULL check for object pointer

Signed-off-by: Omkar Wagle<ov.wagle@gmail.com>
---
 mm/kmemleak.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index a7b74dc3ff01..93b77288754a 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -410,8 +410,6 @@ static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
 		unsigned long untagged_objp;
 
 		object = rb_entry(rb, struct kmemleak_object, rb_node);
-		if (!object)
-			break;
 
 		untagged_objp = (unsigned long)kasan_reset_tag((void *)object->pointer);
 
@@ -1030,7 +1028,7 @@ static void object_no_scan(unsigned long ptr)
 void __ref kmemleak_alloc(const void *ptr, size_t size, int min_count,
 			  gfp_t gfp)
 {
-	pr_debug("%s(0x%p, %zu, %d)\n", __func__, ptr, size, min_count);
+	pr_debug("%s(0x%px, %zu, %d)\n", __func__, ptr, size, min_count);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
 		create_object((unsigned long)ptr, size, min_count, gfp);
@@ -1051,7 +1049,7 @@ void __ref kmemleak_alloc_percpu(const void __percpu *ptr, size_t size,
 {
 	unsigned int cpu;
 
-	pr_debug("%s(0x%p, %zu)\n", __func__, ptr, size);
+	pr_debug("%s(0x%px, %zu)\n", __func__, ptr, size);
 
 	/*
 	 * Percpu allocations are only scanned and not reported as leaks
@@ -1075,7 +1073,7 @@ EXPORT_SYMBOL_GPL(kmemleak_alloc_percpu);
  */
 void __ref kmemleak_vmalloc(const struct vm_struct *area, size_t size, gfp_t gfp)
 {
-	pr_debug("%s(0x%p, %zu)\n", __func__, area, size);
+	pr_debug("%s(0x%px, %zu)\n", __func__, area, size);
 
 	/*
 	 * A min_count = 2 is needed because vm_struct contains a reference to
@@ -1098,7 +1096,7 @@ EXPORT_SYMBOL_GPL(kmemleak_vmalloc);
  */
 void __ref kmemleak_free(const void *ptr)
 {
-	pr_debug("%s(0x%p)\n", __func__, ptr);
+	pr_debug("%s(0x%px)\n", __func__, ptr);
 
 	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
 		delete_object_full((unsigned long)ptr);
@@ -1116,7 +1114,7 @@ EXPORT_SYMBOL_GPL(kmemleak_free);
  */
 void __ref kmemleak_free_part(const void *ptr, size_t size)
 {
-	pr_debug("%s(0x%p)\n", __func__, ptr);
+	pr_debug("%s(0x%px)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
 		delete_object_part((unsigned long)ptr, size, false);
@@ -1134,7 +1132,7 @@ void __ref kmemleak_free_percpu(const void __percpu *ptr)
 {
 	unsigned int cpu;
 
-	pr_debug("%s(0x%p)\n", __func__, ptr);
+	pr_debug("%s(0x%px)\n", __func__, ptr);
 
 	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
 		for_each_possible_cpu(cpu)
@@ -1155,7 +1153,7 @@ void __ref kmemleak_update_trace(const void *ptr)
 	struct kmemleak_object *object;
 	unsigned long flags;
 
-	pr_debug("%s(0x%p)\n", __func__, ptr);
+	pr_debug("%s(0x%px)\n", __func__, ptr);
 
 	if (!kmemleak_enabled || IS_ERR_OR_NULL(ptr))
 		return;
@@ -1186,7 +1184,7 @@ EXPORT_SYMBOL(kmemleak_update_trace);
  */
 void __ref kmemleak_not_leak(const void *ptr)
 {
-	pr_debug("%s(0x%p)\n", __func__, ptr);
+	pr_debug("%s(0x%px)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
 		make_gray_object((unsigned long)ptr);
@@ -1204,7 +1202,7 @@ EXPORT_SYMBOL(kmemleak_not_leak);
  */
 void __ref kmemleak_ignore(const void *ptr)
 {
-	pr_debug("%s(0x%p)\n", __func__, ptr);
+	pr_debug("%s(0x%px)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
 		make_black_object((unsigned long)ptr, false);
@@ -1224,7 +1222,7 @@ EXPORT_SYMBOL(kmemleak_ignore);
  */
 void __ref kmemleak_scan_area(const void *ptr, size_t size, gfp_t gfp)
 {
-	pr_debug("%s(0x%p)\n", __func__, ptr);
+	pr_debug("%s(0x%px)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && size && !IS_ERR(ptr))
 		add_scan_area((unsigned long)ptr, size, gfp);
@@ -1242,7 +1240,7 @@ EXPORT_SYMBOL(kmemleak_scan_area);
  */
 void __ref kmemleak_no_scan(const void *ptr)
 {
-	pr_debug("%s(0x%p)\n", __func__, ptr);
+	pr_debug("%s(0x%px)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
 		object_no_scan((unsigned long)ptr);
@@ -1258,7 +1256,7 @@ EXPORT_SYMBOL(kmemleak_no_scan);
  */
 void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, gfp_t gfp)
 {
-	pr_debug("%s(0x%p, %zu)\n", __func__, &phys, size);
+	pr_debug("%s(0x%px, %zu)\n", __func__, &phys, size);
 
 	if (kmemleak_enabled)
 		/*
@@ -1278,7 +1276,7 @@ EXPORT_SYMBOL(kmemleak_alloc_phys);
  */
 void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
 {
-	pr_debug("%s(0x%p)\n", __func__, &phys);
+	pr_debug("%s(0x%px)\n", __func__, &phys);
 
 	if (kmemleak_enabled)
 		delete_object_part((unsigned long)phys, size, true);
@@ -1292,7 +1290,7 @@ EXPORT_SYMBOL(kmemleak_free_part_phys);
  */
 void __ref kmemleak_ignore_phys(phys_addr_t phys)
 {
-	pr_debug("%s(0x%p)\n", __func__, &phys);
+	pr_debug("%s(0x%px)\n", __func__, &phys);
 
 	if (kmemleak_enabled)
 		make_black_object((unsigned long)phys, true);
-- 
2.34.1

