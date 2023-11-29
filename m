Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58547FD317
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjK2Jq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjK2Jq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:46:56 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8ACD6C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:47:01 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9fd0059a967so133449566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701251220; x=1701856020; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lkr8t9D0wxE4Z/I0QJxL5c6oDaDd0nklY7ppqyjUFtU=;
        b=TQOiyCcjRGJnksqRkRqvqZhFDoqO4X5Wbg5ae7dhUUNBbwWrHggXVkOf9QYRCMUuPM
         nbcQ7V1JswKA78uXIVIkk56nqdxqFmoXhqr3AuZ3IwmzKjrmHfj9BdGewo6dEYhy2b3y
         oKwAGw/WhzvSK1uMLkZrLQuZtIbsyOjnwsEiTQDM4utvPwYaCQBuQ3HsrADM3fnQ6kCk
         Bb429IpiJYOHGMlwd3uj8wrkJHou7rRsJkDGNsFOW4tAgIe7Qgidnk4RRR7X81wXiiI1
         ZZGuaIs9kPsHef9s9pOyvQvZcZs4/NnOnepMVFtyxmEgrCI7RLdiUtp6rTPvyXCqys2K
         ZVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701251220; x=1701856020;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkr8t9D0wxE4Z/I0QJxL5c6oDaDd0nklY7ppqyjUFtU=;
        b=u2maBBXo/buIpUZ9zaYvtaLeQADv6zPTOnmWbMmetOhRsJtzHi9X7t73rL8rAvWIrn
         OfUCTr3Tep7OGZGOkXqp+si9OWkhUnb+7ODOpUOI3nWlTDuzG9/nneJklhtpYUdiokrZ
         hdTcCGB3mW6XsFesmZ8G++IiEc9US1PeUahUb7FssplP5Bq8I+LUe4yreKJO3J+PsqSo
         lZcQrDQ6LM5kAgmO9eavdC4YRB7vqQSPDoJEkjsoniBuIbcqJ4/v8ENFspp044OkTOh5
         qdbiXXd28WIEDVsXNqX9BjSt92ZSep2CSaOt0hK3jUmONstamC7owlslBhWOt4at54jW
         MC8A==
X-Gm-Message-State: AOJu0YxHkTc+xrQl9Tf2iDCcT8g3cBZMphslIoyCss4cMxnUUD5p75R3
        2feU/UlGWfsPZ8FpZTFk8RNhtrAiaw==
X-Google-Smtp-Source: AGHT+IH98tZUFJa7BN8QJdTW8Oa0vn2A1pJ5nvg6eWzJQF6TMyuXtFYt87/j86uYPcMRBoLqozruVA==
X-Received: by 2002:a17:906:100e:b0:a0e:7e2:1b1e with SMTP id 14-20020a170906100e00b00a0e07e21b1emr10029624ejm.23.1701251219936;
        Wed, 29 Nov 2023 01:46:59 -0800 (PST)
Received: from p183 ([46.53.250.67])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906218900b00a0988d69549sm6192529eju.189.2023.11.29.01.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:46:59 -0800 (PST)
Date:   Wed, 29 Nov 2023 12:46:57 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: make struct proc_dir_entry::name const
Message-ID: <d724d33e-7c0d-422b-8d23-3d677cc414fe@p183>
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

Multiply ::name into "mut_name" and "name" which is "const char*".

PDE's name must not be mutated on live PDE, hint modules they should not
do it.

Many other members must not be mutated live as well, but start with
obvious one.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/generic.c  |    2 +-
 fs/proc/internal.h |    5 ++++-
 fs/proc/proc_net.c |    2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -436,7 +436,7 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
 		}
 	}
 
-	memcpy(ent->name, fn, qstr.len + 1);
+	memcpy(ent->mut_name, fn, qstr.len + 1);
 	ent->namelen = qstr.len;
 	ent->mode = mode;
 	ent->nlink = nlink;
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -59,7 +59,10 @@ struct proc_dir_entry {
 	struct proc_dir_entry *parent;
 	struct rb_root subdir;
 	struct rb_node subdir_node;
-	char *name;
+	union {
+		const char *name;
+		char *mut_name;
+	};
 	umode_t mode;
 	u8 flags;
 	u8 namelen;
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -368,7 +368,7 @@ static __net_init int proc_net_ns_init(struct net *net)
 	netd->namelen = 3;
 	netd->parent = &proc_root;
 	netd->name = netd->inline_name;
-	memcpy(netd->name, "net", 4);
+	memcpy(netd->mut_name, "net", 4);
 
 	uid = make_kuid(net->user_ns, 0);
 	if (!uid_valid(uid))
