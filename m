Return-Path: <linux-kernel+bounces-123502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C09989099A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B33B21343
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA4F13957D;
	Thu, 28 Mar 2024 19:49:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A599213791B;
	Thu, 28 Mar 2024 19:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655387; cv=none; b=VbIVfPRlWP3/6hjZ57bVROrSqUVFefFUC+iUO8Bqo5lrTIg5AI25dPsNccF65MqMji79z0w24eZaYjKB0+NQJs4SJZCr5GvtNUZJNfV7tFcbQZqAUFPdpnEtEuFOnvMuR+x2vfdRaEqQJpJ5xnwXf4lKFOaWglGdEaEAKotiT7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655387; c=relaxed/simple;
	bh=et/eoJGMNd0vTCToaQQh73zn2b3liW18d35E1eXVzIk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eAwcAhtMOQgxKe6FwUC0EGlBs7aMswXDVRNPhntbn5kpZRjFo1Zp/gnd/npA1o4nmUs3o8OzURIakuHBvltyL/pxANOqjS8bYoaTpUx0N7YEIfHH6W2fX5gwwlVbliiXAjVh7YB0mNi5s290U8vqBPChSMZ9sMorUYPjrFGmRpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB1AC433F1;
	Thu, 28 Mar 2024 19:49:36 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 00/19] ACPI: store owner from modules with
 acpi_bus_register_driver()
Date: Thu, 28 Mar 2024 20:49:10 +0100
Message-Id: <20240328-b4-module-owner-acpi-v2-0-1e5552c2c69f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALbJBWYC/4WNQQ6CMBBFr2Jm7Rg6lCCuvIdhUekIk2BLpooaw
 t2tXMDle8l/f4HEKpzgtFtAeZYkMWSg/Q66wYWeUXxmoIJsUVKNV4v36J8jY3wFVnTdJOhtY4+
 uISorA3k6Kd/kvWUvbeZB0iPqZ3uZzc/+Cc4GC6ypImsceSJ7HiU4jYeoPbTrun4BbVkVX7kAA
 AA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Matan Ziv-Av <matan@svgalib.org>, Mattia Dongili <malattia@linux.it>, 
 Azael Avalos <coproscefalo@gmail.com>, Ajay Kaher <akaher@vmware.com>, 
 Alexey Makhalov <amakhalov@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
 Richard Cochran <richardcochran@gmail.com>, Theodore Ts'o <tytso@mit.edu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-input@vger.kernel.org, 
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
 platform-driver-x86@vger.kernel.org, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2945;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=et/eoJGMNd0vTCToaQQh73zn2b3liW18d35E1eXVzIk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBcm7x2hj3d2zpvyvF4vA8mg4yC8+etkmYT4Zh
 G2dLDASeKiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXJuwAKCRDBN2bmhouD
 192SD/9qGoLgtpw8rsrC7Gf28HEEVE/zgzMqcA3xgUIfiuauaMcmktjDhwOqNJZjlTQGcylgOF1
 2ABvh4Y1pF5pg5Q/P1/rnUy8IAPyQoiwGFDNDjuaIwhc1XsECyvb9yB7f9NIPLpeY6JN/EJCUzp
 NYvUgUWloxv/gOYyuvjOqlnJn69xA/xXbxsCL8lk0ASIWSi0dKum4qK9Bo8rcPGsavex7FlEcG6
 lfuoxgXuvihD3OjX2xNZGsK95HeuBDfpDqBqnCbwieBGxyxQNM8ErmQYvs6dPBaOQk7PhWqq78w
 dzJsV/yK+CueaRMlBAR9muLkRAsdsWvTYoc2vOsrYPx+F8h2EY/oZ2bryjy/JEFrUdmEyb5c1T6
 S/nbk8DAnv3BA2tvx0qLSJBR7MxyLTe4G522wl0LBfs1EWJIpZ1NDkerw7+9z7/UdPnLImOY0Nl
 1YrRE8e6es3Rx73sn2Rvf2Y6o+lZ/2v1Yab2VGCn4lNnMzASzZoo8JX9aD5YW7PaJa0V83GDQyB
 641cgZkmWwRKGqRezsA3XTKqsasx3E7NLScZYBGPCZ6T5ULfkjxQNb12ljg3cIFoX7QnkvpC52i
 ZCR6YHWnapkZigARXwuXYUE+WHJdDHplmp2GMGKc8cyHw71w0E7fhWpRp9w07ANiRDMNlU+yseu
 7M5z6W9r0zaaMfQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Changes in v2:
- Correct input and platform/chrome subjects.
- Add acks.
- Link to v1: https://lore.kernel.org/r/20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org

Merging
=======
All further patches depend on the first amba patch, therefore one way is
to ack and take it via one tree, e.g. ACPI.

Description
===========
Modules registering driver with acpi_bus_register_driver() often forget to
set .owner field.

Solve the problem by moving this task away from the drivers to the core
amba bus code, just like we did for platform_driver in commit
9447057eaff8 ("platform_device: use a macro instead of
platform_driver_register").

Best regards,
Krzysztof

---
Krzysztof Kozlowski (19):
      ACPI: store owner from modules with acpi_bus_register_driver()
      Input: atlas - drop owner assignment
      net: fjes: drop owner assignment
      platform/chrome: wilco_ec: drop owner assignment
      platform: asus-laptop: drop owner assignment
      platform: classmate-laptop: drop owner assignment
      platform/x86/dell: drop owner assignment
      platform/x86/eeepc: drop owner assignment
      platform/x86/intel/rst: drop owner assignment
      platform/x86/intel/smartconnect: drop owner assignment
      platform/x86/lg-laptop: drop owner assignment
      platform/x86/sony-laptop: drop owner assignment
      platform/x86/toshiba_acpi: drop owner assignment
      platform/x86/toshiba_bluetooth: drop owner assignment
      platform/x86/toshiba_haps: drop owner assignment
      platform/x86/wireless-hotkey: drop owner assignment
      ptp: vmw: drop owner assignment
      virt: vmgenid: drop owner assignment
      ACPI: drop redundant owner from acpi_driver

 drivers/acpi/bus.c                        | 9 +++++----
 drivers/input/misc/atlas_btns.c           | 1 -
 drivers/net/fjes/fjes_main.c              | 1 -
 drivers/platform/chrome/wilco_ec/event.c  | 1 -
 drivers/platform/x86/asus-laptop.c        | 1 -
 drivers/platform/x86/classmate-laptop.c   | 5 -----
 drivers/platform/x86/dell/dell-rbtn.c     | 1 -
 drivers/platform/x86/eeepc-laptop.c       | 1 -
 drivers/platform/x86/intel/rst.c          | 1 -
 drivers/platform/x86/intel/smartconnect.c | 1 -
 drivers/platform/x86/lg-laptop.c          | 1 -
 drivers/platform/x86/sony-laptop.c        | 2 --
 drivers/platform/x86/toshiba_acpi.c       | 1 -
 drivers/platform/x86/toshiba_bluetooth.c  | 1 -
 drivers/platform/x86/toshiba_haps.c       | 1 -
 drivers/platform/x86/wireless-hotkey.c    | 1 -
 drivers/ptp/ptp_vmw.c                     | 1 -
 drivers/virt/vmgenid.c                    | 1 -
 include/acpi/acpi_bus.h                   | 8 ++++++--
 19 files changed, 11 insertions(+), 28 deletions(-)
---
base-commit: 02e345c7445b96358707ee2e5ca1dfc9b3458d39
change-id: 20240327-b4-module-owner-acpi-d4948a922351

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


