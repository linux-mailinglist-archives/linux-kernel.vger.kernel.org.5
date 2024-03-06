Return-Path: <linux-kernel+bounces-94161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E14E2873AC5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0161C240D3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C233137900;
	Wed,  6 Mar 2024 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ThK34fz8"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884621361C2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739327; cv=none; b=u1mCHFY8iS4AcyzCtvyNXXmHiFfy1FmPRk+16QDyEu19OuCcnQK9KcCamU07xELvHOe6woxQRAFgQY2JqS88aXc3/y5GREHEFklrrVTnQVKID9G7oJiJu09MQ1BWg5quRQWSQMPDRwn00NESF/y9nlx9ljYUN8gc4WwCLZDxadI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739327; c=relaxed/simple;
	bh=5giwwAVs8T7QluRTB+xOQJkMr0YaoDj/v7XSb1HRsYI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mRcEflExyMYj/Lp70KaknuBcBGhatSsMiDd+Yd75yWUAYW7t1P9/CyE1ArcS3Dezg/uQWF1BOL8BH6VULllAEYQpaCmFS5Rpf+LBXvSQ8b4NGKZS3fQOqT2kMWw1TBD2FUNcc/D7etEUoAi/FvsWFvOaMgYHyOQ59HISiSJgBjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ThK34fz8; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bff8f21b74so82841639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 07:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709739324; x=1710344124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4g8A9vGT3dh/Tnjptv4r4bg2myLV+zLGVtLq9Wt7KFM=;
        b=ThK34fz8KYi9hOVVCoX5WC40bBe9o5BM945uU0sSLq2acRjhPQYIwxS2gcXsG4F4eR
         i2Z65L2Ug5qyHth/gxsvUF4uosyiCbxOrXD7g3zWeWPuiolrTBInv2xW/VxxAlxAakZt
         XrTO8FWgmox8c7Q/o5KZas20VEll4j5ENBy59bL/pXY4ijtmAJyEYIP9LT1WanfVFzz9
         Oss8xl0DHsN59EXVwBO3PHxdqeJl/QqmoKCsB2GgJKuMA9KM8uw9b9WGnM8jDo+jJkUC
         D3x9NOZ9kcgJj0YHEo5qPRCASJbFRb4TGykpqTymT1qXvMhsKmBtbcgxUwINnCK4s11a
         1A6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739324; x=1710344124;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4g8A9vGT3dh/Tnjptv4r4bg2myLV+zLGVtLq9Wt7KFM=;
        b=V0NQ/6izW2qqklszW8/i+T9DClHHkgo7nH6YiniTC1gy4w+cr4yafQp5t6bAwH3fGe
         5XxaB+bug2JAj/Sd/dnqMAVPOggyQ6wSrH8JIUaNnivSd/GyO+Yi7yO4hB6aU4bPWCcA
         wVfC0cxpUuxrAhhHwYj8qisW8n3m9IJYVRNQVWgTbQIQo/iY3d9T6qpsTBmxr+cRnha7
         1TP+MWOB1joZdKk4Ky28cdQjTVZSHHUgQmg8YYPJmqlHemc/CGX3h08AUDu+lsuqthCD
         E+2bFvZrHlz2BTVGWthgNh2E7YoAALGP7/wKLJ4Hg3qZyjK8X/m+n5KZk0WTKawLCUTr
         NIpA==
X-Forwarded-Encrypted: i=1; AJvYcCX6U2AwcnFIK1bYLJDwVw98I0Di6q5vhARKBtTZz07bvVoT7Ard0YpGCOzADJwFswqoDiXOtoiEpDG/XNdqlpuCMoAYLkPWYLqjfCaS
X-Gm-Message-State: AOJu0Yy6W679mt14abwQJ6rnR/5cUvfseg2HlGAgVTlS9ls66eEo+l7S
	pyBbNxuiRSKnKyX684IOfY8gfKmtwz3KEdNco4oaFxwvTWUj6CLsV0zUax2jB5M=
X-Google-Smtp-Source: AGHT+IFfwCUfMFiQah0je1TNZa8DbUgEvbi6wVSHkiMMkU6phaMDwuj9KIibMdJlRYTFwBqyREQ7nA==
X-Received: by 2002:a92:ca0b:0:b0:365:25a2:1896 with SMTP id j11-20020a92ca0b000000b0036525a21896mr3696110ils.0.1709739324728;
        Wed, 06 Mar 2024 07:35:24 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a92cc42000000b003660612cf73sm324467ilq.49.2024.03.06.07.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:35:24 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: jonathan.derrick@linux.dev, Li zeming <zeming@nfschina.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240306100216.69340-1-zeming@nfschina.com>
References: <20240306100216.69340-1-zeming@nfschina.com>
Subject: =?utf-8?q?Re=3A_=5BPATCH=5D_sed-opal=3A_Remove_unnecessary_=E2?=
 =?utf-8?q?=80=980=E2=80=99_values_from_err?=
Message-Id: <170973932405.23995.1005180827192138454.b4-ty@kernel.dk>
Date: Wed, 06 Mar 2024 08:35:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 06 Mar 2024 18:02:16 +0800, Li zeming wrote:
> err is assigned first, so it does not need to initialize the assignment.
> 
> 

Applied, thanks!

[1/1] sed-opal: Remove unnecessary ‘0’ values from err
      commit: 217fcc48074be4f526190675140a478ee795d90d

Best regards,
-- 
Jens Axboe




