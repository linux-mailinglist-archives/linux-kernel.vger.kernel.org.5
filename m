Return-Path: <linux-kernel+bounces-161208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C148D8B4904
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 03:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44311C21222
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 01:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92292EC3;
	Sun, 28 Apr 2024 01:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="lY0O6FPk"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6837E8
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 01:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714266847; cv=none; b=oZoX6Tavv8LrS3T7qO2+PXlglzf3mypAkGx7yLa0PR7kRgKzjlFiISgYTM1ihcsnA/ivnU5LCg5J/6C2LE8uUpw4ZAlkdPhabkszDI5vvii6WVC8Mo8m3C1fR1BKUxfr3Ie+fuzA6LisOZxLLuYOoItKdHY7bFzLcetk+A1/aFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714266847; c=relaxed/simple;
	bh=MkxjFPe/XjzQO2U1RPZYV5iizyM+ETgFkRJ4AhpEyAY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oDH6Z0gor9nn/iXrsmbpdMHti1ix4XFYO75QFp686yt4pFlzgSu5Ujz4KhbpibqtYTkXgB7l5h+S56ULdv7keWYCfUbgAQXICnx6LLVSLQqzNF6Z95Z9lKujBYEkktMltI1glfdMjhxC8QgMCqSoZXmFzQeFaX4uN3Z7Xut6t3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=lY0O6FPk; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ad8fb779d2so2833054a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 18:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1714266845; x=1714871645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zQqecslNvADeDtDMc6gN3wUzor0w8dFqE6x2ITjMuoM=;
        b=lY0O6FPksDlKEqBi7YQhBa71zOSubjB4k3/yHz57SheFGSPDZV2vFrAlpp6QucoEHx
         tJ1iut3N7UCweSFlca+ql6hMIU5k4jIKi67ueZlsE3eGub1YFsWezYxH0ZzyYHokALTg
         DouHR2dfZRuo6sFBIZz5oaKog3gSnSs0hRKiQe18+kEalM6dbCTq2olqnERHVqW3uYkJ
         2J8v8hBDwKIVN8bATiI1Wb9cDyuFGE11m90/AGToL4OgWM4SmSLca7Ts7RYID7Y0N3zc
         ppDeTjRJVNFYJ4sRFa/rWSr6S+ayrPv5fiwlManCapkVlhNeDfQCKOxKH6NQegaFYv8j
         BOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714266845; x=1714871645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQqecslNvADeDtDMc6gN3wUzor0w8dFqE6x2ITjMuoM=;
        b=j0y6i1AzMxVx8HpCVBJMCEjx+j/Axu7W1NrFiTvBxsn5Qzi6Bl4Ej33GcCqXOSM20t
         /sQQyuUTTJzW8cSCBBM/Eh4C2Yd1AP3zW0LEtUjpXlFIr9UOD6gWyxmeMFxKSvBPS5AW
         a41iU5MIKq9+uHh9lfLd5oSUvMpcELkfqAw4EgdqW52+5glkgWAM357y+prTV2DiIu6f
         eq5S7Qs23KWWNR0xA0//EAYQhrLJDDNOHvQZbOLLckHlTKX9Zp6NJrZbSIoqfVXZ/Jry
         J74W2MTrWfc1rTir+FWItSrrOniV20oTKkn5aLJIca5GTIR5ZqZdlvLiTievOoUb4Dh/
         ePWw==
X-Gm-Message-State: AOJu0YyLUxTfGkU194meFvS+6iojk+97cy/EBAyln5gg0uJs3VADGJpX
	ae4I6W9giYMnn8mdGd1xU8QVEWD5iMMRI7DcLK/9VQYMsj4mCSNhhueFeFmpoDE=
X-Google-Smtp-Source: AGHT+IHpvftOvAeVZEr2PEgqKQpq01jDhDnbfGc94f5IGcuYhKxBuBao7tHzZ9+WZFt3dc1/5bu8Wg==
X-Received: by 2002:a17:90b:3901:b0:2ac:23ec:6a57 with SMTP id ob1-20020a17090b390100b002ac23ec6a57mr6228811pjb.39.1714266845541;
        Sat, 27 Apr 2024 18:14:05 -0700 (PDT)
Received: from alpha.mshome.net (ip68-4-168-191.oc.oc.cox.net. [68.4.168.191])
        by smtp.gmail.com with ESMTPSA id t24-20020a17090ad51800b002b0696a21a4sm3214662pju.32.2024.04.27.18.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 18:14:05 -0700 (PDT)
From: Remington Brasga <rbrasga@uci.edu>
To: suzuki.poulose@arm.com,
	mike.leach@linaro.org,
	james.clark@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	Remington Brasga <rbrasga@uci.edu>
Subject: [PATCH] Docs/ABI/testing/sysfs-bus-coresight-devices: typos/spelling
Date: Sun, 28 Apr 2024 01:14:01 +0000
Message-Id: <20240428011401.1080-1-rbrasga@uci.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling and gramatical errors

Signed-off-by: Remington Brasga <rbrasga@uci.edu>
---
Fixed typos in the descriptions.

 Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x | 2 +-
 Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc   | 2 +-
 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
index 3acf7fc31659..271b57c571aa 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
@@ -22,7 +22,7 @@ Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
 Description:	(RW) Used in conjunction with @addr_idx.  Specifies
 		characteristics about the address comparator being configure,
 		for example the access type, the kind of instruction to trace,
-		processor contect ID to trigger on, etc.  Individual fields in
+		processor context ID to trigger on, etc.  Individual fields in
 		the access type register may vary on the version of the trace
 		entity.
 
diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
index 96aafa66b4a5..339cec3b2f1a 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
@@ -97,7 +97,7 @@ Date:		August 2023
 KernelVersion:	6.7
 Contact:	Anshuman Khandual <anshuman.khandual@arm.com>
 Description:	(Read) Shows all supported Coresight TMC-ETR buffer modes available
-		for the users to configure explicitly. This file is avaialble only
+		for the users to configure explicitly. This file is available only
 		for TMC ETR devices.
 
 What:		/sys/bus/coresight/devices/<memory_map>.tmc/buf_mode_preferred
diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index b4d0fc8d319d..bf710ea6e0ef 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -244,7 +244,7 @@ KernelVersion	6.9
 Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
 Description:
 		(RW) Read or write the status of timestamp upon all interface.
-		Only value 0 and 1  can be written to this node. Set this node to 1 to requeset
+		Only value 0 and 1  can be written to this node. Set this node to 1 to request
 		timestamp to all trace packet.
 		Accepts only one of the 2 values -  0 or 1.
 		0 : Disable the timestamp of all trace packets.
-- 
2.34.1


