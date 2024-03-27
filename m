Return-Path: <linux-kernel+bounces-121431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2712E88E7D8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1032E2B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EF7147C9E;
	Wed, 27 Mar 2024 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z6875mEp"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD5B12E1EC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549568; cv=none; b=sq5glF3C7gULc58X2UjTxG5gQiq97wl5q3AnqyIVg1KbSuxZcfhtFtvQ6trN62lbKEnRf4rUm9hSoqBjEkJeWhe1ez4jK8XlgVPHGBJ+QlAaQUgobV9H5/EHMOgzoV/e+ener2DVVhaXz6FRtKdP3HO7dTot6almqXCbWz7hQ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549568; c=relaxed/simple;
	bh=vsFPEefnVcrpKrrSULPxqloHcKVad4kXhpbSE2N33Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSdOTtS2OfW9I/VKLGoR8pO9HG6EvS94dMCi/u9gEOwn+0YAzcfbcHLnQTmGOYMkOk0wbxkECujS4VWIuJIlPnnTxWzGpZ/MWVmkic6I7XkQrNsGg37kRrY5guzaUyWYo6jHsBdbaO8hH3ll6ZnQEI+0j8nuA6IzBYJW2IazVoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z6875mEp; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d700beb6beso2931711fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711549563; x=1712154363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jT87oTrz76Du8T7x124Um4OENDgPfui6BWTMm6GyB/A=;
        b=z6875mEpCXhTNvcqni4Nql6SgdbFIStaGGxIyP+cJpshRSR885FbFLNn8nzuX4rp1c
         qpQNtKhmgRnhTUSG3ygkpeCWQaWoaIxPORxpuAYvA0z+h82Qe/flFw/TCP20pT+kwzfX
         lOdTovvz/UButlFlY2EjAwgHwT4uscKsHF+hkQU8jfj3FjyNCh67t7yOrcj/EG7YkQVc
         lDkLJ5e17BUDQjr+PWFbVYQASpScwtCPN574We3Cd8pgXXgdIL675RXNtNXP7tpPVvQ1
         ZUWv+kJ/0Bp5e4qL2bENKS91uKu2sIJ+eilt1tGXn8j7G5rRN3xwbIjk019qUpZDgEji
         qXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711549563; x=1712154363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jT87oTrz76Du8T7x124Um4OENDgPfui6BWTMm6GyB/A=;
        b=s0Uq5jw3Z0XRHNeA8EFwmbqrM9LiKFv/AE4oiYXBjriEN6cwICgNCui0/SjZ/SoU86
         eCTIprnn12CJsbZJgRarTOQmGEbevNwYQEIMcLgq5IxF05rv9YvJXAPTPh0Rq1ALytLk
         T3Jy4hGd0qyRj5pGGYogMr5MrDsHZ+CKy2WIyjdZOxT44Dd1u64t5WKYQmSYWD7FJIsE
         4CXR0J62PqsbkBRvRc57itn2rPn1xe4jLG43jGqaEZQYwgmfmRG0yhFYbdxopzUMQD/U
         FaqnELJD7asABDEjWHEr28H+viTNwMyB8FUnDLwsM6qB2csFGUORNOtsEifSXPNpJ//B
         MWOQ==
X-Gm-Message-State: AOJu0YyjJ1T7Wm13Hd9duc69EksD2S6TGL8ZtR/WBnr9GaNdr/PVnba2
	oPYtB+4RKbiV+zcfM3mjXLaMysNuZbrYwd22Koh8arIA8NEcq8qgix1SmBFVuJk=
X-Google-Smtp-Source: AGHT+IGa+qydAvGtuowtSIYuGaThQUaE9UahIHLl+63Fv71vJXk4dtxt1nTYcVqU1AzCeYYtpr5eBA==
X-Received: by 2002:a2e:b0ce:0:b0:2d4:a8b2:1933 with SMTP id g14-20020a2eb0ce000000b002d4a8b21933mr138229ljl.51.1711549562636;
        Wed, 27 Mar 2024 07:26:02 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b00414688af147sm2300840wms.20.2024.03.27.07.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 07:26:02 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Cc: linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [RFC 0/2] kconfig: Add fzf fuzzy search for config options
Date: Wed, 27 Mar 2024 15:25:42 +0100
Message-ID: <20240327142544.1728286-1-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

These two patches are introducing a way to use fzf with the kernel
config options.

Using 'make fzfconfig' opens a list of all config options and their
state in the currently used configuration file. A preview is provided
for the currently selected config option in the list, showing the
original Kconfig snippet. Using Enter opens make menuconfig for the
selected option.

I reused the existing helpnewconfig command as it contains all the
information necessary and extended it to display all options using
helpallconfig. Using a wrapper script, that does simple parsing, the
view is transformed into a line based representation that is usable by
fzf.

I used this helper for some time now and it seems to work quite good for
me, though there may be cornercases for symbols etc. where it doesn't
work. I chose to use helpnewconfig/helpallconfig as it seems to be just
a small modification on the existing codebase to achieve fzf support.

Best
Markus

Markus Schneider-Pargmann (2):
  kconfig: Add helpallconfig
  scripts: Add fzfconfig helper script

 scripts/fzfconfig        | 112 +++++++++++++++++++++++++++++++++++++++
 scripts/kconfig/Makefile |   8 ++-
 scripts/kconfig/conf.c   |  17 ++++--
 3 files changed, 132 insertions(+), 5 deletions(-)
 create mode 100755 scripts/fzfconfig

-- 
2.43.0


