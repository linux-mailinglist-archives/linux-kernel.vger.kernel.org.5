Return-Path: <linux-kernel+bounces-165778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA75F8B9132
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B82A1F24632
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2DD165FCF;
	Wed,  1 May 2024 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="nv40e7/u"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728BF4F898
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714600667; cv=none; b=hdzRZq+4t+NQIz3WiAmCGx1acdqD+LM2Z6WQ4kpZbV5a96owCljDT3fFVpP4Y9bwcBQEEW2toKSrFWhM6ejuZ7l47uqQDwkY/mktEscutcUTIpp/LKYEzP03xagjbL5JooHrQJWVS9KMkRT9sfDcuqrQ5ztPRWJXUyy87eMFlkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714600667; c=relaxed/simple;
	bh=d/e5nP83VueCg2mWl0yErcWwdakVtDtK8TSYEA+MwPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WyMBNtQb3MOzb+iLg7vNw6Z4j5PqFl6qQAEGfVOwyAwmSYB9i9ouPb9W5gcmVaLPZLaKOPelNjtjxGn4C+VMdqBRqHyhq8ojt3D//eStP52yvVN/WGnGhZSQr/aeqJbfQJQ+o+BZR0rEr9oIvkr/YI5Vu/ZH/sXvsPuv1+xCGmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=nv40e7/u; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f0aeee172dso894079b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 14:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1714600664; x=1715205464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hP245gdXnGpNLaUitQ/lap52SDc0+cCTqDy2+pZv91Y=;
        b=nv40e7/uel3O8gaIorQ6MGb2wLuxDMg366EM0MOrxud72BBHM91T6GiwOw/fg4xVje
         jnGF+b6Sg0y48253gj4Chm1RDjmr5JMHtkpTZb/rfxTu+H6+WyfVLnwrAfx9SOSrl5tf
         mp6L1TIaiza20P2MCQPip+nYb3b3k+Pn1v4NL8zx1Qh/46rSONGrn4HQkkNctvC8GKyq
         a9NciHnhRX+1nIBWp9Krnjmx4dS3sC5ZkJtlxTx8OINMiWlMM58cAjdPhyS/ei7ynjzD
         rECQYPMLjN7aYkSNEPWTlQwkMlgH4uRL+A3CNdunYE/L/MFAHub9gVImIuTuOqOevWFZ
         W6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714600664; x=1715205464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hP245gdXnGpNLaUitQ/lap52SDc0+cCTqDy2+pZv91Y=;
        b=Lu1RRF+emN8hQ8KdsLP+qvWqr+aEYfNlBrIkpwUmMK3S/XX1ytzUoVlA4TGWPrj9PJ
         rEJYF/VtWQLJHaACa4+KKhj6tuLCqrnM6MT3PSyD6yKHV5ekm21ZA9zLeLYgdY7g0aoa
         doFm93anpnLOCqnmSw5fI3P1eu/Dor+10aIQhJFz9cI0N1UqwsViGGTARpOWQIyJGWZJ
         OUvCO6EnRCr/rJwBT200MFhhvFercaMGbyZDZcS4bU8TgBHpdviQsVjUYLKU3istlP+k
         3RpyopQOYlqBdb/hwdrsYU8zZQwTHHTwr+dUOo2qNVnNbCoeQ4Fr8Eq0SA0l76wmIlOD
         EVCA==
X-Forwarded-Encrypted: i=1; AJvYcCXxlpjjB2tQfdxZnFyMg1HwEV3Ip50s3SnqVvvbcSdkJIvoWFhecZPakm2PK6cNeXVcKdiUF4DOyUBHhV179Iw/GV0E/0GnNHQpCDrD
X-Gm-Message-State: AOJu0YyRdHKcaSg5OO6D/L256fnqCtBL4OtdjS/pqeLjpJmknyoT2SBX
	dTruhteLYECLFQ9yRtFFfMWE4q53NG+AbQbTcaHiXcCwSYzXnEqt8xKe6X80NYzMVn6vyRBO4Eq
	s+HPw/Q==
X-Google-Smtp-Source: AGHT+IHDRhsZBlVUffW9yGXinCpWII0es/0nHZPUs+brAMNXKkW8gIT4uNBBoC6oY2uv9aaMO2EBIA==
X-Received: by 2002:a05:6a20:1019:b0:1ad:7f1e:eac9 with SMTP id gs25-20020a056a20101900b001ad7f1eeac9mr1035114pzc.30.1714600663672;
        Wed, 01 May 2024 14:57:43 -0700 (PDT)
Received: from Rigel.pinscher-bonito.ts.net ([2804:14c:34:2097::6c7])
        by smtp.gmail.com with ESMTPSA id y5-20020a63fa05000000b005cf450e91d2sm22919843pgh.52.2024.05.01.14.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 14:57:43 -0700 (PDT)
From: Jorge Harrisonn <jorge.harrisonn@usp.br>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: Jorge Harrisonn <jorge.harrisonn@usp.br>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	laisnuto@usp.br
Subject: [PATCH 0/2] Use of `claim_direct_scoped` for improved error handling
Date: Wed,  1 May 2024 18:57:22 -0300
Message-Id: <20240501215724.26655-1-jorge.harrisonn@usp.br>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make use of `claim_direct_scoped` in two modules, in order to make error handling
more natural and simple than the former call to `claim_direct_mode` and
`release_direct_mode`

Jorge Harrisonn (2):
  iio: adc: ad7606: using claim_direct_scoped for code simplification
  iio: adc: ad7923: using claim_direct_scoped for code simplification

 drivers/iio/adc/ad7606.c | 19 ++++++++-----------
 drivers/iio/adc/ad7923.c | 30 ++++++++++++++----------------
 2 files changed, 22 insertions(+), 27 deletions(-)

-- 
2.34.1


