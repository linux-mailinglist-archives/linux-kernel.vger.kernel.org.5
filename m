Return-Path: <linux-kernel+bounces-25064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF6282C71D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48DF8286F03
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBD91772D;
	Fri, 12 Jan 2024 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D8IHT6lN"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE78F17727
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f9e5455db1so67397357b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705097991; x=1705702791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ksYBhZPLA1Cn7mhQtmBXO13MzYmjYuWLD3WlbMKqULg=;
        b=D8IHT6lNgkyu1IYqrHZryjGx5CpTo/Mg+BadjI7HCKPHhMuXIIWKNWGID49tOArVPN
         cfFAyG3o+psZW22fQUS7grnjv87XVQjOigpOsWA1ZCsfzX/zOQaEdMAVc83aYJ8Gar+5
         sx2bP/fiuMjoh6ll3ONYghFIEEfsr5UBa9TXRtGPDjfze4XfTnAucOqg266r1/bbe2tN
         uuFQ+3mZTrS+VlZoJVjh42lyFXm8JhZtFqA4PlFwlSE66Ww/+jZS6m767ju/efapfuN6
         qKdjlpwvXahcMfu3zS1eNyHrODtsj86cjAlFJeXVslT75XxMwdrweVJimeINUF8iGaHS
         xJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705097991; x=1705702791;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ksYBhZPLA1Cn7mhQtmBXO13MzYmjYuWLD3WlbMKqULg=;
        b=EGBE75DgRzhoMJDV2fx7P9B49F67dPeHjP2vSZI3G7rqmcFhWCESGwltlp0QPNHT97
         fQTIL9hCpLSjd3Z1rpmSJbn3U7r6zTC5xhLezdxg0Ri01m+VfLJoWwYn9VyKKncqvR58
         vZraRfx9ZVMxIw66jm6tCXT2ioZ9FVFqy3/d4XLKRrxFyTEuBn3e263i9JcSPHskNinA
         ht55aGCFDh623SLbCeaqHRJDMCrNVtaW8e8UEq/rDBqZrB/jMXXCaPizB9ukN1vJt2vU
         L5xmq6ic+lLNaFX99ZzupwbmAiBvgLvQEsLeHEtOXiZmdpf7TVraGcJtDD52KMdLX0KX
         5kdw==
X-Gm-Message-State: AOJu0YyD+OFtd7eYRUrlanAS+EQjrYs272K5vowQLLdwXIx+s2la3kW4
	Ya4O9aQbuyp6IEeP9bPCX9gmTKcLHVGAoHvkr9jrZsemtg==
X-Google-Smtp-Source: AGHT+IH/3c4nQhHotLjUfqa00qb5zECzcxyLjHW2As94nCL0vyNkw6St2WHe0+KE/ZM+q3+x9yFdh4bUKZLQkufA4D4=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a81:7102:0:b0:5fb:914f:207a with SMTP
 id m2-20020a817102000000b005fb914f207amr793886ywc.6.1705097991021; Fri, 12
 Jan 2024 14:19:51 -0800 (PST)
Date: Fri, 12 Jan 2024 14:19:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240112221947.1950503-1-willmcvicker@google.com>
Subject: [PATCH v2] checkpatch: allow build files to reference other build files
From: Will McVicker <willmcvicker@google.com>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kbuild@vger.kernel.org, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add an exception to the EMBEDDED_FILENAME warning for build files. This
fixes the below warnings where the Kconfig and Makefile files reference
other similarly named build files.

  WARNING:EMBEDDED_FILENAME: It's generally not useful to have the filename in the file
  #24: FILE: Kconfig:34:
  +source "drivers/willmcvicker/Kconfig"

  WARNING:EMBEDDED_FILENAME: It's generally not useful to have the filename in the file
  #36: FILE: Makefile:667:
  +	} > Makefile

Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

v2:
- Unwrap commit message lines
- Align and update regex


diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f8343b34a28b..c2869803e545 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3785,7 +3785,8 @@ sub process {
 		}
 
 # check for embedded filenames
-		if ($rawline =~ /^\+.*\b\Q$realfile\E\b/) {
+		if ($rawline =~ /^\+.*\b\Q$realfile\E\b/ &&
+		    $realfile !~ /(?:Kconfig|Makefile)/) {
 			WARN("EMBEDDED_FILENAME",
 			     "It's generally not useful to have the filename in the file\n" . $herecurr);
 		}

base-commit: 70d201a40823acba23899342d62bc2644051ad2e
-- 
2.43.0.275.g3460e3d667-goog


