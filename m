Return-Path: <linux-kernel+bounces-81319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A572B867418
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C46528F685
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3995B1EE;
	Mon, 26 Feb 2024 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YqqM70wL"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2124F5A792
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948772; cv=none; b=XOH9zq/j4wlyJdZmI+oaUCa7gNcZe/dPYKvI6X/YzT8FxxGi4iD6LDhT/X6futKFl3oY83yqbQp06k7fpRUlhlHv/6zMkjTvvX8ttikcnaUSWLmnqUcSPw+2XxVyC5WKbLW5YnqcWgNF+JUPUQlH2EHYMzfiyPWhNJWUGcYRrTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948772; c=relaxed/simple;
	bh=1boF7Vn0lILkXSfRRTQEenr6/RP11nxQXsy3laGqUPs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KU3wz6X1T3oIHsFRMxYAGe2Ev+5BgNir0cntJrLAWthHtUvybzV9mPYzhT9GPAw+Ml+7xFQbcTSgqBT185X9QK+gfC9UXrAqslaxaotNDvhLwIwGHMvKhHBamOTgxeuTaDBVgJBd06gzb0zozFqqq8Ig3ZURk0kYlLYUtBFgynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YqqM70wL; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a36126ee41eso340011266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708948769; x=1709553569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6KSPDZCe1P34jJFcbH5CL7iIOfc7j2jHBH+bIt8aphM=;
        b=YqqM70wLqQMCPpbucp3zfmLlTUQsVB2zqYdApx9a3IgPd7/na9P1I6hpfb6fi0Ywc9
         MY+MKCTcrj9eFUjU2Ikr0aI8sPPRtFGj5j6IIPzTZf/GpQlIVI3ouWWyY8LHJdMOB08y
         hDGHdARwYHqNZVSZjt63x55D0jeSw6s6djdc/Ynkzy0ZRKle0vNtzQdc6KXaurHpHU0j
         pHPVoA7d8XiJzfmN6+KopJIZaKbOgU5kUKIYSJ2r37XmqejIt9hVNEp9KsxF+mhxjEPc
         G6/oTjayYNLDjsPz6bEbQrLkxq68Mx6puEwCvLNtH0nmHJXCV7Xs3ztYf39gNtjh/zrB
         3V/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708948769; x=1709553569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6KSPDZCe1P34jJFcbH5CL7iIOfc7j2jHBH+bIt8aphM=;
        b=ZABwLLc5VdKmWThg0uUPIuiAMTNmMkUgSctjtL1AeBqffWAkp4KySSfo081AYiTGTK
         pg/cKB47Vdx5Gnmwa2ATXVBJ5PDrKMt5kzFTJn6phA7lCWFbAEY1nkIhJkPC9ArsvxhM
         8CwAR/jZDfCIvA+QZeVb8mpaF1TJaZTWp+WZoxz3MMu0oTPN9XJAgOG2YXVRPRDCQ/z+
         lom5sCjJrbLDuG41X1D5QAMJ5snb4eOHAR2g+raa6Zp+ERE8+jXr++WZT+7t7CAIk64I
         DH3Ea+Oz/72bxCBWGN1t79+QWFK1gtzp5rVpM4P4DbiVBiCEPdleFUgXyZRm/ahJV4xI
         sXrA==
X-Forwarded-Encrypted: i=1; AJvYcCXvCBE1N9Leuf6H8lUump9KcDrcS26u+bt8QAUK/SYPHY6vRCsmYiW2UgrkkaQndVI+/YOtbX3xUyuxIveCUviCAHPGKMw1zC71Qmww
X-Gm-Message-State: AOJu0YznQ7yI1pMP9ZsM2YPlhHDFXY0OgwDfuMdKy6VrSW9v6RJAcE3A
	1/rFeLs7KjN3no/njtjHmxQDjHhTn2lA9plwVVxYlGkrlqVlF4Z+r4TR6ZaKzfGLV39Ja7YVl79
	B
X-Google-Smtp-Source: AGHT+IFelND3oLFeUPIHV8ueOBEgfQjbSnO9XqLBf3TC4C9FNh0p6bg9Pg6LmuPeWh2Pp5yHNlg1lg==
X-Received: by 2002:a17:906:b189:b0:a3f:268:a8f8 with SMTP id w9-20020a170906b18900b00a3f0268a8f8mr4417682ejy.71.1708948769463;
        Mon, 26 Feb 2024 03:59:29 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id tb16-20020a1709078b9000b00a42ea030a6esm2311877ejc.82.2024.02.26.03.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:59:28 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 0/2] ASoC: codecs: tx-macro: correct TX SMIC MUXn widgets on SM8350+
Date: Mon, 26 Feb 2024 12:59:23 +0100
Message-Id: <20240226115925.53953-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changelog in individual patches.

v2:
https://lore.kernel.org/alsa-devel/20240125153110.410295-1-krzysztof.kozlowski@linaro.org/

v1:
https://lore.kernel.org/all/20230717140138.201745-1-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

Krzysztof Kozlowski (2):
  ASoC: codecs: tx-macro: split widgets per different LPASS versions
  ASoC: codecs: tx-macro: correct TX SMIC MUXn widgets on SM8350+

 sound/soc/codecs/lpass-macro-common.h |   7 +
 sound/soc/codecs/lpass-tx-macro.c     | 679 +++++++++++++++++++-------
 2 files changed, 514 insertions(+), 172 deletions(-)

-- 
2.34.1


