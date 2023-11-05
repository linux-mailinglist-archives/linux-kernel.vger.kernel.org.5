Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0807E1753
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 23:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjKEWWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 17:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEWWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 17:22:30 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4363ACF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 14:22:28 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4084e49a5e5so34329145e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 14:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699222946; x=1699827746; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fa7VoOmtHE16gBTWR/+bdTB9GnKF9MNv8UM/ZbtRuKs=;
        b=dX27NH2QOGBccCxu8ShUtGVYAnOwCKukrFjwaHcyGlaJhvD0591L9OFEQoIoQdXuzy
         cpjCyyQEAyhF2S/ghrd62+ucToUUPoOL4h4Os+DtCnzceOfylWV0/dJAsX0tTWb4TOBv
         ZRZSQd4aM00/u4WcgHDep5gAL0Qduq2ZsUZDSySqr8JqNCnwYsliNoCBIAfASceV0/Na
         Hw8PQKN9jRoMH5Zky24Uf4vZSjo/GBSRMVfoZf2OC3Ge/V3XNIGWCl+Y3n+/NxJUyRjr
         nNaYNWBF1ctuL3xt4zjWBAkzODrhB8Q9Lnfsxt6Awwo9tFfkJDpxAkKybhGicEKQ2jQc
         KvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699222946; x=1699827746;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fa7VoOmtHE16gBTWR/+bdTB9GnKF9MNv8UM/ZbtRuKs=;
        b=vNk1jx+LurvfESoiaCT3dV20RMZg3zfvFateyEyiRhYuEsy/8zIbAlsBaGBLfgxvqN
         TxWcBDvYZC+gn+ryqU7XMwvH8qsMAEyt9MHHBY25QoUgsXUbsGVLQOOvb0o2607C94dV
         YMbAlIyblKnmKHR0lfDMeSblw5UG5UJhqT+gX+V8YoXqv+utdYzS3d7jMLwcTnOeMZla
         jyyrZj3sBYMmQQl85+1yVCHBdU+UfuS7DryoRSwnQlwsIT3yWRp+d+Itzj+SW2LIF+dE
         ljeENA7Ix7XY1lNS2jn+x122LMLbo7ciSALiFADHZatW9/Q42UKA3mxUokb6Syfcr/ZM
         Tk0w==
X-Gm-Message-State: AOJu0YyFwyhaTI+lDX8TRqTqLt7fzsTw9FJm2pOyTO6zjFZ/f2ty/ume
        qrz1o8wxxc8p8IVJuht1ZEZAuGDHPOJIxKiS22SOyEcmNjO+rw==
X-Google-Smtp-Source: AGHT+IHXnJwam1wVAhJbsx1NigqbRmrizPXr6cHJVucVvWT80uKsvcYYoBOHHlAJW6Nb1BqjdSMMrafSIc9ECrnJzlw=
X-Received: by 2002:a5d:6489:0:b0:32f:94a5:5726 with SMTP id
 o9-20020a5d6489000000b0032f94a55726mr15280928wri.32.1699222945996; Sun, 05
 Nov 2023 14:22:25 -0800 (PST)
MIME-Version: 1.0
From:   Joey Pabalinas <joeypabalinas@gmail.com>
Date:   Sun, 5 Nov 2023 12:21:49 -1000
Message-ID: <CAFhcgOWDZ8+KiwmFRYnaBrqSHyeGDX20PgjGHXWK5UikZHPCmA@mail.gmail.com>
Subject: [PATCH] fs: dlm: Remove impossible to hit if statement
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
---
 fs/dlm/member.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index be7909ead71b427aa5..bf7085f21a708ab860 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -294,19 +294,14 @@ static void add_ordered_member(struct dlm_ls
*ls, struct dlm_member *new)
  memb = list_entry(tmp, struct dlm_member, list);
  if (new->nodeid < memb->nodeid)
  break;
  }

- if (!memb)
- list_add_tail(newlist, head);
- else {
- /* FIXME: can use list macro here */
- newlist->prev = tmp->prev;
- newlist->next = tmp;
- tmp->prev->next = newlist;
- tmp->prev = newlist;
- }
+ newlist->prev = tmp->prev;
+ newlist->next = tmp;
+ tmp->prev->next = newlist;
+ tmp->prev = newlist;
 }

 static int add_remote_member(int nodeid)
 {
  int error;

base-commit: 1c41041124bd14dd6610da256a3da4e5b74ce6b1
-- 
Cheers,
Joey Pabalinas
