Return-Path: <linux-kernel+bounces-104725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFE487D2CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706D01C220CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED7748CCC;
	Fri, 15 Mar 2024 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="So4N/Q/6"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC13B3B79E;
	Fri, 15 Mar 2024 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523749; cv=none; b=PkQ2tIDms2RD25VUXJJRDNAZxDIwelkgL6rF+nme2x2OvdmRk0d+bluIRnC9d6hhJZvQ351MA1czxfKjM06h8GRxo1nShXhM++KZYSr8z8gmipvsPmalu7yq5bbrX+Kgpe5LXrBLMjYq0CIgqpkn5nJ/U6/B1pk7mIE8GW9e0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523749; c=relaxed/simple;
	bh=anpAHH2KuXL7ULU+QjpHeyggW4JdiKkCHD81lFQDPOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ksLX6rCFqa4BVPAnUYlhOHG7KHd6/aG51UJRmaJDG0uX1fwsqobh4D5tP/sszmn82zFal4rf+Kjb3XDIfU8Yt0maLcHov6ut3O+qPU/1AskooA6mC+7WcYpPXWnLIicrN5iq/HaDM3RZvfXf35LJdi6SCNieswtCJW1M7LFzg6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=So4N/Q/6; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5689b7e8387so3131472a12.2;
        Fri, 15 Mar 2024 10:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710523746; x=1711128546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TMhhVpAtizRznG8VJtuyPA2sK8UPTaoFMwou67Bt+5U=;
        b=So4N/Q/6Rn5HNuCN3cDWiOnnltlv+wODeMYBEtskyFoBKWbJVGpOaWaYZYdBa+bGwk
         2nHN6vE/sUS7PYqDnkNGJ6ojCGjtK8XmYzZer7LI/fffFRJTZ50ifSXOdZ9pTJEOuNkv
         +TmJe9+1IA+Q7MfYGWvhCZoDiyG+7BQopSwNFYaXB18t/aQEr4w47Z9hYCr5mf+CaA0K
         wm/lCdLcpg3AUHwZjV/a5AIFswlK/+hSzBkq804ikCqYu8g3SStN7+BlgpN7d1J6N11m
         2EM9jK908kiXL7zOYAvTX5pFfS+Yh07/wcqoZAxKOZ48/p7kbIy3XZgcQzrTwetruNqf
         uieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710523746; x=1711128546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMhhVpAtizRznG8VJtuyPA2sK8UPTaoFMwou67Bt+5U=;
        b=UBM14UAzD4Td+sYDHPKmvFpoRqcNzdyAihp0AGR9KSl0a/Kw0Mn+OtjNv6DHYEAUJJ
         6l3f+2nMshQEh6VEEICE4mUO7Y00yzSHnOBSwBvHtUUCmnUDXupi+VCh+439Te5W6jpR
         pMaoYyPi4JloGJP1FeLYSBEDPRglSDk8bMkQsr9DWoyv1Eu/hEhspzRZQDOb5L/SV0RD
         W1nzUWT9x4+r/OUAf3LDeEFgJr93IZusnA+RzTCWPkunTqJxTv+4QCH8n2KvzW0m5w7a
         j7NOKyk0yhjEvRJ/PY9iqJ4cGkAN29J0f8ogWduJkeEze74aQdqqT5BHVKjTnCPAKBYz
         GuxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfm8umKci/FRl12B5h+JdZ6+60+Agb88A2q6C9zCp5lnPmvohVO8zrh37kbJhjwlgXfMjKitYiQA52wi++fiTdbaXpzw9mESjBrMs+
X-Gm-Message-State: AOJu0YzLpZDx8iVvU3M0XqpvDWtumd73WEgRcrrPe40OFQkIzJX/h+5K
	Y2Z97twX+rfUfIEw/AbCEXBK7+9k8XQ4QXCccu/dlArQNDzVFUi6+7/w4uxWWSAHOQ==
X-Google-Smtp-Source: AGHT+IE5Ey+yve1/5Gmwz5QEou0DEEA+7EMC7QqO9RW6lYtUMidYpMcchRWJsAd1RzZMfb8ggEkOlg==
X-Received: by 2002:a17:906:81d1:b0:a46:651a:724e with SMTP id e17-20020a17090681d100b00a46651a724emr2610342ejx.54.1710523746240;
        Fri, 15 Mar 2024 10:29:06 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id kq15-20020a170906abcf00b00a462520d561sm1888870ejb.54.2024.03.15.10.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 10:29:05 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selinux: reject invalid ebitmaps
Date: Fri, 15 Mar 2024 18:28:44 +0100
Message-ID: <20240315172859.634263-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reject ebitmaps with a node containing an empty map or with an incorrect
highbit.  Both checks are already performed by userspace, the former
since 2008 (patch 13cd4c896068 ("initial import from svn trunk revision
2950")), the latter since v2.7 in 2017 (patch 75b14a5de10a ("libsepol:
ebitmap: reject loading bitmaps with incorrect high bit")).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  update wording as suggested in [1]

[1]: https://lore.kernel.org/selinux/d476b21729cafb28c1b881113a563b1f.paul@paul-moore.com/
---
 security/selinux/ss/ebitmap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 67c1a73cd5ee..f1ba333f127d 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -448,6 +448,10 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 			goto bad;
 		}
 		map = le64_to_cpu(mapbits);
+		if (!map) {
+			pr_err("SELinux: ebitmap: empty map\n");
+			goto bad;
+		}
 
 		index = (startbit - n->startbit) / EBITMAP_UNIT_SIZE;
 		while (map) {
@@ -455,6 +459,13 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 			map = EBITMAP_SHIFT_UNIT_SIZE(map);
 		}
 	}
+
+	if (n && n->startbit + EBITMAP_SIZE != e->highbit) {
+		pr_err("SELinux: ebitmap: high bit %d is not equal to the expected value %ld\n",
+		       e->highbit, n->startbit + EBITMAP_SIZE);
+		goto bad;
+	}
+
 ok:
 	rc = 0;
 out:
-- 
2.43.0


