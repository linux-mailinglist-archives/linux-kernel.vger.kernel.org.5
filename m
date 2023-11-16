Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4E87EDEFF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345060AbjKPKyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345040AbjKPKyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:54:53 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4C2D41
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:54:49 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5bd6ac9833fso478083a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700132088; x=1700736888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nPw4dJsdNVea4Mwao+FPddUZ3ILoF14eyx6XTqNoJZY=;
        b=OSBLb1ZUBVTGQgUiyx0BrBwboNi8SdjQ5fy0Z31DB4Ya7i8a7K56Mmm+g20RzPbQWr
         PqFZGTc7xAdgmCpdGO4j55YdeIj/JeHLO4G1ZXq+VTxaV8/OT7f7E2EHi1n5x5wIkrmf
         uQAo2wbNYpj4t8qSETwKP7mTdDMWiLaQWx7GtR6ATQ+SfFHuFgMpZ91Eo8gnudqoC6MF
         MZQ8NzrDQe82cUFWsVxm+Ivr8coW95DSFDgj25bC7RPqvxIg8kGZByA5stqrTpW3DEZi
         lexOOkbwKrVTu2KVprVqiwFaJW1TyFGheENfzUzaJNohNZqfVD/FSO1voMowjWy6LWYz
         5eMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700132088; x=1700736888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPw4dJsdNVea4Mwao+FPddUZ3ILoF14eyx6XTqNoJZY=;
        b=bVB+xODDxYpBf0wjof7Ng3ioYRbr0L1+hVZVHoltFFxO9IZ7xJfgk3katMdQlBWDTW
         MECV0xMj0JKQa1cWO0i8Yak4Jl+jaxWktw6SOQxeK8qpyuYSx7wmjDq4OaCZMehfGbqQ
         tff5TmwRA8QcD2njgb8SUDwNhCrlhsTPmKbpIo45MSSRZkv/9J+zAGI2D739bRR7TUWD
         0qWhORczhwcAwQW3YU79wwyzoxwP8B9lVUwSw+8MLp2cP6i0GMurSNG5BMa89oOAv8Er
         cQ62eJlSPeo1BXwAJTkN0Q4eScOcjku4VkUhcLMlNW3tX/zAnrwfGNlSnsFq+51cwI2I
         MHfA==
X-Gm-Message-State: AOJu0Yzr+2idXubde2q+tUDk7lsn6SSmmsNfSnj5HuABzoAL+xhNw2KR
        fLbDpp9deWa3m73bJ+G2mlA=
X-Google-Smtp-Source: AGHT+IEeZkiBWFrtj1Uu2IlgczoEeuXUZZbXGUjmtJqBYTeH//XKo1Tddms39G3fX8q/+jywP8uBzg==
X-Received: by 2002:a05:6a21:32a9:b0:186:e4c2:4937 with SMTP id yt41-20020a056a2132a900b00186e4c24937mr10166208pzb.23.1700132088372;
        Thu, 16 Nov 2023 02:54:48 -0800 (PST)
Received: from rin-ROG-STRIX-G10CES-G10CES.. (111-255-239-171.dynamic-ip.hinet.net. [111.255.239.171])
        by smtp.gmail.com with ESMTPSA id mf11-20020a17090b184b00b002802a080d1dsm1325064pjb.16.2023.11.16.02.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:54:48 -0800 (PST)
From:   Yiwei Lin <s921975628@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        wuyun.abel@bytedance.com, linux-kernel@vger.kernel.org,
        s921975628@gmail.com
Subject: [PATCH 0/1] sched/fair: Update min_vruntime in more relaxed way
Date:   Thu, 16 Nov 2023 18:54:24 +0800
Message-Id: <20231116105425.84773-1-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because we only use min_vruntime as an offset to avoid
overflow, and we will always update_curr() before making
change to csf_rq. Unlike the requirement on CFS, I
think it is possible to just update_min_vruntime() when
update_curr(), which reduces the cost to evaluate the statistic.

It is worth metioning that maybe we can update_min_vruntime() in
a more relaxed form according to this fact, but we may need more
works to optimize in the future.

The following link shows some discussion which relates to this patch:
https://lore.kernel.org/lkml/20231107090510.71322-1-wuyun.abel@bytedance.com/T/#mc277f045367f4186b34c83e636907ce2f5eb481e

Yiwei Lin (1):
  sched/fair: Update min_vruntime in more relaxed way

 kernel/sched/fair.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

-- 
2.34.1

