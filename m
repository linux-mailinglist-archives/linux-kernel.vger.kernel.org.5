Return-Path: <linux-kernel+bounces-60570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870BC8506DC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16EE1C21328
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4734B5FEE7;
	Sat, 10 Feb 2024 22:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqUJDNV/"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD525D468;
	Sat, 10 Feb 2024 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707603757; cv=none; b=SbrgHSqkq2S8ueA9wf+56KMz7NvQV1jc5FDiaE6Uohc2pLR2zCdgRt7gpXNO4VfVEKR0wljM/PHuyk9fZvZNvMuJCsG3Bkzil0dpbE61O6aYvrA3v/cEk+IyfhwVRPk+Wu8rzGwRJieX1NwEzuvI4QLVs8OCVWdypEYa/WbP9OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707603757; c=relaxed/simple;
	bh=yoOf1EJL98pLcGdr1ZyQ7ynGkZ/o1xuvDT4fSKSj/g8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQhRJPeRY+SVkI3IjCUgOfoIYfmpvscLUt7spvRdK+nRQ5egCZlGg/kKQYXNgTAdOyKFUKBJnH3mQA5QK7O73vpFWJyLXKt5otKCHhvZ5i/UQH0bRGQ2Zb6ZiPgmE77305oQky8LtfIn4UXu0NENr830OADf6XHzSS1WltubYt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqUJDNV/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33b748b419eso255663f8f.2;
        Sat, 10 Feb 2024 14:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707603754; x=1708208554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MarbRK7Kns5sgM2Go9562DLMjofwzOLRXaHhWg6F2Rk=;
        b=LqUJDNV/QuK/Mkc14tc9Io27uGg23yx4iDflPNvLxRDRWdVCPBTg1BhI7OWwztsiZM
         gYAZl+i/RD/r0dTtGnShJnAb1YeiUnD3qiAUT/CpS3m2bGdko35Hvzirmc/UypaSwLYt
         bYidn6rBOhYxWxvc2KH2+B8/NvxRGITCVutELO3kWD2Xo5gljSnEMktZD2PL9Teg3YR6
         S+xz93qMntZw8rafjmgIxMLMAL+nUTmyov0Ma+ox2gRwcTqcifJwOuNDlejao9pTckC+
         Abz7TGyVS0w8O7V3SwbJ4sqhWpT+j6VwrzpHjX+tzGIFtGFTfBhDMoFPf8BMnyWwCmUy
         6MLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707603754; x=1708208554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MarbRK7Kns5sgM2Go9562DLMjofwzOLRXaHhWg6F2Rk=;
        b=rlzuMYyecN+nFUe2G3gKk/yIcRp8iKgfkZFDdJUsnPx5TDuepXzVcBnxnXrxst80OC
         Q0L0g+T8obCC4NzYptDI+c/lSjeKGCYaagib1iDRztIOPuW2anc7TfyhR0Qy0B5QLyKi
         DTIqnBVqfc9FvpSWtcrB0WzVjBqbY77R3l5P+Fm6WjMnUUMYr5fRcU0I5Bc10EKZ7PDB
         GPpnGceiP92tN3FTQUnNN188YZ+2HbckpSUQGbLvSK3iEnCXs48RLuCBlDPbDwH8vp2D
         17scnvaYP/FUxScqMbzDd/dqXD+6nzzxBNcXneqxD8vrW75ps5gtvji+lURw/Wet/mXC
         AXxA==
X-Forwarded-Encrypted: i=1; AJvYcCVuo5lEU97YEtWbLN4dgWTcqwJLo16HbHWBKueT+zER3v2RsNq6tpqKsIBjoMbokNMTYc42MRpSdF8GY4okgddDDgM1u1931j6dOQom
X-Gm-Message-State: AOJu0YwGYBZL/Oy6EGud+Gi7L9D3CYVG7EI0I8dVpFmRixIH/kddXMQR
	j+9/Gt4yg7N/lwPH5nGC9zknUayxo/WwaJdFJwZcNQRd2ezwG1qHoI8LcWRCnGM=
X-Google-Smtp-Source: AGHT+IEuMx46TlNTCEWGzzEuFXQnfMNmJ/dcIY+muuGMoJTXHlj0XmI/eG3jyErbomQIttGsyo16HQ==
X-Received: by 2002:a5d:5405:0:b0:33b:1575:bcd1 with SMTP id g5-20020a5d5405000000b0033b1575bcd1mr1986953wrv.5.1707603753446;
        Sat, 10 Feb 2024 14:22:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWORU51LQtllh2Fd+Qgg7oP+0F0gxhvperX/84tFxCSkFvuIKmVAsl5V/Kb82g+l3AjYBc/pwsoueHYmk8rrO+qdZQlSIZM3fBzGzXieJY+8dWEkp5tQ8tRmH0lu/k/EfV44/OrAQjpQipEnCcwkqqjyZnWWM+LJMc=
Received: from vibhavp-mega.lan ([2401:4900:1c0a:39ad:8621:c30e:70c4:e9ea])
        by smtp.gmail.com with ESMTPSA id l21-20020adfa395000000b0033b3ceda5dbsm2827164wrb.44.2024.02.10.14.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 14:22:32 -0800 (PST)
From: Vibhav Pant <vibhavp@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	linux-kernel@vger.kernel.org,
	Vibhav Pant <vibhavp@gmail.com>
Subject: [PATCH 0/1] Bluetooth: mgmt: Add command for getting device IO capabilities.
Date: Sun, 11 Feb 2024 03:52:25 +0530
Message-ID: <20240210222226.890031-1-vibhavp@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following patch adds a new command to the bluetooth management interface,
GET_DEVICE_IO_CAPABILITY. The command allows userspace to get the IO capability,
and the authentication methods supported by a connected device. The command is
necessary in order to implement parts of the Win32 Bluetooth API in the Wine,
specifically the following two structs:

* BLUETOOTH_AUTHENTICATION_CALLBACK_PARAMS, which provides IO and auth capabilities
info for an incoming authentication request from a device.

* BTH_DEVICE_INFO, which contains flags indicating whether the device supports
Simple Secure Pairing and MITM protection. The former is supported through BlueZ's
"LegacyPairing" property.

Because the Wine API are implemented on top of BlueZ, I'll also be providing a
corresponding patch that uses the newly added management command to expose the
capabilities through new properties in the org.bluez.Device1 interface.

Thanks,
Vibhav

Vibhav Pant (1):
  Bluetooth: mgmt: Add command for getting device IO capabilities.

 include/net/bluetooth/mgmt.h | 19 ++++++++
 net/bluetooth/mgmt.c         | 89 ++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

-- 
2.43.0


