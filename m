Return-Path: <linux-kernel+bounces-33127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB74C8364FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD3B28A8F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA80C3E474;
	Mon, 22 Jan 2024 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEgpyHNW"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471AD3DBA6;
	Mon, 22 Jan 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932152; cv=none; b=lRo+kCGwQLPQqiE5IuJILTASU2e80t69XiNAdmUqOlkVRF4aI6HOBRKTTkfCZFVR9KeAQYvG0V1xEBjN3Ld0WlN+Aym8PrHrDyJIAKw7uLQM/gBjJ3WHVUuzvV0yg3V6E2gTLNrbDqkzR1VRvBuJxT9iu186885yq8T6OwoLkds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932152; c=relaxed/simple;
	bh=H3Bn5PBTfDQYNUBRiWoEdoIC0beHT3kL6osPczjI6nU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DUUrkvFWjNGczNJe9JlKm94bP1KK6VEaDLz58z0S+A7JzT5EwgCGnS9q0Mtg3dEiWDBCuKJSuMS5J7tJXRmkUKXkB1e6NycO5+NIy2Ymmr/dkJawjggEH4+ZkFmLOsLTPIo03MrXA8Z4UNbYtNpqBSh7Hi/2lx96ZCqIBXHUz1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEgpyHNW; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dbd2e435d9so877853b3a.1;
        Mon, 22 Jan 2024 06:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705932150; x=1706536950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNWHkCgMBEhzfewM0Gmi05uGlalhciGwKja6MdQzI18=;
        b=YEgpyHNWxfnmDqbXBUk0C2Tnt4b515nMLCkcTDUBz9/BXMdN32N5AlSyLy0in5OdnM
         6KJDFONBYsyzNtFRWZ4wlfBIZAOdxGIsy2VO4nR+mQ+S26J68jYRXvPcEdrfjw0R1pPZ
         s1ldEdG6ZcR+2qkVAddkx3XeAu0djlxmgeLXZq3Y6lL6VIAkUbBLZmiXEifII7OqupeB
         fvXvytRf9ks2+OM9ITlRC+cbX9jjrRgwLegRKqeHZrrslCWHiJO1yE/FnS1LLvWCaqTF
         W0VjXJ+Gs+6e+oEMLKHAhvbynodVyRC2Pmtwjwqyp08zLEmyv6Bhw45dEAQEwqjeoQgO
         JN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932150; x=1706536950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNWHkCgMBEhzfewM0Gmi05uGlalhciGwKja6MdQzI18=;
        b=nE0JVLy3Lix58DoVbwrCF/4NSooY2jsXXikF9wse5xYWcWCGlCcN2do1ixPGLsAgfx
         +ljpLukzt7cADFUbIO9XigYDNX3eieNWWB9Mj44wHTLCS0asdkBh/I5jaP1zlzsAPrU6
         E5pbViuDARxPOsTQ1/ZCOtyR4KZ9qpJHPYT4SXUhxfLrto0G/TG5TJJig/FsL5lEacVB
         saCxrrSN7DymD5Gx+aYqjAB+KtR9em8WtFLGVK3R1PVGXvw2PHFjhHkGypX0eztu1Lsa
         2xZbKNSj27Vl3PEzPw29gEv8RnhcOdl/GIfusadiodhmJbvRn8yPKkSg6FNtVvFvbdMr
         ZO9Q==
X-Gm-Message-State: AOJu0YxXXGrww8Wr0Dd+nfesbcwOATrI/xzdDuUw4X9QOl3JQ7kjfBBs
	uKekPRVfr96k1YxcdvoaIv6KDUDpIy8EA9AGBuDa7uX7kziVmBLh65gn+vcn
X-Google-Smtp-Source: AGHT+IFikpvZM8EV+HlQ/ZDkmaChzzx/eHz5zr5KkFzWlh9tL5knyBzE1GPS3B8RBDGY3yltUZwGEg==
X-Received: by 2002:a05:6a00:298a:b0:6db:c57e:d8e0 with SMTP id cj10-20020a056a00298a00b006dbc57ed8e0mr2326253pfb.18.1705932150544;
        Mon, 22 Jan 2024 06:02:30 -0800 (PST)
Received: from carrot.. (i223-218-154-72.s42.a014.ap.plala.or.jp. [223.218.154.72])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b006da2aad58adsm9901913pff.176.2024.01.22.06.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 06:02:29 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] nilfs2: move nilfs_bmap_write call out of nilfs_write_inode_common
Date: Mon, 22 Jan 2024 23:01:55 +0900
Message-Id: <20240122140202.6950-9-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122140202.6950-1-konishi.ryusuke@gmail.com>
References: <20240122140202.6950-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before converting the disk inode management metadata file ifile, the call
to nilfs_bmap_write(), the i_device_code setting, and the zero-fill code
for inodes on the super root block are moved from
nilfs_write_inode_common() to its callers.

This cleanup simplifies the role and arguments of
nilfs_write_inode_common() and collects calls to nilfs_bmap_write() to
the log writing code.

Also, add and use a new helper nilfs_write_root_mdt_inode() to avoid code
duplication in the data export routine nilfs_segctor_fill_in_super_root()
to the super root block's buffer.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/inode.c   | 38 +++++++++++++++---------------------
 fs/nilfs2/nilfs.h   |  3 ++-
 fs/nilfs2/segment.c | 47 +++++++++++++++++++++++++++++++++++++--------
 3 files changed, 57 insertions(+), 31 deletions(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 9c334c722fc1..b9d40f5e94d3 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -759,8 +759,18 @@ struct inode *nilfs_iget_for_shadow(struct inode *inode)
 	return s_inode;
 }
 
+/**
+ * nilfs_write_inode_common - export common inode information to on-disk inode
+ * @inode:     inode object
+ * @raw_inode: on-disk inode
+ *
+ * This function writes standard information from the on-memory inode @inode
+ * to @raw_inode on ifile, cpfile or a super root block.  Since inode bmap
+ * data is not exported, nilfs_bmap_write() must be called separately during
+ * log writing.
+ */
 void nilfs_write_inode_common(struct inode *inode,
-			      struct nilfs_inode *raw_inode, int has_bmap)
+			      struct nilfs_inode *raw_inode)
 {
 	struct nilfs_inode_info *ii = NILFS_I(inode);
 
@@ -778,21 +788,6 @@ void nilfs_write_inode_common(struct inode *inode,
 	raw_inode->i_flags = cpu_to_le32(ii->i_flags);
 	raw_inode->i_generation = cpu_to_le32(inode->i_generation);
 
-	if (NILFS_ROOT_METADATA_FILE(inode->i_ino)) {
-		struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
-
-		/* zero-fill unused portion in the case of super root block */
-		raw_inode->i_xattr = 0;
-		raw_inode->i_pad = 0;
-		memset((void *)raw_inode + sizeof(*raw_inode), 0,
-		       nilfs->ns_inode_size - sizeof(*raw_inode));
-	}
-
-	if (has_bmap)
-		nilfs_bmap_write(ii->i_bmap, raw_inode);
-	else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
-		raw_inode->i_device_code =
-			cpu_to_le64(huge_encode_dev(inode->i_rdev));
 	/*
 	 * When extending inode, nilfs->ns_inode_size should be checked
 	 * for substitutions of appended fields.
@@ -813,12 +808,11 @@ void nilfs_update_inode(struct inode *inode, struct buffer_head *ibh, int flags)
 	if (flags & I_DIRTY_DATASYNC)
 		set_bit(NILFS_I_INODE_SYNC, &ii->i_state);
 
-	nilfs_write_inode_common(inode, raw_inode, 0);
-		/*
-		 * XXX: call with has_bmap = 0 is a workaround to avoid
-		 * deadlock of bmap.  This delays update of i_bmap to just
-		 * before writing.
-		 */
+	nilfs_write_inode_common(inode, raw_inode);
+
+	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
+		raw_inode->i_device_code =
+			cpu_to_le64(huge_encode_dev(inode->i_rdev));
 
 	nilfs_ifile_unmap_inode(ifile, ino, ibh);
 }
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index 98cffaf0ac12..2e29b98ba8ba 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -256,7 +256,8 @@ extern struct inode *nilfs_new_inode(struct inode *, umode_t);
 extern int nilfs_get_block(struct inode *, sector_t, struct buffer_head *, int);
 extern void nilfs_set_inode_flags(struct inode *);
 extern int nilfs_read_inode_common(struct inode *, struct nilfs_inode *);
-extern void nilfs_write_inode_common(struct inode *, struct nilfs_inode *, int);
+void nilfs_write_inode_common(struct inode *inode,
+			      struct nilfs_inode *raw_inode);
 struct inode *nilfs_ilookup(struct super_block *sb, struct nilfs_root *root,
 			    unsigned long ino);
 struct inode *nilfs_iget_locked(struct super_block *sb, struct nilfs_root *root,
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 2590a0860eab..b512e7728465 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -913,6 +913,7 @@ static int nilfs_segctor_fill_in_checkpoint(struct nilfs_sc_info *sci)
 	struct the_nilfs *nilfs = sci->sc_super->s_fs_info;
 	struct buffer_head *bh_cp;
 	struct nilfs_checkpoint *raw_cp;
+	struct inode *ifile;
 	int err;
 
 	err = nilfs_cpfile_get_checkpoint(nilfs->ns_cpfile, nilfs->ns_cno, 0,
@@ -941,8 +942,10 @@ static int nilfs_segctor_fill_in_checkpoint(struct nilfs_sc_info *sci)
 	else
 		nilfs_checkpoint_set_minor(raw_cp);
 
-	nilfs_write_inode_common(sci->sc_root->ifile,
-				 &raw_cp->cp_ifile_inode, 1);
+	ifile = sci->sc_root->ifile;
+	nilfs_write_inode_common(ifile, &raw_cp->cp_ifile_inode);
+	nilfs_bmap_write(NILFS_I(ifile)->i_bmap, &raw_cp->cp_ifile_inode);
+
 	nilfs_cpfile_put_checkpoint(nilfs->ns_cpfile, nilfs->ns_cno, bh_cp);
 	return 0;
 
@@ -977,6 +980,33 @@ static void nilfs_segctor_fill_in_file_bmap(struct nilfs_sc_info *sci)
 	}
 }
 
+/**
+ * nilfs_write_root_mdt_inode - export root metadata inode information to
+ *                              the on-disk inode
+ * @inode:     inode object of the root metadata file
+ * @raw_inode: on-disk inode
+ *
+ * nilfs_write_root_mdt_inode() writes inode information and bmap data of
+ * @inode to the inode area of the metadata file allocated on the super root
+ * block created to finalize the log.  Since super root blocks are configured
+ * each time, this function zero-fills the unused area of @raw_inode.
+ */
+static void nilfs_write_root_mdt_inode(struct inode *inode,
+				       struct nilfs_inode *raw_inode)
+{
+	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
+
+	nilfs_write_inode_common(inode, raw_inode);
+
+	/* zero-fill unused portion of raw_inode */
+	raw_inode->i_xattr = 0;
+	raw_inode->i_pad = 0;
+	memset((void *)raw_inode + sizeof(*raw_inode), 0,
+	       nilfs->ns_inode_size - sizeof(*raw_inode));
+
+	nilfs_bmap_write(NILFS_I(inode)->i_bmap, raw_inode);
+}
+
 static void nilfs_segctor_fill_in_super_root(struct nilfs_sc_info *sci,
 					     struct the_nilfs *nilfs)
 {
@@ -998,12 +1028,13 @@ static void nilfs_segctor_fill_in_super_root(struct nilfs_sc_info *sci,
 			      nilfs->ns_nongc_ctime : sci->sc_seg_ctime);
 	raw_sr->sr_flags = 0;
 
-	nilfs_write_inode_common(nilfs->ns_dat, (void *)raw_sr +
-				 NILFS_SR_DAT_OFFSET(isz), 1);
-	nilfs_write_inode_common(nilfs->ns_cpfile, (void *)raw_sr +
-				 NILFS_SR_CPFILE_OFFSET(isz), 1);
-	nilfs_write_inode_common(nilfs->ns_sufile, (void *)raw_sr +
-				 NILFS_SR_SUFILE_OFFSET(isz), 1);
+	nilfs_write_root_mdt_inode(nilfs->ns_dat, (void *)raw_sr +
+				   NILFS_SR_DAT_OFFSET(isz));
+	nilfs_write_root_mdt_inode(nilfs->ns_cpfile, (void *)raw_sr +
+				   NILFS_SR_CPFILE_OFFSET(isz));
+	nilfs_write_root_mdt_inode(nilfs->ns_sufile, (void *)raw_sr +
+				   NILFS_SR_SUFILE_OFFSET(isz));
+
 	memset((void *)raw_sr + srsz, 0, nilfs->ns_blocksize - srsz);
 	set_buffer_uptodate(bh_sr);
 	unlock_buffer(bh_sr);
-- 
2.34.1


