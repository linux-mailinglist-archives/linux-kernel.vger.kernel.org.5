Return-Path: <linux-kernel+bounces-61543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D415D851380
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E721C2161D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1691539FE4;
	Mon, 12 Feb 2024 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgyE58kj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB1F39FCD
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740652; cv=none; b=QVmw9Q6g0TrpolHnBvL/MY4cZ34nnut10UG7V9KhK7SES2k8ynB6qRhHnooEoT8shTuEcmtZ+lPRfk+9BSbeyZw7Poq/4y84/7kSdZqwFvtOs1GE83CIgqoeAZ0wmLdWTVVaTCVxmwmY3ffF2DJgENNR7b4NhCYNYqqlUq8c8HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740652; c=relaxed/simple;
	bh=acPHK8IdUjxMeyxurQI2Gi+2UqoYkNniJUXwfOJMhd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qf7cmdOSPxx7kOjebYoJwT2KkncMrpFWYbtM7Yjao4o7aoRWVzHTFYGUZ3vTl5Ul58R+uxt44ioDfxw06o0kh9tLnlj6CxE23K9vAyF/GgaXWMUQIPsua+tOI7BBu+9jnBEPaUQ65IpaJecrwUl6uL0hhvQZgH8N9Urs00QhsMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgyE58kj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15478C433A6;
	Mon, 12 Feb 2024 12:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707740651;
	bh=acPHK8IdUjxMeyxurQI2Gi+2UqoYkNniJUXwfOJMhd8=;
	h=From:Date:Subject:To:Cc:From;
	b=IgyE58kjHyqRgbKyCXjeRHnMDbvo00vpzVs+go4RgPN2drqnZDZTvwqbBmNSAO6pd
	 t6S2DHw0GavNjiQpDdI3BlbRNh/1jTfsn64kw1hHlSImrkgxfr9wUo2+Dh/+xOEzVN
	 CbeZacQH1j9KFkvUcfgILtR76N7yIq9AO2+RuA4E61rYOncywLj9Ey42xdgRtOmFeO
	 Ftaghxbo4vAQCk2/qNQT+7uZf/NOTQ4ibYgb5tXuVv7ED2pzN/rbK3vF6R2lrAu3Q0
	 kIU0MsCdNGuvFDScgiFBA7IYUIyyhhgz+CGKPmQOChEa9Nf3Adrz5dgDRlnIJgr4zx
	 sPyjAhQbUx4Mg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 12 Feb 2024 07:24:05 -0500
Subject: [PATCH] filelock: always define for_each_file_lock()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-flsplit3-v1-1-019f0ad6bf69@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOUNymUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0Mj3bSc4oKczBJjXUNzk9S0tFRjM3PTRCWg8oKi1LTMCrBR0bG1tQC
 yf5H8WgAAAA==
To: Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Tom Talpey <tom@talpey.com>, 
 Luca Vizzarro <Luca.Vizzarro@arm.com>, Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <aahringo@redhat.com>, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1974; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=acPHK8IdUjxMeyxurQI2Gi+2UqoYkNniJUXwfOJMhd8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlyg3qKC8hijrzL59SUXn70Z3kvQgeGygYYL/o1
 0g+D6CdJsiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZcoN6gAKCRAADmhBGVaC
 FYvfEACzWCk6XfVxuJvUphAIdSoatT5AZE1OSok/HefL2FbjdPdOKd7TQOGiGbyAVHTvx9EOqnA
 /BmVRcNqbP2ZLXS9G1XPEPUepUD+DS131wXVymvIqQtBE6dyb3/1MlNrtjAJrneMLkG4JF6HCwl
 B7bGh3e0SKf8JHD8dIpQu6DofKeC20xthbTv2/oh7x7IS7WN+jQdIvULEBbYPu5VtsR9m1dQhU5
 8SsZvpxaBpTQcWxHKOdLpZe6mX0G3reIP66YNYx5DmVsvootDZ7wkWQn1xyNrty4Pntc3iFxfL2
 NrhEDwcNSLFt0WH1NHeQtHpzQYItF0YQbwrSzq3FswUrfRp22jlSqfF0CNQFsV85CBeI286W7iB
 NB904cEQLtj4XzgF3Ij61FYrhC7skQ5+rLDumSBxQJIh6OuZXNQVUF6z1RgGXaPE1ij+U/9Hvdf
 c69xh+Fu5lQ0tfxLGi1mEKmPt0SxV8UW0sIXapNjMFxryZDSRBY+HzHi+VMtP3KBR6akcE4PfoL
 9cS0BdIutsxQHEqd9i7yLraRfTa6FwwPTrJ3WR3rjsnKKjkYIq6nh4tXYjdr/U1dqD4vUYFju46
 DcG9yQj0zGVcPmqn522fpKwNpGQz/3K0tGB01m4RBxnA8HaLd0eNExsI1UoRQNrOWIN8StRIPl6
 Lnc4BR8L/oFvAgA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

..and eliminate the stub version when CONFIG_FILE_LOCKING is disabled.
This silences the following warning that crept in recently:

fs/ceph/locks.c: In function 'ceph_count_locks':
fs/ceph/locks.c:380:27: error: unused variable 'lock' [-Werror=unused-variable]
  380 |         struct file_lock *lock;

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402062210.3YyBVGF1-lkp@intel.com/
Fixes: 75cabec0111b ("filelock: add some new helper functions")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/filelock.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index aabd4bdf7eba..daee999d05f3 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -180,9 +180,6 @@ static inline void locks_wake_up(struct file_lock *fl)
 	wake_up(&fl->c.flc_wait);
 }
 
-/* for walking lists of file_locks linked by fl_list */
-#define for_each_file_lock(_fl, _head)	list_for_each_entry(_fl, _head, c.flc_list)
-
 /* fs/locks.c */
 void locks_free_lock_context(struct inode *inode);
 void locks_free_lock(struct file_lock *fl);
@@ -283,8 +280,6 @@ static inline void locks_wake_up(struct file_lock *fl)
 {
 }
 
-#define for_each_file_lock(_fl, _head)	while(false)
-
 static inline void
 locks_free_lock_context(struct inode *inode)
 {
@@ -414,6 +409,9 @@ locks_inode_context(const struct inode *inode)
 
 #endif /* !CONFIG_FILE_LOCKING */
 
+/* for walking lists of file_locks linked by fl_list */
+#define for_each_file_lock(_fl, _head)	list_for_each_entry(_fl, _head, c.flc_list)
+
 static inline int locks_lock_file_wait(struct file *filp, struct file_lock *fl)
 {
 	return locks_lock_inode_wait(file_inode(filp), fl);

---
base-commit: 292fcaa1f937345cb65f3af82a1ee6692c8df9eb
change-id: 20240212-flsplit3-174effe3675a

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


