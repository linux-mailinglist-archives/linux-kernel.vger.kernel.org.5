Return-Path: <linux-kernel+bounces-98030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1C98773D7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A98A281D85
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 20:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5717E4EB4C;
	Sat,  9 Mar 2024 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YX3h28jB"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3056416FF30
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 20:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710015893; cv=none; b=vEcGxsPMQpwHMcZsoF9+By9mQ/hEPbzHDBEMNjKB5L5UyeO3/XFvvMujeDUMmfETSd/28yG0NAuaSw7qdp1FsEVRv7ZgfRIZJccW+GktBz/OtlFbx1RIQD0gjL0UkkZyVMguRMsah13kH0wfv02UcB5xsgneqgsSZszJ6NBH3wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710015893; c=relaxed/simple;
	bh=K9RoT73X71QnB+uU8sWtSEx1Mtsrf1E5zhfyiv3p1ZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DTvy3KzbtTw5fJ7mraJIwpaPZSgK32ikbhcTotQb1vzuzoVzpYLq/hnmO0ECCT0gvbaN8uH2rAu6cC1BEgkE2FXvQVWLdkP16ztjgVQ0TK8Q2imDkQeCcf/hl7QZO4xH/23wcWBhsMgwkKKb6VOvDMmqTWl4RLzamv3MaYFMkFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YX3h28jB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dd10ae77d8so26162875ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 12:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710015891; x=1710620691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pzdoSSC7M3Gn4nXch6enCVEFVBAir+v+I5+bn35uJJU=;
        b=YX3h28jB4WRGi8wJ7maxuIUdu3IA/SyxGwsGyKSysTuUxqt4RdCWISSRKrBb73+omm
         8LrXJU8Q152eXWTVi2ap6yN+wg1jxk38dZHEfU/1xDUPkdqEwEyCqBHFVAoO1FrqnZbv
         ccDXNWMXlkJiG1ACdvW+Ay71rFBL8lSPTFkr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710015891; x=1710620691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzdoSSC7M3Gn4nXch6enCVEFVBAir+v+I5+bn35uJJU=;
        b=HCUT6KTpknH73hzc/ie3XORFRtTXs4Es8mYYl+FXNXRW2iD72ReJq2tnZCaSlDw8Jd
         4hS3ZIfyD1jpQFwws+jG5b5jKFyOWgCvvSiNa+LABAvXiV/rfBwSA6vqmtfuDq7QZ7KQ
         ySjHjEJzRX3F9hwh4Ec99241ijOR4G/7Zl3UUR3hbVCOrOcTy7stny7RKZEl6zalt6Mz
         kyq0DDoIaMsFf7l4O+Ef26Rv90EuI1bUHExoC3eAbv1sfqbIwSLxwC/NTnU4yP5Zs52C
         4CNzV8JCvV5Pu4YXoWq615QC3nldREcUUJPpo4SOLK45Ve8ezaFcjHAl42IoEQC0jpsM
         2HRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkJh9PyktQN+e99MTalg5ECOYVt3KkeB1hNOWcTUcbD5aw+0d6qOilAidiBGEglYa9mrjEnw8vCJ/ncs2+S70mpTjQweKCCvOmhNfO
X-Gm-Message-State: AOJu0YymHyVOqNPVdw/T5IyG6h7hPDinsQU8Cis+jSPIaa78cgjetaPp
	IIZghkW1Ealq4jn4DGRVruQ/XdYaiHdf3xBZASJl6G6ahNlbjETQ1XIqvaKjag==
X-Google-Smtp-Source: AGHT+IHS3V/gDLEjjvi9Itvln/GKgAbneox6bx5epnt2P+RSO7WF1SQOAKdmHYGasuxFgTMM+KSrxg==
X-Received: by 2002:a17:902:ee51:b0:1dc:abf0:14ee with SMTP id 17-20020a170902ee5100b001dcabf014eemr1783343plo.22.1710015891485;
        Sat, 09 Mar 2024 12:24:51 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kv13-20020a17090328cd00b001dc91b4081dsm1689004plb.271.2024.03.09.12.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 12:24:51 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Kees Cook <keescook@chromium.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Elena Reshetova <elena.reshetova@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] randomize_kstack: Improve entropy diffusion
Date: Sat,  9 Mar 2024 12:24:48 -0800
Message-Id: <20240309202445.work.165-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; i=keescook@chromium.org;
 h=from:subject:message-id; bh=K9RoT73X71QnB+uU8sWtSEx1Mtsrf1E5zhfyiv3p1ZE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl7MWQSFajPauij2zI2NqidKesJzjt4bPzfLCaH
 yknBCinsCGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZezFkAAKCRCJcvTf3G3A
 Jmw7D/9F0pyXIKqu9kZmrjuYv8/kfrd8EBz4K3EsSJ877q3bmqlQxMfJwm/KOL/Wt6HVE0a/P8a
 dHAS5wUM14FBGvPkoEmUPu2kuxeegqRC2FCKCuvx2JiiXFVoQ/YF3RHw6XNosQUi465oFMZHf7i
 wArtIwAloVlVK5fvYEvDoYP/fmZ+cgUxuraqrTDQZRQq637paFp+HGthtvdQd81bV4mrwDoKrpm
 FFPbq5uvAKued3ymyZ4XFRYy7ryBz8reIgIyxACSnBX8PG5ZY/JX9eFX5Dgglyd+epZ+wkeOV3Q
 y8mk8G+7vK/3CInx+EXsjU2biIIRKgHSYaCa2G79XRL6YiJH5y4HgONJVCZ5EgG2F91yhGuCYsi
 zyNVm77/4EQ1EFjhP0qSritGVorn3HavQlWvSnk//b2z+VcZVQ5168aImJCyhI5IbTdKyjjxfGC
 WnPMAnkqPIkPvhM2o9C8I7fP5FLY09G/hcZNW7pz+3G7tbOd5eEe4NqaUKqchu4KT+/3gnuWYE6
 pmEruvww9YJn5ZcMteecUkWWHrUDMOwLu/lROpmnh00fUcs0zfg58ynqC1v0UPacrXxZH31MYzW
 YnRnu++vJJEhejWU18Lxkc8JugyphNk95dSlnqhKjCnXnvU5qgxbV4ieXmq4OWM6J3uhbLHAZEr
 aXbZzcE j2hbFSUQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The kstack_offset variable was really only ever using the low bits for
kernel stack offset entropy. Add a ror32() to increase bit diffusion.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 39218ff4c625 ("stack: Optionally randomize kernel stack offset each syscall")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
---
 include/linux/randomize_kstack.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
index 5d868505a94e..6d92b68efbf6 100644
--- a/include/linux/randomize_kstack.h
+++ b/include/linux/randomize_kstack.h
@@ -80,7 +80,7 @@ DECLARE_PER_CPU(u32, kstack_offset);
 	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
 				&randomize_kstack_offset)) {		\
 		u32 offset = raw_cpu_read(kstack_offset);		\
-		offset ^= (rand);					\
+		offset = ror32(offset, 5) ^ (rand);			\
 		raw_cpu_write(kstack_offset, offset);			\
 	}								\
 } while (0)
-- 
2.34.1


