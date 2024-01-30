Return-Path: <linux-kernel+bounces-44493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBC38422CC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE4E1C268A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C45E6A02B;
	Tue, 30 Jan 2024 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M16zKUra"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058EA664A2;
	Tue, 30 Jan 2024 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613439; cv=none; b=mAIbIKbQwZkuA0hk8/Q6SVpcDmS/RzkMMkCHghm+swjOfCE/b9mDK0X9R02AdHqb36sE8kWw9y9JtVHAUqja0XBkUran3QDe4WswM+3SVH/o4vo+wXZtjOqD9mmWezpUF+kyGJP7LxRr49Cy4yiwpE+vAyN7BM9HRyrw/NAtzX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613439; c=relaxed/simple;
	bh=hok62KdyZlUwWp+vCS6X/XQdwd32WCp3cJQev+HQ4/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCKKdDZbopcD9YADgk4wnsG1WhwHsUcG2pKsHY7qcvCmr6F2QuetODYPUosYwA4rQDxqxuYnHr8AqzgWBscqrrSFt6KD9vGde5yT1Eqzb61MjB2kJISowg5lbrNzSSN1SN0en7Fb0jti6Ndme1zk0JtxsqPmq9ZlZ/fO2yFkcwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M16zKUra; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51030ce36fbso3895222e87.3;
        Tue, 30 Jan 2024 03:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706613436; x=1707218236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wazdN7gWecYYIgnQB0kZi/Sg4s0sKcCnfJoTIpjsRfg=;
        b=M16zKUraYiLKTDBqvGW/39Rwaru78TstltSv8LSMDdHiDMTh6jAq19WGJZKKUzEXLS
         5/bZt981SgAjiToDD3rg/04L1KQOMgr0Bk0LEY3b5+w2q+fuKde6mhBL3KwAWWWgJIjt
         I0fHeMuFlMy0BBIrPw6KOC25ozU4bg6ZC486r9eTmjEWyCNdJSKbnwr7Dlh7VRk67TEX
         HTmeP3Wk4gAGw9ng+2536D8cb0eD32co5dAP5M+vHPlyFk/80jN7vxvd3Kc9JVu5YqFM
         X+9xjNt2c+r2MFztvOkhlLSFS+XscSq/n1wsMK4XHfFqnTSQLSvN6/P79aj2xvUOh/ms
         ZLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706613436; x=1707218236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wazdN7gWecYYIgnQB0kZi/Sg4s0sKcCnfJoTIpjsRfg=;
        b=PA5zpQOVyTg9hV8MPC4oYUG3RXaNNtUBm6HTvurVLI18Cu4YcaTtkS30RbujU6xunD
         KAo/rMzKKb4l8uv997j68bDtL1GsR7dgR+1EsvDd5C7g64l9mdXZKqAph7sIk5NkYTYC
         kTP1i+YhbB04KllQwJ/+dsQrvlfMGeiA1EBw38vbZWWgyifNpd0/squfjMCx4Hr/2jXw
         U3F9t7qt7XQCIrwb2SpHXchRjqxOg3YH12UnNr4ZnX8uGY4fJ09BDi6SXkNwSpjat3m9
         vlhRgSvj5KhgbW542HFJWq0tuRzWL7laj9jPZ4n/f2IL00Srt2jdvUKplDulgzRU4S34
         eR3g==
X-Gm-Message-State: AOJu0Yy6i0tr1D+0STQIcWPhOaDfMVDBTB+nM1TjtS65lOyjUvrdq8gN
	RxL94V3ZKCZGUj0aEoxX2lH1WTToDatdNj/Z33BFmbKKFxq8FDEgWb07pDsoBnp2lTHU
X-Google-Smtp-Source: AGHT+IGxlMPKnSMbUoMbnQFyGvSDa0I2zkMTc4ETQ9XXe5Y58aHJgIMcmgPrdwIcZWV2QkCqSCigSA==
X-Received: by 2002:ac2:538d:0:b0:510:e05:435a with SMTP id g13-20020ac2538d000000b005100e05435amr5587908lfh.26.1706613435618;
        Tue, 30 Jan 2024 03:17:15 -0800 (PST)
Received: from localhost.localdomain ([84.32.202.14])
        by smtp.gmail.com with ESMTPSA id se27-20020a170906ce5b00b00a349318ea10sm4995202ejb.199.2024.01.30.03.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 03:17:15 -0800 (PST)
From: Yaraslau Furman <yaro330@gmail.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Yaraslau Furman <yaro330@gmail.com>,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Jiri Kosina <jikos@kernel.org>,
	linux-input@vger.kernel.org (open list:HID LOGITECH DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] HID: logitech-dj: allow mice to report multimedia keycodes
Date: Tue, 30 Jan 2024 13:17:00 +0200
Message-ID: <20240130111700.11666-1-yaro330@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128214906.60606-1-yaro330@gmail.com>
References: <20240128214906.60606-1-yaro330@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multimedia buttons can be bound to the mouse's extra keys in Windows application.
Let Linux receive those keycodes.

Signed-off-by: Yaraslau Furman <yaro330@gmail.com>
---
 drivers/hid/hid-logitech-dj.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index e6a8b6d8eab7..3c3c497b6b91 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -965,9 +965,7 @@ static void logi_hidpp_dev_conn_notif_equad(struct hid_device *hdev,
 		}
 		break;
 	case REPORT_TYPE_MOUSE:
-		workitem->reports_supported |= STD_MOUSE | HIDPP;
-		if (djrcv_dev->type == recvr_type_mouse_only)
-			workitem->reports_supported |= MULTIMEDIA;
+		workitem->reports_supported |= STD_MOUSE | HIDPP | MULTIMEDIA;
 		break;
 	}
 }
-- 
2.43.0


