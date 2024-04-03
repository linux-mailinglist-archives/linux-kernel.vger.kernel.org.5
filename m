Return-Path: <linux-kernel+bounces-130036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C78389736B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D008A28F5D6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9267014A0A3;
	Wed,  3 Apr 2024 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY+HT+6C"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C47149DE3;
	Wed,  3 Apr 2024 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156804; cv=none; b=BOZbiWzrfoZx5De7FfUGEtxO64UL+d6HABp17bwGBR12tnHaRaHBNG5Tsvp4gknIGBOvdzjYN4Jf1QKW5F+IW+WObbQcLAX9lgt4fdyJaMwxXRfkwcrLEzCkQhWsaOkgBT+Lx5sLGNLTU4t2kpO/Qgo0X1iEXDFbmEqfFqxSHI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156804; c=relaxed/simple;
	bh=vKEnA46LNIYBD/r4zg6POqJ9fE49+HQ7ou3GmwNLpXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+krWyJ4MLN70L1kPhh2GWu7t6Kmj70MnZeeNqq7ZztnT5M/E39H851nbrMHPv45PU6t//EXv+vMnFN2c4CfnwFIeZNolQzE966eEmZKiBesUOuwsJtdlcWJ0ONUEsgvN2V54IQLGALRQfYjzF8CwnmSFXGWBq+GkZPK9+EMzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WY+HT+6C; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4a393b699fso183918166b.0;
        Wed, 03 Apr 2024 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712156802; x=1712761602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxHB0J6rX43HE9ciPEpBOcvr3yTZZIhFw+viwUxDb3A=;
        b=WY+HT+6CqL3On0pQN+9jvcK1JVCUU23L2U0l+YNC7tyH0gNxUxannWRHIMX3S6ES+6
         aaYZlhiDtvy+BSX7wRd9PlppwhBZHHBJAvgRonuhboiltaCel9Je6Ou/FRDFQSsEDFxe
         QP7E7ZIuXxDN5MOm3dKZuTEFNNR8nmK3lkZofhXOOtBsDL75j2K5qMcjcyY9MD6TKAAL
         bawy1HvG/CCizziKLT6ccekRE9mDJvBQJurEGQyyhJ4l9KU7kLjcGQLCB2c7WwJw8B0/
         Kb7UGu3UP7FhJZEFzFXZOfLCvzDZuRY/6Rn9a2ViUZJx96GYmhxuJNf4Ql0UhKmubhyZ
         aHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712156802; x=1712761602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxHB0J6rX43HE9ciPEpBOcvr3yTZZIhFw+viwUxDb3A=;
        b=BWa6Lbxm4TyUU1q1HL01GQJv9NFmtQBzs04d/chJQFtKoe6i2n3E4Xrt2UwvmjGpqc
         wSLTQDOWAj/izZySJXbPd/a1MzAeUjcF3nQz9D1U8mZZoVIdZ8LW0qW/VnFpIn9CVS6P
         Nz+k38dlf9rxsOkdd2dZWUeDOaVKOoptMzy+hy89GfsaM5Rltf7jSPy0R1zUQBkbjuv5
         XYdCqmzMfNAnRvDo0Zw6KAcJzr012pkH5sh0l4K3H6xyax3C7qz/fofh5qEuRgmPE6Fu
         BtB6wclDHcdgViFiPbKFRSeKjiMTBAc2bw0ofxULgQG/M7Dpu5P6njMJbJIjl4mwPZ1r
         /AGw==
X-Forwarded-Encrypted: i=1; AJvYcCVgcV0DiIYvzVq6qfxRvoNFNMIkd2wfa/rn+fb0kX2OE8tXmY73JjvmEjULIteda/TF3PtCBp6To3jjFb2XIaFe9wxTIXkdNdyjzjTb+s6nZaLkV85zxSiFkhYYgRQcJNrLtpk7umHwd20=
X-Gm-Message-State: AOJu0YzSJ3EdtkLj24Y+bwXUo+i360JKSSICmDCVW/1qKDZbSVjK4+Ey
	KtAKqw2MZByojSZj018DHUI3SbgH+7OJvYhwFLWcBgbBfLfbjSaN
X-Google-Smtp-Source: AGHT+IG9kkRVouRP74AFp5q4dKHNdH85++1zsaBEZPIU2xrFn0qWTXZYX0aSlfvqFfWjTGc8nJd1rA==
X-Received: by 2002:a17:906:d0c3:b0:a4e:539d:217f with SMTP id bq3-20020a170906d0c300b00a4e539d217fmr2510913ejb.33.1712156801375;
        Wed, 03 Apr 2024 08:06:41 -0700 (PDT)
Received: from localhost.localdomain ([84.32.202.14])
        by smtp.gmail.com with ESMTPSA id h8-20020a1709060f4800b00a46d049ff63sm7744886ejj.21.2024.04.03.08.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 08:06:40 -0700 (PDT)
From: Yaroslav Furman <yaro330@gmail.com>
X-Google-Original-From: Yaroslav Furman <Yaroslav.Furman@softeq.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Lucas Zampieri <lzampier@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Yaraslau Furman <yaro330@gmail.com>,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	linux-input@vger.kernel.org (open list:HID LOGITECH DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] HID: logitech-dj: allow mice to report multimedia keycodes
Date: Wed,  3 Apr 2024 18:06:37 +0300
Message-ID: <20240403150638.18749-1-Yaroslav.Furman@softeq.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <7e34dc43-b70b-4a50-86fd-f021f2de4845@redhat.com>
References: <7e34dc43-b70b-4a50-86fd-f021f2de4845@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yaraslau Furman <yaro330@gmail.com>

So, I think this should work fine for now, but IMO we should see if it's
possible to allow the driver to receive all events that a keyboard can send,
since Windows application can assign pretty much any keycode to any mouse
button (perhaps not the main ones though), and then we might see the same situation again.

I tried doing that on my system but the driver stopped working completely.
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
2.44.0


