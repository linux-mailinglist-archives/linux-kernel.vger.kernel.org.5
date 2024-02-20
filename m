Return-Path: <linux-kernel+bounces-73253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F22B85C015
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D061C21C23
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1C9762C0;
	Tue, 20 Feb 2024 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWWHTzqx"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9211D7603D;
	Tue, 20 Feb 2024 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443361; cv=none; b=OpWM+o9UzeXwCOoocBM0uFtaYrwHa2oZzIG5PiICX6Z53yJB0tQztsiZGoFxLu8903XfkjhcLpI3hX2yuHw6uyfzTZJW7JC8psw6KR0NmF1EpQHCwfU17WJtae5FbPN2Dhwk4G29sZT52LZYEMx2ihaUR6kCbBj95OGj4Sd1gr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443361; c=relaxed/simple;
	bh=Po5utv3fA/luMbcWwBO4VwP9A8cuznOrLBVfb0lAcNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pn2O9gWSlOwiynQXgITa9sSj+/Nb4qHXsZnCQLZHG/toF8XgOq0Tc78PhTOhU32NwHs4QhOFFHE6Pv/RDfetA8EckiLMu+rcd0uB9YRfDh0im8XvHkB0CRLmDmeB9/Lz0+G+tPQEK9a6Kks/OrR2KmcGdgUnuchMRCZM8c3yWCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWWHTzqx; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3f1bf03722so43488666b.1;
        Tue, 20 Feb 2024 07:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708443358; x=1709048158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jZEnw7vNP6fBmQ9T0aAwTaPsoq+/YHVzJE/SsdyjyGA=;
        b=MWWHTzqxIAYlHnwsqXoGjxKqfP+ItKAJkpwW+7ffWsKYaGMXgfsaJlq5uNLgX/0eh6
         /T90Br3fj+HhCbEeUJMcp1CHHsWpYxdqAhu39o11LrslYaqQ6PRK8xoOBCrP3sAuGjkW
         hwEtT2ATWqWFx5ZNNfkHzzyKMkLF5AXZmQyaoe7t9zZY7ums+iRDj61N55iVg3ImcKhE
         TntCLK9BiY2gUp8sYR107FEDad5q6PWwEbpkFdnNPJ6zFqoEa+40mVj6Kday3/JXJOmz
         nFQy35AYQiXtkg02iR8elBCYzrYVXKZiBz/4Dh2MsBYNZIpMHmST1EoU0shp7Qbr+NLH
         vjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443358; x=1709048158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZEnw7vNP6fBmQ9T0aAwTaPsoq+/YHVzJE/SsdyjyGA=;
        b=oT7oxzthakQTLPzVVHSaJ8eAecDCKjJ9QURmQRNPuGI7kzK306jsen2FPkIEWM+oLy
         pYftKbO+iutEz2IZ7HFPzF1KyINjrBMb6WhZxQMkLlY7bpXVlLhUGnfykWPrdf98EvtF
         UzZ4Cqv1+qJIMyuji488gmcIZwwwlQFmt5aQ0JiKJqGToqoDmQVOhTEaF1kNbBEdEpHZ
         0u/HdPBfesMMCTaiI1MxnjSZrURcLUWIRHStycDYrCACL9JwGq1T4gtcwd3zvcjGmarW
         N5BgubB+mJY08wJDF6n6nADfkwNiAYCnv7+9kE2WSs8cZHfHmZUsnjq7BYXd+x3H1c3t
         mRyg==
X-Forwarded-Encrypted: i=1; AJvYcCXSGygfFMJ0YZn2etPwz6Qrm4b2xxynpn4r1O+Xgh4IE+/VfDyU5aYOkj/lO3MC0IqP+6QzxbQ7xTr5IHHAYF5dlx/qJx1gNp9JKM1urQ+7oUr2R/WZdjY61HiLsV/a7xCyxrWRRC2JqWJbCKFnxTpeRz2awegYRGsRwTyQb25DX5gVjg==
X-Gm-Message-State: AOJu0YxNU4BplY470VnlEPksMFWKAnR8XWRr+1bA57cdRvkGgrqJ7h/l
	hCu61b7jkmSUmJCUPOWT3Va9ZDg8GX/rhuj5S0FaBPnsqaKJJ9ib
X-Google-Smtp-Source: AGHT+IFxUmK1xZSXePm+guZXPJGQe4Tlm1Ulsa3heQ3mpM7aJXESFuiCzizx31MC4umz2QvpTOY62g==
X-Received: by 2002:a17:907:11c2:b0:a3e:88fb:3e23 with SMTP id va2-20020a17090711c200b00a3e88fb3e23mr4760515ejb.7.1708443357502;
        Tue, 20 Feb 2024 07:35:57 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id r22-20020a170906281600b00a3d777aa8fesm4039024ejc.69.2024.02.20.07.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:35:56 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v5 0/5] Add support for LTC6373
Date: Tue, 20 Feb 2024 17:34:48 +0200
Message-ID: <20240220153553.2432-1-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LTC6373 is a silicon, 3-bit Fully-Differential digital instrumentation
amplifier that supports the following programmable gains (Vout/Vin):
 G = 0.25, 0.5, 1, 2, 4, 8, 16 + Shutdown.
The programmable interface consists of 3 digitally controled inputs.

V4->V5
 Move converion logic:
 - Modify to use callbacks
 Use pointers in match table:
 - Drop enum type from state
 Driver:
 - Use DIV_ROUND_CLOSEST for conversion
 - Remove comma from ltc6373_ext_info[]
V3->V4
 - Fix git commit message typo and remove newline between tags
V2->V3
 - Use return instead of break in *_gain_dB_to_code()
 - Add new line before return in *_code_to_gain_dB()
 - Match parameter alignment for added _powerdown functions
 - Add precursor patch for using pointers in the match table
 - Add chip_info attributes: has_powerdown and powerdown_val
 - Change probe logic to use has_powerdown for default powerdown state
 - Added 'Fixes' tag to commit message of 'add conditional GPIO array...' 
V1->V2
 Driver:
 - Fix chip info table indent
 - Remove enable attribute
 - Add ext_info powerdown attribute
 - Enable by default powerdown attribute
 - Set default gain after disabling powerdown to min value
 Binding:
 - Fix conditional checking of GPIO array size for LTC6373
 - Add precursor commit for correctly checking gpio size depending upon compatible


Dumitru Ceclan (5):
  dt-bindings: iio: hmc425a: add conditional GPIO array size constraints
  dt-bindings: iio: hmc425a: add entry for LTC6373
  iio: amplifiers: hmc425a: move conversion logic
  iio: amplifiers: hmc425a: use pointers in match table
  iio: amplifiers: hmc425a: add support for LTC6373 Instrumentation
    Amplifier

 .../bindings/iio/amplifiers/adi,hmc425a.yaml  |  47 ++-
 drivers/iio/amplifiers/hmc425a.c              | 273 ++++++++++++++----
 2 files changed, 259 insertions(+), 61 deletions(-)

-- 
2.42.0


