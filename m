Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8677F8AD5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjKYMmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjKYMmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:42:47 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A78DBF
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:42:53 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5aaae6f46e1so3287541a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:42:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700916173; x=1701520973;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVWFhLs8ORSFO/NO9yPaeWB3lSAwZhu+e7DVkC4j4oY=;
        b=GVsuOJrOLn5heQH2FE3hZkm6BrKg78PhiDN/YCkbAnDZNHfi6T3stUxTJWToMqeHKX
         +yYIZrLQ7uPj20gV/ACmiD04LfoCrsFsyXsOekcdJ33U6ix+QGDWCpXQnfEGS4xEWgfy
         LSjtQvQ+9rnTb7A1Gw8adkfdDXy9CbykmVCSmkJbzcdkap1GoyeaNKstLPmy8PteWNtJ
         Rjlj8V8kLXZn9NqKhosyM3D3BNwGPo6frHtZe++qKaq8HGEZlHdUjbmfnnvzB0PI5xqq
         1nhPNkw4EfZ1sN/0cjLgAsVZ6BuO08CR+lte/ErDxhKHVIMmbUMWdVSzFSfE502NsxdC
         sZlg==
X-Gm-Message-State: AOJu0YwcT+CARusBy+h6lLABctfJWnisc7/PjnWt0bNGMAEbZrZnk7rf
        Eh2G+MZsbgHnYaJ/bQrsAdWlR5pWOlUacGO9vK0PkenXHg5AZhs=
X-Google-Smtp-Source: AGHT+IGmwvj0uhcxUM2+OVOVH00RKehTmiix306e+Pd3JQ2bYnu8+329vmUx6Bav0U8rEIoPM8XXZvpxqEt0hWm3DxyVKv/fcoli
MIME-Version: 1.0
X-Received: by 2002:a63:154c:0:b0:5c1:589d:b3dc with SMTP id
 12-20020a63154c000000b005c1589db3dcmr984573pgv.1.1700916173006; Sat, 25 Nov
 2023 04:42:53 -0800 (PST)
Date:   Sat, 25 Nov 2023 04:42:52 -0800
In-Reply-To: <000000000000fb2f84060ad4da7f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048efa9060af96848@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in indx_insert_into_buffer
From:   syzbot <syzbot+c5b339d16ffa61fd512d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
index cf92b2433f7a..a625302a3b1e 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1909,8 +1909,11 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 		 * Undo critical operations.
 		 */
 		indx_mark_free(indx, ni, new_vbn >> indx->idx2vbn_bits);
-		memcpy(hdr1, hdr1_saved, used1);
+		kfree(hdr1);
+		hdr1 = (struct INDEX_HDR *)hdr1_saved;
 		indx_write(indx, ni, n1, 0);
+		kfree(up_e);
+		return err;
 	}
 
 out:

