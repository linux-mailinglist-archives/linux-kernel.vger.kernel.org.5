Return-Path: <linux-kernel+bounces-106785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD4D87F3BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C0C282DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36545B687;
	Mon, 18 Mar 2024 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="UMisAxXH"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBF55A7B6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710802936; cv=none; b=moVjxd00sB5VVJl4M7zKCvSvMXJxsxn2o60AYP6JVIJvDM2psTWIs3LbcRElbOgAUOtxCgjRayqBoCdC3PN/5aFyPHIDL6JI5iCXsRMwYV4sewy4Eh3bQfC7wv04oRrpk/Yd8sBRjjqVAvqvFNKhom/WkyuuT2EjX9mBlDU37So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710802936; c=relaxed/simple;
	bh=PLBNaeGU4NGKgH+5UYKS87ZNpd4Ohvlws0rrQwvjxCs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ol8IWJ16Y6Jf6gd/oHcVeIQzQkn0Ss6LCPEyZMyCx6F+Lqj7EPmUxrIU464z315p1h0HTUddUN8bY+zwgGbl4ULpZBZeunq2H33gft1YzmMQ3X0vDyNCV3vIB72/ffSUiXVLStJCXnTiOzeE9VVZkN9JFKPNyst1MdNxdXLFM2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UMisAxXH; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7cc7a930922so129950339f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710802934; x=1711407734; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RuRw5x2krmOTvpAyjZbMZbMO9GBeCXlz1oxN1a8wl6I=;
        b=UMisAxXH96OIu1uQ2lJuAXEkkS6Iqh3MbHamKlgTCrWILnYmz9sFpAwuvuaklH7Mqi
         qWy4C8ZbQT/NTBNhYHbXo8RyYvoMYoSetiiiqGyROsRouGTGqS28p9Vb2MBgwvP4FuoA
         WvvIp2epZFPKrW/CNMnDfovM9Q0f1EixlARPbfhpSm9wbcj1hXJBAOihwBUygvaK3i25
         Q4bIXUWfKraOF8T9yCqL5uLveboWs+9/ehW/eLAYtM8N/4sc/wxpRqoI0liDtslBGOaI
         aDY/YvgTIyiQG6tiD31RUJbP4kAetZ1eo4JdBIxNmISPw7Y1lQ7zTNvGXF1YAZvemshP
         5tGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710802934; x=1711407734;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RuRw5x2krmOTvpAyjZbMZbMO9GBeCXlz1oxN1a8wl6I=;
        b=d7vVFzZHo1VYkEVR0a6+mbGdN8HKM13vu64qpEpYZ4oy7q+M0ibOye0SMiLK/WLO/b
         F6SWSItc3iBd5/EpxevYVtTxXW1fOWxITnX3CL9OvecYiQT246wtAwL8H7oVVH+QZpDb
         3P2gzSwlWRsudgiV5dRFsOl05LNNvZ6B/T5HHhPQbk+LAnv04QztIXIlbah/o/xoOJ8S
         tNRdEHFFPhaIfy/AaT3eYkPXJ/iA5asPySV6kY1iLZkygJVu02M9GYGwHr5nbwfFMu/a
         yD4mA9Xws+qfhS9+4x8+gaIb15ZjhvbZuhnvIjTfzuywglYaYXanx78QrI5Qi47AvcXW
         ik4A==
X-Gm-Message-State: AOJu0Yx+IdRGp6UGY+ML1JfxfERhK5ogTndgzeUXCEbjLr1MdtosbZm/
	DkJIc8sHQtGm7v6+VhrD6HQWOseoTDPzaqsTbaO3bX0MqBGEQfGoNBgB/kqf0WS++y1HgOzRJMl
	NC9h0blMuRTuw8PnFsoNa8Q==
X-Google-Smtp-Source: AGHT+IGigwPG3lswWUAwHTHW//LsWC2Z+0kkjdFTnuXg/Py0AAp24wxbDb4trJJAijtKAdS9ElBjrJTq+3LBUasfOg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6638:1501:b0:474:f25a:6fb with
 SMTP id b1-20020a056638150100b00474f25a06fbmr18381jat.3.1710802933921; Mon,
 18 Mar 2024 16:02:13 -0700 (PDT)
Date: Mon, 18 Mar 2024 23:02:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPPH+GUC/x3MSwqDMBAA0KvIrDuQj0jrVaSIxqmdhVFmgiiSu
 xtcvs27QEmYFNrqAqGdlddYYF8VhP8QZ0KeisEZVxtv36hJYthOnIR3EsWUToz9rAsGHEbrfUO G7KeBMmxCPz6evfvmfAO2nZ2DbQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710802933; l=1720;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=PLBNaeGU4NGKgH+5UYKS87ZNpd4Ohvlws0rrQwvjxCs=; b=fmH1GAtSbSXvWJQhDzqi9ECrH9lrSt1Xh3vgXrt6mIBppacRRR69jUkAWUkkscz5SfVvIypNY
 6lWcTQXikENDBdVs8XK2spG8HvT3aLgM+9oP+uAW70dWhbZzew5Ck/7
X-Mailer: b4 0.12.3
Message-ID: <20240318-strncpy-drivers-tty-n_gsm-c-v1-1-da37a07c642e@google.com>
Subject: [PATCH] tty: n_gsm: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect nc->if_name to be NUL-terminated based on existing manual
NUL-byte assignments and checks:
|	nc.if_name[IFNAMSIZ-1] = '\0';
..
| 	if (nc->if_name[0] != '\0')

Let's use the new 2-argument strscpy() since it guarantees
NUL-termination on the destination buffer while correctly using the
destination buffers size to bound the operation.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 4036566febcb..f5b0d91d32a7 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -4010,7 +4010,7 @@ static int gsm_create_network(struct gsm_dlci *dlci, struct gsm_netconfig *nc)
 	mux_net = netdev_priv(net);
 	mux_net->dlci = dlci;
 	kref_init(&mux_net->ref);
-	strncpy(nc->if_name, net->name, IFNAMSIZ); /* return net name */
+	strscpy(nc->if_name, net->name); /* return net name */
 
 	/* reconfigure dlci for network */
 	dlci->prev_adaption = dlci->adaption;

---
base-commit: bf3a69c6861ff4dc7892d895c87074af7bc1c400
change-id: 20240318-strncpy-drivers-tty-n_gsm-c-ab1336e0e196

Best regards,
--
Justin Stitt <justinstitt@google.com>


