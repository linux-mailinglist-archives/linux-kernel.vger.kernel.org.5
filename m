Return-Path: <linux-kernel+bounces-163889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3647E8B755B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683871C211BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA68513DB92;
	Tue, 30 Apr 2024 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3HkwD6x"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A230912C471;
	Tue, 30 Apr 2024 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478759; cv=none; b=lU7AL7Gj5WGY6/nsYCGQIlJoXTDFADsPZ9DBKECu+tAkIOsXlNuwZ7FBJjpDgmLWWQZctU/uyeBpjN5W6oGz6FXnzazStB52IiWIHyzxkiPndMaSF9afLyNyhOd6NgBbWTWbz36ZFBVnAdJNy2Qa54KXzR5YvjzSQXIy0cgawC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478759; c=relaxed/simple;
	bh=tMBs+lDNe9pLbTu0zCJhN2lDhjpRZ8I9tXgirUQvoUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=me/h/U/8nE6PDto+uJGVnj89RSd3Ora7xgDXhLaSBWaRc7DiXiZYvweFQjbA22u4VQqEWJkZMvpR2CsbtI6E3HqCxbWZofgRBQRA+G6svDYWxwwNV5oWh4Jg0Vr1EZx9N3imTvPSrQv7GnVHI4xA23Slu4oYa2jCpDqICIlNW84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3HkwD6x; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41b782405d5so45412705e9.2;
        Tue, 30 Apr 2024 05:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714478756; x=1715083556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xYqTeRRrkthPO0LeFJIEx/W2fJhEeuQeFbdCdQP3IhM=;
        b=a3HkwD6xn8s/ljLRHdHrDspoSV8pS6gefNG7PzEW12Q7cBzCiX+++lF/fC7MbUpylL
         Fxh64FRgkg27Nvde4pXvpgMI9KPB2HiDFhZoDFuOInc5hvLVLG4BXXDml8sbZmikO+sk
         Q8rNyBS5k6gMvjbBpf5HzFiVOmrLkASkTHRI5dDnjTyPrP38rtKsPaNP0+FA6rBHbdxj
         2cgkmqc2mCdjFYu6mCzQCToyvtuzWk7myY7WYZso02wfBsnoWvtzX0rNHXFWDf1CF+YV
         t3/3wzVYUGQhuq2wggbrzDiRUcnKi5gGOoL/a8UB5QKuNJIFItUpNDsQCS91N5/kRtPJ
         ga6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478756; x=1715083556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYqTeRRrkthPO0LeFJIEx/W2fJhEeuQeFbdCdQP3IhM=;
        b=wPor6IkEhtnrkflLTPjBw2znIQMQgWoZ19n4Q0qYalFjJYvcSAn8bK8esoLLnWuh/2
         B+4ptzjzt2djlLyVuuH8J3RZQj9mhk71x/11rBhchbJK5U0YQ1lUpjYiJ/RGACoQ7T8f
         MMFt5tcGkDJLGqDd9V52JV6AxWHU2cQf0EQ1j41o/jPwEvGsXs/W+UpiiXGdXNu8wdvm
         YQxei24EJqlayRaneAPLUDBM1mHWC4G19PMhpAw06S2ncVWPWF6rBwNVNY/oFW37jMIA
         tQmdnp/qIs/49KXXEdcire69JOk70HUSNXt5dZHfrjLXCD46290hNGpHe1OMynNNg7dp
         4fbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmGJ/EDYwTxf4IvLWj4Qe0W5bvUdKQloX4ep00k5Fj/3zBVjszwhqesFlLQNwl/yciA4N+hzM03510G9NkhWLjb+7vQyj0rlciuIshxgrB006v3b05fiY77KkfNvhE06aJtwk/eeW2
X-Gm-Message-State: AOJu0YxCTiRfbPxfHvULk85m2dOQjCMDafn7pd+6UN91AK6UhxOMbfCw
	9xn1KthDT9BSp4BPv1t6B/eSQWy3BSrWZuil6MPSvRJZcZ6TBA9Q
X-Google-Smtp-Source: AGHT+IFPjPkJKtFjpK+eQGii/e5GMM8QnFML8gfFnNVYjHDKXP04IceDzHqkyK4XtlxBv/YgpYRfyg==
X-Received: by 2002:a05:600c:1f06:b0:41b:d85c:d3e2 with SMTP id bd6-20020a05600c1f0600b0041bd85cd3e2mr8949292wmb.38.1714478755634;
        Tue, 30 Apr 2024 05:05:55 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c35d500b0041bf45c0665sm11054324wmq.15.2024.04.30.05.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:05:55 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Add threshold events support and some minor cleanup
Date: Tue, 30 Apr 2024 14:05:30 +0200
Message-Id: <20240430120535.46097-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds threshold events support for the MCP9600 device.

Based on fix:
3c324a40b7c3 iio: temperature: mcp9600: Fix temperature reading for negative values

Dimitri Fedrau (5):
  iio: temperature: mcp9600: set channel2 member
  iio: temperature: mcp9600: Share scale by all channels
  iio: temperature: mcp9600: add newlines after if statements
  iio: temperature: mcp9600: Fix line exceeding 80 columns
  iio: temperature: mcp9600: add threshold events support

 drivers/iio/temperature/mcp9600.c | 381 +++++++++++++++++++++++++++++-
 1 file changed, 368 insertions(+), 13 deletions(-)

-- 
2.39.2


