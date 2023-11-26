Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3297F932E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 15:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjKZOtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 09:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZOtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 09:49:40 -0500
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B658192
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 06:49:45 -0800 (PST)
Received: from pop-os.home ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id 7GS6rtIcCmTW57GS7rbvab; Sun, 26 Nov 2023 15:49:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1701010183;
        bh=iCucAYF477kNI1im5xQ/khbymwoZZ8iwxk7MzQbavyc=;
        h=From:To:Cc:Subject:Date;
        b=NxlB7LRXIS360L+bGzATYs/jW1KNTT9Ejfv1fOlGUtvMipDIyLZnHUiKaypxBGKjp
         ivYgt/TkCjScIRNrB0Y9ajojgTnXQl/Qd+cZOS2yfXU2qeiH7/+KRaVilbuFEab3Fh
         AY1tGJNy2fXokJw2ONntvG5YtnY2jinFx16/y9zYMF2wK6roTVf8H2Ex62muzMemIB
         +zQWetqIvqUJ7h7FEOdzJ3dugib0FmvNMxcB9uDgDs4X7o7tPyMXSSgytFQ2XThI/H
         6FFJYNk58uU2mZ7QmoYETKlKvinsKbPZVVog6vE0/Ke6BCrmDb7KSjbA7iwRp6Ln5f
         GIoAZm5TY767w==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Nov 2023 15:49:43 +0100
X-ME-IP: 92.140.202.140
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] kernfs:  reorder 'struct kernfs_node' to save some memory
Date:   Sun, 26 Nov 2023 15:49:37 +0100
Message-Id: <465890c56c6f5ad702a091a1ecd3c70bd4a3a74c.1701010150.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct kernfs_node' uses a dedicated cache, so shrinking its size is
always a good idea.

On my system, each entry is 128 bytes and their are 32 entries per pages.
After the re-ordering, the struct is 120 bytes and 34 entries are stored
in each page.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The numbers below are with a allmodconfig configuration. The delta is
related to CONFIG_DEBUG_LOCK_ALLOC and struct lockdep_map	dep_map.

When I checked on my system, it would have saved 372kb of RAM:
  sudo less /proc/slabinfo | grep kernf
  kernfs_node_cache  49397  49504    128   32    1 : tunables    0    0    0 : slabdata   1547   1547      0

I have left flags close to the union, I *think* that they are related.
I don't if having 'mode' here is logical or not.

Before:
======
struct kernfs_node {
        atomic_t                   count;                /*     0     4 */
        atomic_t                   active;               /*     4     4 */
        struct lockdep_map         dep_map;              /*     8    48 */
        struct kernfs_node *       parent;               /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        const char  *              name;                 /*    64     8 */
        struct rb_node             rb __attribute__((__aligned__(8))); /*    72    24 */
        const void  *              ns;                   /*    96     8 */
        unsigned int               hash;                 /*   104     4 */

        /* XXX 4 bytes hole, try to pack */

        union {
                struct kernfs_elem_dir dir;              /*   112    32 */
                struct kernfs_elem_symlink symlink;      /*   112     8 */
                struct kernfs_elem_attr attr;            /*   112    32 */
        };                                               /*   112    32 */
        /* --- cacheline 2 boundary (128 bytes) was 16 bytes ago --- */
        void *                     priv;                 /*   144     8 */
        u64                        id;                   /*   152     8 */
        short unsigned int         flags;                /*   160     2 */
        umode_t                    mode;                 /*   162     2 */

        /* XXX 4 bytes hole, try to pack */

        struct kernfs_iattrs *     iattr;                /*   168     8 */

        /* size: 176, cachelines: 3, members: 14 */
        /* sum members: 168, holes: 2, sum holes: 8 */
        /* forced alignments: 1 */
        /* last cacheline: 48 bytes */
} __attribute__((__aligned__(8)));

After:
=====
struct kernfs_node {
        atomic_t                   count;                /*     0     4 */
        atomic_t                   active;               /*     4     4 */
        struct lockdep_map         dep_map;              /*     8    48 */
        struct kernfs_node *       parent;               /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        const char  *              name;                 /*    64     8 */
        struct rb_node             rb __attribute__((__aligned__(8))); /*    72    24 */
        const void  *              ns;                   /*    96     8 */
        unsigned int               hash;                 /*   104     4 */
        umode_t                    mode;                 /*   108     2 */
        short unsigned int         flags;                /*   110     2 */
        union {
                struct kernfs_elem_dir dir;              /*   112    32 */
                struct kernfs_elem_symlink symlink;      /*   112     8 */
                struct kernfs_elem_attr attr;            /*   112    32 */
        };                                               /*   112    32 */
        /* --- cacheline 2 boundary (128 bytes) was 16 bytes ago --- */
        void *                     priv;                 /*   144     8 */
        u64                        id;                   /*   152     8 */
        struct kernfs_iattrs *     iattr;                /*   160     8 */

        /* size: 168, cachelines: 3, members: 14 */
        /* forced alignments: 1 */
        /* last cacheline: 40 bytes */
} __attribute__((__aligned__(8)));
---
 include/linux/kernfs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 99aaa050ccb7..b7cd6e793286 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -206,6 +206,8 @@ struct kernfs_node {
 
 	const void		*ns;	/* namespace tag */
 	unsigned int		hash;	/* ns + name hash */
+	umode_t			mode;
+	unsigned short		flags;
 	union {
 		struct kernfs_elem_dir		dir;
 		struct kernfs_elem_symlink	symlink;
@@ -220,8 +222,6 @@ struct kernfs_node {
 	 */
 	u64			id;
 
-	unsigned short		flags;
-	umode_t			mode;
 	struct kernfs_iattrs	*iattr;
 };
 
-- 
2.34.1

