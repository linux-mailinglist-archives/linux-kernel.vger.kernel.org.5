Return-Path: <linux-kernel+bounces-105454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204DC87DE14
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA03281C61
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BFC1CA89;
	Sun, 17 Mar 2024 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kubisiak.com header.i=@kubisiak.com header.b="dnY9B7M4"
Received: from mail.kubisiak.com (unknown [75.171.8.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29E51C6AF;
	Sun, 17 Mar 2024 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=75.171.8.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710690440; cv=none; b=D2JWrfu8gFrVK5JVNwqfGuNr3Kg3/HWWdBe1C02okKkMBhHjUYZmOWtpyhb1ONfCjX3VnAETi7Th6Owgvi+f+KJm38MMphHlDHAbCmzipfu5JxjAqSeIthdAtMWzjKyjr+753vyvvRpjlkUz8s8zmuFloRNWHUR3lBcCu4PyHCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710690440; c=relaxed/simple;
	bh=/d6FompPnxhaxX+dDXc+VGeDfM+UfK/1YUE8lld3lhU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MXusDpUplUzoUN+wsCyLZ51hiDq5nXIMYMuQZnvB4isKwlLFnnkx06njPm/7ncHSZd8XGjKccl3daZ4leW/WTz48AEYiJqXni0Vr3sY/EKceX3GSXIsvultRvbwn4vw3cavVSasdW+zqKq7KiHkajDlwvK1KRd7/18ufUPkTMjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kubisiak.com; spf=pass smtp.mailfrom=kubisiak.com; dkim=pass (2048-bit key) header.d=kubisiak.com header.i=@kubisiak.com header.b=dnY9B7M4; arc=none smtp.client-ip=75.171.8.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kubisiak.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kubisiak.com
dkim-signature: v=1; a=rsa-sha256; d=kubisiak.com; s=s1;
	c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type;
	bh=MCX9h6Wp1S4fn4QEqAne15wbcPppx7KIa+vp+dPFm88=;
	b=dnY9B7M4d9sgb7QnbzEVQ9Sv8xAh7xF4+QkRVSjoz4F4H/DwfocJWvXPaGQAzP0DQejKgQosuBu3mnw0/4jf7cY8TXI0SJSx9BdGE2/6fqLj+V18VjjRsuQDZ1ql67sgj9TmMfF6tY9z0f3lPImqG0gqakQYg7f/xICmjL5o4YvLX2OILfgd4dHab07CLFrFq44A0xd+Mz8yMXO0SaYvS0VOomU/7JpD4n5gvwwdSc34SvSGvOM261Sqn0
	pG/cJDgUarktWAZ7Sf/knw9EHwqGEuo7rn4mNlIeb0LgLm8rK8DwBSUG6OqTzx7tjq1CMdC9vb7wqA9+NMLj0N1DWT7A==
Received: from peregrine (192-184-148-161.fiber.dynamic.sonic.net [192.184.148.161])
	by mail.kubisiak.com with ESMTPSA
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256)
	; Sun, 17 Mar 2024 09:46:02 -0500
Date: Sun, 17 Mar 2024 07:46:00 -0700
From: Brian Kubisiak <brian@kubisiak.com>
To: ecryptfs@vger.kernel.org
Cc: brian@kubisiak.com, code@tyhicks.com, mhalcrow@us.ibm.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ecryptfs: Fix buffer size for tag 66 packet
Message-ID: <5j2q56p6qkhezva6b2yuqfrsurmvrrqtxxzrnp3wqu7xrz22i7@hoecdztoplbl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The 'TAG 66 Packet Format' description is missing the cipher code and
checksum fields that are packed into the message packet. As a result,
the buffer allocated for the packet is 3 bytes too small and
write_tag_66_packet() will write up to 3 bytes past the end of the
buffer.

Fix this by increasing the size of the allocation so the whole packet
will always fit in the buffer.

This fixes the below kasan slab-out-of-bounds bug:

  BUG: KASAN: slab-out-of-bounds in ecryptfs_generate_key_packet_set+0x7d6/0xde0
  Write of size 1 at addr ffff88800afbb2a5 by task touch/181

  CPU: 0 PID: 181 Comm: touch Not tainted 6.6.13-gnu #1 4c9534092be820851bb687b82d1f92a426598dc6
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2/GNU Guix 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x4c/0x70
   print_report+0xc5/0x610
   ? ecryptfs_generate_key_packet_set+0x7d6/0xde0
   ? kasan_complete_mode_report_info+0x44/0x210
   ? ecryptfs_generate_key_packet_set+0x7d6/0xde0
   kasan_report+0xc2/0x110
   ? ecryptfs_generate_key_packet_set+0x7d6/0xde0
   __asan_store1+0x62/0x80
   ecryptfs_generate_key_packet_set+0x7d6/0xde0
   ? __pfx_ecryptfs_generate_key_packet_set+0x10/0x10
   ? __alloc_pages+0x2e2/0x540
   ? __pfx_ovl_open+0x10/0x10 [overlay 30837f11141636a8e1793533a02e6e2e885dad1d]
   ? dentry_open+0x8f/0xd0
   ecryptfs_write_metadata+0x30a/0x550
   ? __pfx_ecryptfs_write_metadata+0x10/0x10
   ? ecryptfs_get_lower_file+0x6b/0x190
   ecryptfs_initialize_file+0x77/0x150
   ecryptfs_create+0x1c2/0x2f0
   path_openat+0x17cf/0x1ba0
   ? __pfx_path_openat+0x10/0x10
   do_filp_open+0x15e/0x290
   ? __pfx_do_filp_open+0x10/0x10
   ? __kasan_check_write+0x18/0x30
   ? _raw_spin_lock+0x86/0xf0
   ? __pfx__raw_spin_lock+0x10/0x10
   ? __kasan_check_write+0x18/0x30
   ? alloc_fd+0xf4/0x330
   do_sys_openat2+0x122/0x160
   ? __pfx_do_sys_openat2+0x10/0x10
   __x64_sys_openat+0xef/0x170
   ? __pfx___x64_sys_openat+0x10/0x10
   do_syscall_64+0x60/0xd0
   entry_SYSCALL_64_after_hwframe+0x6e/0xd8
  RIP: 0033:0x7f00a703fd67
  Code: 25 00 00 41 00 3d 00 00 41 00 74 37 64 8b 04 25 18 00 00 00 85 c0 75 5b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 85 00 00 00 48 83 c4 68 5d 41 5c c3 0f 1f
  RSP: 002b:00007ffc088e30b0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
  RAX: ffffffffffffffda RBX: 00007ffc088e3368 RCX: 00007f00a703fd67
  RDX: 0000000000000941 RSI: 00007ffc088e48d7 RDI: 00000000ffffff9c
  RBP: 00007ffc088e48d7 R08: 0000000000000001 R09: 0000000000000000
  R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000941
  R13: 0000000000000000 R14: 00007ffc088e48d7 R15: 00007f00a7180040
   </TASK>

  Allocated by task 181:
   kasan_save_stack+0x2f/0x60
   kasan_set_track+0x29/0x40
   kasan_save_alloc_info+0x25/0x40
   __kasan_kmalloc+0xc5/0xd0
   __kmalloc+0x66/0x160
   ecryptfs_generate_key_packet_set+0x6d2/0xde0
   ecryptfs_write_metadata+0x30a/0x550
   ecryptfs_initialize_file+0x77/0x150
   ecryptfs_create+0x1c2/0x2f0
   path_openat+0x17cf/0x1ba0
   do_filp_open+0x15e/0x290
   do_sys_openat2+0x122/0x160
   __x64_sys_openat+0xef/0x170
   do_syscall_64+0x60/0xd0
   entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Fixes: dddfa461fc89 ("[PATCH] eCryptfs: Public key; packet management")
Signed-off-by: Brian Kubisiak <brian@kubisiak.com>
---
 fs/ecryptfs/keystore.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 3fe41964c0d8..7f9f68c00ef6 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -300,9 +300,11 @@ write_tag_66_packet(char *signature, u8 cipher_code,
 	 *         | Key Identifier Size      | 1 or 2 bytes |
 	 *         | Key Identifier           | arbitrary    |
 	 *         | File Encryption Key Size | 1 or 2 bytes |
+	 *         | Cipher Code              | 1 byte       |
 	 *         | File Encryption Key      | arbitrary    |
+	 *         | Checksum                 | 2 bytes      |
 	 */
-	data_len = (5 + ECRYPTFS_SIG_SIZE_HEX + crypt_stat->key_size);
+	data_len = (8 + ECRYPTFS_SIG_SIZE_HEX + crypt_stat->key_size);
 	*packet = kmalloc(data_len, GFP_KERNEL);
 	message = *packet;
 	if (!message) {
--
2.41.0


