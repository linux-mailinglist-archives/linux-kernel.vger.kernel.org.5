Return-Path: <linux-kernel+bounces-168341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762C98BB6FF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045842818F8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C875E4CDE0;
	Fri,  3 May 2024 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Fj2r+TLs"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C517B59B71
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 22:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714774623; cv=none; b=Wh1wen2hlzEStnRAe1LwV74Tl1YM5TfOBiGvXKGMGp0qP2Qq1dnbTO8Guarv8ZV3IAJmD989rpQzSWPbs3yI7qfcAlQnnsxALhyEnX42wzAnWXxK5XpkhpTTJi3PXljnKhJg696/S0LYsHH2lfwY9fdDPiwmniGmcU9J8bVrYco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714774623; c=relaxed/simple;
	bh=bjrPyd8oi0HdoqaOMudW73dCqeW2eJJ1sam9lCXCaJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jgLDv2SLCkogYwGHTXxF/03g5bO2tJ2EobUq8HWjmgsJZbDmOo/1jDXkZuBPIefnXeNBWD4ThTwph4EDilcrZocmitkopLrIEbAIlSE23iwqFIqILvverfCbIhwjeanHvMVCurIo3DeTE5qIt8jCY4OPnfTk33i9uSLXdVCTdKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Fj2r+TLs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41b9dff6be8so1812395e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 15:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1714774619; x=1715379419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RwCOw0nc1pOxcjdsWVI1ueYL54XbeJ/hpDJBTzvXAfg=;
        b=Fj2r+TLsI06YE5Iee9AsJP5geZ4ByaUByi0m41VO/RPSn1fzM/0VbkmvkyF7PXd7fk
         vG3sOWl7Un7Z+E449WEHvfU+PjeAhqIMqgSpKbs8ibpO3XUM3HSsUZJfI/JN18V8BYOv
         qcT1RuafUIB9+eJqkdK50R0AoaLG5kldJazZOf/FVw/6+BXzDU6jNvFsInJXTHoaf106
         jNnvDWOEMCBp01/KPdkp/FnT9kiXOot7FY1tCUSqyM/udVLSZZ+x3PycpoCiHHHU6K9c
         hzj85iXMZSQdkSVJ8oBvLe9QcRdwfbYA00MSp/9lNIQJLuIcMGDyzk7rfXo3ype2PdH4
         uRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714774619; x=1715379419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RwCOw0nc1pOxcjdsWVI1ueYL54XbeJ/hpDJBTzvXAfg=;
        b=j3YfLTg5RxJfs8YK+K7yxniwxOi+NfrZrZurGtJraR0YHNEh85wL8/bQap10Mj79BK
         7H25oLGx40UbpVvVEffz7KuBHsIBhgJ7L99o5xwT1oh46JllhCf8OL0v/lpCcGgy30I7
         xyJQUXOJlWfVDPpf+WhUSCDIoNHko6q1FcQJ+Kh4PmS9sXXyGGZwqTDfG2YEtfwhkd4Q
         jbEf+RSuX2/07xOrSmhnQTlY7wX7V1wC0WcLIus+ynjCBm8bUV9hdqCPyAjPuzP5LA9p
         KPgorB+My1oK44L4G80/9wxMvVK5gi1E8IWWZr9N8AetCCeYcTWXkPWi1sJtK22IvowH
         zX3w==
X-Forwarded-Encrypted: i=1; AJvYcCXTTpEy5qRUkE0wjtunhfBx/KzNQ/+Mq15hai3bFkdhgH//xO1XqfjbgSjT9rAqmznBmexlYEQio5OI9clW7999FuNsOaaa6uVbXBmF
X-Gm-Message-State: AOJu0YwN/AroDvYqtNgarIZXDeXRmius+v19QLiS5BANDkVIV5wJ355j
	3wKCPr0x2Wbku77IFwcuHd2QPCS4qgn3htoLhzcns+mjBPa0Gl+YVG4ct3hiNZg=
X-Google-Smtp-Source: AGHT+IH8IaaKjpv39xJ6W/yfMwMMQLl5Ff5DYRJtGnHzBJ5kmUMtt7DNuIuZyWuSjfonfV1sSj+lPA==
X-Received: by 2002:a05:600c:3b21:b0:418:f5a9:b91c with SMTP id m33-20020a05600c3b2100b00418f5a9b91cmr2954824wms.33.1714774618992;
        Fri, 03 May 2024 15:16:58 -0700 (PDT)
Received: from localhost.localdomain ([104.28.200.6])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b0041563096e15sm10873368wms.5.2024.05.03.15.16.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 May 2024 15:16:58 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	serge@hallyn.com,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [RFC PATCH 0/2] TPM derived keys
Date: Fri,  3 May 2024 23:16:32 +0100
Message-Id: <20240503221634.44274-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

TPM derived keys get their payload from an HMAC primary key in the owner
hierarchy mixed with some metadata from the requesting process.

They are similar to trusted keys in the sense that the key security is rooted
in the TPM, but may provide easier key management for some use-cases.

One inconvenience with trusted keys is that the cryptographic material should
be provided externally. This means either wrapping the key to the TPM on the
executing system (which briefly exposes plaintext cryptographic material to
userspace) or creating the wrapped blob externally, but then we need to gather
and transfer the TPM public key to the remote system, which may be a logistical
problem sometimes.

Moreover, we need to store the wrapped key blob somewhere, and if we lose it,
the application cannot recover its data anymore.

TPM derived keys may make key management for applications easier, especially on
stateless systems as the application can always recreate its keys and the
encrypted data is bound to the device and its TPM. They allow the application
to wrap/unwrap some data to the device without worrying too much about key
management and provisioning. They are similar in a sense to device unique keys
present on many mobile devices and some IoT systems, but even better as every
application has its own unique device key.

It is also easy to quickly "wipe" all the application keys by just resetting
the TPM owner hierarchy.

It is worth mentioning that this functionality can be implemented in userspace
as a /sbin/request-key plugin. However, the advantage of the in-kernel
implementation is that the derived key material never leaves the kernel space
(unless explicitly read into userspace with proper permissions).

Current implementation supports two modes (as demonstrated by the keyctl
userspace tool):
  1. keyctl add derived test '32 path' - will derive a 32 byte key based on
     the TPM seed and the filesystem path of the requesting application. That
     is /usr/bin/keyctl and /opt/bin/keyctl would generate different keys.

  2. keyctl add derived test '32 csum' - will derive a 32 byte key based on the
     TPM seed and the IMA measurement of the requesting application. That is
     /usr/bin/keyctl and /opt/bin/keyctl would generate the same key IFF their
     code exactly matches bit for bit. The implementation does not measure the
     requesting binary itself, but rather relies on already available
     measurement. This means for this mode to work IMA needs to be enabled and
     configured for requesting applications. For example:
       # echo 'audit func=BPRM_CHECK' > \
         /sys/kernel/security/integrity/ima/policy

Open questions (apart from the obvious "is this useful?"):
  * should any other modes/derivation parameters be considered?
  * apparently in checksum mode, when calling keyring syscalls from scripts,
    we mix in the measurement of the interpreter, not the script itself. Is
    there any way to improve this?


Ignat Korchagin (2):
  tpm: add some algorithm and constant definitions from the TPM spec
  KEYS: implement derived keys

 include/linux/tpm.h                     |  16 +-
 security/keys/Kconfig                   |  16 ++
 security/keys/Makefile                  |   1 +
 security/keys/derived-keys/Makefile     |   8 +
 security/keys/derived-keys/derived.c    | 226 +++++++++++++++++++++
 security/keys/derived-keys/derived.h    |   4 +
 security/keys/derived-keys/tpm2_shash.c | 257 ++++++++++++++++++++++++
 7 files changed, 524 insertions(+), 4 deletions(-)
 create mode 100644 security/keys/derived-keys/Makefile
 create mode 100644 security/keys/derived-keys/derived.c
 create mode 100644 security/keys/derived-keys/derived.h
 create mode 100644 security/keys/derived-keys/tpm2_shash.c

-- 
2.39.2


