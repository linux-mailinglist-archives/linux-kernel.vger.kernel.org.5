Return-Path: <linux-kernel+bounces-87313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FD786D28D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5872E1F2450E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FBB13441B;
	Thu, 29 Feb 2024 18:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULW0u7Nu"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C3A132C1E;
	Thu, 29 Feb 2024 18:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232402; cv=none; b=f0dCbs2zfOA3d6XXTuBRdBJ2OEyzFYquvSGchwD1Gy24UJdoMnBtGdgBlBhRDm757yuqva6U9I7MPYKKljj+4tm2CG1dCC5ngq+hJk9/hR+5ULSNnqnRhD5duS7VdcjAvVw+wLSvypbzvRhM/puzJ05YN2L3t34XxJC5e+wyUQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232402; c=relaxed/simple;
	bh=NaVqAnhHE6EuaViDoiWwLbszIitagFfls73+Nhz4ceU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aR4Vt8bBj9CxBPT2jYRBS4RPa3SrnKbB0nByf7Y/E7RdZzGuzYQzIgpYHvY/1nypfRuR9qnPhfRwUXDtLjJCKDPnqAgtWfr71x9c7GwmlBXLqEP7GGJXK4JKCs6gdhF+jUSKNSJ94lfHICMFDouULEn8sSOIWfmXaFAyzmwiWzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULW0u7Nu; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e59bbdd8c7so746830b3a.3;
        Thu, 29 Feb 2024 10:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709232400; x=1709837200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NaVqAnhHE6EuaViDoiWwLbszIitagFfls73+Nhz4ceU=;
        b=ULW0u7Nu7hkS/gQuGIclS/Sk1dduMYXJC1GpoXCPCnsJf86vpI+VdNi7a9qCJ5s0IT
         hgMgrrg3uLx/Bx/2H8awCPl0FGptUDoFPeJxt70x8qDeAz7MJiPciTuh1zagO5dlEfjf
         /6Apaq8Te/tr0Ya1+froTqV5KC55zu1z/TVyt8m145YK6h89Y69ikR3Qwe2CkHhtNlSn
         pCSOqGwWu4TqTGz2fnsv5aaWD21tTGrhftjJwMwBcKMkC9cGpVRo+QBD+P7YqjhzBfv+
         FK5ZPYiBTL/kAmJKMSOeVboVqo7PQjlgKFVXRBEXshXj5aQahAayd7LJPY0XpIWcfCso
         UTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709232400; x=1709837200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NaVqAnhHE6EuaViDoiWwLbszIitagFfls73+Nhz4ceU=;
        b=s1htQ+F6gw+d+jFwoBN41p46eDaacqA5N2NJDn8mGunXvGCgbxOc478EXo9wiBItUX
         ANumnbz/XDc3aUKurOjqeaiv8ESSxi5tDhH9/+V9raE5Ue8IZNSR9idnUGL+kxX1dvDf
         5mnZRrwNiYPGtvFMFry9cQxjgubG8kkubS9QXE+SAjGo+lJOt6jW1aO3+OQwhS8eLzri
         gg+AQpqoprW3RoXAZxkdvWPBCYSEdn7mgf2x6kdTlzXEbqDDrOGCBkVqRNZViuYmG6Qy
         7tekNLOkVbN4apNB51sO7PTsenIgzEmPVacEKJYLjBRhjDwS1daXOwhjXM6cLdzOpRX0
         /eqg==
X-Forwarded-Encrypted: i=1; AJvYcCVh2c3nAgjMDh4avVFj/zeWegV5QwH210xeEDjLLNXPDskxKW5/+OZ6Dv3lNYi/mfdy3T5uYOOm3h4DIk8YyddjLm17gsZ98qQRk7hz
X-Gm-Message-State: AOJu0Yx1i1m0TeV1NzbxF7AHrCClo3i3+/hbid8S4qIuBYxWEyobYaAs
	FDsTmr0BwlJ9jgkXTJ2JVNO0QjA1iGEJNsIRfyxWVCrIw4vELbRs
X-Google-Smtp-Source: AGHT+IGU87rpW8Gt3NqgCIMbJs6ZfclJvDDRq+JEWoFVPm+zNXBBsdMh7JXMZenxkRqDE3t3F/klpw==
X-Received: by 2002:a05:6a20:e68c:b0:1a1:864:65a3 with SMTP id mz12-20020a056a20e68c00b001a1086465a3mr3632840pzb.13.1709232400081;
        Thu, 29 Feb 2024 10:46:40 -0800 (PST)
Received: from Artemis.. ([101.0.62.73])
        by smtp.gmail.com with ESMTPSA id y19-20020a056a00191300b006e55016966fsm1577553pfi.81.2024.02.29.10.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:46:39 -0800 (PST)
From: Saalim Quadri <danascape@gmail.com>
To: ciprian.hegbeli@analog.com,
	marcelo.schmitt@analog.com,
	dragos.bogdan@analog.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: GSoC Proposal 2024
Date: Fri,  1 Mar 2024 00:16:36 +0530
Message-Id: <20240229184636.13368-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone, I am Saalim Quadri an undergrad student at Dayananda Sagar College of Engineering, pursuing Electronics and Communications.
I wish to participate in the GSoC 2024 as a part of the Linux Foundation, IIO Project.

I have been contributing to the Linux Kernel and have more than 10 accepted patches.

I started looking into https://wiki.linuxfoundation.org/gsoc/2024-gsoc-iio-driver and Analog Devices Inc. and I am interested in writing
the driver for AD7294-2 12-bit control system with ADC, DACs, temperature sensor, and current sense.

In that sense, I would like to know if anyone in the IIO community could provide with some suggestions, I can get started with.
Any suggestion or hint is appreciated!

Sincerely,
Saalim Quadri

