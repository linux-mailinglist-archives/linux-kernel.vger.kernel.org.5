Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030BB80737F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379228AbjLFPOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379296AbjLFPOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:14:10 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1EAD65;
        Wed,  6 Dec 2023 07:14:16 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 7D9731D0B;
        Wed,  6 Dec 2023 15:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1701874902;
        bh=24fZy/sgMaW82JR5E0MnWROlI1NKAwMnW1CVh0eH4aU=;
        h=Date:To:CC:From:Subject;
        b=gdyJ3AGYCLh4/ErqRngAwMEMdM9X/g/UMeFQa98F8s7+8IndIBSbFsUWQmVfZSNo1
         vrcvB2u23hoIr1mTVs2Tm2M1kGg1EokLPIMS9ODB9rSSpU8tRwulvf90dDb/Z5yfVU
         LGJDWpi3IZa08yPjnS9VCwYvPxfXvIoeZehTiJk8=
Received: from [172.16.192.129] (192.168.211.144) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Dec 2023 18:08:06 +0300
Message-ID: <00fd1558-fda5-421b-be43-7de69e32cb4e@paragon-software.com>
Date:   Wed, 6 Dec 2023 18:08:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarovc <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 00/16] fs/ntfs3: Bugfix and refactoring
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.144]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains various fixes and refactoring for ntfs3.
Improved alternative boot processing, reduced stack usage.

Konstantin Komarov (16):
   fs/ntfs3: Improve alternative boot processing
   fs/ntfs3: Modified fix directory element type detection
   fs/ntfs3: Improve ntfs_dir_count
   fs/ntfs3: Correct hard links updating when dealing with DOS names
   fs/ntfs3: Print warning while fixing hard links count
   fs/ntfs3: Reduce stack usage
   fs/ntfs3: Fix multithreaded stress test
   fs/ntfs3: Fix detected field-spanning write (size 8) of single field
     "le->name"
   fs/ntfs3: Correct use bh_read
   fs/ntfs3: Add file_modified
   fs/ntfs3: Drop suid and sgid bits as a part of fpunch
   fs/ntfs3: Implement super_operations::shutdown
   fs/ntfs3: ntfs3_forced_shutdown use int instead of bool
   fs/ntfs3: Add and fix comments
   fs/ntfs3: Add NULL ptr dereference checking at the end of
     attr_allocate_frame()
   fs/ntfs3: Fix c/mtime typo

  fs/ntfs3/attrib.c  |  41 +++++----
  fs/ntfs3/dir.c     |  44 ++++++---
  fs/ntfs3/file.c    |  59 +++++++++---
  fs/ntfs3/frecord.c |   5 +-
  fs/ntfs3/fslog.c   | 218 ++++++++++++++++++++-------------------------
  fs/ntfs3/fsntfs.c  |   5 +-
  fs/ntfs3/inode.c   |  30 +++++--
  fs/ntfs3/namei.c   |  12 +++
  fs/ntfs3/ntfs.h    |   2 +-
  fs/ntfs3/ntfs_fs.h |  11 ++-
  fs/ntfs3/record.c  |  16 +++-
  fs/ntfs3/super.c   |  47 ++++++----
  fs/ntfs3/xattr.c   |   3 +
  13 files changed, 302 insertions(+), 191 deletions(-)

-- 
2.34.1

