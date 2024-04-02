Return-Path: <linux-kernel+bounces-128668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3A5895DE6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AEEAB2852E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729D715D5D2;
	Tue,  2 Apr 2024 20:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ag979f8a"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5061C2E415
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712090398; cv=none; b=GlojYgE45Pd+I8alc4dsKgZqkJ8Sj3jrdDBZpM8BdnQowPpZy7OKrJvTlXsJNNATdR5ndK6JvKp8bxlGjH6KucXgN7i/VSIvFbOf9Sjbd+Q6TSTk/2yQdtLraMTnAdmJbDlAuDwqw5Fz1x8wDc59CBXs+98k9JuI9uDyf0NnunA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712090398; c=relaxed/simple;
	bh=tjg4x5e3PlDUqq2WuUJ3+ChpV/LB7ZJ2PHMkeIF7ESs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KFceP3ysBTVyk25wrpLVKb76qg8WHb++ym5ifvItcdiJnuB1RslZ+z+0u8yIXJa8eydSZ5r63ZZGwzIJXBg/cMMmq6ZFDBDTBcouR1N5faDPWuyK5IehZ8mFXhgBfckveHsCF59cMfDgqkbsToNKX4Xn9D9ljwN8c6Aie6FpR1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ag979f8a; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7cbef888187so566919839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 13:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712090396; x=1712695196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5VM22ZLPwCtsIw+jd1nTqxgUKJwdnIyjGn6t0jOkoy0=;
        b=Ag979f8abBT6DlUaCi1RaZnycttckxA6YLSwyv9z6XIDvol7pa3atZJAVl1V0Df/dD
         t5rjQNfe6xN/mYrvsNIazYvVeg1tTUkgFjC7hnN9+L9DQm1Nm9/0E3RFuACahkAtlJN7
         V4rVM3swXjd0Sp+Kf4myk9n1gyqptSh5qT6+nbFqJVezrUyJSX4u1jTgMLg5gni5pDKy
         eepjuHMejaVO4szhFHWX1voEVThsHhrnRXZyox5eeJentP5Rl07wRanSTW1jui/HKJi9
         Z2V0+io5bvqYA1XViCYJAdlw2rQffFKuqUUoJ1dStFk8XGc57Vf6jMLtdVhtlqGflml5
         u+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712090396; x=1712695196;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VM22ZLPwCtsIw+jd1nTqxgUKJwdnIyjGn6t0jOkoy0=;
        b=LokX9/l4zDhz4uO8m5d+IMSPzO+Fq2p7FgbjRmJ9vj4c2DKELCdn/cjvLmLWY1Lxcr
         boLFb4gI+H369hq/M4wLqOUa+4fUohS9v6Gfe86HJ6YaFQnwwSPJQh5c4PBxvDcIAlpj
         wE5V3XK4SZmthGdJ1cxsQLbKbjoFH0UM3Zlo+873DRRDFkeLDJEO5DhuLPQNpE1DL1LF
         PE9m9M/3lVYIBPyPF1GRtnUwx0ALb0IPnn4sdC8/de9T6zVSHfv48q2JeVrSVp7MhtAL
         GZ3PwMush1Olayldxy7wzI24B57oYk2WrcR7g32yWUZN9SCC9Gs7aJj2j6SmJepKLUKW
         GArA==
X-Forwarded-Encrypted: i=1; AJvYcCUWb5D6DyFoTrXSZjXULUsuh23a+ZzGWWQKQGvGP1mciXrGdnorhCetlGoWKHywli0ktQyotAU3n/n9PmgzgxFdXR2Tq8HFamUd52+G
X-Gm-Message-State: AOJu0YzO++HkHuegLQPrBsCOFDSGAWrGYhl8Q/ii+m2xCtqZM8O3w3pC
	09InSw4lF/32hSbl8htVkFV6m9ijR/B7Tie0X9nQovSaMriYKmOipeVyixF8cfdTLP4TQUyjwIs
	zsTjWaDUWhrhOnv1/6yAWKg==
X-Google-Smtp-Source: AGHT+IETt606vn4lNHDW0WE2X2CYGTAwbZHxQnN51d+Fg1HVMdUJfWlJGaaEMQ8RBw0bMJQMIrKbATkWStefspoEyg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6602:3422:b0:7cc:ea7:4f0f with
 SMTP id n34-20020a056602342200b007cc0ea74f0fmr705482ioz.3.1712090396564; Tue,
 02 Apr 2024 13:39:56 -0700 (PDT)
Date: Tue, 02 Apr 2024 20:39:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABRtDGYC/x3MQQqDMBBA0avIrDsQY8DYq5Qikow6CyeSidIi3
 r2hy7f4/wKlzKTwbC7IdLJykor20UBYJ1kIOVaDNdYZZyxqyRL2L7JwwZjGLR1SFANSG7veB++ NG6Dme6aZP//1633fPwhSQSRqAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712090395; l=1551;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=tjg4x5e3PlDUqq2WuUJ3+ChpV/LB7ZJ2PHMkeIF7ESs=; b=hxAr8s4jOllI37g6nd6bnWHNTlJmle/4ReN2d9pG0fwRgSqJNmD7gevfUKm+eOTcGaS+Foga9
 Wl/BSJBSpDDAEzH6WgKhVZY/42+Q5I+j/O92HrtY2JrImnsHtOykUky
X-Mailer: b4 0.12.3
Message-ID: <20240402-strncpy-init-do_mounts-c-v1-1-e16d7bc20974@google.com>
Subject: [PATCH] init: replace deprecated strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

data_page wants to be NUL-terminated and NUL-padded, use strscpy_pad to
provide both of these. data_page no longer awkwardly relies on
init_mount to perform its NUL-termination, although that sanity check is
left unchanged.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 init/do_mounts.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 3c5fd993bc7e..6af29da8889e 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -159,8 +159,7 @@ static int __init do_mount_root(const char *name, const char *fs,
 		if (!p)
 			return -ENOMEM;
 		data_page = page_address(p);
-		/* zero-pad. init_mount() will make sure it's terminated */
-		strncpy(data_page, data, PAGE_SIZE);
+		strscpy_pad(data_page, data, PAGE_SIZE);
 	}
 
 	ret = init_mount(name, "/root", fs, flags, data_page);

---
base-commit: 026e680b0a08a62b1d948e5a8ca78700bfac0e6e
change-id: 20240402-strncpy-init-do_mounts-c-e1d378c88049

Best regards,
--
Justin Stitt <justinstitt@google.com>


