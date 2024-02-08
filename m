Return-Path: <linux-kernel+bounces-58052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0E384E0A6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98DE9B25C6D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389357318E;
	Thu,  8 Feb 2024 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ViLUOT9J"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8E871B57;
	Thu,  8 Feb 2024 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707395146; cv=none; b=H4jnQj+sIKh6m0hICla0Z+3QfdnZm84DqFGbuRxYHY8decXCVg7OWmS5V0rZcBqtK1v4eJ926wpuM/7JMWujxEDrKHOBr3G98VNQF6R4bgXahdFf57xCDCzo0642l1HPGEFKYSFZh3M6GZ17qSTxowZe6Xo6JOk3OQ57R6iuc/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707395146; c=relaxed/simple;
	bh=ya00qK6ZrbbH8bfPz6OV3tDxIjKH3/JzCbz4vmNTj80=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=OSrxFlq6d59wFHCr7DAsshpLCIhqhCg7BxrALBPQYiuKkSHSHKIKU07VK8LgxxzwFnf/5KQ6TUl0R+iXavYaQoB9b8Mifze47F9ermLvm0TBVjXo+ICI9XfJ6tVMGzCKv/AXRjZFW/ed3HM6ze+Gsizk6sdvDbCWDkJp01vET2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ViLUOT9J; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fc6343bd2so15224795e9.1;
        Thu, 08 Feb 2024 04:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707395143; x=1707999943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lk6lDhH+jNgP8E7fUtyDWqSj9xlcIvyWHBnZhCdRQI=;
        b=ViLUOT9JQZaoqBzdu3nXPDYbfutkJN+oCD590c86Iyk/QU52uLOICqrhyitEUG8+q4
         +TZ9znpaTo21fh34q+b1rqYxOeZqHvYHcqCZzT3DyASs/TP3r8tG/l/f6bkxw/LfA4xE
         kttb0aH+2R7m1JcEifiSYZ7ctody8uFAd621wIxNlN48ydb1YrFa5NNecReuProfJwoS
         EPd17k52gFBWNMH4CwEreS6cA+zJw0veNWeIUrlWaIXk4JS8vAWUkFKg6sKaxQI+G1yI
         71T258uvGYkM8KYZeFg01ghQtd67GElPCJrCLoh6jUvF8t13a1QF+q9CYm2y0rTq2zy4
         8k7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707395143; x=1707999943;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lk6lDhH+jNgP8E7fUtyDWqSj9xlcIvyWHBnZhCdRQI=;
        b=F17CJMB8v5EjGwpDPQVMMgiKxxatnrJ1pPp6EBdOEKiiAV8yYjRCDEM7Qn2rxw1Viu
         nVDxGnC5TsoHIsj8OXXOOO+bKTlI5U2HHUbVwUp6Zmc9FMVV/m1qZdOgHulgDNpBE5P8
         y0uw9HnZA35Io08+n8cxoQdnl3TmwXRaXs5q3CX34os+ZYqVaQCRO7teH6CTVx5ttqXX
         VZr5yXUKIWile29l85iVIRnjO6Bn6FdJ4yvrCfkzce02sxBgbp2vOjUemwDwfrIi9X1E
         DZcTV296Oh8lGciP8XOmJPfCB42zpZLAHhkYB3YHvmPELmWtnS4Rta0jWQbZ4z0gjm3l
         0Zxw==
X-Gm-Message-State: AOJu0Yx00xZgsdTIWCcLw9rWgM2SBb67ai4eD/riMewWFM9sULKh9Ios
	DLg6aKPUfWjqQOwt05TbSL+w8OfuAeZi3PAV4cl0pN8=
X-Google-Smtp-Source: AGHT+IFGH6T4iO9ag7ISjbx4h+kJpA2XiUkJ3nfZ64ZG/Vae7LcVOF2Ucgwc7VdG90/hrVU1dSD7sA==
X-Received: by 2002:a05:600c:1e1d:b0:40f:f4b2:b26 with SMTP id ay29-20020a05600c1e1d00b0040ff4b20b26mr5693676wmb.25.1707395142880;
        Thu, 08 Feb 2024 04:25:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5523syL23ya7l/XdgTOkpd24c+X2e1oo9RsaaVKfqzxRGvzyVjpt7TZwFOhUqQDFnelJ8oJx6vQoff8S/sC2uuW30hUh6e8kugSF0uU3jVy7NY/4cQHBAS7szwmkKXICuGeFWdfwgYr2F+xaboE/TFGbVSFABwHCcqTBCrtwCPQWlwgVoTeKFTTwaWmMd09z3uCE8TzpW
Received: from ?IPv6:::1? (p200300c85f11e2005dd582a67e0023fd.dip0.t-ipconnect.de. [2003:c8:5f11:e200:5dd5:82a6:7e00:23fd])
        by smtp.googlemail.com with ESMTPSA id p4-20020a05600c204400b0040fa661ee82sm1433984wmg.44.2024.02.08.04.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 04:25:42 -0800 (PST)
Date: Thu, 08 Feb 2024 13:25:41 +0100
From: Sebastian Kranz <tklightforce@googlemail.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: samsagax@gmail.com, derekjohn.clark@gmail.com, jdelvare@suse.com,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add support for Ayaneo Air Plus 7320u.
In-Reply-To: <099bc4e3-ec08-4604-90cf-5691a98441b2@roeck-us.net>
References: <20240207084206.2204-1-tklightforce@googlemail.com> <099bc4e3-ec08-4604-90cf-5691a98441b2@roeck-us.net>
Message-ID: <332FEE3F-E07C-4144-933B-E085C2CB4E57@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: [PATCH] hwmon: (oxp-sensors) Add Ayaneo Air Plus 7320u

Am 7=2E Februar 2024 15:55:39 MEZ schrieb Guenter Roeck <linux@roeck-us=2E=
net>:
>On 2/7/24 00:42, Sebastian Kranz wrote:
>> ---
>
>Patch description missing=2E
>
>>   drivers/hwmon/oxp-sensors=2Ec | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>=20
>> diff --git a/drivers/hwmon/oxp-sensors=2Ec b/drivers/hwmon/oxp-sensors=
=2Ec
>> index ea9602063eab=2E=2E8d3b0f86cc57 100644
>> --- a/drivers/hwmon/oxp-sensors=2Ec
>> +++ b/drivers/hwmon/oxp-sensors=2Ec
>> @@ -43,6 +43,7 @@ enum oxp_board {
>>   	aok_zoe_a1 =3D 1,
>>   	aya_neo_2,
>>   	aya_neo_air,
>> +	aya_neo_air_plus_mendo,
>>   	aya_neo_air_pro,
>>   	aya_neo_geek,
>>   	oxp_mini_amd,
>> @@ -98,6 +99,13 @@ static const struct dmi_system_id dmi_table[] =3D {
>>   		},
>>   		=2Edriver_data =3D (void *)aya_neo_air,
>>   	},
>> +	{
>> +		=2Ematches =3D {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
>> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AB05-Mendocino"),
>> +		},
>> +		=2Edriver_data =3D (void *)aya_neo_air_plus_mendo,
>> +	},
>>   	{
>>   		=2Ematches =3D {
>>   			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
>> @@ -332,6 +340,7 @@ static int oxp_platform_read(struct device *dev, en=
um hwmon_sensor_types type,
>>   			switch (board) {
>>   			case aya_neo_2:
>>   			case aya_neo_air:
>> +			case aya_neo_air_plus_mendo:
>>   			case aya_neo_air_pro:
>>   			case aya_neo_geek:
>>   			case oxp_mini_amd:
>> @@ -374,6 +383,7 @@ static int oxp_platform_write(struct device *dev, e=
num hwmon_sensor_types type,
>>   			switch (board) {
>>   			case aya_neo_2:
>>   			case aya_neo_air:
>> +			case aya_neo_air_plus_mendo:
>>   			case aya_neo_air_pro:
>>   			case aya_neo_geek:
>>   			case oxp_mini_amd:
>

--=20
Diese Nachricht wurde von meinem Android-Ger=C3=A4t mit K-9 Mail gesendet=
=2E

