Return-Path: <linux-kernel+bounces-80122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF01862AEF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF671C20AEE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63681401F;
	Sun, 25 Feb 2024 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hpLfTyKn"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C149125C7
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708874036; cv=none; b=k1+Eyyh/QteEyz7iv5pPMhXZjnd8lFFKnAyN9YZxchcy42SBz3i+iDyH5WhGGnGG60XzlOC+24llxbyWNbQVXc6rvLEefq98i02M7C+Yc7i+3YVfnT/YTgfzFYT9I61wJbiB+NHMdiRwJP8HFMSq5WIKYPAeM9N0UzVkaRgYc/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708874036; c=relaxed/simple;
	bh=LTGFdupuT23BxZzrNVXEZbY3GxxghhE6SPaarUNXIww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=brmI/gtpXrnPtIxZ5ZgQhXi3pIrGL9DSu+uwUnmszLh8IYSMSyS+5AN+2R0enJNGbYiIYotcln/DeG+TAiVChRe2nxEKlZ3NvPOfOrylEMUEBcBUGLXEVs5DiJvkZr50TfcL+bV2/uJiFjjxt1dkRKEe1WTvX3SA1phi1Ln6rgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=hpLfTyKn; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso2072310a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 07:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708874033; x=1709478833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DVg8Vc6dakvWYwVma+prJnPaDG1VK36u81Rqo7/s+Y4=;
        b=hpLfTyKn+6g7nWXaxwK8Sl/7dlLDoO7F4uJ1aA3qUJvW+5otbl3xwFz4YRtRGg1+UO
         7vi16434m0ed3prjSiWInvhuyzjseMIKkxX85lbgOPBXz8gK+6lJ9bdkQHCXgY36H7rK
         0bjLwG8vK+5Z32+wF8425owmUws4qNZF1+mAsj/bD+FQE98uth0Ga1LLcgbH0XZt8A3R
         IUI9gwnW/f7mxIoO/ONnA8vn+/zm6xnztWnmCyUvnNFF6+jVasP5EBMCjjIP0jEDQYTt
         PPs6XchisRtmp62s093IIzBTBgD4XbDPwkjJ2zUVGYQsrnHpcwUI6YudWhlhSg3jQeUd
         KkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708874033; x=1709478833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVg8Vc6dakvWYwVma+prJnPaDG1VK36u81Rqo7/s+Y4=;
        b=RNoMCzGK/ndHdBrNiC3SChae2TIZ5WSK672XOGirGQpTg8TRJugdLW8+XpVPj3eDpZ
         +1d06JULYIz9+lHr7sumOADqfTDNmXNG34Q0j7ipI3cHht7ADOq69zPs5+59bFS7Eh7T
         eoFJhrpMskT19PQtyat7p77sdiBVi+g2/W84d4ixFNgsgJcHnwozaCehMQGXRtAf71cK
         rx9vXnjCdCdmBkf9TLVPdfjyAKBrSOLU5zxtaTFj8MPCLJu8BCAZOMoNhA/MApAZkRHo
         2Uo96WKR83EPA2yiXxgUNNfdP53+hL6DXdkJUjdhfFDGmDbnMZMLeLFZoqxLQFsKvkqU
         /6qg==
X-Forwarded-Encrypted: i=1; AJvYcCU961pMkDX6AmZWjzRZgsNwfU7jTkdnYXxvlbpXNT3rqnwl0g2upzVXhmlNon1fiiNCuSpWHfseUt8L+HrkjzCKrb45X0ElCynxLVPL
X-Gm-Message-State: AOJu0Ywr6OuGxdwQIycxSWIhlsLhg4LTZ9sLQrwCrKU6zOjfMkg2HrSZ
	nxrbna5czkLd//BqeWxGJXae+ZcsCo2v24k7s+kjP5MaZ+ch30wr
X-Google-Smtp-Source: AGHT+IGCQo1yS8w8bgkVLKkBxnJVTPr3dCB3UxKhw9znfmTVz8F0ktG+O+xtCQOlZnIFn6o8EhslAw==
X-Received: by 2002:a05:6402:7c5:b0:565:92b:ae77 with SMTP id u5-20020a05640207c500b00565092bae77mr3271019edy.12.1708874032625;
        Sun, 25 Feb 2024 07:13:52 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-94e3-d600-0000-0000-0000-0e63.310.pool.telefonica.de. [2a02:3100:94e3:d600::e63])
        by smtp.googlemail.com with ESMTPSA id f5-20020a50d545000000b005651ae4ac91sm1588450edj.41.2024.02.25.07.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 07:13:52 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	patrice.chotard@foss.st.com,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 0/3] clocksource/drivers/arm_global_timer: Three improvements
Date: Sun, 25 Feb 2024 16:13:33 +0100
Message-ID: <20240225151336.2728533-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are three improvements / fixes for the arm_global_timer driver.

Changes from v2 at [1]:
- add patches 1 and 2 (which is why this is now a series instead of a
  single patch) as in the code review process more issues have been
  spotted that need fixing
- remove "psv < 0" check from patch 3 (as this check is now impossible
  as patch 2 makes the variable in question an unsigned long with a
  check for zero and returning before decrementing psv).

Changes from v1 at [0]:
- use FIELD_FIT() to check whether psv overflows the register
- update the description accordingly


[0] https://lore.kernel.org/lkml/20240221214348.2299636-1-martin.blumenstingl@googlemail.com/
[1] https://lore.kernel.org/lkml/20240224213529.2601333-1-martin.blumenstingl@googlemail.com/


Martin Blumenstingl (3):
  clocksource/drivers/arm_global_timer: Make gt_target_rate unsigned
    long
  clocksource/drivers/arm_global_timer: Guard against division by zero
  clocksource/drivers/arm_global_timer: Simplify prescaler register
    access

 drivers/clocksource/arm_global_timer.c | 31 ++++++++++++--------------
 1 file changed, 14 insertions(+), 17 deletions(-)

-- 
2.44.0


