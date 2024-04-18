Return-Path: <linux-kernel+bounces-149684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A29D8A9482
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD2BAB22696
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34E5762DA;
	Thu, 18 Apr 2024 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UfCWYajQ"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC85B41A8F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427207; cv=none; b=aoNsjtuqjdiLHMASEtvL9fJ0WKMQYKik91+gyQsd/gWTcG44SURhMnyTJaF1eVinPGgY+RJ9Mgx+50ycSwb9OImamL4BIPsDVTdeGJ0aursbgn/m6uwIPoZsUSEJRTVtlbd1nzjheNubVjuFyyMk0AaXu5Dc283zPMG6BMMKhJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427207; c=relaxed/simple;
	bh=4YnNYGgVOhX9XUOB8UHSWyvalI0+TtY35J+ckM/ljv4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fOZgbBThDrA0Uo+1fkyXeyK+UZQ5SdHlrlpAIWjSDp1J1uEFs52DK5JcEs14f6CwFyvk7D7E/16FNoGapuZrR0hHgUDsH4cDDtTQVWCBtgfL+iqdR8nJLTGuv+M5ywgn+0i7FPErCFI9pmpLIyeoMFEzdyr77rB2RaiTK0YWbbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UfCWYajQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e424bd30fbso5246405ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713427205; x=1714032005; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XrGSZ4gIHI++Gh6B5QRi9SlQW6fGKWlC41/w97ih1MY=;
        b=UfCWYajQzdGIL9Mc0+wJmYAhgqYBk/+1PJencdaXAd73+ZZwBy8z0K4bNv/FXX2XBz
         Rbp1Feqw9BP9PJx+XTgmQBPpatDF59QjjvSWOmHCDtsya8wQzS+OYRf4Ovw4HlTqjBE/
         qYRoStLQplngZyhzgwtQGOSlsABZTtTe2vlGWWGLiP6pekc9Zm6y6ZGLFGLbg0Y+Ct3t
         N31mP2p65f8DbycXBfbGgL2dD0dMoTHXpaPru7Sqc5QHS7Me11zjzdkZZZyCtcK3WHNI
         h9VEM69RMs6Re8W3ASIcH8ZbjXsjgB6ZdLo3CiHDf1rmH7VXDloNZ9S+coWN3bkLLlLb
         JGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713427205; x=1714032005;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrGSZ4gIHI++Gh6B5QRi9SlQW6fGKWlC41/w97ih1MY=;
        b=ulTtsFMhZRXMy7RnlSGqHYdhKqsnce49kXlBHSp5Ag1LV4xLOuiWZu+6+gDey8SZv5
         oErn9SrehXa3MmDsKofY2qFk0pk0bob8nTz6UPG++BqPptNa/osulIfaElXttvmGOM0G
         7dRvGzzFITu6tcgYXT7QRu0yjWK9DHdTeU1UajSrFid8AHQpoHlk1nt98XI50Htq7V7p
         mVvIf/95MmX8qWon3wEzI2rZBSaDJO/gUx9dg3yWZXYHHSyRuWWe3W2cXlZX1ujTKTVl
         3/Pn5jeCXjvLdknGl6WUOm5BTtZC24gDUNP/hQjGYGIbPzhkga7KMPtTge4XPAUzWgub
         oQ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfDr2m3l3D2ReEFS5zYWR8T1hpeFd2PjjUxStnov0gODzu/9N/x0WLAJ/yXcuY3UYdKM/ZxplXuD4prBA85bW5oMb303g5Fh4uxnbo
X-Gm-Message-State: AOJu0YyHAz49XgSG2BEQ5S6YqkMqH039pQGAF+/0e4NRHnmRAVdg58jq
	L986+GXJbzUYYCsvR2OOo/9TaoUuf8q+sEIC6uc0J7KM29aDGyH40Vefp8ZNfkKBMyJn/Tz2W+o
	=
X-Google-Smtp-Source: AGHT+IGxGAJBI8PL5TlTgHXNWuERrnZ4u8IUAqfdFizOq/kSWBGL4deE48MPZ6GRT2DcxtqkSlOR8Q==
X-Received: by 2002:a17:902:8696:b0:1e2:9676:c326 with SMTP id g22-20020a170902869600b001e29676c326mr2283826plo.29.1713427204644;
        Thu, 18 Apr 2024 01:00:04 -0700 (PDT)
Received: from [127.0.1.1] ([120.56.197.253])
        by smtp.gmail.com with ESMTPSA id lo8-20020a170903434800b001e546a10c50sm889956plb.286.2024.04.18.01.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 01:00:04 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/2] PCI: endpoint: pci-epf-test: Cleanup the usage of
 'pci_epf_test::epc_features'
Date: Thu, 18 Apr 2024 13:29:57 +0530
Message-Id: <20240418-pci-epf-test-fix-v2-0-eacd54831444@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP3SIGYC/32NTQ6CMBBGr0Jm7ZjOiD+w8h6GRYUpTGJo05JGQ
 7i7lQO4fC/53rdCkqiSoK1WiJI1qZ8L8KGCfrLzKKhDYWDDtanpiqFXlOBwkbSg0zcym8YK81N
 uBsosRCl6Tz66wpOmxcfP/pDpZ//EMiHh5XzqG6KBnLX3l842+qOPI3Tbtn0BObFJMrEAAAA=
To: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Niklas Cassel <cassel@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=4YnNYGgVOhX9XUOB8UHSWyvalI0+TtY35J+ckM/ljv4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmINMAAuepBRZH3MDyeWzVacCxqwMoBBoAI59JH
 os8gWAWsL2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZiDTAAAKCRBVnxHm/pHO
 9eQUB/4z7UZoNHoGOFY3lX20++2OMe2rnar7Cs2z5Rxper88059mfXzIun4k3Ti1SHg5b26JD4w
 KlwXTz1Ju2M4LVfEklgQw9zzACauOoqoo6h/jCJ4AYA9VTndIo4p3yfhFQXYGxVavSrBiLaBqq+
 8QCCmIl/Z1ySa+04nfxAyfYFR6ALC4REMENi3RN0joRKKGENrSSsC1DpWd8LLw7ywwrzUFvfRm6
 a21HT3v+E74zzVHJmgDLVrM5Ux02/huIkqi9yo7ZwDbyACKnNg5zcCZBbaB0Z5s41tX7/5L3x09
 VHa+CkjM2jkfl5bGSel0/TceiguWuSGyxM8BmMGZWeXPBl9D
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Hello,

This series cleans up the usage of PCI EPC features in the pci-epf-test driver.
First patch fixes a smatch warning reported by Dan Carpenter and second one is a
cleanup suggested by Niklas.

- Mani

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v2:
- Modified the patch 1/1 as per comments and added Fixes tag
- Added a new patch 2/2 to cleanup one more instance of 'epc_features'
- Link to v1: https://lore.kernel.org/r/20240417-pci-epf-test-fix-v1-1-653c911d1faa@linaro.org

---
Manivannan Sadhasivam (2):
      PCI: endpoint: pci-epf-test: Make use of cached 'epc_features' in pci_epf_test_core_init()
      PCI: endpoint: pci-epf-test: Use 'msix_capable' flag directly in pci_epf_test_alloc_space()

 drivers/pci/endpoint/functions/pci-epf-test.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)
---
base-commit: 6e47dcb2ca223211c43c37497836cd9666c70674
change-id: 20240417-pci-epf-test-fix-2209ae22be80

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


