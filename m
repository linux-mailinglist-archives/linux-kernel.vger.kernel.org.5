Return-Path: <linux-kernel+bounces-87698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FF686D7E7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0001F23B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E137A15F;
	Thu, 29 Feb 2024 23:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iV33OeB/"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4233F6D528
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249733; cv=none; b=beiGOjc3l2Z4wA9buBSUaQUzuul+DZJtQXcBaUNwvZhopov4BcVjiOCQpKok6pHWoOhEfm8wSUaVFklxbzZgDGnqprIbe10BkmXa/+m76Ps5i5/nupPNWPxXFNDxIc9LqoZWeiSQdoYT6vZEOA0X8LaWqx7LZbmdW+7fPX9KERc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249733; c=relaxed/simple;
	bh=af0i+Z+NBmK8wTAcFrJRYhmqFQ66AAdLmiOFLw1OeN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=axZaQieFAjKlu+R1N86sehmECXB8cDXuuuEgR6eG8OQpOo9jeaFiWR0aFC3njjqyHmxvQMPGk0jnTixw0tjz4ZBTlsOuKTvg0J1ufzluhwG1Cb45uNoMMiAEswS9WUN7CU/g8+4YsrR0qW54UpOePMYEX1bI4NKSQNUTjQGj3q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iV33OeB/; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce942efda5so1215729a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709249730; x=1709854530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qgeC0dWQiXHpXbv+RTu39Eq188gL97uOmLAZY2hF3fA=;
        b=iV33OeB/heUvveeMxMcuzWULjLQOcnaBkonkrwllHoMHT9+q6G7sgVqjqs9iqspm12
         QqLO0jSpm/i2UNS+HjnS2KXgqhnLKSQP6OcHQpFiHakAVrmhl1N58ojk/wt3yspqp0Ff
         yc5+F5x++hWxSdiy8QHHczoGzyQwaSj8VBM50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709249730; x=1709854530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgeC0dWQiXHpXbv+RTu39Eq188gL97uOmLAZY2hF3fA=;
        b=IttlemU2Hkm/SNP4vBqXpBb9700TggXg/uSJHXPZvAhexs4rHjyq4Ai7P6oypjafNu
         sH6E1FT2Kn3K5aIfHvrUC/Z0TU2EVo5BmUc6pmInqB8tR9ZzuojZuwtR9DwOPxevEI+j
         Laul4Z3soaT4hb7a9LkGJAedFKvefTVsqdqNqblWttLPiS/YBNNGfLnPBEyEf7wzWb5V
         1oxTr9av8dlaoJpaDGg8RnJvAIT5jNgXJl11I6o0LGt6Ib/dm+PmTX7ITnsJZRbCrtgc
         +NGunGGdGv/hBhMJsQAquABTR/fMPQ+iIKKQGLV7APIUJ15zjB2zmcHHFbMp1bgseJet
         1fmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzftwf1/mjGPayi/16oSEm6daBxashAF2Jzg8hCUJBphuBbm4wgDHjJzt+brtZWmCW57BZ/yRHnt/NbmMHsxbsFOwU34ERIGtqosdA
X-Gm-Message-State: AOJu0Yz9t85wPw5kd04q10lvdAWeWvGo7yqmhS45UNTKY6f6JRRealS6
	RUHY7ycVNyvGfc/G8wSzbw0Shw2IR8GQn955kptNolIUztz6Hj4gaLutEJwbtA==
X-Google-Smtp-Source: AGHT+IHdzgU8MOGA5OKgWWi/ALEW2RCneug+tnxz+xSDAC8KU+oM+pEJdlK0nR/tNDGF6pdVEe5zug==
X-Received: by 2002:a17:90a:9481:b0:29b:1964:3921 with SMTP id s1-20020a17090a948100b0029b19643921mr82708pjo.46.1709249730678;
        Thu, 29 Feb 2024 15:35:30 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x24-20020a17090a531800b00298975077d0sm4146974pjh.19.2024.02.29.15.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:35:29 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] string: Convert selftests to KUnit
Date: Thu, 29 Feb 2024 15:35:22 -0800
Message-Id: <20240229233432.work.675-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=704; i=keescook@chromium.org;
 h=from:subject:message-id; bh=af0i+Z+NBmK8wTAcFrJRYhmqFQ66AAdLmiOFLw1OeN4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl4RS8DgHghW1lD3n4SWnltPLnr7H9SGtGAp+Br
 8H0kDAa54GJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZeEUvAAKCRCJcvTf3G3A
 Jn8kD/9JnIyBUTtwBNswGjX9Dv3u9HUZt9zvuY9Dmpb+fBXd/VSq9KauLA7vo2CrSnruGsZ9GYG
 o6/DQynkvUK2WSzaV/wcqovVciPJ+OZ9MuZ8N4Lj8dVsASz4wxNnU0rsCfg/A9q7q7ph3BUiV52
 Y7V6udqf9+2ezuI/1mq5wdv3HrEvfqogMbwx3LPW+ZJRaBBqTAg7dqVRxU6eavWPzHxX67uVbg/
 y/jfS89N4d8hanXtonuifHw0nFudU4SNW+C14EKC1UuqHxwQ2qR4iiXc0Mw1lPYmZrPoD2hG9DJ
 BG5Lw0AbVECzEk/je4GwaWQ/sBSh+ZfEaxx2xBD0ISJgyLmIlm60FL8BKtYAtjUFmqoMGeiXWGm
 qMlK+Y6SNHSPS37CJ/wrUz+OaSdEOZbV7dbrE7cP3T6HveouT5b2xj+Lb2weInPKQgjVXONukfU
 vI+xy+JgEArv/fcZGM4hRqx5vzdH8bZoXMWBLxw12SjE/nKA4VHHRU7DUs5/vL8F5FVebF2iuJx
 mAt5wfqbtoQeqELn+3BopODrgR5C/EhR3lKpe1K40kfQqaiogSXW9A5RBxHUAVkdl2LLYj5fi9a
 57JjcO+5QckYCYZ8xE7U/EuOl+RJj81uG4BCU1EQeSPWHQ1Vbkn3q8C45GVe82YlTERf83zKmk9
 pjpt1zYC ratD4aA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

I realized the string selftests hadn't been converted to KUnit yet. Do that.

-Kees

Kees Cook (2):
  string: Convert selftest to KUnit
  string: Convert helpers selftest to KUnit

 MAINTAINERS                                   |   4 +-
 lib/Kconfig.debug                             |  12 +-
 lib/Makefile                                  |   4 +-
 ...tring_helpers.c => string_helpers_kunit.c} | 160 +++++++++--------
 lib/{test_string.c => string_kunit.c}         | 166 ++++++------------
 5 files changed, 154 insertions(+), 192 deletions(-)
 rename lib/{test-string_helpers.c => string_helpers_kunit.c} (79%)
 rename lib/{test_string.c => string_kunit.c} (54%)

-- 
2.34.1


