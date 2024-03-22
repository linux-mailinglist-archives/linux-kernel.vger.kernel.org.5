Return-Path: <linux-kernel+bounces-111159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F8888687F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35DF2B217FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0F81B801;
	Fri, 22 Mar 2024 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNyPnFMS"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC6518057;
	Fri, 22 Mar 2024 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097395; cv=none; b=mbCpJ4Q9PnEdHdG+7f1UKhDdeEg0qRdJVgbBufCdMV2ZJAx82412VhJfcGqzrQY0KA4zp/xGBBxsey5RUmM1sLJf0SpuSLvPihalHuOG0EyrYEhxbWr/p8SkWK5nEmQncJIyZVigm41ozhpTqWUg6lpLP1S9U3eHnEOucWsuH1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097395; c=relaxed/simple;
	bh=LUo7IYr04GBx667e4z19W63l1+ZSfrQTXBaKA7AYx3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qMba2WGfQ3i0KFEpwCm1PHF7l5z5bGSEMpak4CxIOQ0XFyjso5x0kElnys/9GQWUVKlZqEbtgLnZL8lVFMCOg2XTioGu1pdAjSHDQC8kOdLVRtUS7ea4wBrnk/jepkn8jIyRCJcVUSudbWLebnn7Rq9zWHRXqyAk81f/TdIbq6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNyPnFMS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dddbe47ac1so19316985ad.1;
        Fri, 22 Mar 2024 01:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711097393; x=1711702193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eSJRJbc7Ms8BxI4u7jirBbWm4aboNputwfC65mYN+TQ=;
        b=nNyPnFMScZ3Y/lrh9k/2d+Mlk2IGJP7Zl3lvMGKSJeFmNM4hPj/FjQ00vsYSTzWb8h
         0+ceHT1IOTiiRRu3GNVwsMeZdsvz71aObg/NCN2R+BrH78OTDXZdMW8AknNkhkBHKVar
         CeogR9Yl1u4O9t7IFOwkGDbub26BGkUgTpvN/bAc4IUazmNgBJRDlh6VOC1BoMaDcR80
         73SZXh9rsV94ifMaqLpymE/4Ua/4wDGBsqOYY8piCm1kabtjl7yWqf6ekTk2warrSP0Y
         CyThI+oihX1UWj6KhbuRqzPaGjRF8cGMorvNYmweXE2R40HqaJU4lZbw/MeghrK9g7iM
         hCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711097393; x=1711702193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eSJRJbc7Ms8BxI4u7jirBbWm4aboNputwfC65mYN+TQ=;
        b=gFBrZa1A4ZGey8EG2i1DcEyoN50H6ne6Ww5nT+KqSF10ZVI50MagSGeXu3W8cp+KlY
         ZxOSDBl0UcgkrteYIK3MwQM/clzQb4Dgc9+8/F1iOL5cB8HDKBQxtdQxcwOtTOg/mXwa
         tyo6giABj5MOq3d55TTIXR6QNZgt7MYbQqZdTdIEvHGDONn8RXFenHBzrT9a48NjmqV9
         5fEelO5+MdSnMfsDCvmWCuFqIUHaVXWSC40FtV4hABfH+mY1kUq7OhMybD242Cw4siiT
         AkMSFCeNjMtsloxbVyNcXQQhMQLZfnpgs+9qwTyhq7YhKbrWuB2rMJjokMjMkR4yGo8I
         4q8w==
X-Forwarded-Encrypted: i=1; AJvYcCUEM3Pd7KDZUBi9DLbe07+MU4wu3TSuzIWgg0SmsQyVRd8Mvb+bNRzp+g6A0zjH5usaVK94GDW3xAt/aE0eSC0GkMEmnIdbNe7b78T93g3JPBSWoDLxUuFGJhBV55rT8TjAtgEU
X-Gm-Message-State: AOJu0Yz4bKl6Fve20TNkzHRkm8ttA4t6ETaR4yHTlAipzf38J034IIwm
	7yWLReQfEt0itqmS7yh97zqVoQc6vEIjZQx1AzP1o6nhLuEFo3UW
X-Google-Smtp-Source: AGHT+IF8G0ze6xWxM5iSLw2ue1CqqKFhTxeqiNbW0UakQ9Ua7SxE59QWSirl1wdmOIzQtAHbnDw25Q==
X-Received: by 2002:a17:902:684e:b0:1dd:a03d:8d54 with SMTP id f14-20020a170902684e00b001dda03d8d54mr1670405pln.24.1711097393543;
        Fri, 22 Mar 2024 01:49:53 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001dd5a0a20d6sm1328165plf.287.2024.03.22.01.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 01:49:53 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: corbet@lwn.net,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH v3 0/2] codingstyle: avoid unused parameters for a function-like macro
Date: Fri, 22 Mar 2024 21:49:35 +1300
Message-Id: <20240322084937.66018-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>


A function-like macro could result in build warnings such as
"unused variable." This patchset updates the guidance to
recommend always using a static inline function instead
and also provides checkpatch support for this new rule.

Barry Song (1):
  Documentation: coding-style: ask function-like macros to evaluate
    parameters

Xining Xu (1):
  scripts: checkpatch: Check unused parameters for function-like macro

 Documentation/process/coding-style.rst | 16 ++++++++++++++++
 scripts/checkpatch.pl                  | 24 ++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

-- 
2.34.1


