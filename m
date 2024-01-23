Return-Path: <linux-kernel+bounces-34546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F328B837ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77779B2878F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A54313D4F1;
	Tue, 23 Jan 2024 00:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MRjAVZJb"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EF4612E2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970765; cv=none; b=NT65EqOpv0zAx8AiUKVUZMcbqnG5ORwLX1ZB2rHyXh9Pxe0oHrrbUaHPTtaqiZxVrjti+94GjclURyHLOCpDckDat+918LKCrqMbCNSshEQYM/iJwF9wbBV2LvPpF0FONAyQf+c6iU7S//izRD67A/YTf5iDRZxzfTIDuCYQ6ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970765; c=relaxed/simple;
	bh=xNoy2DEKxPexmysOm1XEIuiIvV0tGdJOvp+eDp29H/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UC9yCPtzoV1kQyqW2GlR31fnayjtC6rFtjn0eBb6SdXG+esjJm7Ggzk3ZNJopCdXmv0s1KNV/Y4iEkaLXiREO51RQyWTmea2mYOESa6CDHWti9iG479IyNrFZC2KDEHkG79GkVynrE/QM33hIJKK7t4b4EyObnmgTMnkhe6NzS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MRjAVZJb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d748d43186so10872275ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970763; x=1706575563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sf0op9UA6jGtVwywOsAePMFRok3+ELaOdVPcTfD4XW0=;
        b=MRjAVZJbe42rSHmoOvvFIwJvZNVonvQg/oqutEfbNGF0UTgPcHbZ93GkDEbE+u8vAq
         qkZ4bWljeIcLpy8gcfFJOHNKPUb6+Z8M0WTNUbnoAyAnq+B6egwKtnudItlaJiTl3KYz
         ff+8RMc43P1FAS7qpz3hkvSn+NmpWDsWEtPfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970763; x=1706575563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sf0op9UA6jGtVwywOsAePMFRok3+ELaOdVPcTfD4XW0=;
        b=pFP+g7aflBEPOG+siK1WQJJCKhQ9jUM1g58n4+Xh9fH4Fj8bHAu3n65Ywq0zZ8rFN0
         EGW8UEz8jyy8z5mRGN6foXptqLehH+OXNkL4cpouZXRAZzw/eu5CbxCT4bcqcEgCHY+q
         G5vsVKiMSRjMHYKTcL7KWhTlafiCYfBtuU5vdEMtKoYzs9r/KL6atf3CaZFrI3LlTU/W
         KvkxeRU744O3LI+HQUQ/BpAD+dDOnv4eNWb+XpWJyPVdIs+o2m7DM/sUYQYJaTVWeepK
         InNPf1PP1vCqoK1ASDmY49tvbuTUKHrujJbl8Tjm8/FMcf+LIIN6USSKtymi1iAueYti
         NhSw==
X-Gm-Message-State: AOJu0YyZo73aaGXGfV0Afs1gS/rnn4mZNp2PTDWw5JaeJPfn9Cz6z2Ik
	S0sw7OEySOl/3PATpFlOUbGZiUs4madaR2CjEcxaD2vsEugGB0ryIp7W7wZ8hQ==
X-Google-Smtp-Source: AGHT+IE/WhXYgKQUaYpV5E0ASAMI7oMgYNg2DdzzRnLz2Ll1a0tefzWqoAbEPID43E3715pmMfsXlg==
X-Received: by 2002:a17:903:2348:b0:1d7:617f:6dea with SMTP id c8-20020a170903234800b001d7617f6deamr1290475plh.59.1705970763650;
        Mon, 22 Jan 2024 16:46:03 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r9-20020a170903014900b001d7211cd3f7sm5853984plc.265.2024.01.22.16.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:45:57 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 45/82] cifs: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:20 -0800
Message-Id: <20240123002814.1396804-45-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2484; i=keescook@chromium.org;
 h=from:subject; bh=xNoy2DEKxPexmysOm1XEIuiIvV0tGdJOvp+eDp29H/0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgIC9jJ8iaLQLpMHm2oaP/gJFWo6z16pwWIH
 frFA2mk5NyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICAAKCRCJcvTf3G3A
 JidPD/43jyw+n24wTT1kk3hrH8GaVm1jhQv0Peatn4T8EGaS6EeAlVVxyaPfgjyRlynINUrXvsK
 HaEtBB4FIngOHcdhwrcU6rjQ6dR1uIlyMg4E72yb8tVbdliP6qwkiT2ecDroeGiBrW1oaJGvoBV
 +BW2xWnKw/xUWkEuY5/gOAg70JYqLdhrj1+O/sBKrVG3Z//+lHssd0Gua1rN5yLWCexaUbs98/P
 fUwsGsPV3XXcpZRHQm6gxLzlUxUl2QRmAZpbc6yHf+iQqeQJNvMF+U9LjgVvk+FancFxNeVl71s
 1kNlAm/+gBZou1Mk97HK49dTT5BMklB1S9hoNjZWRMtCnuCxRyYOuMS6RpQxRkCQnU0BUBHuE2K
 h/F4dHaFnL67EdIG87Kkpl9QtRSQWBwr4BNIYF0jfEo/cM19ltK1b6Rs8D4X/OFvNYs0IABel5w
 znOAKXPr7JmH6UW2Sld9YPHUedVxOCMuk/i9PgzIUxJkF3D3W1yv/A0YaN/j0jNvdSkE3qalwbg
 QSWUHXbJtPytx7L+XPKl1zACMCU0Ul5NQUl11Vk2NbjuxayThC1Y0A1TayLxVq1gtmBUyO09nsS
 dH3jGnzw/kZTzoU6P0S5pw7QDLI6CVNv3Hho4jhx+k2DERI0biLRv+dl2VEtnMsVph/T9izC/Va gR1KNJ/P1/j+s7Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@manguebit.com>
Cc: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/smb/client/smb2pdu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 288199f0b987..85399525f0a7 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -5007,7 +5007,7 @@ num_entries(int infotype, char *bufstart, char *end_of_buf, char **lastentry,
 	entryptr = bufstart;
 
 	while (1) {
-		if (entryptr + next_offset < entryptr ||
+		if (add_would_overflow(entryptr, next_offset) ||
 		    entryptr + next_offset > end_of_buf ||
 		    entryptr + next_offset + size > end_of_buf) {
 			cifs_dbg(VFS, "malformed search entry would overflow\n");
@@ -5023,7 +5023,7 @@ num_entries(int infotype, char *bufstart, char *end_of_buf, char **lastentry,
 			len = le32_to_cpu(dir_info->FileNameLength);
 
 		if (len < 0 ||
-		    entryptr + len < entryptr ||
+		    add_would_overflow(entryptr, len) ||
 		    entryptr + len > end_of_buf ||
 		    entryptr + len + size > end_of_buf) {
 			cifs_dbg(VFS, "directory entry name would overflow frame end of buf %p\n",
-- 
2.34.1


