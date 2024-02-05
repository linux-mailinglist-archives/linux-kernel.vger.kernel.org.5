Return-Path: <linux-kernel+bounces-53102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD33284A0AA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3F01F23DAD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E25C4595B;
	Mon,  5 Feb 2024 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gLQb7Ryp"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF1245941
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154050; cv=none; b=It1XB8Udqoa8JjHXlSxA6NYygFkvNp6N4j2rR3TxuW24lYlewc+BJWibm9lLz4p4olwwCJuUpvZW6/ONoNp6z9bskpu+THf8rtOeWU+w8N5GORKLMNWJYteKK2xvZEJFQ7FmP/nirLSRuouxvz9fLA4tHEiv4kqEZvXGsuqR5jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154050; c=relaxed/simple;
	bh=HWhC3riTOwXg+yy/60MQ/z+HIxKpqDzEaAK6EfQRCzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CKgBYlOjC3/j2Rv0Wy3Gx0A/DzV6q+StkTzxzV0APPzOp78zImVCJF2YWCxu3xnacYZhPZ35XHqG/sz7/8T0L3jxi4lIL4fgXUwASTiT56Y1rX3TiEVbfV/xmmuvqgiX1TzjgaYuX8+4T8acGQd4T7yI15SZnSLxMw4otv2DLiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gLQb7Ryp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d91397bd22so35670795ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 09:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707154048; x=1707758848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4U+N71xHm4gg+B0aHt1NbcRFqwuGDCVmnH0NzcNhfq4=;
        b=gLQb7RypR0GkICA5Cqv4+GGOV+bHsY04D8TEzXeSD4I2BAJgEEoDWuwo70gn0AUQEt
         AiO+/2OLIXKNAdZhejhk1AU8bMhmsKhfsIXBzOsOmNeC9HBcfQVwgVe/aZjzZvWmt4G/
         vGDUL0SyItjm5xjSbHdTfnr6V3NLZ42YS/Kl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707154048; x=1707758848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4U+N71xHm4gg+B0aHt1NbcRFqwuGDCVmnH0NzcNhfq4=;
        b=eIe3CLNs4M3DYOGH2o4N52ocZqHSPXOl/u1LTgZLXpnJ2ADgNaGlfkt8sBwSg++eBi
         AkppXECAGugLfVWxeybegrwF46t1EAOC+aUesZuh2hykNxRcZ0Cjic4hSva0Hd/uhafR
         7JEGemunA2TXj5FUOcO0x0UYiT8WP/rx8BCKiab+bdjK5UCSzn0csGGo80vRcAgVSYpK
         dj7N39aNz4jzVLcOSx2cHD6IvwIPxIehiwfBmz+BI42t5mqesntvH1Q3eVZhxmB2Rcdb
         8Zme2mpg+tzXmhtlnlMDLj4vFavz3mtsOzG0b6WDI9V0IhHefIx7YKts/olh2QBsGDqX
         uv3w==
X-Gm-Message-State: AOJu0YxHDKrS8ON+ixir+oAScPF3Jftq8Ui9ZLtbjGRUuEifw6ButlAE
	NGg7tsmV4Mn8x4sRvSjfuNQ/CJ0MKfjpj0ej5K1NJoNUnK+pOKYMl27VUzaoHQ==
X-Google-Smtp-Source: AGHT+IFUJYXHGIr2LCGI8FKWXE3xOLGI2mYhp7DYexE/TWjuF+OeqNnn4MkzN96+o/X73V7ZYaQWDA==
X-Received: by 2002:a17:903:181:b0:1d9:3938:40bb with SMTP id z1-20020a170903018100b001d9393840bbmr164878plg.20.1707154048553;
        Mon, 05 Feb 2024 09:27:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVkRLaBMi1cNLgwcJ4gr0SdqkEdQyijwctiuf5LdVVfpVmK0cY3vbrQqxELm4VsUf5Iviie567CjnCp6QpZv2cJZ9qTb8bfFOzwsPSAlJh48jISJ5aEd1JYomsvY9PR9cZx2/SH/22aLo2LrtRfXvQSb2Bh1iuSAKT6xYetCUbxpQ4DFFVfEk7UJMJ1DqEHXhF2UQ+ReydK0bsF1WRihOmbhvch2i16kfzSuBnbaT8FTOs/yaujTj8mQ7QfpkBkp6Pbv7f/gEovrwRk1fsN+HmauyY2TRN4DA0XDpWrv23N7KxjeaOVBouvbOiux/BPvBL/ENUNLXoA3iqUrfDtfX7ZH924Fou+JlW18gHs1XX4HkDX8Bw5WvPK3NZTGnMWnpblMUi56HW33N7QE5JjPqf30PAXfjhzwnnGvCPTjkg0V7+BrDv9nwbIgg0TgeH2EJZ6lj47Nwmd/T1HsnXwnzPsUI46BtJckryogPjZAVY9WQM=
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:95f9:acd:a17b:b759])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902d08b00b001d942f744f6sm115259plv.157.2024.02.05.09.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:27:28 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dave Martin <Dave.Martin@arm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Matthew Wilcox <willy@infradead.org>,
	Douglas Anderson <dianders@chromium.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2] regset: use kvzalloc() for regset_get_alloc()
Date: Mon,  5 Feb 2024 09:26:30 -0800
Message-ID: <20240205092626.v2.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While browsing through ChromeOS crash reports, I found one with an
allocation failure that looked like this:

  chrome: page allocation failure: order:7,
          mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
	  nodemask=(null),cpuset=urgent,mems_allowed=0
  CPU: 7 PID: 3295 Comm: chrome Not tainted
          5.15.133-20574-g8044615ac35c #1 (HASH:1162 1)
  Hardware name: Google Lazor (rev3 - 8) with KB Backlight (DT)
  Call trace:
  ...
  warn_alloc+0x104/0x174
  __alloc_pages+0x5f0/0x6e4
  kmalloc_order+0x44/0x98
  kmalloc_order_trace+0x34/0x124
  __kmalloc+0x228/0x36c
  __regset_get+0x68/0xcc
  regset_get_alloc+0x1c/0x28
  elf_core_dump+0x3d8/0xd8c
  do_coredump+0xeb8/0x1378
  get_signal+0x14c/0x804
  ...

An order 7 allocation is (1 << 7) contiguous pages, or 512K. It's not
a surprise that this allocation failed on a system that's been running
for a while.

More digging showed that it was fairly easy to see the order 7
allocation by just sending a SIGQUIT to chrome (or other processes) to
generate a core dump. The actual amount being allocated was 279,584
bytes and it was for "core_note_type" NT_ARM_SVE.

There was quite a bit of discussion [1] on the mailing lists in
response to my v1 patch attempting to switch to vmalloc. The overall
conclusion was that we could likely reduce the 279,584 byte allocation
by quite a bit and Mark Brown has sent a patch to that effect [2].
However even with the 279,584 byte allocation gone there are still
65,552 byte allocations. These are just barely more than the 65,536
bytes and thus would require an order 5 allocation.

An order 5 allocation is still something to avoid unless necessary and
nothing needs the memory here to be contiguous. Change the allocation
to kvzalloc() which should still be efficient for small allocations
but doesn't force the memory subsystem to work hard (and maybe fail)
at getting a large contiguous chunk.

[1] https://lore.kernel.org/r/20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid
[2] https://lore.kernel.org/r/20240203-arm64-sve-ptrace-regset-size-v1-1-2c3ba1386b9e@kernel.org

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Use kvzalloc() instead of vmalloc().
- Update description based on v1 discussion.

 fs/binfmt_elf.c | 2 +-
 kernel/regset.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 5397b552fbeb..ac178ad38823 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1928,7 +1928,7 @@ static void free_note_info(struct elf_note_info *info)
 		threads = t->next;
 		WARN_ON(t->notes[0].data && t->notes[0].data != &t->prstatus);
 		for (i = 1; i < info->thread_notes; ++i)
-			kfree(t->notes[i].data);
+			kvfree(t->notes[i].data);
 		kfree(t);
 	}
 	kfree(info->psinfo.data);
diff --git a/kernel/regset.c b/kernel/regset.c
index 586823786f39..b2871fa68b2a 100644
--- a/kernel/regset.c
+++ b/kernel/regset.c
@@ -16,14 +16,14 @@ static int __regset_get(struct task_struct *target,
 	if (size > regset->n * regset->size)
 		size = regset->n * regset->size;
 	if (!p) {
-		to_free = p = kzalloc(size, GFP_KERNEL);
+		to_free = p = kvzalloc(size, GFP_KERNEL);
 		if (!p)
 			return -ENOMEM;
 	}
 	res = regset->regset_get(target, regset,
 			   (struct membuf){.p = p, .left = size});
 	if (res < 0) {
-		kfree(to_free);
+		kvfree(to_free);
 		return res;
 	}
 	*data = p;
@@ -71,6 +71,6 @@ int copy_regset_to_user(struct task_struct *target,
 	ret = regset_get_alloc(target, regset, size, &buf);
 	if (ret > 0)
 		ret = copy_to_user(data, buf, ret) ? -EFAULT : 0;
-	kfree(buf);
+	kvfree(buf);
 	return ret;
 }
-- 
2.43.0.594.gd9cf4e227d-goog


