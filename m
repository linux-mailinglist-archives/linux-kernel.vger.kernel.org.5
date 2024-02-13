Return-Path: <linux-kernel+bounces-63321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE9A852D98
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC451C21303
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9229624A1F;
	Tue, 13 Feb 2024 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfyBgvoQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D3022F02;
	Tue, 13 Feb 2024 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819188; cv=none; b=gmXMdRWoQa6AVN7rnWriiyK2zrPdb7O5Yv9V3Fkk1zm3/lQSe5UkB0nmVulwt5dyhYZ7gOZVFPQMRaUh9ALIFYAyiwTZ2vqiQixDZnnnQ+pkjyeCvnwv2JysEv/Uwf8gL+pGtsHe5m9qCfwYlF4wz5pAGvMl3ezcqte2aqjrfIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819188; c=relaxed/simple;
	bh=uKIQ1Nctqeju4Pl5cuBowlVWxJ3okEk/Sw8LIufw8xE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gEgbAFSpRHoRmvnVbeHLb/0aXCaIHBRaNBU9zJfe7ck92PNbstwJzWCZkyK5memqZqreaa+GZWcTJqff1t52PkxOUmzMOoKb7IebdZlMSzYoKdmu72OySmEP7+R2OO3miSBxLhp73g7PJVUHYvCRQm62UMW9qvBoAV2Pp8sLMHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfyBgvoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF7AC433F1;
	Tue, 13 Feb 2024 10:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707819188;
	bh=uKIQ1Nctqeju4Pl5cuBowlVWxJ3okEk/Sw8LIufw8xE=;
	h=From:To:Cc:Subject:Date:From;
	b=UfyBgvoQxnUzP/7Xdi954fvjl8/LMFJMz2EQKKKSq6IdLsjF0osBzoLRMKbu2Z+cd
	 CMKunuMkOVqPYRIw8jZxPHx/c+lP3OIJTDN8wEIJEVCiAwDaRs/WIt0hKIeiJVXCXu
	 1/c99Y5W7xh4ZH3oom/g1lx6cvh1UbmnaolGCejc0u1gARSxrsi1TMJybBpw3wsZLd
	 6bQcdINswAvbVjC8dy7D/JxBWnNnUIj4WQ9FBG4zn3Rl4G0KcjowDDa86Ql3cGF59o
	 3wGT2uxuUi998vL+mwcKbCnH0yroPPqNY5Z+1oxAR2mdj3b7RIM/MDB+sW/TdvZC0y
	 8cDpgbLyV6O1A==
From: Arnd Bergmann <arnd@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Wai Yew CHAY <wychay@ctl.creative.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: ctxfi: avoid casting function pointers
Date: Tue, 13 Feb 2024 11:12:46 +0100
Message-Id: <20240213101303.460008-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This driver creates an abstraction for different components by casting function
pointers to slightly incompatible types for each one to get the correct
argument even when the caller does not know those types. This is a
bit unreliable and not allowed in combination with control flow integrity
(KCFI):

sound/pci/ctxfi/ctatc.c:115:25: error: cast from 'int (*)(struct hw *, struct src_mgr **)' to 'create_t' (aka 'int (*)(struct hw *, void **)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  115 |         [SRC]           = { .create     = (create_t)src_mgr_create,
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
sound/pci/ctxfi/ctatc.c:116:20: error: cast from 'int (*)(struct src_mgr *)' to 'destroy_t' (aka 'int (*)(void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  116 |                             .destroy    = (destroy_t)src_mgr_destroy    },
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
sound/pci/ctxfi/ctatc.c:117:27: error: cast from 'int (*)(struct hw *, struct srcimp_mgr **)' to 'create_t' (aka 'int (*)(struct hw *, void **)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  117 |         [SRCIMP]        = { .create     = (create_t)srcimp_mgr_create,
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/pci/ctxfi/ctatc.c:118:20: error: cast from 'int (*)(struct srcimp_mgr *)' to 'destroy_t' (aka 'int (*)(void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  118 |                             .destroy    = (destroy_t)srcimp_mgr_destroy },
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Change these to always pass void pointers and move the abstraction one level
down.

Fixes: 8cc72361481f ("ALSA: SB X-Fi driver merge")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/pci/ctxfi/ctamixer.c | 10 ++++++----
 sound/pci/ctxfi/ctamixer.h |  8 ++++----
 sound/pci/ctxfi/ctatc.c    | 23 ++++++++++-------------
 sound/pci/ctxfi/ctdaio.c   |  5 +++--
 sound/pci/ctxfi/ctdaio.h   |  4 ++--
 sound/pci/ctxfi/ctsrc.c    | 10 ++++++----
 sound/pci/ctxfi/ctsrc.h    |  8 ++++----
 7 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/sound/pci/ctxfi/ctamixer.c b/sound/pci/ctxfi/ctamixer.c
index d074727c3e21..397900929aa6 100644
--- a/sound/pci/ctxfi/ctamixer.c
+++ b/sound/pci/ctxfi/ctamixer.c
@@ -292,7 +292,7 @@ static int put_amixer_rsc(struct amixer_mgr *mgr, struct amixer *amixer)
 	return 0;
 }
 
-int amixer_mgr_create(struct hw *hw, struct amixer_mgr **ramixer_mgr)
+int amixer_mgr_create(struct hw *hw, void **ramixer_mgr)
 {
 	int err;
 	struct amixer_mgr *amixer_mgr;
@@ -321,8 +321,9 @@ int amixer_mgr_create(struct hw *hw, struct amixer_mgr **ramixer_mgr)
 	return err;
 }
 
-int amixer_mgr_destroy(struct amixer_mgr *amixer_mgr)
+int amixer_mgr_destroy(void *ptr)
 {
+	struct amixer_mgr *amixer_mgr = ptr;
 	rsc_mgr_uninit(&amixer_mgr->mgr);
 	kfree(amixer_mgr);
 	return 0;
@@ -446,7 +447,7 @@ static int put_sum_rsc(struct sum_mgr *mgr, struct sum *sum)
 	return 0;
 }
 
-int sum_mgr_create(struct hw *hw, struct sum_mgr **rsum_mgr)
+int sum_mgr_create(struct hw *hw, void **rsum_mgr)
 {
 	int err;
 	struct sum_mgr *sum_mgr;
@@ -475,8 +476,9 @@ int sum_mgr_create(struct hw *hw, struct sum_mgr **rsum_mgr)
 	return err;
 }
 
-int sum_mgr_destroy(struct sum_mgr *sum_mgr)
+int sum_mgr_destroy(void *ptr)
 {
+	struct sum_mgr *sum_mgr = ptr;
 	rsc_mgr_uninit(&sum_mgr->mgr);
 	kfree(sum_mgr);
 	return 0;
diff --git a/sound/pci/ctxfi/ctamixer.h b/sound/pci/ctxfi/ctamixer.h
index 4498e6139d0e..8fc017da6bda 100644
--- a/sound/pci/ctxfi/ctamixer.h
+++ b/sound/pci/ctxfi/ctamixer.h
@@ -43,8 +43,8 @@ struct sum_mgr {
 };
 
 /* Constructor and destructor of daio resource manager */
-int sum_mgr_create(struct hw *hw, struct sum_mgr **rsum_mgr);
-int sum_mgr_destroy(struct sum_mgr *sum_mgr);
+int sum_mgr_create(struct hw *hw, void **ptr);
+int sum_mgr_destroy(void *ptr);
 
 /* Define the descriptor of a amixer resource */
 struct amixer_rsc_ops;
@@ -89,7 +89,7 @@ struct amixer_mgr {
 };
 
 /* Constructor and destructor of amixer resource manager */
-int amixer_mgr_create(struct hw *hw, struct amixer_mgr **ramixer_mgr);
-int amixer_mgr_destroy(struct amixer_mgr *amixer_mgr);
+int amixer_mgr_create(struct hw *hw, void **ramixer_mgr);
+int amixer_mgr_destroy(void *amixer_mgr);
 
 #endif /* CTAMIXER_H */
diff --git a/sound/pci/ctxfi/ctatc.c b/sound/pci/ctxfi/ctatc.c
index fbdb8a3d5b8e..2a3e9d8ba7db 100644
--- a/sound/pci/ctxfi/ctatc.c
+++ b/sound/pci/ctxfi/ctatc.c
@@ -105,23 +105,20 @@ static struct {
 			    .public_name = "Mixer"}
 };
 
-typedef int (*create_t)(struct hw *, void **);
-typedef int (*destroy_t)(void *);
-
 static struct {
 	int (*create)(struct hw *hw, void **rmgr);
 	int (*destroy)(void *mgr);
 } rsc_mgr_funcs[NUM_RSCTYP] = {
-	[SRC] 		= { .create 	= (create_t)src_mgr_create,
-			    .destroy 	= (destroy_t)src_mgr_destroy	},
-	[SRCIMP] 	= { .create 	= (create_t)srcimp_mgr_create,
-			    .destroy 	= (destroy_t)srcimp_mgr_destroy	},
-	[AMIXER]	= { .create	= (create_t)amixer_mgr_create,
-			    .destroy	= (destroy_t)amixer_mgr_destroy	},
-	[SUM]		= { .create	= (create_t)sum_mgr_create,
-			    .destroy	= (destroy_t)sum_mgr_destroy	},
-	[DAIO]		= { .create	= (create_t)daio_mgr_create,
-			    .destroy	= (destroy_t)daio_mgr_destroy	}
+	[SRC] 		= { .create 	= src_mgr_create,
+			    .destroy 	= src_mgr_destroy	},
+	[SRCIMP] 	= { .create 	= srcimp_mgr_create,
+			    .destroy 	= srcimp_mgr_destroy	},
+	[AMIXER]	= { .create	= amixer_mgr_create,
+			    .destroy	= amixer_mgr_destroy	},
+	[SUM]		= { .create	= sum_mgr_create,
+			    .destroy	= sum_mgr_destroy	},
+	[DAIO]		= { .create	= daio_mgr_create,
+			    .destroy	= daio_mgr_destroy	}
 };
 
 static int
diff --git a/sound/pci/ctxfi/ctdaio.c b/sound/pci/ctxfi/ctdaio.c
index 7fc720046ce2..83aaf9441ef3 100644
--- a/sound/pci/ctxfi/ctdaio.c
+++ b/sound/pci/ctxfi/ctdaio.c
@@ -684,7 +684,7 @@ static int daio_mgr_commit_write(struct daio_mgr *mgr)
 	return 0;
 }
 
-int daio_mgr_create(struct hw *hw, struct daio_mgr **rdaio_mgr)
+int daio_mgr_create(struct hw *hw, void **rdaio_mgr)
 {
 	int err, i;
 	struct daio_mgr *daio_mgr;
@@ -738,8 +738,9 @@ int daio_mgr_create(struct hw *hw, struct daio_mgr **rdaio_mgr)
 	return err;
 }
 
-int daio_mgr_destroy(struct daio_mgr *daio_mgr)
+int daio_mgr_destroy(void *ptr)
 {
+	struct daio_mgr *daio_mgr = ptr;
 	unsigned long flags;
 
 	/* free daio input mapper list */
diff --git a/sound/pci/ctxfi/ctdaio.h b/sound/pci/ctxfi/ctdaio.h
index bd6310f48013..15147fe5f74a 100644
--- a/sound/pci/ctxfi/ctdaio.h
+++ b/sound/pci/ctxfi/ctdaio.h
@@ -115,7 +115,7 @@ struct daio_mgr {
 };
 
 /* Constructor and destructor of daio resource manager */
-int daio_mgr_create(struct hw *hw, struct daio_mgr **rdaio_mgr);
-int daio_mgr_destroy(struct daio_mgr *daio_mgr);
+int daio_mgr_create(struct hw *hw, void **ptr);
+int daio_mgr_destroy(void *ptr);
 
 #endif /* CTDAIO_H */
diff --git a/sound/pci/ctxfi/ctsrc.c b/sound/pci/ctxfi/ctsrc.c
index 4a94b4708a77..159bd4008069 100644
--- a/sound/pci/ctxfi/ctsrc.c
+++ b/sound/pci/ctxfi/ctsrc.c
@@ -540,7 +540,7 @@ static int src_mgr_commit_write(struct src_mgr *mgr)
 	return 0;
 }
 
-int src_mgr_create(struct hw *hw, struct src_mgr **rsrc_mgr)
+int src_mgr_create(struct hw *hw, void **rsrc_mgr)
 {
 	int err, i;
 	struct src_mgr *src_mgr;
@@ -580,8 +580,9 @@ int src_mgr_create(struct hw *hw, struct src_mgr **rsrc_mgr)
 	return err;
 }
 
-int src_mgr_destroy(struct src_mgr *src_mgr)
+int src_mgr_destroy(void *ptr)
 {
+	struct src_mgr *src_mgr = ptr;
 	rsc_mgr_uninit(&src_mgr->mgr);
 	kfree(src_mgr);
 
@@ -821,7 +822,7 @@ static int srcimp_imap_delete(struct srcimp_mgr *mgr, struct imapper *entry)
 	return err;
 }
 
-int srcimp_mgr_create(struct hw *hw, struct srcimp_mgr **rsrcimp_mgr)
+int srcimp_mgr_create(struct hw *hw, void **rsrcimp_mgr)
 {
 	int err;
 	struct srcimp_mgr *srcimp_mgr;
@@ -866,8 +867,9 @@ int srcimp_mgr_create(struct hw *hw, struct srcimp_mgr **rsrcimp_mgr)
 	return err;
 }
 
-int srcimp_mgr_destroy(struct srcimp_mgr *srcimp_mgr)
+int srcimp_mgr_destroy(void *ptr)
 {
+	struct srcimp_mgr *srcimp_mgr = ptr;
 	unsigned long flags;
 
 	/* free src input mapper list */
diff --git a/sound/pci/ctxfi/ctsrc.h b/sound/pci/ctxfi/ctsrc.h
index 1124daf50c9b..e6366cc6a7ae 100644
--- a/sound/pci/ctxfi/ctsrc.h
+++ b/sound/pci/ctxfi/ctsrc.h
@@ -139,10 +139,10 @@ struct srcimp_mgr {
 };
 
 /* Constructor and destructor of SRC resource manager */
-int src_mgr_create(struct hw *hw, struct src_mgr **rsrc_mgr);
-int src_mgr_destroy(struct src_mgr *src_mgr);
+int src_mgr_create(struct hw *hw, void **ptr);
+int src_mgr_destroy(void *ptr);
 /* Constructor and destructor of SRCIMP resource manager */
-int srcimp_mgr_create(struct hw *hw, struct srcimp_mgr **rsrc_mgr);
-int srcimp_mgr_destroy(struct srcimp_mgr *srcimp_mgr);
+int srcimp_mgr_create(struct hw *hw, void **ptr);
+int srcimp_mgr_destroy(void *ptr);
 
 #endif /* CTSRC_H */
-- 
2.39.2


