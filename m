Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAFF7A9E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjIUUBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjIUUAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:00:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6886E81;
        Thu, 21 Sep 2023 10:22:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65063C4166B;
        Thu, 21 Sep 2023 07:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695282780;
        bh=ijv4aQ43jgxUfEGDSGPU0BYp7t7D3uvLn02bpHs8gLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bPycPiF29+qaXcyZz6b//1CYmM5+vysCKh0Ay6EHegbJ9h9kecF0RdGJrBN8MV8Dy
         Tg6PuvvOhQpeZZqZFLDB0haQYP9oTl853g8BKvbspe79QmC+aHqL2Jt5u5Fid7cvAg
         0/UtWLPe/bOwy6Dwpr48+mBBSqoizOz8Cgq3pm00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.196
Date:   Thu, 21 Sep 2023 09:52:47 +0200
Message-ID: <2023092154-statute-quantum-9f8c@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023092153-fragile-bleak-cca1@gregkh>
References: <2023092153-fragile-bleak-cca1@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 006700fbb652..7021aa85afd1 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 195
+SUBLEVEL = 196
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 0b7e9ab517d5..12388ed4faa5 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -479,7 +479,6 @@ static struct dentry * configfs_lookup(struct inode *dir,
 	if (!configfs_dirent_is_ready(parent_sd))
 		goto out;
 
-	spin_lock(&configfs_dirent_lock);
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
 		if (sd->s_type & CONFIGFS_NOT_PINNED) {
 			const unsigned char * name = configfs_get_name(sd);
@@ -492,7 +491,6 @@ static struct dentry * configfs_lookup(struct inode *dir,
 			break;
 		}
 	}
-	spin_unlock(&configfs_dirent_lock);
 
 	if (!found) {
 		/*
