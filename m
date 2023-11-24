Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669C27F74A0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjKXNNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjKXNNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:13:15 -0500
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFC410DC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:13:22 -0800 (PST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2859d0d09a3so20085a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:13:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700831602; x=1701436402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8W2/y1DTkb3zOaGhAOkLLti9FUuKiVwIKZjOaFB7Fo=;
        b=nTVAN5Gn38U1Co5XYlh524HCVE2sgD/5eUlI0QsoZW/FnO/VCeCV/cNUuXde+HY2Rp
         Xk+Ydi4GCil2GQ0171eH2AwTo0rL7HvLTEg1nHYntgbpGGdpf7JwmiCuBsrwTEeJNGl4
         eXMeRgJY1hm+f2n2/3CuUDKAltz7Ab4+9Jsu5xIMd61Eb5zu8VSBlOxyEOgLZh4xcSnD
         cKgEZ/S50TL01h3GTGt1t7efbH8/b573HfEaCfTkVbE0oc4YCwMFB2GZnBxO+Ma0VrCA
         U5lEVfRkZP+aiG2QJq5VT3+bIOTa/x3BSPSjWhEpqOH0O68G/xaC/2dY14rujGj82Wms
         tp/g==
X-Gm-Message-State: AOJu0Ywnvk9tMHpALpiyAJyZbDk6wt8Pibfyj7fooEwE0YxX7dpmzVtr
        d3Tnzv9zLw/Zel0ADAeanSAGI9Unm1u5BatYbh5ZhRNcPjt/rMw=
X-Google-Smtp-Source: AGHT+IFvJ1Gx78AdMdl+hqo8h0fGCZua6acNdkV2WmJXC0loBdx8mfTYTuuVs6OVjLztyWGFrgwr5gUvFfXsS7P03d2eEm0UpXFs
MIME-Version: 1.0
X-Received: by 2002:a17:90a:6587:b0:27f:fc05:3c0d with SMTP id
 k7-20020a17090a658700b0027ffc053c0dmr552632pjj.8.1700831602014; Fri, 24 Nov
 2023 05:13:22 -0800 (PST)
Date:   Fri, 24 Nov 2023 05:13:21 -0800
In-Reply-To: <000000000000fb2f84060ad4da7f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075ffad060ae5b7cb@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in indx_insert_into_buffer
From:   syzbot <syzbot+c5b339d16ffa61fd512d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [ntfs3?] WARNING in indx_insert_into_buffer
Author: eadavis@qq.com

please test WARNING in indx_insert_into_buffer

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 037266a5f723

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index cf92b2433f7a..ea8b605471eb 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1892,6 +1892,8 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	 * We've finished splitting everybody, so we are ready to
 	 * insert the promoted entry into the parent.
 	 */
+	printk("l: %d, e: %d, h1: %p, h1s: %p, u1: %d, %d\n", level, err, hdr1, hdr1_saved, 
+				used1, le32_to_cpu(hdr1->used));
 	if (!level) {
 		/* Insert in root. */
 		err = indx_insert_into_root(indx, ni, up_e, NULL, ctx, fnd, 0);
@@ -1909,6 +1911,10 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 		 * Undo critical operations.
 		 */
 		indx_mark_free(indx, ni, new_vbn >> indx->idx2vbn_bits);
+		printk("%d, e: %d, h1: %p, h1s: %p, u1: %d, %d\n", level, err, hdr1, hdr1_saved, 
+				used1, le32_to_cpu(hdr1->used));
+		if (!level && err == -ENOMEM)
+			goto out;
 		memcpy(hdr1, hdr1_saved, used1);
 		indx_write(indx, ni, n1, 0);
 	}
@@ -1916,6 +1922,7 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 out:
 	kfree(up_e);
 	kfree(hdr1_saved);
+	printk("h1: %p, e: %d", hdr1, err);
 
 	return err;
 }

