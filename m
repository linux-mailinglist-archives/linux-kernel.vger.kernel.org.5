Return-Path: <linux-kernel+bounces-161399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665418B4B86
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9553A1C209EE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B13E58119;
	Sun, 28 Apr 2024 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmxEfX5R"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD7751C48;
	Sun, 28 Apr 2024 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714304059; cv=none; b=XcpSU7bsS7KdGkXsdL71rUB3t+G1uHm6w3++SLgj+aErz66Qck9tRuEXoqLpCBzSlH54w7wqRZrQCqKbe3Ae17/ya2jx15G0V8JzHAmKq0N9mXUvROefqkcS+Xrpuw53tHzVG19w1EiJ19tqPH9Lnh/SJbW8XzDkK/p7uKHrGoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714304059; c=relaxed/simple;
	bh=tu/yzr2e4ah5s6+db+f98kjxOIm9ubRxmAyenqTK+w0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uJumVCbte1OLe+X+pEwW/CVFyNr2yDlznZ/il2D0w0Me2OuATcQVtzN5G+0DgT7DMmQjILm/2R2GSAJEbyuezwRwJvhwiJ/KHj7A/wwwAdMIOqc40zz9D/SEpp+mHeAfZjWhJqQuSpSru1PuegVeq3wRzHc3Ge8lzW64fKh/5gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmxEfX5R; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed32341906so3401656b3a.1;
        Sun, 28 Apr 2024 04:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714304058; x=1714908858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pCE+aleX8NCw02bPlUWAoYFvDuoC/mN1QeE8lhYhFU=;
        b=FmxEfX5RcT9UtDSdqq0TkEjb987tMrhJhu7KH+WtQb3o+kKiBHMM1EfFKE8XL+l/bh
         OANlEajw0Q4ZRTI+dqB2kVxSr/bujMdzu1RWjwKOLep1dtbCCQeACB2jRVW/F3hZeIQu
         Vo9lUDUdcypZVHXAjTcHzkcuBB8jW8aXj81c8Ocrmx3FSAGVyogVBpILZhfG4OJfERxN
         cuHqqIqift28334kn8woH3NQI/8yTppvIJYLvGeemGyIhUUxnU9WvNoHwGpzeunVOYJs
         cExbkJeR8TMktjtfkPqr/LXVyr51LLruCXvV4LyKnHtUs65Uwww68SqBRGdarv640yux
         s5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714304058; x=1714908858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pCE+aleX8NCw02bPlUWAoYFvDuoC/mN1QeE8lhYhFU=;
        b=rnwgo1QMWlZ4dtAy7UmVa4ATWtDFkm7O7GY8t9tdYwz94pck/AZaQ3arxQZ5LImxrp
         0wd9vW0WG3EN9vNYoEMxc1W/X9z+VSgUuymOXSqAoRHM76eG4xqnvPIm9NtUYlA/Y0v1
         Kc+Ck+l7eqp5uFewR3Rg25AVxHhFqEsyav5SWeDCjA4SdMvAAyeo+64Z7t84+hUiAhDs
         6X0IeugovF3+uyp/8EBbWb6tbO1HUOLiStb92vDf9iZRZ52CP1qJOk6hqbtaB5rzXeb9
         Ff7mJesYRY5TLWVVeyaWtLOobDY195p9/3qg45gWNijTIj6DOPiJAwm1UWYGR1UzoL/Y
         RZBg==
X-Forwarded-Encrypted: i=1; AJvYcCXljbkd+YebQxfJkbPVb1AgitDVN4XhAkPNzn13N6O6uwl2ZjR0J6JTGwG1rVdGeFaWmmUMNVr/jGu5Vpv+qG1IW7kIBtT2H5xCbPAEQH7gspnhwQn0Nt9H5j1ZBVw7kJySkUf3S0EaRg==
X-Gm-Message-State: AOJu0Yy8MtrZjW9oPIfzxszQE0C1W01p+ssjFFYpTpuzPFtWvAaPWA+E
	qICU13z29D6DkHZh7tjUEgV8g7Ae3jOcxXleJL7XCkUd6wZq6FFzl4kpkw==
X-Google-Smtp-Source: AGHT+IGL7HLlKiG3tx+e8XEh5UFO6uTqpWDPecfVQV6DsH8rtPc3da/k878RgfkFJdi+vdZMrTvO+A==
X-Received: by 2002:a05:6a21:3d84:b0:1a9:5b1e:4f06 with SMTP id bj4-20020a056a213d8400b001a95b1e4f06mr7871483pzc.52.1714304055956;
        Sun, 28 Apr 2024 04:34:15 -0700 (PDT)
Received: from VM-147-239-centos.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id x5-20020a17090a388500b002a53b33afa3sm21056504pjb.8.2024.04.28.04.34.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2024 04:34:15 -0700 (PDT)
From: Yongzhi Liu <hyperlyzcs@gmail.com>
To: skashyap@marvell.com,
	Markus.Elfring@web.de,
	njavali@marvell.com,
	martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com
Cc: himanshu.madhani@oracle.com,
	GR-QLogic-Storage-Upstream@marvell.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jitxie@tencent.com,
	huntazhang@tencent.com,
	Yongzhi Liu <hyperlyzcs@gmail.com>
Subject: [PATCH V2] scsi: qla2xxx: Fix double free of fcport in error handling path
Date: Sun, 28 Apr 2024 19:34:04 +0800
Message-Id: <20240428113404.12522-1-hyperlyzcs@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <443fb75b-948b-430f-be33-170e6f592280@web.de>
References: <443fb75b-948b-430f-be33-170e6f592280@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When dma_alloc_coherent() or qla2x00_start_sp() return an error,
the callback function qla2x00_els_dcmd_sp_free in qla2x00_sp_release
will call qla2x00_free_fcport() to kfree fcport. We shouldn't call
qla2x00_free_fcport() again in the error handling path.

Fix this by cleaning up the redundant qla2x00_free_fcport() and
replacing error handling with a goto chain.

Fixes: 82f522ae0d97 ("scsi: qla2xxx: Fix double free of fcport")
Signed-off-by: Yongzhi Liu <hyperlyzcs@gmail.com>
---
 drivers/scsi/qla2xxx/qla_iocb.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 0b41e8a06602..7b6a1db55672 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2749,10 +2749,8 @@ qla24xx_els_dcmd_iocb(scsi_qla_host_t *vha, int els_opcode,
 			    GFP_KERNEL);
 
 	if (!elsio->u.els_logo.els_logo_pyld) {
-		/* ref: INIT */
-		kref_put(&sp->cmd_kref, qla2x00_sp_release);
-		qla2x00_free_fcport(fcport);
-		return QLA_FUNCTION_FAILED;
+		rval = QLA_FUNCTION_FAILED;
+		goto free_sp;
 	}
 
 	memset(&logo_pyld, 0, sizeof(struct els_logo_payload));
@@ -2774,10 +2772,8 @@ qla24xx_els_dcmd_iocb(scsi_qla_host_t *vha, int els_opcode,
 
 	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS) {
-		/* ref: INIT */
-		kref_put(&sp->cmd_kref, qla2x00_sp_release);
-		qla2x00_free_fcport(fcport);
-		return QLA_FUNCTION_FAILED;
+		rval = QLA_FUNCTION_FAILED;
+		goto free_sp;
 	}
 
 	ql_dbg(ql_dbg_io, vha, 0x3074,
@@ -2787,6 +2783,7 @@ qla24xx_els_dcmd_iocb(scsi_qla_host_t *vha, int els_opcode,
 
 	wait_for_completion(&elsio->u.els_logo.comp);
 
+free_sp:
 	/* ref: INIT */
 	kref_put(&sp->cmd_kref, qla2x00_sp_release);
 	return rval;
-- 
2.36.1


