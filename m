Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13F8773EA6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjHHQd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjHHQcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:32:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1989D31029;
        Tue,  8 Aug 2023 08:52:01 -0700 (PDT)
Date:   Tue, 08 Aug 2023 08:44:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691484240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fk74tCtX53wVUn2Lm/NtmiVu1U7qFhlk1cx1q4Oyjgc=;
        b=kBTewyJl8lJyAvsER9fySaS2M7oa8WTobHE+tAL31bpku1DHabxX3j4vrIkpSxcXoCVlSu
        UW889tl1JEGy5/a469Hh4leMOG/k2tyLst0XdV7A782g7uPPOmT2hAWgefzB3JiWtxBkCF
        kWovHcZMa74R8iVSZDulwodh62pg0SXrOautcEOVbI8OejATI7IjrM76K9ny72BZvHUkki
        2JrFecvQ9UGYL/QP2ob05Edvy3D/IMaqd5mScwaB8XmDwuB8iwMGOBudcDsgFAJ5S2RSXg
        HmrW4k4Y/0ZhHVvYLeDIBjoWfaepuaD3tLfC0hm6NmJLK6pCQDQnonVOlnTVwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691484240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fk74tCtX53wVUn2Lm/NtmiVu1U7qFhlk1cx1q4Oyjgc=;
        b=c37Vpfy9lgdBz7GsthOrQq/vuiNud0IU51CfmeCTbfa67tH4Lg/f88xuwcT8Ur43ftGX8G
        iGQUItWTYPFb6xAA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] decompress: Use 8 byte alignment
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230807162720.545787-19-ardb@kernel.org>
References: <20230807162720.545787-19-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <169148424001.27769.17774724848904519464.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     8217ad0a435ff06d651d7298ea8ae8d72388179e
Gitweb:        https://git.kernel.org/tip/8217ad0a435ff06d651d7298ea8ae8d72388179e
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 07 Aug 2023 18:27:15 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Aug 2023 20:55:27 +02:00

decompress: Use 8 byte alignment

The ZSTD decompressor requires malloc() allocations to be 8 byte
aligned, so ensure that this the case.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230807162720.545787-19-ardb@kernel.org
---
 include/linux/decompress/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/decompress/mm.h b/include/linux/decompress/mm.h
index 9192986..ac86242 100644
--- a/include/linux/decompress/mm.h
+++ b/include/linux/decompress/mm.h
@@ -48,7 +48,7 @@ MALLOC_VISIBLE void *malloc(int size)
 	if (!malloc_ptr)
 		malloc_ptr = free_mem_ptr;
 
-	malloc_ptr = (malloc_ptr + 3) & ~3;     /* Align */
+	malloc_ptr = (malloc_ptr + 7) & ~7;     /* Align */
 
 	p = (void *)malloc_ptr;
 	malloc_ptr += size;
