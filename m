Return-Path: <linux-kernel+bounces-128904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B35458961AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2686D1F231B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B6BDDDF;
	Wed,  3 Apr 2024 00:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1NdzGZW"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247E628FC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 00:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712105559; cv=none; b=qxzrAJHqbAXkeb4zFmMeNtnQKBioiaq5g2LidE3Qjsed0rvnJrJ8M5JVgJgJrrwSSUbV5CnWEuCgACz05yLcgafHS9t5EVEHQzx40Xp1nwC4BGobb0d/lXcMQj4XrcsEiMmr7DGk2QG1LwWGu3yJOniqXJN7FEChJQdFUD1anHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712105559; c=relaxed/simple;
	bh=AMBZZucRDLbkCBnpUsFkHT1Acvq2JW3K7G/CZEuEqfE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=q/3e6D3ElwHFPbxkY9XcY47PhldbUwCIs1dx1Ixvja1LLP6Dys9cP1sHfjcCYq8GgcbMPX9GscpADM8EcUMRrdDQ9+zeEbl3+Eoi0Pu/N3aApUIdPyfp1r8yWSuAk/kWJ/21NmmPH3KNMDwvfUSd4Ds79QFzloNGp7G7K6DcvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V1NdzGZW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd8e82dd47eso7819366276.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 17:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712105557; x=1712710357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2LtWRlkSNk32zYyNyz1b834Pph06BPJDWHucHrmrXSY=;
        b=V1NdzGZWloPXuLxDqb/B8tmJQPVGQnQmw+bKqLVmL7rOtFACzymWsvAwnP7tIVfkLD
         s4IwLwXfAK8T4p3EeJCPxDJ8lNkAYVvcAFSmbpOh1vfeui2rZSMtQF0yIUPCBeJkmN7x
         SmxzA4mE6X/kCFH7OClcwbzIuAfY2agibcTt6Wzm2cDm+f63LoOxvrvKdVwK/5Ab7SmV
         PZPEvKWT68Vk0t+ruOoFQOO7nHvAIoh9W8gR3R3Pffy+aA4dii2G/YQCIFDfYU5MKRLN
         Y0SfQ0Sta0PmbjnNqcOF736arowuF99YZE5eF/+BWbVUWomluW9EcbPoBkNp56EfjclF
         kY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712105557; x=1712710357;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2LtWRlkSNk32zYyNyz1b834Pph06BPJDWHucHrmrXSY=;
        b=JYH1aN77ttyK+S3UECfQxD7jeiIJBw2GQ6Gl3l1Ucr+hvs0cz13U6iakf+GKzxNIju
         TzrKboe7+rk59K2s+mjdfmfxihI+v+qA531TtMovgW1z7KluDmRMMgUjNwjmuSSnyFlZ
         Dc+sD0bZnvph8LwekaX5Oy9LqROKn4zIRLw3YwJMqZfrt13sYL2oR9dZVYWS+zVorVph
         5dodhqc4EnRrioik6Aj4k0ePtSh2jYqSyX3kabpZ6J3bAniQdFwL5U6qeu/eiB0yOl2y
         6pUASmhkXjEzHAz0E9jl+J5hbVOB+tp0lMDjQgNSjkt9mV+3wKDpm3CS9uxI4nNkJasg
         1j/g==
X-Forwarded-Encrypted: i=1; AJvYcCVPKAsl3QjTayxnTe8nfpvla5YnlHWQJX89Ypy1wRFzAuswZClpETDIXS2R6gjazju67nxLqlWbN0BNzRMFWHhvqoBmuVIdLTZQG2zb
X-Gm-Message-State: AOJu0Yy9BnbqQEpV2RwNh7AK7gog8uZ619S+onf7QBB0ouqhbcfeP8Vm
	4f193KedBsRVmra9kKh065b9EFNHn/2kqVq8h1Pl2HUdng13nfpZ5SpNQ8oulGvQepa0RaLFAyg
	jTtWFDDeOKRP/HYEckJVoPQ==
X-Google-Smtp-Source: AGHT+IENHtMGTKiMA0s2/kOwugq4yr4dOndu0KnzLEY/2IVlh0JUmWjmdLHBkuswQWDSDEhDP1VdBsuAqxFROrPxgA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1b09:b0:dc6:c94e:fb85 with
 SMTP id eh9-20020a0569021b0900b00dc6c94efb85mr980999ybb.2.1712105557231; Tue,
 02 Apr 2024 17:52:37 -0700 (PDT)
Date: Wed, 03 Apr 2024 00:52:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFOoDGYC/x2NwQ6CMBAFf4Xs2U1qAQ/+CjEGuk/cQArZKoEQ/
 p3qYQ5zmdkpwRSJ7sVOhkWTTjHL9VJQeLexB6tkJ+985SrnOX0shnnjARYxsqD79jxI9+OpEwe uS9QQf5O2FMqd2fDS9f9oHsdxAlV4hjpzAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712105556; l=1581;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=AMBZZucRDLbkCBnpUsFkHT1Acvq2JW3K7G/CZEuEqfE=; b=5vCiLZjVHanyhM6gz89NkA5pyYDVG+O71KYpStpAjblh7KSvarGbuKYfVC5QMLNwXCs/IhIuP
 Rq24m4eV/t/B4SeYnsudISx/x6NQCQ+38VqG8fIE7d7TQ8vT8eU4wBo
X-Mailer: b4 0.12.3
Message-ID: <20240403-strncpy-kernel-debug-kdb-kdb_io-c-v1-1-7f78a08e9ff4@google.com>
Subject: [PATCH] kdb: replace deprecated strncpy
From: Justin Stitt <justinstitt@google.com>
To: Jason Wessel <jason.wessel@windriver.com>, 
	Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

All the other cases in this big switch statement use memcpy or other
methods for copying string data. Since the lengths are handled manually
and carefully, using strncpy() is may be misleading. It doesn't
guarantee any sort of NUL-termination on its destination buffer. At any
rate, it's deprecated [1] and we want to remove all its uses [2].

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90 [2]
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 kernel/debug/kdb/kdb_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 9443bc63c5a2..8bba77b4a39c 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -368,9 +368,9 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			kdb_printf("%s", buffer);
 		} else if (tab != 2 && count > 0) {
 			len_tmp = strlen(p_tmp);
-			strncpy(p_tmp+len_tmp, cp, lastchar-cp+1);
+			memcpy(p_tmp+len_tmp, cp, lastchar-cp+1);
 			len_tmp = strlen(p_tmp);
-			strncpy(cp, p_tmp+len, len_tmp-len + 1);
+			memcpy(cp, p_tmp+len, len_tmp-len + 1);
 			len = len_tmp - len;
 			kdb_printf("%s", cp);
 			cp += len;

---
base-commit: 026e680b0a08a62b1d948e5a8ca78700bfac0e6e
change-id: 20240402-strncpy-kernel-debug-kdb-kdb_io-c-53e5ed26da3d

Best regards,
--
Justin Stitt <justinstitt@google.com>


