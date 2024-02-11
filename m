Return-Path: <linux-kernel+bounces-60849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235AE850A23
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB561281C99
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCD55B699;
	Sun, 11 Feb 2024 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="hF+dYNiT"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525F25B688
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707666656; cv=none; b=SvCQC0X9i28f2YIpbRvieuiHzo8a35TeEjWC+/6K5koPA4dJw6f/Q1nS3VUDgv9jEJKnUfXTdHjQdqlW1UeQ92lIrKYnh7WeNxf68QDUQHBVUtPuxZT6SbcrgT+e6p8wIkjRMjZl44XbtWp2y1uHr8MybhfVIbkvxRjOzExW/bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707666656; c=relaxed/simple;
	bh=MoZzZriDEbnW/RpPSEFwGgmj9ZQbVTEDvtAHOpfxyak=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p1hLa3AfCRDNqHv9Mke08WD25RuJqile7vV08kfiEBwskK35M+jJt4p4gn+5BU3N60S8zAg3yfAu0h6XbjV9psWurxXGKIPiqabBGEs/uGeq0cx9qsqJ97QA70BZrDBXzK8Z/75zR5CN1UrFiBJmVAu6h9qGqyysoy5iGXIuVc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=hF+dYNiT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d73066880eso23025295ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 07:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707666654; x=1708271454;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zFvZCWLL5rcVPLPKQFGuY+LumUsEsYdkGzJ+Zdb4OX0=;
        b=wKYjU2LMB2Rebx6rUPXjDVGG7tTtICaRnQ3s/PFjsa65PR8V7jZ1Xd4OF21rjJfhoU
         8NF8J+E6JJgApfE4VJvm9qLIPuAdVH8v2G3krUzC97uT++BVbjwMZ+CMhg9bcwpEQ9L4
         F3AJcu0/gbvigCHEQMlFCBdIq7SYCFXEQESCH133MBWIZ6LU3wUroX5/+tOsq9ceNhEq
         GUzrLvb8gZJgmEVVLNewfwjjlU2EqqmHsxwEWZYRujg+Zg6IL1R8lBnMQ3hK0fZS21rX
         Zlr3x5pOlSiM6jXBvapzmHPtl7EWe/u3ibcOYyEYUobvMKxhOoULLLUrAOWjZg46rYox
         AuzA==
X-Gm-Message-State: AOJu0Yy9zpS6E+kWbVkKhd/gaQNNSnOjDm9Wos2kEUzRhGq9EYapmNQ8
	WrHmH+DlZxPVTsJTgQkHoukCiRKzahe76jA5xO+HbyLvGlLwC/Os
X-Google-Smtp-Source: AGHT+IGadDMIzw49zyegAsA5UuD1mQG8rrqXQRQ43R+FYjSGCFdUoCKw69wY7Oifx7FDuw2N3O9Rrg==
X-Received: by 2002:a17:902:be14:b0:1d9:a609:dd7e with SMTP id r20-20020a170902be1400b001d9a609dd7emr5443798pls.55.1707666654656;
        Sun, 11 Feb 2024 07:50:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUp+9ZLo3ycl/4J0opzfBsoTMPfmzyynAlSMAIFhHtaMcbcVvf1NwL3ogbeNbH0V+Q3ZjMwnjGu8OeecTvkmZspg7vjMXNCv2OUjoLetLustXGfGe6/zXypAfpOt4/0VO7fQeWG3EhvCftJyczQm1CUGMuH7UmdSs4t/sE89GM9cxQ/
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id o14-20020a17090323ce00b001da27cbcf60sm1288606plh.236.2024.02.11.07.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 07:50:54 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707666652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zFvZCWLL5rcVPLPKQFGuY+LumUsEsYdkGzJ+Zdb4OX0=;
	b=hF+dYNiTFKmk0qGwwKEaqANMaej0cgG2qeQWk70cya0f73SuDYMj45GXVPWLAkkfHdwdAh
	AfNVMaJzaegG7qSDas0qF/BO4Jhpf1ZzKhJS4P871TEozNJqsku4j3lTYBQUhxUV9YJDyO
	PTUq3jmv+K4QwBM3qbxXAADwFTkVduObodzOsWziNmtVnOH9LdNPt01mm05807qM4TyuCj
	VR+4n1e9nHNRkXIJXY3V9D+aM8b67/f/OtoEbxCvUTlgFxUOYzw9EcXazucQRzuTeY2MAH
	PuOtfJWl/coe9Mw9qvP+Ii4fm7S8/mbny+JKXsiC/k/ejinLPkHG4wptxM2UuA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/2] firmware: struct bus_type cleanup
Date: Sun, 11 Feb 2024 12:51:28 -0300
Message-Id: <20240211-bus_cleanup-firmware2-v1-0-1851c92c7be7@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAHtyGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0ND3aTS4vjknNTEvNIC3bTMotzyxKJUI90000QzY2NDA3NLI0MloN6
 CotS0zAqwudGxtbUAqDKgXmcAAAA=
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=MoZzZriDEbnW/RpPSEFwGgmj9ZQbVTEDvtAHOpfxyak=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlyO0BoVrNPODCeNbi07QsvrVI93defvBvNSamX
 PCuBxN0aWKJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcjtAQAKCRDJC4p8Y4ZY
 pvAYD/0ZkkFJaIyizyPjpb1zb5LdVpvsR0cqDifWbUvLWk//6zzYK94B3db8RdlXHomT6Q3VNTw
 bLkipsEY5dRrLrs4/Oz4VgoNZn59zPcPW/Wd0hjnuoHxL7qj2EvS9LLx2qAUW7J8jE6u6Yrfmkn
 l5E/PgtcTMv3l2uwFjgYUvccuwCKtvBZTVFEVZfoZrwHucLiSgACRnAcrdKL6SrI2N9mNtx5mLz
 SJD0AA0qZESFZlTPZRasFgNesE2tOK7DctRV+5qLLYXi2VnViTffO52A8uFyiIF6/h7gth0nLlL
 IOfX8kv0kOjZvLbyU3h2j8GpMigy4EEGorXTAery29hbkgaB9BSG3kBFCqvtRZ7FgpiSyHTS5hf
 BcYEiVKnD2DpBWjAk9wFIA5/6yS7ZlNt+8JKgoH6gR2vYjCq130cIhVCniZ4+iRYNvfZU4GYDZs
 31qHQQ8C8A7sAIdbhj7wSOnsYK5lErBN8ujjd4Bh79l/v9Y6XCchK/c2Wnw081tvujPDokWGoqR
 4KWrE9j32ZOCVfK74rr/BYiVhebR39l+vTErdUctjxDqV+LJwakra0BQQHjWTf9TNLOPaG8fPgD
 aT7fMy4pbjSoJNlCzJ2+ptHiopORw+htSArPPdZBLAJPoAjhiV51mH0dC1w0P6p//q4PzfqCxGn
 1qzo/U+JmN6zk8w==
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
      firmware: arm_ffa: Make ffa_bus_type const
      firmware: arm_scmi: make scmi_bus_type const

 drivers/firmware/arm_ffa/bus.c     | 2 +-
 drivers/firmware/arm_scmi/bus.c    | 2 +-
 drivers/firmware/arm_scmi/common.h | 2 +-
 include/linux/arm_ffa.h            | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: 047371968ffc470769f541d6933e262dc7085456
change-id: 20240211-bus_cleanup-firmware2-f5a633107921

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


