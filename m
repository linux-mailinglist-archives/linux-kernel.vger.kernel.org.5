Return-Path: <linux-kernel+bounces-60433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD17F8504E0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87DE4283141
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BC25BADF;
	Sat, 10 Feb 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="ApECabZt"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F765380D;
	Sat, 10 Feb 2024 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707578074; cv=none; b=ksZfjrR2yC1jqfpeBSqKtAE45/nuvsQF2RQYzpsJyLPeWlGxsWvxQQ9zIsA+iytTUKbS6czSdCXrfvWtmd2Q00U/92WsIZ2JPn7U6g9Pr4LBRPH1IM42ElGqid1yroCI7JMp0RDBdLKazEP/+jupGiwWwBJfXY1X0DFbIH6Zuok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707578074; c=relaxed/simple;
	bh=kzuYAL0Q3W5IoevqxmRusinDuR6hBB8ObAvm8X5wMBM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rlWle6WgAYLTmCduq2Lx5l6F7gpivNvzxfoHGTyHo2j1fUX6HBiWASCTm9ehId0fJhP6N4pUX6FwbnRvNGoqQFoZ09uYUN7EVUOYB+3lA4yOHY+BXBSZbGPdTODJfdZS319GBXMHY888zUGrzsoPaqwPs70UFQJpZ/lL4b/fTHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=ApECabZt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d8aadc624dso15273305ad.0;
        Sat, 10 Feb 2024 07:14:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707578072; x=1708182872;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zQkaWqJl7pMIWT995zvqC9gdsJb2Z3jcvYFdnK+EjME=;
        b=eE4vIQXDNjSdYQfEqGnENuJO5krQ1Y2FrFrNMu7iLm98BLrvOZyDdKpJzf0D0mam2Z
         G2CFy9URWsGr9Dfz7RpCXGcqthU9B++uGnwYn0hZSLs7UfwdWvvS1whIgLHwndPpL7Vn
         rzmsZ3LBWy20r0DSdJNpDoQc8Yy8uBVJBDxPdMjA2RcgHzKdp0Z9+ahqLM9JtPz7jBfr
         w12FF5CgDyMhWvSEXPmN5Xwaj7P1EE9LmQOt1q3CrmcKj5DYGD6vxoQZHfED9IrcoYbi
         ZWCgER/NNMpKWLfSDe/ljSEYb5xY6e0VhsS+q5S8lqyCCP5AnPhne/8ikE1/NzzebjDf
         lMmA==
X-Gm-Message-State: AOJu0YwxJR2HORS4Uo+8veegc4CoNgwbYSQrzvX/sREjvPH0MthAzzkk
	Y5fkXMkmfqgqC1BWjZh7U8DHTuwjVu6M0m6Nn3Oxzg27tvi/mpwO
X-Google-Smtp-Source: AGHT+IEdz/bpO2GULPdrY13S1STtbOkLXOlSe4oEyWSlw5VFStJBGV1Qf+9Ryfd0i06MTgqTdtqvqg==
X-Received: by 2002:a17:902:d2c5:b0:1d9:bd7d:3c79 with SMTP id n5-20020a170902d2c500b001d9bd7d3c79mr2736458plc.26.1707578071716;
        Sat, 10 Feb 2024 07:14:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXFYKIkxFttKdM3eJXrNabObw5BlBNpbjicdaGmAf54FIBXUGgHEGxkRAVjPrRx7JvWcCtdVGi7RKP25TSnLfssen1wPQaNZwJwHaotHXFlaYYr01+5rOoXN9tll9175aJJt+mCyxJWhw==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id kw14-20020a170902f90e00b001d949393c50sm3141350plb.187.2024.02.10.07.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 07:14:31 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707578069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zQkaWqJl7pMIWT995zvqC9gdsJb2Z3jcvYFdnK+EjME=;
	b=ApECabZtu4UycNwFSZiPmDvVZyRf1VZTfpJ0/CkhHFaC65RKh0DTmKxp4Z6YmcWXYEU4RS
	/mwjzYeZBCkqO9SL5XqIeHubmXr2yfqBxKfxpF/tSrOXLx44LpcRNqp4NYy0f6d+QdWN2X
	keWgnAAU9yF16Oy3SkX7iH+j193LC1pXfLfJuwl4nmzYpJDLzjDjPkPL5yDIMa+lKBvtZC
	U2jkWVK6rZOfIKXoKDzNPAM1KMK7jgNHt0qX2OoCD/MSHml3RPXfD7b9sXhv6uaUzSYpYv
	t08WfRU4jfgyNoLaSqyipxa80NCpevfHSs9Kju25vFhIxhOyFEjbaJEgmVwCcg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/2] Input: struct bus_type cleanup
Date: Sat, 10 Feb 2024 12:15:00 -0300
Message-Id: <20240210-bus_cleanup-input2-v1-0-0daef7e034e0@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPSSx2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0MD3aTS4vjknNTEvNIC3cy8gtISI91U89Q000Qz41SLZBMloMaCotS
 0zAqwodGxtbUAl5bBaGQAAAA=
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=902; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=kzuYAL0Q3W5IoevqxmRusinDuR6hBB8ObAvm8X5wMBM=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlx5L5jYGFYOw0CEdClRUvwTtw1ri8R6501vnwR
 i/MqNagmraJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZceS+QAKCRDJC4p8Y4ZY
 pkV8D/oDomaYy2QI1rFyYeP6jx/IyxWyYCn8QIq7R0edSYalgdHiPAWB2zissyuzBJRTQw3YKrc
 HSuwRdxW+Su42MFmBDUya8Y4RpTRQEm+wPJFULy0LJj10aFRNDsLWp5BMW+j8Y8rx0dUfte9FtQ
 4X7gxiOwZXf3EPIrJkZwNCUkwGnOkRbkyhIDr+4qat1F5/vO+nc0xWR0P/RrgFXC2Zp9tj/FmbM
 sOKhX4VsaNDt7niq2Cg9R4mKP/QwXaDWrYAWndzwr7Nr7MPOds9yd7Cm3okeeocQPGoyagy1AqM
 vO2867J5iM9ODO2Y4YzJz+0SByrlcojteSXjoCGdqd+pmHGK86VF3if/e0PNXMd4HN3lVmeQIA3
 D1srtQVJqePcizSylEqLAd840rPYecb+8luw1MvMPsWhHRN3at1r2VcXwCF9WEd6lFnDH8lTjgE
 FB9/iI51M1VRzioXWtYTf9YcVJeZkxAHsfXu1fgNh1uEa30kPR+WY1YgeovDlNTyNpqrw/jbosZ
 FwKtLWoxcyK1BEVhpzIMuPO9w1hUzB2LDeVrngZiqKcGKC0Y4htxZjMW2o8Uu2ngxpLxgM54zPA
 e5ZOWtOYCXcGglBpzj6ggjzAYtqaMsbIgSoaWfOghuHZC2a+AmEkKvXGBE2yhKNaSvIklh8WvpC
 3DNplai6i9XDb5g==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This series is part of an effort to cleanup the users of the driver
core, as can be seen in many recent patches authored by Greg across the
tree (e.g. [1]).

---
[1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

---
Ricardo B. Marliere (2):
      Input: synaptics-rmi4 - make rmi_bus_type const
      Input: serio - make serio_bus const

 drivers/input/rmi4/rmi_bus.c | 2 +-
 drivers/input/rmi4/rmi_bus.h | 2 +-
 drivers/input/serio/serio.c  | 2 +-
 include/linux/serio.h        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: d03f030115fe930de1222fef294730ba21b93045
change-id: 20240210-bus_cleanup-input2-e7ef5a63e8c4

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


