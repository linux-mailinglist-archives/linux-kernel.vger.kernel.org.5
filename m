Return-Path: <linux-kernel+bounces-59003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C9B84EFBB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B7FB20BC9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789BD56B84;
	Fri,  9 Feb 2024 05:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2C58QM5"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E6A56B6F;
	Fri,  9 Feb 2024 05:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707455059; cv=none; b=g/S1iCjTqmkRKDxVj8PBSz5GwEbSnCVtgeMKLNjfCgprvP4v6qFWgcmVP6+2kVGqKV4LEaX3ROrHAe0eIpgEWYjc340KF0WPqAU17f3zMg5rxiEOU0tEQ24/W4nJh3dYf+tjSKaecUeqolHcVyJwRctnw0PMoOKindl0yAAZPp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707455059; c=relaxed/simple;
	bh=iYwn5QLJdVB+ghgEBg3i1c/g2ed20+S9+3wBs7CVqYg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EX8Q1SKP+37qPju8eL/fViTkpv08q55gPeLWbIaWmYHlkKFyowmEa6S6bH3eW35y5EKdoweGMUlvmD0iB0RVfVxCfqo1QZgtzFDV7KfVgBCfadVfXrrZbZylqESiU7EkALrsgrTLu3iLhj+XGh3LGrRBiLZdqpEYkAh5dQjpjZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2C58QM5; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e2af0bc0dbso314422a34.3;
        Thu, 08 Feb 2024 21:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707455057; x=1708059857; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/TkQWLhW/D4MixjGad1sChqtl8eoiZM//YipfEBx+7U=;
        b=S2C58QM5GvZIKWh4yEcBRTml2IvaKRsDMpA/AYZigI1r8LPbpek6Tr2E0ebk1MN7Hg
         bP3sq6syWHMpoo2TwmeGayESDRcsEEgAT7tMUnQKg3HxJJf0vbrwaByHDHIbZ5yfLoG2
         waRjlxt+nrCbzhWIRkR2e281C2LHtsWi9abld1L/6y9lT2GLCwY4Vvdsdq6/Q1mUFA4T
         6Z/hQkauSuncbVh5fluT0tVwMhKYH4HR1o+/vf+/KJM2Eiuo8paAzLQnsnyNA9QTMer0
         Yz9CPpUJfU0uXlFMXHLk6nPSS0D/Ipnb3ZuvOByvZPf99OTDW+I9YWu4Qzvvop0rO5uU
         nmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707455057; x=1708059857;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/TkQWLhW/D4MixjGad1sChqtl8eoiZM//YipfEBx+7U=;
        b=ihrbq0Sr8PHorza1L+eW5AjdcDMvCw71b1SIBq6b+DCCw2LGbv6pxvzSXMcMKAV+NP
         PW2KOdsoTjyXHAzFG+5D3vNbti2Bq4pg16FV3PAa4PIpr0L7M1FPJ7uPLfaOKXCUSoR5
         F125ZCC3wJVJa8Kkttmws3MJd/0PwC/RuUS1OKcPxciFCCtlJEZmht3Oc+Te5nEBEhaq
         ynxhBTWP9gcGtOPbekadWDqZBB2nyiqpcQHbEUoFSAOnv7f/6E4LFh3TO7kSjFWyRYh4
         PWKbojd2HZ+mB5zjb0maSKh4RBRwJruU0MBVtlPT4aUazasb4z2pfoT7JVH6dRzhqNBs
         /WNg==
X-Gm-Message-State: AOJu0YwldlV8F8SFZIGDqwA/N3Ai5mHzPWMstCdqprBSfmz/Rj6K2joY
	q7SSItmgIfXH6iR/YQgp8Zfvu0zKcJdHAse6elLWz1xEMynljaaT
X-Google-Smtp-Source: AGHT+IFtJYtZ226MUhhY3PMPbO73jKSYnFBzJAlDbPj7zjBIB1snR7AQFqUi86pGj2ahVfMAaGlAwQ==
X-Received: by 2002:a9d:76c8:0:b0:6e2:b25a:2249 with SMTP id p8-20020a9d76c8000000b006e2b25a2249mr442370otl.24.1707455056651;
        Thu, 08 Feb 2024 21:04:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7ENsB0oSICA33FAVb2VzC1UevEUKbfbzlb53+8ZGtbr3qqf83r+nbh3fbXRuTLqQZje2q0M4rS6u6GAGLhohmhoGkbu14vj5FY9df12K2yM8cQ+AbT7ddMFtMkM5UWHMP/5basxZnakOG3GyLDfjXrHhGnPGKcbJbqIU0UWqanuhPgy3BZsbIPcnxyvia731LLygwXIPetYPSGJ4u+quHB2QdwT876LvfBzg31+QBIXb6OulJ8izOQ03DrdCC/rnMLicY+OsREBFBh1E6A581xCK/Qeke/6Z4YcCc9xSs2LrikpRgOxi/xVzKhg0IB/gE9S+AjQSnIO/CBUafTg6GdLm5Pu3uwAXpV4WEZYnMmJnQOuMg3ZUIAz0LVyx/1BCYe2jiMBHDfgCulZ/zwzJ4/O2H
Received: from tresc054937.tre-sc.gov.br ([2804:3b0:4104:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id d1-20020a634f01000000b005cda7a1d72dsm793616pgb.74.2024.02.08.21.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 21:04:15 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next v6 00/11] net: dsa: realtek: variants to drivers,
 interfaces to a common module
Date: Fri, 09 Feb 2024 02:03:36 -0300
Message-Id: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACiyxWUC/2XOQQ6CMBAF0KuQrh3SFijgynsYYmoZoBGKaQtBC
 Xe34obE5c/Mf/krcWg1OnKOVmJx1k6PJgRxiojqpGkRdB0y4ZSnlPEcLMre4+MWntE6BHYXlLO
 0pKrISGg9LTZ62cUrMejB4OJJFS6NHQfwXQCOYsJZJqiIuciZAAb9pN/9pOSlHaTuYzUOX7XTz
 o/2tc+cs93+9RP6t2jOgAIq2dQlLxJJ8wNVbdv2Ae3i0jP0AAAA
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6849; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=iYwn5QLJdVB+ghgEBg3i1c/g2ed20+S9+3wBs7CVqYg=;
 b=owGbwMvMwMG4W/D2rovs1mGMp9WSGFKPbjLOuFjbq7ri0btCdnW59Iudct8+CP2w5BLxmh4p8
 7ZS7q96J6MxCwMjB4OsmCKLILuGe+vZaCuhX/o/YAaxMoFMYeDiFICJ5Nqy/zP83CCh2l1f7TLj
 RpD3nkjhzzMb86q/1m7MmfRO2na7K8OqhFeuXTPz3qixeU1UNNd4+uD24yUhibyXIl4+4CxmzdA
 JE70wm8PvcwbjpXgb2YhvL8pcbN8eZ9wz8b+jbJfRuT6pa9rLSheFmefE9JqbHtVRDC6ssmNLnp
 HYLfLsEV/zs6cl01Lzirm9nJWKnbnDVzM/Ern55eXhdzdyr+S9WdU9U24Cc/HU55zXdp6x8rm/+
 q3dNr/9atHeTWVK7Vt74np2BH8SXbPftinX+dBzjoSqVwdU+TxkjCct/ZHtbH0m1/QcA5NjvXLE
 OYv0T7rH1V7M4nDsUfWSE1TfqmPu+6vyS1p7JgfrlqMA
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

The current driver consists of two interface modules (SMI and MDIO) and
two family/variant modules (RTL8365MB and RTL8366RB). The SMI and MDIO
modules serve as the platform and MDIO drivers, respectively, calling
functions from the variant modules. In this setup, one interface module
can be loaded independently of the other, but both variants must be
loaded (if not disabled at build time) for any type of interface. This
approach doesn't scale well, especially with the addition of more switch
variants (e.g., RTL8366B), leading to loaded but unused modules.
Additionally, this also seems upside down, as the specific driver code
normally depends on the more generic functions and not the other way
around.

Each variant module was converted into real drivers, serving as both a
platform driver (for switches connected using the SMI interface) and an
MDIO driver (for MDIO-connected switches). The relationship between the
variant and interface modules is reversed, with the variant module now
calling both interface functions (if not disabled at build time). While
in most devices only one interface is likely used, the interface code is
significantly smaller than a variant module, consuming fewer resources
than the previous code. With variant modules now functioning as real
drivers, compatible strings are published only in a single variant
module, preventing conflicts.

The patch series introduces a new common module for functions shared by
both variants. This module also absorbs the two previous interface
modules, as they would always be loaded anyway.

The series relocates the user MII driver from realtek-smi to rtl83xx. It
is now used by MDIO-connected switches instead of the generic DSA
driver. There's a change in how this driver locates the MDIO node. It
now only searches for a child node named "mdio".

The dsa_switch in realtek_priv->ds is now embedded in the struct. It is
always in use and avoids dynamic memory allocation.

Testing has been performed with an RTL8367S (rtl8365mb) using MDIO
interface and an RTL8366RB (rtl8366) with SMI interface.

Luiz

---

Changes in v2:
- Renamed realtek_common module to realtek-dsa.
- Removed the warning when the MDIO node is not named "mdio."
- ds->user_mii_bus is only assigned if all user ports do not have a
  phy-handle.
- of_node_put is now back to the driver remove method.
- Renamed realtek_common_probe_{pre,post} to
  realtek_common_{probe,register_switch}.
- Added some comments for realtek_common_{probe,register_switch}.
- Using dev_err_probe whenever possible.
- Embedded priv->ds into realtek_priv, removing its dynamic
  allocation.
- Fixed realtek-common.h macros.
- Save and check the return value in functions, even when it is the
  last one.
- Added the #if expression as a comment to #else and #endif in header
  files.
- Unregister the platform and the MDIO driver in the reverse order
  they are registered.
- Unregister the first driver if the second one failed to register.
- Added the revert patch for "net: dsa: OF-ware slave_mii_bus."
- Link to v1: https://lore.kernel.org/r/20231208045054.27966-1-luizluca@gmail.com

Changes in v3:
- Look for the MDIO bus searching for a child node named "mdio" instead
  of the compatible string.
- Removed the check for a phy-handle in ports. ds->user_mii_bus will
  not be used anymore.
- Dropped comments for realtek_common_{probe,register_switch}.
- Fixed a compile error in "net: dsa: OF-ware slave_mii_bus".
- Used the wrapper realtek_smi_driver_register instead of
  platform_driver_register.
- Link to v2: https://lore.kernel.org/r/20231220042632.26825-1-luizluca@gmail.com/

Changes in v4:
- Changed Makefile to use ifdef instead of dynamic variable names.
- Added comments for all exported symbols.
- Migrated exported symbols to REALTEK_DSA namespace.
- renamed realtek_common to rtl83xx.
- put the mdio node just after registration and not in driver remove.
- rtl83xx_probe now receives a struct with regmap read/write functions
  and build regmap_config dynamically.
- pulled into a new patch the realtek_priv change from "common
  realtek-dsa module".
- pulled into a new patch the user_mii_bus setup changes from "migrate
  user_mii_bus setup to realtek-dsa".
- removed the revert "net: dsa: OF-ware slave_mii_bus" patch from the
  series.
- Link to v3: https://lore.kernel.org/r/20231223005253.17891-1-luizluca@gmail.com/

Changes in v5:
- Removed empty line at the end of files
- Multiple kdoc fixes
- added rtl83xx_unregister_switch and rtl83xx_shutdown
- moved include <linux/regmap.h> from rtl83xx.h to rtl83xx.c
- moved dev_set_drvdata to the end of rtl83xx_probe()
- changed mii_user bus is name to devicename(switch):user_mii
- Link to v4: https://lore.kernel.org/all/20240123215606.26716-1-luizluca@gmail.com/

Changes in v6:
- Renamed realtek-dsa to realtek_dsa to match loaded module name
- More kdocs fixes
- Calls rtl83xx_remove on error after a successful rtl83xx_probe
- Use struct dsa_switch *ds instead of priv->ds
- Link to v5: https://lore.kernel.org/r/20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com

---
Luiz Angelo Daros de Luca (11):
      net: dsa: realtek: drop cleanup from realtek_ops
      net: dsa: realtek: introduce REALTEK_DSA namespace
      net: dsa: realtek: convert variants into real drivers
      net: dsa: realtek: keep variant reference in realtek_priv
      net: dsa: realtek: common rtl83xx module
      net: dsa: realtek: merge rtl83xx and interface modules into realtek_dsa
      net: dsa: realtek: get internal MDIO node by name
      net: dsa: realtek: clean user_mii_bus setup
      net: dsa: realtek: migrate user_mii_bus setup to realtek_dsa
      net: dsa: realtek: use the same mii bus driver for both interfaces
      net: dsa: realtek: embed dsa_switch into realtek_priv

 drivers/net/dsa/realtek/Kconfig        |  20 +--
 drivers/net/dsa/realtek/Makefile       |  13 +-
 drivers/net/dsa/realtek/realtek-mdio.c | 205 ++++++----------------
 drivers/net/dsa/realtek/realtek-mdio.h |  48 ++++++
 drivers/net/dsa/realtek/realtek-smi.c  | 279 +++++++-----------------------
 drivers/net/dsa/realtek/realtek-smi.h  |  48 ++++++
 drivers/net/dsa/realtek/realtek.h      |  12 +-
 drivers/net/dsa/realtek/rtl8365mb.c    | 128 ++++++++------
 drivers/net/dsa/realtek/rtl8366-core.c |  22 +--
 drivers/net/dsa/realtek/rtl8366rb.c    | 119 +++++++------
 drivers/net/dsa/realtek/rtl83xx.c      | 303 +++++++++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h      |  22 +++
 12 files changed, 705 insertions(+), 514 deletions(-)
---
base-commit: 2121c43f88f593eea51d483bedd638cb0623c7e2
change-id: 20240127-realtek_reverse-1b6021490c85

Best regards,
-- 
Luiz Angelo Daros de Luca <luizluca@gmail.com>


