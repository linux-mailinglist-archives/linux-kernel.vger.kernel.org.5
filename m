Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C3C7EDFB7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345234AbjKPLZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345253AbjKPLZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:25:44 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4549DD5E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:25:39 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32f737deedfso476328f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700133937; x=1700738737; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1YX8Ma5KZ+r8tu/EL90pFa7sq/MQQuAqGo7t9/vWh4o=;
        b=h6IWRuMOdAw7ibiv4mDnmIhzU2TgCMrq4eAvysZnU1ALvcCu6ymcHc+ZmsWPUFxXDf
         IKE3MiQ0XNAQSVbLVlm4f/VXQHEUykuyZnHHQTTh3Opak56ml3xSfv65TGCxnlW/e2rB
         F+o6+MKn3j9IA308UEmB/GuV5uvlhXSx1bHyBTm9A9tE+BVH8J78l/xh9o600nZAKAUL
         ehB0u2IWy9UpPX9Zs8i0rVahhI1tyX80blImX/8pdqS8cRNfT/mGCCfi9SkBU+54p0BX
         XgdFoP2Q/JEehHOYjbFTEfVQa2Ex2t/4RYnXgvES08yosP9N2yVgqiDORkl88Fp5Kd3I
         X8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700133937; x=1700738737;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YX8Ma5KZ+r8tu/EL90pFa7sq/MQQuAqGo7t9/vWh4o=;
        b=ru/2d0pV6Qb1U95BBss1hr0mo5FTq52lGgPzMHnl63kIWHd/ynZBZ26wmp1UHlr4/4
         T4cRyUtXWVIlNktbZ2h7b19rZz16Vauii6ySNMLTakobV0LWhKlrXFBySB8f2ZaCT9ro
         bdqSz09FVWIVEHYB+hBNNK7jh+SdbKpcJhPtHyWld22FzLMe6I5UFv1O41c3olQDLdSz
         llGoov0lGtUMsz9qbDSaZSSXjZaXOktxuYHAHuaiPeIP4hMLkZe+k0kC+DeZmt5K0aXu
         +JZFCjLRKn1axyLaN1MmAQYShHu+S4jOe8RClaQSfogJbgxSGaaxqMLwnPja+ys8MOEy
         JrXQ==
X-Gm-Message-State: AOJu0YzChYlDeddXy7WsZN+bQeVgDv+1E+0ze6au8H8+Pif3oTBwGueL
        TMZeYH0p51ZXNWRgirXCrN9oo92pRA==
X-Google-Smtp-Source: AGHT+IEKbLwKhjaGhRimyAQP2Qm8j6xMPOMrsJGbuXtsUoXAiuYRudvUu3QNjoKr/UGhXcuP2Zn0OA==
X-Received: by 2002:a05:6000:1818:b0:32d:9a1b:5d7f with SMTP id m24-20020a056000181800b0032d9a1b5d7fmr11330684wrh.29.1700133937381;
        Thu, 16 Nov 2023 03:25:37 -0800 (PST)
Received: from p183 ([46.53.252.123])
        by smtp.gmail.com with ESMTPSA id w3-20020a5d4b43000000b0032cc35c2ef7sm13300534wrs.29.2023.11.16.03.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 03:25:37 -0800 (PST)
Date:   Thu, 16 Nov 2023 14:25:35 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lockdep: optimise "struct lock_class" layout
Message-ID: <e527403e-9be1-4aa2-98c0-a3ab1f02787f@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct lock_class does

	const struct lock_trace *	usage_traces[];
	int				name_version;
	const char *			name;

which wastes 4 bytes after "name_version".

Put pointer after pointers shrinking sizeof from 208 bytes to 200 bytes.
Space savings are considerable for such a trivial patch:

	$ ./scripts/bloat-o-meter ../vmlinux-000 ../obj/vmlinux
	add/remove: 0/0 grow/shrink: 1/11 up/down: 2/-65640 (-65638)
	Function                       old     new   delta
	check_irq_usage               2852    2854      +2
	reacquire_held_locks           486     484      -2
	lock_chain_get_class            41      39      -2
	l_start                         34      32      -2
	check_noncircular              276     274      -2
	print_usage_bug.part           688     683      -5
	print_circular_bug            1017    1011      -6
	hlock_conflict                 141     135      -6
	print_deadlock_bug             944     935      -9
	mark_lock                     3791    3769     -22
	__lock_acquire                9801    9753     -48
	lock_classes               1703936 1638400  -65536
	Total: Before=21163908, After=21098270, chg -0.31%

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/lockdep_types.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -127,12 +127,12 @@ struct lock_class {
 	unsigned long			usage_mask;
 	const struct lock_trace		*usage_traces[LOCK_TRACE_STATES];
 
+	const char			*name;
 	/*
 	 * Generation counter, when doing certain classes of graph walking,
 	 * to ensure that we check one node only once:
 	 */
 	int				name_version;
-	const char			*name;
 
 	u8				wait_type_inner;
 	u8				wait_type_outer;
