Return-Path: <linux-kernel+bounces-77437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53345860554
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7D2AB23D16
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E715013BACF;
	Thu, 22 Feb 2024 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FcmFdY3L"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1505A12D21A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639262; cv=none; b=ql3M0V15sr5kBOR9zxEDnrMhgtqRpNNEgSGpOBkaYY0cOmR5nhKnzbsYS+ZaJ+tflCT4YwsTZEXIlad++E+q8I8vSucmKThmKRjIU+1F7Dl8+GutVs1xYuOV1xNJtLaVr1zDbU6xMqP35FdKaumaujbDy7Ayy1MynqIDPbZxS+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639262; c=relaxed/simple;
	bh=hbXGJ/YlyPpD27cmj4b3cp4Yzd2WD9bezI3PKuZsB5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gxiX+YPrvPNpmMFMeEC6p0Vy95F/E7LDc/U9/dmMpXOCzcygAEbaXDNt2z0CjVjHJ+7hTTH6YFWgpXKUPdMYAoCqGWFxnIuudsgdotJMnX8UwgpU7AWpll01NZAANA4M+eVQqAhhLEoukMEQ0CVcWEraT5eGJR/QzOo1skOL29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FcmFdY3L; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5dc20645871so184793a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708639256; x=1709244056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HPkEnHNu93Xut7ylGeEwx3NBgivyxIrV8yPaocBRkWI=;
        b=FcmFdY3LT5D1jofQv/R9pi1nPRUuDWfCX75k6RGwJ+EDuPhQcrTcuAVTMwEXgNMm3N
         r+H5jOzoOm9PkcLQk77EOZGEGAP1H9X515eN10NVjKTuFsc/JuYOUStkKVEc0PHIaa49
         tLdGo6IuZM5RJ2FTjGcC3VeMD4vn8t3akzIL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708639256; x=1709244056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPkEnHNu93Xut7ylGeEwx3NBgivyxIrV8yPaocBRkWI=;
        b=Ayaf+PttpKQWZjmEXIvsPBFARvyhINuiEWQXWuwNX3im0hp7WHfb0MBpFJvIAX5Lz1
         pOouxKl6VR+1WTpnFYdi4nUWYjmYq7w6xNTwyf33kGAzpoXT7hbdWIQDDnldqns2aVQj
         iyAC6JLDt4zgdemNd0t7XIz6kNJaBdSUWsaBe5Kek9lFlnFEMiJPdKHt1h2m0npQk26A
         CamNw7fYLpb6j0IR6C93+O4sKRCuc2A1WJ2HSJKhfQ2cQ8fDUCv4KRnOhpipguwr0QKh
         V2LSUJ/+umICqiHnqD7ng/iHiprBnDaQxgcPRrL7F7oedtZp+N+kuF6kgZ3Nqx56muYh
         tK4A==
X-Forwarded-Encrypted: i=1; AJvYcCV/Xku8TWL3Gl7OFgNbCvjAPk7hDnsWJYjeDBAuQzKiFTwg/iJRXOu57clQlf6FOkxuu4cH3l9IaPVuVePmWX5FpgTdzziEeYfco8Bg
X-Gm-Message-State: AOJu0YzjNKnFfnO3AnKTym3VPLAGXsCfYVagCkHkP0/4K/TQJ56ehZxv
	K+U1VsF6qoPnvlcbc/xBBEVpCWg29IB3U/uOLw5iJ6I1xAG3JVf+/3etd2JpVA==
X-Google-Smtp-Source: AGHT+IGs8zsc2Vp/WM60VQeWwc1+0/1fLHpMgn/G2tjc49F0xIKiuOWzyw0/UdZWXwdCJaTAIF0jVg==
X-Received: by 2002:a17:90a:5915:b0:299:d975:89ea with SMTP id k21-20020a17090a591500b00299d97589eamr5305831pji.21.1708639256302;
        Thu, 22 Feb 2024 14:00:56 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090ac00400b0029a75101532sm86105pjt.50.2024.02.22.14.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 14:00:54 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Kees Cook <keescook@chromium.org>,
	"Tobin C. Harding" <me@tobin.cc>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/4] leaking_addresses: Provide mechanism to scan binary files
Date: Thu, 22 Feb 2024 14:00:47 -0800
Message-Id: <20240222215755.it.764-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=719; i=keescook@chromium.org;
 h=from:subject:message-id; bh=hbXGJ/YlyPpD27cmj4b3cp4Yzd2WD9bezI3PKuZsB5k=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl18QSB21XgR75CdHFMdboQm274FdSvsB0skHsd
 tLyagq8jnOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdfEEgAKCRCJcvTf3G3A
 JlrCD/4rxBK5ZdiEM903WPKFmSyOx6fBKqejjipROUfR1COBQWejoVnMOCfp1s0tPxTsULjFbpF
 RkU85zfnuqSajfnklsFybDe67UM4J2zusweiQAKFCkuOheq49PQEgwWCL53IEKiY+/+oDyNJ6KR
 n1WSUKdo7rIyUhhEDQ9TpOwy8CWHILXTdcxTYd6VyNmkUQKEu+eClxqmgF4DqiVgxnMHzlET5l7
 nxVAwDEclFBUxE28ZQCtN253gsYPX/nnXguzciBxioQqEbbgpOu2KYjDjUKal8TrnX09mkZyvdB
 Uq3HpV285oa6TgcVIz6TxX50dgJQga5WmKjZpnexZJnLlGJvUcT7JUU7RRfZq23e739Aa47Zh5S
 8RFLvqZAQjfGhLEfviNmjlqobLLJnBsVz0v1ZsbSV8UT7yK4a6XTuh39F/bbj6hGRM1ZHH/+0lu
 dcwaZL1S6BpGjiFxahU0GJ53qikeiectsveucYA65vxo8tFbnXw3qqCyY4E+Ct2eh2W45HTNFvp
 BBbeZQybe529xNbzsLieuYQWZHPIyHZPGEav8iNlZ5W8ZGZBT0BwZI1IeszHT321HSIy7QKg80O
 E+jjr9CrJBd/hk+YhYilwmPAq0tcgnFGOtWkFcBd05P5znJb/jWF2PShRNApt2l8YO00QtPZsBR
 YxMbVGQE 26VLZMg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

Since I was in this script for the binary file scanning, I did other
clean-ups and tweaked the MAINTAINERS file per Tycho's suggestion.

Changes in v2: patches 1-3, move hex() after ^0 skip
Prior v1: https://lore.kernel.org/linux-hardening/20240218173809.work.286-kees@kernel.org/

-Kees

Kees Cook (4):
  MAINTAINERS: Update LEAKING_ADDRESSES details
  leaking_addresses: Use File::Temp for /tmp files
  leaking_addresses: Ignore input device status lines
  leaking_addresses: Provide mechanism to scan binary files

 MAINTAINERS                  |  4 +-
 scripts/leaking_addresses.pl | 90 +++++++++++++++++++++++++++++-------
 2 files changed, 76 insertions(+), 18 deletions(-)

-- 
2.34.1


