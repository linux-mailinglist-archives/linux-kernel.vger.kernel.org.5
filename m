Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101E87C9548
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 18:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjJNQOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 12:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjJNQOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 12:14:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FDAD7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 09:14:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53e84912038so521499a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 09:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697300058; x=1697904858; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+ivNfTDHIsqHJ1JTSXb0uVQIdYQ3DRGLDEgHrf6wmY=;
        b=UvODmFS/hi9UX2xFdOxaYy8urpjdOToMJkOLov/9d7gipGogeOB7FHXjOqwZXmG3/4
         8gUowlgzO3kx6sps/EhwMQkq7XPo62/BPBALKuafQJUWbILgAN+sEYPS90wWRor9G1NG
         lzYdiKtm14BE54tEPO7JitJaQIIe1yTTKUf+jB+6NfQuU/6MUyPsGQOjdy5yMN9LXEjJ
         eOKYO17/GLU/KBS/4A59xAVZNhB6VMmW5TZ3PV7BJcRxACHJIA8KuZOUxjp/I0nqkVgG
         q/o9WgSmMawntPz0JvxQOOWPCEnLl7QkwlZAo1jatjcWrls6R+YrddLAR94dba558FKY
         alfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697300058; x=1697904858;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+ivNfTDHIsqHJ1JTSXb0uVQIdYQ3DRGLDEgHrf6wmY=;
        b=l8L930EJpxUym0CiGBCndp+ukfCfqzb3gmqPKLlf5JOE+Svb0zF89sxT07wCjlhrAX
         B+3g3zQb2tyFJRuJLSSvS5DS0z4QByKLdMZuTKaRXie9PpR0zvWI1KVUNhJqHP7EPaXC
         bEw547dGUvjwXsjGWkis+yIRmGLaIqs9lWDjd93kP11EdbZ1OQNfevoWp7JpwRrjE+w7
         Y7RffvxdGNiknxGE9o7fZi1lVCZosujn15XOnlAOLOFbc3MyRIpSS1SKsPzBGcc8B+o4
         sdaOzI/cx9LvGkEkDofaHUAhjGftKtmBrSk5Ry+7VxE448zIQp4xMfDA3CaLRqzU3l7q
         Mh1w==
X-Gm-Message-State: AOJu0YyQ4pO00QOKaZlV2nR7RgHdE1JnINZJYZTsq5FKRnln5/g0XwIG
        +6OFcMlT/vysCSK5kpRWRndq01GT8g==
X-Google-Smtp-Source: AGHT+IFwyFm24nYmXMdTcQhxHdjQJrEV91vZcMyTBlzWWZoakfG4nMJnZcHhq5+Pi1QZxEVv0Fc2ZA==
X-Received: by 2002:a17:907:31c2:b0:9be:30c2:b8ff with SMTP id xf2-20020a17090731c200b009be30c2b8ffmr2805103ejb.61.1697300057731;
        Sat, 14 Oct 2023 09:14:17 -0700 (PDT)
Received: from p183 ([46.53.253.206])
        by smtp.gmail.com with ESMTPSA id hg22-20020a1709072cd600b0099d9dee8108sm1130147ejc.149.2023.10.14.09.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 09:14:17 -0700 (PDT)
Date:   Sat, 14 Oct 2023 19:14:15 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] smp: fix __smp_processor_id() backup macro
Message-ID: <b12bdef9-d5c0-49cf-aea2-ff7b56220fdc@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every __smp_processor_id usage doesn't have arguments and
every raw_smp_processor_id usage doesn't have arguments,
therefore "#define __smp_processor_id(x)" can not possibly work.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/smp.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -261,7 +261,7 @@ static inline int get_boot_cpu_id(void)
  * regular asm read for the stable.
  */
 #ifndef __smp_processor_id
-#define __smp_processor_id(x) raw_smp_processor_id(x)
+#define __smp_processor_id() raw_smp_processor_id()
 #endif
 
 #ifdef CONFIG_DEBUG_PREEMPT
