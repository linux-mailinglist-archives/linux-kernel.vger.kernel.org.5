Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01CE809F6F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573443AbjLHJdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjLHJdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:33:09 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E834210CA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 01:33:15 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1f47f91fc0so168438666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 01:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1702027994; x=1702632794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ml3aYbEq09uGjduR2N6EJX5pAeyS3QJMe6FIXxf84y8=;
        b=QE1yCNi/RKufBR/+9V8qBw+gNmJ7H8TD55foVj7sizAM1YtpZkH4NvnxOF5vNd0a7/
         zP9liIPL+7PKC9TUv36IcDL0LHhXXTZjAHZfYCgqI07ENhRBLh9NvWOAVgRlMgTa97BO
         7/iJWvHZYS7zsVFOCAoAEgH3PimGntYufZ7+LdMFB+TIcUxcyYlOqeQStJvTpIhFCWlN
         lKsnrcZcSQ+j33SecPZ98Fg/GEoaEX5XA2/nMsmZwXTWGhwSEmdbTO37wCGD0hdn2LVi
         8R0Jkgiu39W+7o8D4QgNs5BBzLVAYF2b7LGk3nKuU0SUSXUe0Pwnus+RI1YwhEEaxqfn
         Rsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702027994; x=1702632794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ml3aYbEq09uGjduR2N6EJX5pAeyS3QJMe6FIXxf84y8=;
        b=EZxMqX7gYh18MvlAVolEFeCOkHf69dwPP9kVBLgMnn+NrT6int02Usaj5k3IEFNJ1X
         HLCmVlFtK2ui0UnDbQddAu/E/oJJu0WKlxubktySowGmd+dBBJbl/JVLyoDfjZbMg5vM
         ceL00gsqJgjp9E+iEXiWSwX9JTHPD7MhOnVTKwgWSslBcDLZ1EOJMhyKIagQ4gQq3qdp
         Qv0vKO07nmtV++PYItm6oF0z1ldL/6l5ogqPwwB9Wq+zn/WyggJOz9RqAU1zhcze7Rc5
         OYFoSlV1FEJMJntGCvvOMtgrn/aVpS7tXHnpKaY70YcjyKa98aBHzs2TW6pZpQ0IXL6Z
         U0Xw==
X-Gm-Message-State: AOJu0YxkvwOKTR3nWR2dfGHGhc09unNKN0mV+qOUQK8juiU0IWP52lxr
        wF9PY3de/DpCJdja5lF3c1wRkg==
X-Google-Smtp-Source: AGHT+IEuKQeMuuKkaUhmEtfSrBM5Y2r6Yi4pZc13ZcJTRcSq5BfXk+frg+NXJmtaY+6NBNePrmd0Lg==
X-Received: by 2002:a17:906:eb57:b0:a19:a19b:55c3 with SMTP id mc23-20020a170906eb5700b00a19a19b55c3mr1992038ejb.83.1702027994303;
        Fri, 08 Dec 2023 01:33:14 -0800 (PST)
Received: from heron.intern.cm-ag (p200300dc6f0b6500529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f0b:6500:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id vk5-20020a170907cbc500b00a1ce56f7b16sm774812ejc.71.2023.12.08.01.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 01:33:14 -0800 (PST)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc:     Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 2/2] fs/kernfs/dir: obey S_ISGID
Date:   Fri,  8 Dec 2023 10:33:10 +0100
Message-Id: <20231208093310.297233-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231208093310.297233-1-max.kellermann@ionos.com>
References: <20231208093310.297233-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handling of S_ISGID is usually done by inode_init_owner() in all other
filesystems, but kernfs doesn't use that function.  In kernfs, struct
kernfs_node is the primary data structure, and struct inode is only
created from it on demand.  Therefore, inode_init_owner() can't be
used and we need to imitate its behavior.

S_ISGID support is useful for the cgroup filesystem; it allows
subtrees managed by an unprivileged process to retain a certain owner
gid, which then enables sharing access to the subtree with another
unprivileged process.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Acked-by: Tejun Heo <tj@kernel.org>
--
v1 -> v2: minor coding style fix (comment)
---
 fs/kernfs/dir.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8b2bd65d70e7..62d39ecf0a46 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -676,6 +676,18 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn;
 
+	if (parent->mode & S_ISGID) {
+		/* this code block imitates inode_init_owner() for
+		 * kernfs
+		 */
+
+		if (parent->iattr)
+			gid = parent->iattr->ia_gid;
+
+		if (flags & KERNFS_DIR)
+			mode |= S_ISGID;
+	}
+
 	kn = __kernfs_new_node(kernfs_root(parent), parent,
 			       name, mode, uid, gid, flags);
 	if (kn) {
-- 
2.39.2

