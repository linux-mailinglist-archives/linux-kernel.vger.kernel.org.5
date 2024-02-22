Return-Path: <linux-kernel+bounces-76408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E57685F6CF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5411C233B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789274652F;
	Thu, 22 Feb 2024 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWMvq4Hq"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0755D45BE7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601272; cv=none; b=VDkmiH6gtxeY35moASmlRXwyZ+pPH6VhiCg3/vYwA6+EFWMdgpzhFtBQ2lHK3CcdqwCGJcnVOyLgiaMuqgLlFcH7D5ks3Ok38W16EvnwKUaHXRLjJ81Di9intt3HRKr+yGUG+8SefK3PuIQCF5u3iW2LrIY/I7UuMF/i4UuH4s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601272; c=relaxed/simple;
	bh=s1HPqz0qh7gqcih0FvEIaSC2XVzpCndQCg9E2w4lGCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QboJrtb5IGFKOwqj0nk7UgHeao+fqUnSZihEY87l5OTKQQ3xMRi3zL0QFVhCBkzlmxSb8WgOvSJc3WjiuLdcjbClqHW+6ZYWRwr+d2EffWxEXNafkQiEzhAUGalY7N07QR0YCYwvkAgqz/I7XlGb4aH/Lu/Bdgt6UcDafq/q+kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWMvq4Hq; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512bb2ed1f7so5452607e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708601269; x=1709206069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1yfiraC5quW41p8ykFc76HAZ3CK1+m5zIrpNUz/QnU=;
        b=eWMvq4Hq9jTDVsEXVaZ3iki5TNRWMaQvgwqR0V5NUx4cjG9VwDNb38PigMuXCQYiWR
         qJyiUUWAnuVKvYpT4qNb1hBUTJt2tOQdbg4xFd+EOrKs7ZtGiB2U4wU8vJPiySOtTO7D
         87YNi1EoxV+yPnSNbUWTsvg5eFL+lwfQmn4e9FiUOSO2TXIh7DFje9SsVntpbS9xi3G6
         19si0s8XrbjWZ5gsHWfi3elXfHJ0cpYrntVSWo4U69QXP1wOeEouFkP+HBi8AIvcCFW/
         iEQ9VP+B3F3OYlOh6FgDGdC8pgCYH+v6qsQAUZ9NRX8OsLRF6NVHSjdKllx5zIWNoHiI
         CKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708601269; x=1709206069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1yfiraC5quW41p8ykFc76HAZ3CK1+m5zIrpNUz/QnU=;
        b=uFhxTx/wsix6GHbtG7f7jw2ksgeUT1k1XPaq8h1uXf8qW04q1BGK5XuZaKYotHb0p9
         qkWUwUG/giRXkkcbEnOyRJVqJIEbGYWTLCRMpS7zxuGsCMRtfFAF/F7j8pg4QW3Jyf/j
         aJARv3Hq1j9pgCstEUKERi9DleELmna7Z85XIJOxLkKqfNgVnGBf+VvBd3LjBTHmlLDy
         wf673FCrKZ6THAceuqmhsZY0vmD//SP+MdzGsPtTY7Nm+5tHZdpQxOe2toM1saW+MnWd
         P8b5pOQLYPAFoK59xpvmiGPS/Q9s/wfLxBS7uttkRRggQjucxOVi7+MWw/6KXs5aMx2U
         uahA==
X-Forwarded-Encrypted: i=1; AJvYcCUHjUA0V+tMVTfk5BJFpbMfxlCipqnkG/p8cVvZ+uy3OtWGT++ElFvSxQATdl5vW9qrjadpcFNmjkZEuL/PnGmlOgpzeMsDUvAbLy0V
X-Gm-Message-State: AOJu0Yz+zqaQSfnwMCww1BUe6ABlaDCr4JUZbJcIGnaonfQElnKalN8n
	xBzx5TxHA4re1dVl0Fjz8iFVT4BrF2dXDrQqXXYfQ5kBfSOH4nU9
X-Google-Smtp-Source: AGHT+IFrKMGU8VcxleGYFQ5yPW1HF/YQBiC035CBr41JIguflFvvCIegKaQnpXPUAsLCmXFyOwNN8g==
X-Received: by 2002:ac2:5191:0:b0:512:ab73:d2d4 with SMTP id u17-20020ac25191000000b00512ab73d2d4mr7478165lfi.16.1708601268844;
        Thu, 22 Feb 2024 03:27:48 -0800 (PST)
Received: from localhost.localdomain ([95.90.186.51])
        by smtp.gmail.com with ESMTPSA id ck8-20020a0564021c0800b0056452477a5esm4338524edb.24.2024.02.22.03.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:27:48 -0800 (PST)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: rtl8192e: remove empty cases from switch statements
Date: Thu, 22 Feb 2024 12:27:22 +0100
Message-ID: <20240222112723.18428-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240222112723.18428-1-straube.linux@gmail.com>
References: <20240222112723.18428-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rmove empty cases from switch statements to improve readability.
All of these empty cases are covered by a default case already.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 57e1a361a7c9..4b622ad4c534 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1725,7 +1725,6 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 				_rtl92e_dm_start_hw_fsync(dev);
 				priv->rtllib->fsync_state = HW_Fsync;
 				break;
-			case HW_Fsync:
 			default:
 				break;
 			}
@@ -1740,7 +1739,6 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 				_rtl92e_dm_start_sw_fsync(dev);
 				priv->rtllib->fsync_state = SW_Fsync;
 				break;
-			case SW_Fsync:
 			default:
 				break;
 			}
@@ -1760,7 +1758,6 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 			_rtl92e_dm_end_sw_fsync(dev);
 			priv->rtllib->fsync_state = Default_Fsync;
 			break;
-		case Default_Fsync:
 		default:
 			break;
 		}
-- 
2.43.1


