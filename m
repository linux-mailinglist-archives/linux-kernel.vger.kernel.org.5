Return-Path: <linux-kernel+bounces-19746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFB08272CE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38BFBB22CE1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49264C612;
	Mon,  8 Jan 2024 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfjTZppC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025B4C3C9;
	Mon,  8 Jan 2024 15:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01302C433C9;
	Mon,  8 Jan 2024 15:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704727108;
	bh=8PwEk7P5BBf3VE10mim4cSVYkJKhniqxJDNUxpENG/I=;
	h=From:Subject:Date:To:Cc:From;
	b=SfjTZppC1MrtRVTwHXBZZmYZSfeOUHKe8IHgKjsJo6bnCjntp+cCEYGxyBLdUXIsT
	 MXHM/M24HicaPK8tD8cRDPN+leAGG+30CJ7RV72qCJKh1ZlHuYhuhcTKheZl0Y1kob
	 ga+ge8URLvikNOVvUGEmKpAyq4x1CYdPyYadzPXtWmPrc0d3P1LWLNWcxVKKbotekK
	 5jK1Lt3KWMT0rZhY6fbfSH4RNjssyM5dCwVktMKWGdxhSWEh1QJZ5b20JklbOJPVA8
	 Fq5X/FYkWpgvRQ6d6ztZkh+kyvFlK9JsEOdpMppFLh/1rmuM3J55x7a2Snj0vZIq4M
	 anwz6qJhjUXtA==
From: Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH v2 0/8] fs/9p: simplify inode lookup operations
Date: Mon, 08 Jan 2024 15:18:16 +0000
Message-Id: <20240108-ericvh-fix-cache-dups-v2-0-a73f8822838c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADgSnGUC/3WNyw7CIBREf6W5a6/h0dbHyv8wXVB6KUQDDSjRN
 Py72MSlyzOZObNCougowblZIVJ2yQVfQewa0Fb5mdBNlUEw0TLOJNa6zhaNe6FW2hJOzyWhYSf
 RKTOOk+BQt0uk2ti816GydekR4nu7yfyb/oz9H2PmyLCTRy3YoTWyl5cbRU/3fYgzDKWUD6iR4
 Fq7AAAA
To: Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=8PwEk7P5BBf3VE10mim4cSVYkJKhniqxJDNUxpENG/I=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlnBJCA3YAT/K0zUlUSw0wLS7RVLRdGcb04STK+
 qhZ3MlrsTaJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZwSQgAKCRCI/9X7Sl//
 mJeaEACg5bw7BYwNffeHxavg8vcrefEHNkRmmR/q4ATlXB0i2Rgd8C2ajiHLxhsXPmIpz2DNrot
 7nFTDYsLqppmHxeQD3IR2OZ/+T2irxoQENmaKgIWMtSsYoXb+cxwr8E6PqvtN3YF8t1uaUw+yau
 gus6Cl5BFuL8KAF0JYd2zstTCC8aGRVa5irpINwPTD3dkh9k93Tft6mddKDWuwrYBnCoH/SaleS
 KGYlMQcyEgeUElAbKzRfqX4kt4DH/fFoK87HrwrK5tr8OnzYli7IP1WWGqtA9NfVnl9LmY9HHBe
 9tBvwomo+L+x5Di2yXL3BLLl90QRByjFoyiIzBSjFEmS8J2MpEYbtjr1m3NoEocTL1HfprmR+6R
 /q3lhB2NniF6M03EVczAvVm82V0JFmdSc/L6BE/W/SCbWuTg50/BOIdzH1KmfAExMbIX5c2mH5f
 O/WnxD9jP6RTFgULrf30RuYzZBWotEjKl6Yqbbccqj0dV4YheVJEHXKNMh05XYnz1djU/aOX5YV
 PcA0gY8u13D0SkYpaJDxk/3r5aHFSNj6XEyM+erkHF5cIAogudn+5jKt18LDcamFsf8eW8hai1A
 AhkO1MEuo1IfqAJFt+eYhoxN5Eh0/iWeqAbnXysLTk4LrZ3xYxirRN/afhcsr4dOpPdU2ae4zUe
 g/Qpb6e155y4EAg==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

This patch series takes a pass on the inode lookup-related
operations and attempts to simplify the code path, eliminating
unnecessary and/or redundant code and/or protocol operations.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
Changes in v2:
- Fixed whitespace issues
- Switched QID2INO to use BITS_PER_LONG macro
- Fixed some vestigial inconsistency in inode number assignment between legacy and .L
- Link to v1: https://lore.kernel.org/r/20240106-ericvh-fix-cache-dups-v1-0-538c2074f363@kernel.org

---
Eric Van Hensbergen (8):
      fs/9p: switch vfsmount to use v9fs_get_new_inode
      fs/9p: convert mkdir to use get_new_inode
      fs/9p: remove walk and inode allocation from symlink
      fs/9p: Eliminate redundant non-cache path in mknod
      fs/9p: Eliminate now unused v9fs_get_inode
      fs/9p: rework qid2ino logic
      fs/9p: simplify iget to remove unnecessary paths
      fs/9p: fix dups even in uncached mode

 fs/9p/v9fs.h           |  31 ++------
 fs/9p/v9fs_vfs.h       |  11 ++-
 fs/9p/vfs_dir.c        |   4 +-
 fs/9p/vfs_inode.c      | 149 ++++++-------------------------------
 fs/9p/vfs_inode_dotl.c | 194 +++++++++----------------------------------------
 fs/9p/vfs_super.c      |  45 +-----------
 6 files changed, 71 insertions(+), 363 deletions(-)
---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240103-ericvh-fix-cache-dups-f0925afbbd21

Best regards,
-- 
Eric Van Hensbergen <ericvh@kernel.org>


