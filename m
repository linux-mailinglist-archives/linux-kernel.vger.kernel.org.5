Return-Path: <linux-kernel+bounces-53895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8336A84A7C8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7041C270BD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A9E12EBC5;
	Mon,  5 Feb 2024 20:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b="DrUe6eJ/"
Received: from egress-ip12b.ess.de.barracuda.com (egress-ip12b.ess.de.barracuda.com [18.185.115.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B01612E1F8
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 20:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.185.115.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163699; cv=none; b=cInQgB+rGsJjWduQUAGmrhlKl6z5DKVopGdwTqLg582/KZBbb393PhfBjeqtwyAVkcE3l6nhp3xL/uQBv2hvA12GVgk68wf4viD6M4BNj1MI0IoC1uwGgvCqkD+Myv85aUOYNrtxM8CmJ3riGTfrFIhouqbWS5F8Tgh+KvfmEu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163699; c=relaxed/simple;
	bh=7wGCzJFWb5hFlaCiZEoJ6HQDkjtS4pWyMbct2zWNLls=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IuveD/4e+d1Etei6v/lr6usEdzzmGjk4Cc0fFipP73pqHuXtSUwaqXFNg1N6Frs/hmViNsmTFkJxzZiCchGKs/vvUkT4EAVv8JDcW/K7/pxVTdLnEO4TUGEr8XI/k3H/Kp7WYBdUMz7Xm726hA5DRZCeLeLyIPizuq9FR0dEhWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com; spf=pass smtp.mailfrom=mistralsolutions.com; dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b=DrUe6eJ/; arc=none smtp.client-ip=18.185.115.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mistralsolutions.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198]) by mx-outbound16-171.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 05 Feb 2024 20:08:13 +0000
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1d45d23910aso690935ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 12:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1707163692; x=1707768492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SWbDoVD07rVKEBKYtIbbk8nLQfwFu4lWItnDKsOHDdE=;
        b=DrUe6eJ/qor3tx2+pnt18MU1A14ut5Vzml40ZdPDZEO2C1B8gw95vjVnDi7VHtSp5+
         EpoWzx1K6dx/LivjEQkRLfZdbHH8PlOwXjg5pYA7RaCr6Fwz/XcGn+vXcqUJ3uDe6yXf
         veI2BfgQhkKKfVhWt6F+AeEtrtbp/c+hcNXgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707163692; x=1707768492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWbDoVD07rVKEBKYtIbbk8nLQfwFu4lWItnDKsOHDdE=;
        b=vnQeJIVGJsu4YMjV/iWbtb0A3usncPE3K4VOxcRrYpHSoM8zzRwP60J9xA3OVEv0dr
         VkK1pjV3BawMEmS96M87pxSIJ23Z5B+LIAnag8aEh77r/Kqg/n9hm6YkfzdISFqgqwSw
         N0RHVXVK1L3t4S9VOTg5dGVsP6BbS9kzj/AkWJWv9r8uu9EUxlASTKQrKdwVIJXYsE+c
         +7/g76cxcJb8t9tUILU5gGZpSe6AhIpPX322LJD75DAYBx1gEwZZ+Wwha1go3d+uAT7y
         3aNi+6rNAQ4KMBM2Jjt7eDB0CcQy8SzC558qFa2NO/M+vaqTqpLL36azP+FcOSNXRr6P
         ZGRQ==
X-Gm-Message-State: AOJu0YxaBu+zg2sWyNKBGgQNbMjMFbXcrNjFA4n4W7AoBSYLb7hZzXws
	qJjmH3KDu+Fa/nT7iiMgTdyLnMRkObYif8+0dB7BQcR1EJY0b/D0wYVJUUjnn+sJLCBl6CExJ4g
	vNVcyBq67fsO4mCMlT4dhwP1oiICgp1tMIk8yK23ZBLTw5tOk6mxLJ2czLdy232M43kaEDGgYO2
	v/72cCCgAVMTRO7gRQOd6/
X-Received: by 2002:a17:903:1c9:b0:1d9:b8bc:fd7 with SMTP id e9-20020a17090301c900b001d9b8bc0fd7mr512435plh.68.1707163692633;
        Mon, 05 Feb 2024 12:08:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEh4+ZhiFeDkX7Q/woSOxwV5s1uHQHdpvC65GpnLTOH8TThLkC8QDx1mJjn0/AF8IelkUdgRA==
X-Received: by 2002:a17:903:1c9:b0:1d9:b8bc:fd7 with SMTP id e9-20020a17090301c900b001d9b8bc0fd7mr512423plh.68.1707163692321;
        Mon, 05 Feb 2024 12:08:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXwR6oYP4P5WmdXmesTXXZ02ffhuiat/gT+98uiClGqhk46BD9T+TfBuufWMDRmk8bfijxoiYyATNNRRjKdUZCz/uCqSnuGhiB6XKXqI/vug3mSk7BMtEpCLCgYkK4r2pZjr8zsCyBdx1HPtfiC8hu0cZJeWnKu/8of/k6DRddaxmNQscpKYZ0TSzkplK30ZaKE3bQSlmzDrrYzvfdGJf3qiky1tcJRnHg3BNQwt3BvigTv3wpntj6s7k1bUuZ8ytClvVP5quTb6gfabQHHtp3myt96ZIaA/6ZFQ0nvmhCe51Wk1LpMp/RY5gartKlwdDS2ifC5vmTIc/cKokQ021+tsjE=
Received: from LAP559U.mistral.in ([106.51.69.35])
        by smtp.gmail.com with ESMTPSA id t21-20020a170902dcd500b001d739667fc3sm263900pll.207.2024.02.05.12.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 12:08:12 -0800 (PST)
From: sabiya.d@mistralsolutions.com
X-Google-Original-From: sabiya.d@ti.com
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linus.walleij@linaro.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	u-kumar1@ti.com,
	sabiya.d@mistralsolutions.com,
	Dasnavis Sabiya <sabiya.d@ti.com>
Subject: [PATCH V2 0/2] Add CAN and OSPI support for AM69-SK platform
Date: Tue,  6 Feb 2024 01:37:41 +0530
Message-Id: <20240205200744.216572-1-sabiya.d@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1707163693-304267-12419-35369-1
X-BESS-VER: 2019.1_20240201.2150
X-BESS-Apparent-Source-IP: 209.85.214.198
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyMzECMjKAYoapiQbJyRYpRq
	mmScamSZZGlsmpJslmiUnGloYWFsbmSrWxAENBwqNAAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.254009 [from 
	cloudscan18-189.eu-central-1b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 NO_REAL_NAME           HEADER: From: does not include a real name 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_SC0_SA085b, BSF_BESS_OUTBOUND, NO_REAL_NAME
X-BESS-BRTS-Status:1

From: Dasnavis Sabiya <sabiya.d@ti.com>

Hi All,

This series adds support for the below interfaces on AM69-SK platform:
-  CAN support on both MCU and MAIN domains
-  OSPI NOR flash support

v2: Changelog:
1) Removed CAN interface aliasing.
2) Updated bootph property on the leaf nodes.

Link to v1: https://lore.kernel.org/lkml/20240118153524.4135901-1-sabiya.d@ti.com/

Dasnavis Sabiya (2):
  arm64: dts: ti: k3-am69-sk: Enable CAN interfaces for AM69 SK board
  arm64: dts: ti: k3-am69-sk: Add support for OSPI flash

 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 162 ++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

-- 
2.34.1


