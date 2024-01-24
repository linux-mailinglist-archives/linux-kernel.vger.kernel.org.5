Return-Path: <linux-kernel+bounces-36224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C78839DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E238D2887DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F0C1860;
	Wed, 24 Jan 2024 00:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WHG50iut"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1AE15AB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706056728; cv=none; b=AI3YZy8Ri/B23liW34zRbbZ5BBF5FiXZ4+/Gxnb9gQXm+Dy7VHDlHvRfW0qEdaNjtDtqrsC+pKBuAvfZg8qQElJael9qwy4MDOXHGnayJCZj29d4rX1kWfeSh2dzejdVpnAdhDw5G5z0gGI9lPrTJr+TYOvw/5cei8asa/UYpzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706056728; c=relaxed/simple;
	bh=wGukjyksfhKxl+wN3jLp6qvIjHdJhtPhlh30DmeGEU4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JzaKARyG1bLLeuKvyQNuBvYF8U4ohVkCdBX1+1yeJ6s86gZWIj7GNSU9OduuuSCJOpuAYPnD448vSSzD/8g0AhWFRIyHrwrVtTm3+LPh+Vsg3BrzFqo5qEYnPPXS7HabEfrv/wE0q2+KqwOKC5LcQnSqhKPsBGGqHJESOWsxcHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WHG50iut; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d7232dcb3eso22515005ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706056726; x=1706661526; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=brX+Tjgj6em20jRbwvZLT5G9OOMh+GdwBGseR7oDqAs=;
        b=WHG50iutYpge9z/hybzXqjFMStjjVfmUmvoHazi4b2VPR/fQ78qaW0MAAPDnET7xBr
         lKc0hu6CQjppwbpqLNgFD25D/feClLwp/6XjwR3IyY1Pvdpq0dgGzU9JHDHpUDc0Saok
         ttYVYBOUyJsOaSDIQj+INrEP0jwb0XDyBFWoUCnrfCMqQQLYD8sJdygEy+7+Sngo74aA
         cIx5Qbijp3x0ot4rWzRvs8kO48Uj6koMtaObDgT0cvOlQ98kJmuVPjOFztcTZqxm+UVX
         RpdCnIetHj5EKcq5KVWGu38J8GvZYdpnnQGyIn3OlWrV25QAi/rT7sZjajzI3bVr95lZ
         VXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706056726; x=1706661526;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brX+Tjgj6em20jRbwvZLT5G9OOMh+GdwBGseR7oDqAs=;
        b=FXEtY7mDFP//gUX+h2hWCa/e5sFdHBpzfsbtvsAniNclPqP29ZlVhC7UqYoyfCbj5B
         ZjrJBUHcogeGqzp+XYs/1lRo83T21NC92nN8yLKMLkkHSxtsQgl70sGlCAot2dGA7E+W
         JID4qI2KrZlvQo8KF0KQAa1+VPXil+NtIuQUWs2/Xo7jIPtQ/2zwRT0KLBWEUXSGPfbS
         870SnITjrokMACVUdBff+gkNXqrzZcuJPg67jGPuQe6KD5T+K1XwDBe7jwqPtzm//O3U
         6Kmm2eNxnjL30P/uUMskz+65Ps8r5dM0K+KynJCpuwRV6ldGbviZAMH/fja4MzyysRKA
         ksdQ==
X-Gm-Message-State: AOJu0YzONEAYOsuJw1p7z7GDItH9/tdGU9ujXAeATpJYVxXb6RtG9m2F
	K/kjw2dZ0LhJhea/mqyBm4ew+j1rdqQJboi6fnQrr1M0ycLUMNgih9NPBwJgorBggsIo3wjv8Oz
	F
X-Google-Smtp-Source: AGHT+IFy/IOyEkszkl7MjZgGAeqyZ83op788oyXUk1cuGw0HKORx3icTX46n+Mk9lLJzNOjZd46F+A==
X-Received: by 2002:a17:902:f683:b0:1d5:78db:4293 with SMTP id l3-20020a170902f68300b001d578db4293mr45995plg.29.1706056726258;
        Tue, 23 Jan 2024 16:38:46 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id bi3-20020a170902bf0300b001d6fe15b563sm9384275plb.157.2024.01.23.16.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 16:38:45 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v3 0/2] lib: checksum: Fix issues with checksum tests
Date: Tue, 23 Jan 2024 16:38:41 -0800
Message-Id: <20240123-fix_sparse_errors_checksum_tests-v3-0-efecc7f94297@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABJcsGUC/5XNQQ6CMBCF4auQrq2hLRZ05T2MIbQdpDFQMoONh
 nB3CyvjSpdvkvn+mRGgB2KnbGYI0ZMPQxpqlzHbNcMNuHdpM5nLIhfiyFv/rGlskKAGxIBU2w7
 snR59PQFNxKU2lTaqcGVVsMSMCOlnS1yuaXeepoCvrRjFev0Dj4ILLp1ybaVdlRJn9DGQH+zeh
 p6tfpQfplQ/mJLn3KhcG22hdM3hy1yW5Q02S6fpJwEAAA==
To: Guenter Roeck <linux@roeck-us.net>, 
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706056725; l=982;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=wGukjyksfhKxl+wN3jLp6qvIjHdJhtPhlh30DmeGEU4=;
 b=wl+vTT9NaLdB8EnF8clYo8HrBuTOKXUqhd8RcHy8HHB9vdXYDE77jvI79jSUrrF1UM6CteD91
 HivpzVdlwVyB3XVkZX1VzH9SOeuxt2LAG/tTeJj4KpKqaHJv3NAM7lX
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The ip_fast_csum and csum_ipv6_magic tests did not have the data
types properly casted, and improperly misaligned data.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v3:
- Don't read memory out of bounds
- Link to v2: https://lore.kernel.org/r/20240123-fix_sparse_errors_checksum_tests-v2-0-b306b6ce7da5@rivosinc.com

Changes in v2:
- Add additional patch to fix alignment issues
- Link to v1: https://lore.kernel.org/r/20240119-fix_sparse_errors_checksum_tests-v1-1-2d3df86d8d78@rivosinc.com

---
Charlie Jenkins (2):
      lib: checksum: Fix type casting in checksum kunits
      lib: checksum: Use aligned accesses for ip_fast_csum and csum_ipv6_magic tests

 lib/checksum_kunit.c | 389 +++++++++++++++++----------------------------------
 1 file changed, 129 insertions(+), 260 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240119-fix_sparse_errors_checksum_tests-26b86b34d784
-- 
- Charlie


