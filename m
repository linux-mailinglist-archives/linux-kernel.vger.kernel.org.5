Return-Path: <linux-kernel+bounces-152546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549188AC057
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 870B6B20ACC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 17:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAA6374F7;
	Sun, 21 Apr 2024 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIHPYHY1"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEC71401C
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713721470; cv=none; b=AAcg/oZCpaavTTaB55VhZTIQ9YtnFe4VWuy59DLw94N/ICIUVeVBc8wchqdhSAeVikNAZLQUpBRax7LVUErkfi1MbLRNT/TwG2Mcvv5BD773Viuqp8wX3ySRmwectUx6qdZzlRZ9mbmGSlE4nshtDLeVUADnMUdpkhUUMQUoD/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713721470; c=relaxed/simple;
	bh=Rxo/QLb3D3FLuHpq7mRBclfypka9nF4CKeJoBwNdfpM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=vGTUHW4U9se2dZaWuX3YY936CAEVjzkj05QPlIaU8/8kxdQYuUYH62xiiMYBdYJMp6eJsefRK3G4AlcFhw96nPDT+Ze9ArTViN3zVfnpJf4mQik7Fs4iVf9qgxA7ThRpKUjZJ01KatcVUX0sVOfc8WGXakBu49fvdVUCqL2YLvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BIHPYHY1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61510f72bb3so84694927b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 10:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713721467; x=1714326267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pfJhufGPprljhvqok4xuEp55QbKVyiGYgMx3ut44Am8=;
        b=BIHPYHY1h0UTofabFuCg7ujlFTprNGseIERqlJkBWKp37GHfi+nziSy+eIluIW4eMP
         IUeXHLiDQWn8rwu6ShQx6mn/QgaR9JMilJkreXsquyIGw2Nv9Cz9ft4QlG2CtWQJxzwc
         1EpOp+MiWiiR7EjDC2a1FkP/kZZFFEWwMHPXl0Rq/4FqxSOi8UpGGBIugiH2HJiFgcol
         uUoTsaQXHYMnZbb8p9Yotxduo6SGLkXtVZt6tUyZThq7QfH04rH4S9SGwdcUQfxiEDVs
         SRrxvNiKNO4lU3epXrxuvk2CBpl9FL62PRBsp62hSejRXdgyQDGTeyqqVtl8EtH60yFW
         Yttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713721467; x=1714326267;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfJhufGPprljhvqok4xuEp55QbKVyiGYgMx3ut44Am8=;
        b=ZiOsNp0MhY2GUsqjrlJeK20TSTY5PhrxR91fAVSgGLZ9j7LfBGi0LjnxiIuEpiNium
         fKIXHhefGTCxSzZR302O+1P2kfPNepScIIClFHRqVj7N585fADuS/w9TDKGLY7zcW8ly
         LB4xQA4K1b+3vi2ratt73ZyaBDIObDjYv/Fmz0AHP5ZC0KN0nYNn9yNQk8bvjvsK4oyX
         nZD+l7k8bX41Boqnycy6+untAkfWHiv0Un6ntCSN3NH40so2aXrOli3p7e6BEGD5qz38
         cJMPdHpzPqG+XkTO9JeAgBHjQo5yexQnRgWl6tOJ1NVS140ciKzOdhczQh5pShhGyiMz
         m0VA==
X-Gm-Message-State: AOJu0YxTapYEEHudxzdC0j5lZDPguV2flwIDkSVylBAty2PWZArBiyC7
	LcbU/EkSRSqackUfiVMmNeQaOW2+b5fOuhVkRFtDV1qn5UuZnDid2q98/5RuxcrNB3PlCjVcJp1
	nL/hK6cat2A==
X-Google-Smtp-Source: AGHT+IFea26EdgRBiy2bok1wSSeQVXwViDdWSFDukZLbc7EAjnnR+53AfvJcxXye0zeBN8dajLnwzb+FJYxlLQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a0d:d8cb:0:b0:61a:bfc8:64ce with SMTP id
 a194-20020a0dd8cb000000b0061abfc864cemr2032717ywe.8.1713721467059; Sun, 21
 Apr 2024 10:44:27 -0700 (PDT)
Date: Sun, 21 Apr 2024 17:37:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240421173750.3117808-1-cmllamas@google.com>
Subject: [PATCH v2] binder: fix max_thread type inconsistency
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Serban Constantinescu <serban.constantinescu@arm.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The type defined for the BINDER_SET_MAX_THREADS ioctl was changed from
size_t to __u32 in order to avoid incompatibility issues between 32 and
64-bit kernels. However, the internal types used to copy from user and
store the value were never updated. Use u32 to fix the inconsistency.

Fixes: a9350fc859ae ("staging: android: binder: fix BINDER_SET_MAX_THREADS =
declaration")
Reported-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Cc:  <stable@vger.kernel.org>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---

Notes:
    v2: rebased, send fix patch separately per Greg's feedback.

 drivers/android/binder.c          | 2 +-
 drivers/android/binder_internal.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index bad28cf42010..5834e829f391 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5365,7 +5365,7 @@ static long binder_ioctl(struct file *filp, unsigned =
int cmd, unsigned long arg)
 			goto err;
 		break;
 	case BINDER_SET_MAX_THREADS: {
-		int max_threads;
+		u32 max_threads;
=20
 		if (copy_from_user(&max_threads, ubuf,
 				   sizeof(max_threads))) {
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_int=
ernal.h
index 7270d4d22207..5b7c80b99ae8 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -421,7 +421,7 @@ struct binder_proc {
 	struct list_head todo;
 	struct binder_stats stats;
 	struct list_head delivered_death;
-	int max_threads;
+	u32 max_threads;
 	int requested_threads;
 	int requested_threads_started;
 	int tmp_ref;
--=20
2.44.0.769.g3c40516874-goog


