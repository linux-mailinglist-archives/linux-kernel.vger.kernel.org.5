Return-Path: <linux-kernel+bounces-136130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CADE89D058
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CEE71F23791
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC0C4F889;
	Tue,  9 Apr 2024 02:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LcDk4L5B"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B66C4F1EE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 02:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712629661; cv=none; b=aE265tJ9ejR0fm91gQyNMIUsonKryW0xv6rQec31OwQ2bAXwo749rTyOK3xBhEI++xfoce8gTPKxkB4G/46+POsq6RN70it6VsTihF+qN/CI0zhuToGGYov/irMscWsmUzz76uXeof0kc6+eXF3Z3kvyxNdEx4bOcyLP+JVu6J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712629661; c=relaxed/simple;
	bh=unKs6TkoxSItwhjqY6Xksy31shLVbGrRwXEzYRDKVBs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q2S5AW2mXNGVDsjRifUD9XceDHsPwoQ0xO5DdKrmQhlZ3Qek9A7IVSvpme0gxWpzwlM/2glOGAsgtbHWBPiMlq1BXXlo2YddfOWWoOPwY7pEFEesnd6BpiQQScbAxbpPwD/S9jIAWYVqhHWX0DQrafUQJcG1/qJgZa1qA4XyvYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LcDk4L5B; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e2a7b5ef7bso42144865ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 19:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712629659; x=1713234459; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KnUPa/A9V813oeE8EVVl8Mgh5nGUgOiLvHqt02U6ihY=;
        b=LcDk4L5B0enTyToevyfrBMiIUbnxmFUmmYlZORxu28Vq7SO4UXSnvTEBLIT2bOQFQ5
         7CrAfInNLUO97u9G48ykhcuXknBuDSj03hA/GN6vlw92AWi/0F0Veq/D+OJ/tD/lwbR5
         RuG4umn3/CG0JqwKzn+ttWImVIuSvSKPlPVNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712629659; x=1713234459;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KnUPa/A9V813oeE8EVVl8Mgh5nGUgOiLvHqt02U6ihY=;
        b=NQeJ79RVfcSBWKv2ft+FdUQ0QCPSBu0StrlbNYsRdS01l/vmYYaweyP633zl4dBMXN
         Lia0x1PDcNFYZeq54ItFeHKtwInCNaynhoXHijsVP9SKmLZqCLeH1FwbcPQR3Hknn8B3
         D02yaxJ5AqKOBgxDx3IkyzjAXLCNuwIUM2MbFnb2jXTRDb1H4dMKzpDgnEBQf7NazPlG
         UPWe/xtXZ/fRBIsy/kNniq3C0Pwp9J9y1JIf8alDCMXLJ0nWHdnaB8EaxAOhGmedtWPD
         rIR7unuTXo0z/bOhqEFzHOktQCoPj9YZQtY9pDpWGeuHqadMsbNdr/PWDmyZWVQ8RXpK
         eKnw==
X-Gm-Message-State: AOJu0Yz1+wr2v5w26zguw+LTIkBpunCGuV+JS2Ie5w4srnhNQ4SSApXI
	S+R2BIId0jkHC5hw0OqnVI3wMy2DQXaKc29VsbNY4ed8LL8M8tapFVOetLBK7w==
X-Google-Smtp-Source: AGHT+IGw3JdFUfEM6zcpZf05fYgwsx6QTc5nMG19Apx3DM0vbfksLMq/SiGaGAdpU/M42WKc1ZTv1Q==
X-Received: by 2002:a17:902:c14b:b0:1e2:a42a:af5d with SMTP id 11-20020a170902c14b00b001e2a42aaf5dmr9750503plj.30.1712629659506;
        Mon, 08 Apr 2024 19:27:39 -0700 (PDT)
Received: from pholla1.c.googlers.com (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902680700b001e2b4f513e1sm7880850plk.106.2024.04.08.19.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 19:27:39 -0700 (PDT)
From: Pavan Holla <pholla@chromium.org>
Subject: [PATCH v4 0/2] usb: typec: Implement UCSI driver for ChromeOS
Date: Tue, 09 Apr 2024 02:27:35 +0000
Message-Id: <20240409-public-ucsi-h-v4-0-e770735222a2@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJenFGYC/33OQQ6CMBCF4auQrq1pS4HRlfcwLqAMMIlQ0kqjI
 dzdwsaEqMv/JfNlZubREXp2TmbmMJAnO8TQh4SZrhxa5FTHZkooLVKV8XGq7mT4ZDzxjqdoELU
 UeZkBizejw4aem3e9xe7IP6x7bXyQ6/pLCpILXpgCAQBrI8qL6ZztaeqP1rVsxYL6C6gIlHldy
 PyUQ1XJL0D6ASKxB9IINKABJZj4g9oBy7K8AeG1tVgvAQAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
 chrome-platform@lists.linux.dev, Pavan Holla <pholla@chromium.org>
X-Mailer: b4 0.12.4

This series implements a UCSI ChromeOS EC transport driver.
The ChromeOS EC is expected to implement a UCSI PPM.

Signed-off-by: Pavan Holla <pholla@chromium.org>
---
Changes in v4:
- Setup notifications before calling ucsi_register.
- Cancel work before destroying driver data.
- Link to v3: https://lore.kernel.org/r/20240403-public-ucsi-h-v3-0-f848e18c8ed2@chromium.org

Changes in v3:
- Moved driver from platform/chrome to usb/typec/ucsi.
- Used id_table instead of MODULE_ALIAS.
- Split EC header changes into seperate commit.
- Fixes from additional internal reviews and kernel bot warnings.
- Link to v2: https://lore.kernel.org/r/20240325-public-ucsi-h-v2-0-a6d716968bb1@chromium.org

Changes in v2:
- No code or commit message changes.
- Added drivers/platform/chrome maintainers for review.
- Link to v1: https://lore.kernel.org/r/20240325-public-ucsi-h-v1-0-7c7e888edc0a@chromium.org

---
Pavan Holla (2):
      platform/chrome: Update ChromeOS EC header for UCSI
      usb: typec: ucsi: Implement ChromeOS UCSI driver

 drivers/usb/typec/ucsi/Kconfig                 |  13 ++
 drivers/usb/typec/ucsi/Makefile                |   1 +
 drivers/usb/typec/ucsi/cros_ec_ucsi.c          | 259 +++++++++++++++++++++++++
 include/linux/platform_data/cros_ec_commands.h |  20 ++
 4 files changed, 293 insertions(+)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240325-public-ucsi-h-3ecee4106a58

Best regards,
-- 
Pavan Holla <pholla@chromium.org>


