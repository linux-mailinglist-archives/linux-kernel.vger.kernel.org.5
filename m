Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD297F87E9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 03:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjKYCqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 21:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYCqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 21:46:48 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BB41702
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 18:46:54 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c1bfd086f0so2773198a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 18:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700880413; x=1701485213;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I39ioAM3Aka7GAnl1o2N13zSIx6wGAuQ37kD+RV/0Mg=;
        b=Mr58Wa1cSiU8x3VuBfH9iKIf5Kw1SUWo89wG2KlkPho9GZb+OFeQsGmcL8iy42lFMT
         NBi1HChTsAGGGakvcjdBQAICbFqE8MRUU1ll12mr7z5k4/hMdSgNFdaXEdFO6BnP228D
         esn62Wq7Ms6DpXcZqU5ALksmpQOcVYrnmQKTL/5MoqZuWQfmRtXWeWgnqUV6HufZqstZ
         cSk+JD0K7+FhFlx+HUtepFImjqk2Ri3LmL06IpPU7UGS1eGv+qWPyBIJ0boGOPx+mm3E
         gNtrx9a+wF9MoeUt7lEW2WMfWwF4vS7NZ7M7GvZB6ePJftMCz5nYDe+uOLEHkeIm22oV
         1Fvw==
X-Gm-Message-State: AOJu0YywblK/cbKZrEKS1Cqn702nwe518x4JNdMf2R5l+fPaLm8jgleA
        XNvjv3umh8YHz90+8xLovFWLMqIUKZqg8GoBlSWRfF09zNCsqsE=
X-Google-Smtp-Source: AGHT+IHGRLrpGehUUUQrfXdyPptRj55xovUyoVZXEWM3lGfwQZKVYps0y0PKVv1gxQpvU2omNTyFa0UqZaMNWx7MKiDhczAxW/5t
MIME-Version: 1.0
X-Received: by 2002:a63:ed03:0:b0:5c2:1816:24c4 with SMTP id
 d3-20020a63ed03000000b005c2181624c4mr716190pgi.10.1700880413701; Fri, 24 Nov
 2023 18:46:53 -0800 (PST)
Date:   Fri, 24 Nov 2023 18:46:53 -0800
In-Reply-To: <000000000000fb2f84060ad4da7f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd3c09060af11448@google.com>
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
index cf92b2433f7a..67c27e6ce497 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1816,6 +1816,9 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	 * - Insert sp into parent buffer (or root)
 	 * - Make sp a parent for new buffer
 	 */
+	printk("l: %d, u1: %d, t: %d, do: %d\n", 
+		level, le32_to_cpu(hdr1->used), le32_to_cpu(hdr1->total), 
+		le32_to_cpu(hdr1->de_off));
 	sp = hdr_find_split(hdr1);
 	if (!sp)
 		return -EINVAL;
@@ -1833,6 +1836,8 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 		goto out;
 	}
 
+	printk("l: %d, u1: %d, sps: %d, t: %d, do: %d\n", 
+		level, used1, sp_size, le32_to_cpu(hdr1->total), le32_to_cpu(hdr1->de_off));
 	if (!hdr1->flags) {
 		up_e->flags |= NTFS_IE_HAS_SUBNODES;
 		up_e->size = cpu_to_le16(sp_size + sizeof(u64));
@@ -1895,6 +1900,8 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	if (!level) {
 		/* Insert in root. */
 		err = indx_insert_into_root(indx, ni, up_e, NULL, ctx, fnd, 0);
+		//if (err == -ENOMEM)
+		//	goto out;
 	} else {
 		/*
 		 * The target buffer's parent is another index buffer.
@@ -1909,6 +1916,8 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 		 * Undo critical operations.
 		 */
 		indx_mark_free(indx, ni, new_vbn >> indx->idx2vbn_bits);
+		printk("%d, u1: %d, sps: %d, t: %d, do: %d\n", 
+		level, used1, sp_size, le32_to_cpu(hdr1->total), le32_to_cpu(hdr1->de_off));
 		memcpy(hdr1, hdr1_saved, used1);
 		indx_write(indx, ni, n1, 0);
 	}
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 86aecbb01a92..67d0fd8f5b7d 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -759,7 +759,7 @@ static inline bool hdr_has_subnode(const struct INDEX_HDR *hdr)
 struct INDEX_BUFFER {
 	struct NTFS_RECORD_HEADER rhdr; // 'INDX'
 	__le64 vbn; // 0x10: vcn if index >= cluster or vsn id index < cluster
-	struct INDEX_HDR ihdr; // 0x18:
+	DECLARE_FLEX_ARRAY(struct INDEX_HDR, ihdr); // 0x18:
 };
 
 static_assert(sizeof(struct INDEX_BUFFER) == 0x28);

