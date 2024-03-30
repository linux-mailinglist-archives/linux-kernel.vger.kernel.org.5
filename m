Return-Path: <linux-kernel+bounces-126234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF81893412
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655A5286013
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57823158A33;
	Sun, 31 Mar 2024 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ru3QkUkt"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D53146A92;
	Sun, 31 Mar 2024 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903254; cv=pass; b=fkwRtvq+6mkel5qfKAbUFZnYLOI6oP4vqZpshXxEwDWEuKQz0bRxwCKOzoNZGMJQtohhOUROQ5sElHgWphMSFBlPa4wjAC+9NQZFOayfNpOWHaEUXEullos+N87KL/6q3TM1o0b0jyIfynCNF0+dCyhwAli4GkX7RlQRGkR5xGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903254; c=relaxed/simple;
	bh=jaZYbjys81pMsn0Wpbu1r14QuC0gHXmfLKIH1QJCNaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4oqbJyroO1U1bu1oJ1CTjxcaNdltg47+CS2P6baSkXOokHaIFf7c57FNwt0w7cDlL8Mz6rrbJxLNypN9FOTXOOYj8REtUscs9q1Ijp5wbwPyUIfOgnD1lA20oRPHeK5TT2sFskzxSo8qWcWqjba0/vJAhHczUXGCk4G3fqHYFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ru3QkUkt; arc=none smtp.client-ip=209.85.128.51; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D1095208C2;
	Sun, 31 Mar 2024 18:40:50 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lgHE1uuu_6Xm; Sun, 31 Mar 2024 18:40:50 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1B75A207D5;
	Sun, 31 Mar 2024 18:40:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1B75A207D5
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 0F26880005E;
	Sun, 31 Mar 2024 18:40:50 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:40:49 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:03 +0000
X-sender: <linux-kernel+bounces-125694-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-essen-01.secunet.de
X-ExtendedProps: BQBjAAoAKIumlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.197
X-EndOfInjectedXHeaders: 15416
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125694-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 029EE2025D
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ru3QkUkt"
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711797880; cv=none; b=ZIXGcYhCXLMVWHJo3W2W2yb1Rxp9+tJgQBNkeJCkBipOpuverpier3uHKWtL6mwV8kLHwJcgKrlY6ILy6fy4eLzYLoCBaX68UYPXXpFWlJ4xxEYqMyo8NvYoHCrIZZKCjtpw66IinREO/dcliUUxmgBHQW7TtMT0Qe4uVnXTYmk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711797880; c=relaxed/simple;
	bh=jaZYbjys81pMsn0Wpbu1r14QuC0gHXmfLKIH1QJCNaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d697TUB1TwKnQ9ixMma64QWb+lag67Vsv1F3HVvr3yA8RGMQCJSYttya8m59KnFZn8NlbK3CKEwkrTnJ9YMbC15X/Kyr/MIp26HbKG8hwN7YpDZEbyTjiIgCfglVndggN0ERsDvVlSn6co2aTSqeWrukOJFM+WekG57kL7mb+7Y=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ru3QkUkt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711797877; x=1712402677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQXwuJoLJSBrzkd58wtTek0mHwm7fvJx/Uhfmo/YVjY=;
        b=Ru3QkUktTmx7gXoXCXf76xXePRTYZWhqg+IePz7xDvkhv9ITm0W9Eekox1J/LOeuUf
         hLjm5uCaJgdHN2YLqNQIdJPrgZzYUiRv5T+2EYlVjHBxuYDnfWchjnGN280YW13Ibam6
         wqSVwzuTydliK6Kb2v2AZuH/LyFhZ+L5Nm8AWqITORbyZPa/m84Oes1Z7slBFw5LKPNn
         aoVFg6QgIhHcb/EVufI8LtV3MAJUkVOwnScll51LIsatniyde/ZmEgtPEVC7O+uixBgG
         GslgpBU78vNNHpXO3Jb/hDu8nqDRXy42wcR0AS70N54STccTIHbQpat36Hc2AohClBvL
         3irA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711797877; x=1712402677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQXwuJoLJSBrzkd58wtTek0mHwm7fvJx/Uhfmo/YVjY=;
        b=e6EVPioYZuvUoCX9jL99XFLtdPYghIl4/wcCUlPiA1pHzN7BOQAOv2phMDt4lg+hic
         3q/nFHrtori28NF/EiteViz//yu+v6f4zcq6zYHuzlWN1jX4UApOduf6Yy0psPON5suA
         IT0T/x7eMecroBRyaRaOWU16Un+iYW4BaHqfg7RQDUyvfMFYhNlb/XZ3efs3u4Sklw9l
         8HnFu12xoUekxHBPbde27/PiAvFw9ap6rcGKTDgSqo1cJlSSk5jnQ5rnvjrn2UCSa4zd
         RA5Yas6WF2N/j6wrhGh6JLR4jAHfnd+g9z4Rv+TZu/V+svabyPc95pOptCgrpAZnBawy
         iRSA==
X-Forwarded-Encrypted: i=1; AJvYcCWNNUtvLBKPFewzC3wiHTBFLxNbowTykB9/ozh5fj6qji8zcSWfx8S3xh487Ge/BjPpv4LVggVpAR5F5dPRdw+HH2Xp0TTpEADkBy1CFh3MRsguFuZk0Vsz2w7ypFc8zqckEnK/57lRLoTGkcoM0QV3yi3W7ENLwkbUGr0aiex3F9HIv5f2bifgXsu3b29p
X-Gm-Message-State: AOJu0YzgN2qO2nHtOhhwS2AZXIeBLCDrbBqsDK9mFbxyPaiP8vJelYPS
	EZb/BCXkGkokla7R2LL/+yK5QfOwaJB86vBVI3MI4xo+v2MLFn06FKkpt3fW
X-Google-Smtp-Source: AGHT+IEwYiu779mvlq62aGrWVMA5xFbAJKfIzkmTk7OyUTyJmbNJZ4C8TVIbIsBD5UHFy8EVBL039A==
X-Received: by 2002:a7b:c843:0:b0:413:e81a:55c0 with SMTP id c3-20020a7bc843000000b00413e81a55c0mr3943297wml.41.1711797876908;
        Sat, 30 Mar 2024 04:24:36 -0700 (PDT)
From: Maximilian Luz <luzmaximilian@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Cc: Ivor Wanders <ivor@iwanders.net>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 2/3] hwmon: surface_temp: Add support for sensor names
Date: Sat, 30 Mar 2024 12:24:01 +0100
Message-ID: <20240330112409.3402943-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330112409.3402943-1-luzmaximilian@gmail.com>
References: <20240330112409.3402943-1-luzmaximilian@gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Ivor Wanders <ivor@iwanders.net>

The thermal subsystem of the Surface Aggregator Module allows us to
query the names of the respective thermal sensors. Forward those to
userspace.

Signed-off-by: Ivor Wanders <ivor@iwanders.net>
Co-developed-by: Maximilian Luz <luzmaximilian@gmail.com>
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/hwmon/surface_temp.c | 112 +++++++++++++++++++++++++++++------
 1 file changed, 95 insertions(+), 17 deletions(-)

diff --git a/drivers/hwmon/surface_temp.c b/drivers/hwmon/surface_temp.c
index 48c3e826713f6..7a2e1f638336c 100644
--- a/drivers/hwmon/surface_temp.c
+++ b/drivers/hwmon/surface_temp.c
@@ -17,6 +17,27 @@
 
 /* -- SAM interface. -------------------------------------------------------- */
 
+/*
+ * Available sensors are indicated by a 16-bit bitfield, where a 1 marks the
+ * presence of a sensor. So we have at most 16 possible sensors/channels.
+ */
+#define SSAM_TMP_SENSOR_MAX_COUNT 16
+
+/*
+ * All names observed so far are 6 characters long, but there's only
+ * zeros after the name, so perhaps they can be longer. This number reflects
+ * the maximum zero-padded space observed in the returned buffer.
+ */
+#define SSAM_TMP_SENSOR_NAME_LENGTH 18
+
+struct ssam_tmp_get_name_rsp {
+	__le16 unknown1;
+	char unknown2;
+	char name[SSAM_TMP_SENSOR_NAME_LENGTH];
+} __packed;
+
+static_assert(sizeof(struct ssam_tmp_get_name_rsp) == 21);
+
 SSAM_DEFINE_SYNC_REQUEST_CL_R(__ssam_tmp_get_available_sensors, __le16, {
 	.target_category = SSAM_SSH_TC_TMP,
 	.command_id      = 0x04,
@@ -27,6 +48,11 @@ SSAM_DEFINE_SYNC_REQUEST_MD_R(__ssam_tmp_get_temperature, __le16, {
 	.command_id      = 0x01,
 });
 
+SSAM_DEFINE_SYNC_REQUEST_MD_R(__ssam_tmp_get_name, struct ssam_tmp_get_name_rsp, {
+	.target_category = SSAM_SSH_TC_TMP,
+	.command_id      = 0x0e,
+});
+
 static int ssam_tmp_get_available_sensors(struct ssam_device *sdev, s16 *sensors)
 {
 	__le16 sensors_le;
@@ -54,12 +80,37 @@ static int ssam_tmp_get_temperature(struct ssam_device *sdev, u8 iid, long *temp
 	return 0;
 }
 
+static int ssam_tmp_get_name(struct ssam_device *sdev, u8 iid, char *buf, size_t buf_len)
+{
+	struct ssam_tmp_get_name_rsp name_rsp;
+	int status;
+
+	status =  __ssam_tmp_get_name(sdev->ctrl, sdev->uid.target, iid, &name_rsp);
+	if (status)
+		return status;
+
+	/*
+	 * This should not fail unless the name in the returned struct is not
+	 * null-terminated or someone changed something in the struct
+	 * definitions above, since our buffer and struct have the same
+	 * capacity by design. So if this fails blow this up with a warning.
+	 * Since the more likely cause is that the returned string isn't
+	 * null-terminated, we might have received garbage (as opposed to just
+	 * an incomplete string), so also fail the function.
+	 */
+	status = strscpy(buf, name_rsp.name, buf_len);
+	WARN_ON(status < 0);
+
+	return status < 0 ? status : 0;
+}
+
 
 /* -- Driver.---------------------------------------------------------------- */
 
 struct ssam_temp {
 	struct ssam_device *sdev;
 	s16 sensors;
+	char names[SSAM_TMP_SENSOR_MAX_COUNT][SSAM_TMP_SENSOR_NAME_LENGTH];
 };
 
 static umode_t ssam_temp_hwmon_is_visible(const void *data,
@@ -83,33 +134,47 @@ static int ssam_temp_hwmon_read(struct device *dev,
 	return ssam_tmp_get_temperature(ssam_temp->sdev, channel + 1, value);
 }
 
+static int ssam_temp_hwmon_read_string(struct device *dev,
+				       enum hwmon_sensor_types type,
+				       u32 attr, int channel, const char **str)
+{
+	const struct ssam_temp *ssam_temp = dev_get_drvdata(dev);
+
+	*str = ssam_temp->names[channel];
+	return 0;
+}
+
 static const struct hwmon_channel_info * const ssam_temp_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(chip,
 			   HWMON_C_REGISTER_TZ),
-	/* We have at most 16 thermal sensor channels. */
+	/*
+	 * We have at most SSAM_TMP_SENSOR_MAX_COUNT = 16 thermal sensor
+	 * channels.
+	 */
 	HWMON_CHANNEL_INFO(temp,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT),
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
 	NULL
 };
 
 static const struct hwmon_ops ssam_temp_hwmon_ops = {
 	.is_visible = ssam_temp_hwmon_is_visible,
 	.read = ssam_temp_hwmon_read,
+	.read_string = ssam_temp_hwmon_read_string,
 };
 
 static const struct hwmon_chip_info ssam_temp_hwmon_chip_info = {
@@ -122,6 +187,7 @@ static int ssam_temp_probe(struct ssam_device *sdev)
 	struct ssam_temp *ssam_temp;
 	struct device *hwmon_dev;
 	s16 sensors;
+	int channel;
 	int status;
 
 	status = ssam_tmp_get_available_sensors(sdev, &sensors);
@@ -135,6 +201,18 @@ static int ssam_temp_probe(struct ssam_device *sdev)
 	ssam_temp->sdev = sdev;
 	ssam_temp->sensors = sensors;
 
+	/* Retrieve the name for each available sensor. */
+	for (channel = 0; channel < SSAM_TMP_SENSOR_MAX_COUNT; channel++) {
+		if (!(sensors & BIT(channel)))
+			continue;
+
+		status = ssam_tmp_get_name(sdev, channel + 1,
+					   ssam_temp->names[channel],
+					   SSAM_TMP_SENSOR_NAME_LENGTH);
+		if (status)
+			return status;
+	}
+
 	hwmon_dev = devm_hwmon_device_register_with_info(&sdev->dev,
 			"surface_thermal", ssam_temp, &ssam_temp_hwmon_chip_info,
 			NULL);
-- 
2.44.0



