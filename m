Return-Path: <linux-kernel+bounces-41546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D2783F441
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 06:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27AF01F21EFB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 05:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD63D52A;
	Sun, 28 Jan 2024 05:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iS7lodvy"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D90D50F
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 05:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706421269; cv=none; b=WWvUU3kv3IJMWDMI2SjwSuCHoipg6u9DItUyt/MqyV8WPcNShnCg3HL1aFO+W0v8juzgFPjvHoznQh6MgH/egqZqhaQbFvfUGQN+la142WQpHRZDzGDsPzYalcom0qyN8tRImdhBirAT3cyrQRwdamlzUzgc3GalUb7MPjiqF8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706421269; c=relaxed/simple;
	bh=T4a0KkJe3ySw24IAuPysHE97+mezCU60c6pezH3/Qas=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eNPboro1ORPeS8EDL0wRRI5ms5QoqVHbxmvvr3UQpEi1ZGbKOX6Be7pHPMqaGjajvTYu1LH2mqCzHHeBsQT7HzyBynSuySmEPq1DdrsxgWHQXlXt/iNY1SVWTUngFiiOTMzANqM506jGnURh0Dt6SqArGD/Tvyvd/vTyKyovaf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iS7lodvy; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-599fc25071bso1222168eaf.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 21:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706421267; x=1707026067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WoMzznv9gs9CVHyNB3sDyYu8pYaEpVdO9qAfTUaEKLQ=;
        b=iS7lodvy3t5Qh83KiRk2C+o90nyiiD0XPE5FagdFsePnYmypF8cHdcz+A7XGNhY9pm
         sDgYBhHQWahhjYmFeqEbEP4QlxQHt9ybJLUg9SDViqmr8i04OW4bHQdi6Svq9EmWpDlt
         396GCnd+fXSIvgzJxAf4pAwwaqYgR8LgBtE9YDV6GyscBD/qbBhJlLKSG1VW6wM8tT4w
         qhbUOfixZs1o1DsfW2vKsbv8FOQqbqimFBEhDIuZNnuAoqnbstoElakQM4RbfTXTiG71
         n4P2xsDZJTVQswtj/gs44tYoO8wIY9zSGX9KJOHInPUJIgHjqAyUaFWtC8MpY4EW65EK
         Of7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706421267; x=1707026067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WoMzznv9gs9CVHyNB3sDyYu8pYaEpVdO9qAfTUaEKLQ=;
        b=vyR22x+nKjgOPqcSRDERMdkv2QAaDnrQKoLXKdQ2Ng6ps4+7kouFcLV4V3NSe7Ib20
         nhsMIiQgbKHIFzU7IZVOWMeaUCEyIQMf3gMs8I8M03aErdin91hRJ0C2CTYv557gyrOa
         TOEn1gfFltuokMf1w9EOLpAz61qrnhx0uVc/JCv+1SD0PoS6T/UBtW6V9J3febBWIi9t
         /Nxu5E/KuSV9l4ZUnRmVg7AAG3BAs3egaE96GTxZ2tZk9JSEIibRCYfc88olGl7oDWT0
         dkk+j2yGR6wbBLhE2ntX+lR8fu/nVTPb7Sn5sRpF+gdmvKRbkglZXtSnFEyihWk5Tz/K
         DlgQ==
X-Gm-Message-State: AOJu0YxVbDB/M/mN1Ep1VUOBNlkqRbC5V3LCTcah4n2wAsNytUnuGYt3
	8WW6ohgMWrUJUhmsAHPRbqlnqrgrWiUo8hiP7CVMWSxXvs18MUQE8NZwxiffh5k=
X-Google-Smtp-Source: AGHT+IF3BhZQ0kd9MaydOR06jsyngD/uQTkBOXKbnxIlTgDR5uNidOeNUBMOv+APKTb+c7/0nhvxaw==
X-Received: by 2002:a05:6358:2489:b0:176:a102:568e with SMTP id m9-20020a056358248900b00176a102568emr3049490rwc.5.1706421266793;
        Sat, 27 Jan 2024 21:54:26 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090ac88c00b0029272682390sm3757020pjt.27.2024.01.27.21.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 21:54:26 -0800 (PST)
From: Menglong Dong <dongmenglong.8@bytedance.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <dongmenglong.8@bytedance.com>
Subject: [PATCH bpf-next] bpf: remove unused field "mod" in struct bpf_trampoline
Date: Sun, 28 Jan 2024 13:54:43 +0800
Message-Id: <20240128055443.413291-1-dongmenglong.8@bytedance.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems that the field "mod" in struct bpf_trampoline is not used
anywhere after the commit 31bf1dbccfb0 ("bpf: Fix attaching
fentry/fexit/fmod_ret/lsm to modules"). So we can just remove it now.

Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
---
 include/linux/bpf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b86bd15a051d..1ebbee1d648e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1189,7 +1189,6 @@ struct bpf_trampoline {
 	int progs_cnt[BPF_TRAMP_MAX];
 	/* Executable image of trampoline */
 	struct bpf_tramp_image *cur_image;
-	struct module *mod;
 };
 
 struct bpf_attach_target_info {
-- 
2.39.2


