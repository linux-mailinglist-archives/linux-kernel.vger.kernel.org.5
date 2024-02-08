Return-Path: <linux-kernel+bounces-58449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8726584E6A0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA191C24D50
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8069D7EF16;
	Thu,  8 Feb 2024 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jI95zpbI"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEF47EF19;
	Thu,  8 Feb 2024 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413119; cv=none; b=BYAFBm+yDZnqGEriVlX2zZwO7KHD1lzIagd5yGhbaV3zcs1ZF4vM91QJ04WYygXMOV+InAp5n9+/bYxfFZSYSctIHUecbotf6vsfcnpGun8WC2+YNcUXtBRGHJo0rDz/hrDJ7VuBSuk7BaryoJ+qFXLPwMqgDoNYMN8FJtyCl4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413119; c=relaxed/simple;
	bh=hq4ku4vt1XeKlMRyCUa/KiDao0mlnt+hFYOaYzFxPdY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sPNMt53opEHOhEPN2Si1osDNOYovQ6cJymU997P3+VQMKolQgICdie8Zt0+3Gf2ListLONUO/0cHuEMtuyGBvkxBSjKjWcVsvDimCHE0/mA3RZJGo+Yqkvh4JxxmK8kklljdlnlBo08L8K0Ri1nLHEsm/Wood6LmNjaWLNwbHsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jI95zpbI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4105006bf11so654495e9.3;
        Thu, 08 Feb 2024 09:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707413116; x=1708017916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uN08IAla3/N8TjlJJkn0QlgypV3q8u6aGyf2X9ykCwg=;
        b=jI95zpbIB5qTyRWGsqLd3V9YHjaku2r0ZOe+S37amNG3/1xQVdLV1X8V9basiogVlg
         b4FQk7L80SU6tGRZ63Ml5UxswOrb26YV1CJz2cj9m8bopZCXIsg/7K1USdbpKOHDdE8s
         XMwGmqLSDvOyu+ZJ7fQ9fG3hUNbrQAJ5DhN8KQbjE9PDr4yBq4IhFUcC9hU9gpNHWjqE
         i5+Aru3VznawFFIAqbOKOFGQjJ11atx/QwRyFDn6B9SSpcUt6zsHijwdk03UDer4is6R
         lgUVhl/sFMpkGc973do1T8RXQx6tc+rAAiqKS84fh+bLRI1x9lV8qtQYnJuLkq8blig4
         OFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707413116; x=1708017916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uN08IAla3/N8TjlJJkn0QlgypV3q8u6aGyf2X9ykCwg=;
        b=gZ9+9ZCrEU+OwO2LNMzCx+2kg1DN46JqczqPQNXyb3fIus0mPhIfq6Nr1IGYd1NppK
         geA+UuNIqejyd9oOj82fahbh34a5H7DwSRza1bJcipq8sgmJnnxUx0UKcTvvGu/ZWnaC
         eRvKxzTUiBlseDSfRoRCSecP6YJWUR6jCBkWwtAV1jHmnKnzSFKmCQNcOzGH1twcX4PT
         c2CCPrdRdkZO0NW+ApvIAeqaiHi/5hkN0jss/4sTI6ZVhQwsiWUQMOA4q68EfxIUX5Iu
         PJT+0MwElIb90x8YzXbgTxQNquDrHp2PFZElT3rVj+Rqf0XA+uQVyOaJ/U/dY0ra+MBs
         aKCg==
X-Gm-Message-State: AOJu0Yw8VIt6PKHS4lJkCxl/e6Q1KQ09LJbBhOB76cMEkoe3R5yBld4x
	ncmPJTJeCIZDmy98nmfDWrZ42r/5LaPS09ObxXakYxF1xO+eoAfZ
X-Google-Smtp-Source: AGHT+IH9maMdm/drLZSZPWPMiIpW6dfGNTm5yS9rIUuDgcaNf72XHQKtZuDyl1QPz76zdFn7NVl1lg==
X-Received: by 2002:a05:600c:1e1d:b0:40f:f4b2:b26 with SMTP id ay29-20020a05600c1e1d00b0040ff4b20b26mr6406312wmb.25.1707413116179;
        Thu, 08 Feb 2024 09:25:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUrICMUJOG1BkiKRk1VgQOuejlq+GcUC7yLJ5gdEyG9AhtINf0KvigU2j2f5cGGiJD6f4u60YlOD7aP5J3z9vbOZltK+Ryhkd9UKPsuxZ9xScrWrBB1KKEHdWfmBpkEUr2wjKOC876XZ5ZGTO0YmJvlKK9KYPgY6GW0XWBbMdiC2kydL+v4Bi+OXbFCkAHeBafdr43wQyzVJnRcDzo75Ten20j43xLYlrzxxRGuPjrnCMeZfHg14eCfirTZw721p9huTCpnDGBR4N1b3p0D4wU8/tWHA46mSBZFg0dGz9gaS/cU2AQJyxFsu55pZm68zUvcm0EEfES4HjTU66JhXCAsJdQOVY6RrUgRAM7kKFDaBiRot1+5FGEnYS2+zOAIIp4498r+qIQSln16Jjp+p7exzlZH2z7iWJxvJ5TIdR7sPJ9Ykb4NO8eNqoUXiKQ9Zlpkfo1AaDbXLB71cB9y5pRGhyYVEhl95spswTEIf2/vQK3WbvBLHUY=
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b004101f27737asm2238214wmo.29.2024.02.08.09.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:25:15 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: 
Cc: alexandru.tachici@analog.com,
	alisa.roman@analog.com,
	alisadariana@gmail.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.hennerich@analog.com,
	robh+dt@kernel.org
Subject: [PATCH v3 0/5] iio: adc: ad7192: Add support for AD7194
Date: Thu,  8 Feb 2024 19:24:54 +0200
Message-Id: <20240208172459.280189-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear maintainers,

Thank you all for the feedback!

I am submitting the upgraded series of patches for the ad7192 driver.

Please consider applying in order.

Note that I dropped the patch related to the clock bindings. I will be
back with another series of patches related to the clock.

Thank you!

v2 -> v3
	- add precursor patch to simply functions to only pass
	  ad7192_state
	- add patch to replace custom attribute
	- bindings patch: correct use of allOf and some minor changes to
	  the ad7194 example
	- add ad7194 patch:
		- use "ad7192 and similar"
		- ad7194 no longer needs attribute group
		- use callback function in chip_info to parse channels
		- move struct ad7192_chip_info
		- change position of parse functions
	- drop clock bindings patch

v1 -> v2
	- new commit with missing documentation for properties
	- add constraint for channels in binding
	- correct pattern for channels
	- correct commit message by adding "()" to functions
	- use in_range
	- use preferred structure in Kconfig

Kind regards,

Alisa-Dariana Roman (5):
  iio: adc: ad7192: Use device api
  iio: adc: ad7192: Pass state directly
  iio: adc: ad7192: Use standard attribute
  dt-bindings: iio: adc: ad7192: Add AD7194 support
  iio: adc: ad7192: Add AD7194 support

 .../bindings/iio/adc/adi,ad7192.yaml          |  75 ++++++
 drivers/iio/adc/Kconfig                       |  11 +-
 drivers/iio/adc/ad7192.c                      | 252 +++++++++++++-----
 3 files changed, 269 insertions(+), 69 deletions(-)

-- 
2.34.1


