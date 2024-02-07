Return-Path: <linux-kernel+bounces-56130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6830284C66F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F2F286968
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E68920B12;
	Wed,  7 Feb 2024 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="i4H7IViN"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BA4208B9;
	Wed,  7 Feb 2024 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295359; cv=none; b=kmm+C766E8y6PPcY9yuwyCffOB8P7YU6ugiZnex5Yr42sB7MG+U0UF1qpUhlSrOXZMtA3Dqg5/to5IfsC13JjlCiIJiEYOVKXuJaj31rOsnPzVY+S056DWwstdmtEnyBU29tWaJxC98/0otKLHyk/S/OfR+Q8kJ/Es0zWdITJ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295359; c=relaxed/simple;
	bh=L5ZAYEEa7bHsoxaRKBdt5ijloVJqHRjtMzafI754Dxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jNgqhi1jra1Nk5OnOhIORwgeB0IsIX7hxMQ4NRBPUNCKEkY5o+k+uHHCDY7VJXrOBUwxACj4a5OdRwIOzjipdksFZnpcHAiT749Uc9HjK29B/Ujby/evG/VN1wW1TBae6RMNvuFJXf7ix9r5kHZPez3tXRBwxcawlEOVgN9izI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=i4H7IViN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5602500d1a6so390492a12.3;
        Wed, 07 Feb 2024 00:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707295356; x=1707900156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ek5M3wNjOz1sivJxzrJ0sajF2depyYT6ThNER2vlfk=;
        b=i4H7IViN+zdl6/Uvl5ZUBlWQNFFvw7FLS4KdQg/S4ZCTdIiuKtXlsZCoQTnTMTRa1v
         PkIpTnNJWIMq2hoC2ZmAu7JKD960Tl16mtZsQaL7dHhNBMt8LoWuD85HSSWXqu35hv+h
         r7NP/xsxrVTSk2kxR63JAXlnIxNxM0YtXcSW4XXjVVT7QVIv2aRyNyFMxtEkt9jL2/pb
         7oZ4sJ5Ix4TeClyeK9E8XGCIimoNXf8WpLRLRKMW4O7xBi4I75Jr5cZwkl1fi9fy1n7J
         PN2lbpAHZKkTHLsmy5X9uID8Uhoxt8SNPQWITmlkKzevLuO6Y4llpycfQjniI3D+2mFc
         8L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707295356; x=1707900156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Ek5M3wNjOz1sivJxzrJ0sajF2depyYT6ThNER2vlfk=;
        b=VRybIYTJ6kew0dT86actRHgFTfDtjmRPvVzTvsqTsvuX2VgGoXouZ4H6g93lTIDbTv
         LBAWgz02oTUJ5rDN3w5LBj0TvUVO8jRBupVAUMKBBAWPvGaCHnS8n5/Ics0b/IIBzT3a
         /+U/5yFu9H4jvR3FMZ7napAgzIN8CzbuqqS/LqBuD1LQawVxUe6z9qzK5lsHQywmAzjy
         iIMTx/7TjgyhR/HtolgRSChqnnDlx3+eX+hf/Be9aDw5Pe9B7lvjisgH0aPpqs8lNWLB
         STDDXJmO9jQGftmoDF/Yh2hBDK4LgTOE+Nq1CmU/jde4m7fZFiwiV3Fm2ezqEekI84dG
         UddA==
X-Forwarded-Encrypted: i=1; AJvYcCUA395t/UUl7ZSRucIjuINH9CrXsRwU0pWRbsrspBFWaX7YjHD+Gl8E4ySRTxPHRSfUebn8rquBH5N0aUXVCGdnrLjDnek86VuW48i6r0OQyyduSPaOcFZNnGfVZFgiZ3EN5IOR42VuVlg=
X-Gm-Message-State: AOJu0YxLNOm5ZMFZP4oPjo9oS228LgZ6s63ZnAqkziknSzOnFczm31D1
	LQbHiy2l/boXQeMdjH/gTemSRpkdNwPTRfIdK7K+Nkc=
X-Google-Smtp-Source: AGHT+IFdQB2xybn0n2vKrK3UUqlJd/PEUpdMDZKMD+ojhh8s7yQAtrCzb8CoM0+eRv+ysLTa4WE4zg==
X-Received: by 2002:a17:906:eb4b:b0:a37:74fe:2533 with SMTP id mc11-20020a170906eb4b00b00a3774fe2533mr3869381ejb.29.1707295355773;
        Wed, 07 Feb 2024 00:42:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7LEFvPLlx0BuKkS1/GQ5fkG8BVp1ykoUsIshWUuWsKY/TrJEtEmyrXiMEXvHAZ4k5mQJ5OxTjXJuiT3SKkbtn38ke0z2hyft3qAJX98Yxz6N0sYvF+2CJu22TJ99dchQuQ/5+Y/sHgKfFDYSGtas87sfkbDWZ1XNhggPOF4nlLixsTbJ8W5ny5+B0VUPHQxblnmaatnLkShAs1waFCM4QcmFJcfhAYtK1tvgzpDyUzNWYANE=
Received: from lightwarsArch.plastcontrol.local (rs.plastcontrol.de. [212.185.197.58])
        by smtp.gmail.com with ESMTPSA id hw19-20020a170907a0d300b00a376d1a18adsm500341ejc.98.2024.02.07.00.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 00:42:35 -0800 (PST)
From: Sebastian Kranz <tklightforce@googlemail.com>
To: linux@roeck-us.net
Cc: samsagax@gmail.com,
	derekjohn.clark@gmail.com,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Kranz <tklightforce@googlemail.com>
Subject: [PATCH] Add support for Ayaneo Air Plus 7320u.
Date: Wed,  7 Feb 2024 09:42:06 +0100
Message-ID: <20240207084206.2204-1-tklightforce@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/hwmon/oxp-sensors.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index ea9602063eab..8d3b0f86cc57 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -43,6 +43,7 @@ enum oxp_board {
 	aok_zoe_a1 = 1,
 	aya_neo_2,
 	aya_neo_air,
+	aya_neo_air_plus_mendo,
 	aya_neo_air_pro,
 	aya_neo_geek,
 	oxp_mini_amd,
@@ -98,6 +99,13 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)aya_neo_air,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AB05-Mendocino"),
+		},
+		.driver_data = (void *)aya_neo_air_plus_mendo,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
@@ -332,6 +340,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
 			switch (board) {
 			case aya_neo_2:
 			case aya_neo_air:
+			case aya_neo_air_plus_mendo:
 			case aya_neo_air_pro:
 			case aya_neo_geek:
 			case oxp_mini_amd:
@@ -374,6 +383,7 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
 			switch (board) {
 			case aya_neo_2:
 			case aya_neo_air:
+			case aya_neo_air_plus_mendo:
 			case aya_neo_air_pro:
 			case aya_neo_geek:
 			case oxp_mini_amd:
-- 
2.43.0


