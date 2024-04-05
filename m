Return-Path: <linux-kernel+bounces-132891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F643899BA0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31AB285258
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8966816C42F;
	Fri,  5 Apr 2024 11:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EEdF2skc"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499E216C427
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315391; cv=none; b=f0WcVixRT/B6qkkGWOq56fbRJRDWUnK/RqUgHxFFz6pEDwMEOQwROMqI8p2fJW9Iven1FQKcLYMEwLrBiCx7RXHlZDfdQbO5KL1Vo/tzApIdu/3uj6vySJHL4jezYwKgTe65uG6FBiu3tX+V5J8pM31PXVRFO8xlICucot4SR/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315391; c=relaxed/simple;
	bh=TugG3AB0lsWMh7jn+aDBl+S6sWBQPDYKMwxIi40RiBY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KpvVNS1I38VE07olmZD5cp7+Govs9zKpsXHNRcnaOtR0ZoyiBlEJ3aVRRraDTF94wm1jbgQAJhXPg7pWSCaQ4lo0MQ/TWaEaw4jNo1XXaawN99drqydNW2ntsYmkcen6eHtQJAp4+fJQ55D011fN3sa1tlDb4kvPs52nRoxTC4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EEdF2skc; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ece8991654so1671557b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 04:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712315389; x=1712920189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ilEskIN8tKWZMsYnEfjH123xoWAuOl7U7IF0t8VdrT4=;
        b=EEdF2skcPry7IYyyN+2FRDV95aQPsAGTsAI1mOISkCM2bNN70Nu4LJ9jr1SBwg4125
         yL9+sgeKbWkJ8MSMZjNwmGDijUjb6KIDOsqKs+YsOq+ii64W0epFyeKz1Z4TGmJFXS/T
         OOSEw140MbN7ROWcaEZUbdx99/vZjy3G9M6QBXm4eyn2voshxJXzBk9VNJ3JGWL8cUBK
         axfez5OTm8lxebt5G47QESsOUhIA21un2fH1HSJ33Q931JLUgtEpQ/pa/uy1CNQo95qo
         L6z5rO8NXqMozrTp7UOnLVfS3gmveGb3lzjpmC6hPldKYGViaD2cCFy2U75o2NXBKwst
         y29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712315389; x=1712920189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ilEskIN8tKWZMsYnEfjH123xoWAuOl7U7IF0t8VdrT4=;
        b=rO1rsN32uYV1w3CbVAzNn7eLj21Is5r5GeEGPf8Ncs05pYYzFERVFUEux5EmWHMdc6
         uHwArs6YjDM2j4kCzSSeyvSThJ/4nVVJfpalf1KyES6ZnO1jwqsJKXXM+X6sqKbNaA9w
         AFrSo/aVjAWyxySzMVviggHwyBuF+awAeioF4DN7G9xp7RwhFQ4Rpfp+JwXENI6cGUuz
         lUDjrIANoiWZ4Gk5TvzX6cp+D+z+ezQUbhkHnNThq028wAVfNuTMoiPncMFbqSXLb7zC
         FYDD6jW0fDgQzzzNUNjPSykCo5uAE07EY90GHxwPNmI+WvkVOT92gWlojlig1AsUvenl
         FTBg==
X-Forwarded-Encrypted: i=1; AJvYcCVIPJvUQGMFqxYYak1WA0oNcxdxTaIadl8sY/uJw0Sdj6FiG4d3NG7XeoIJqHXGZuVHcI7RfdnxfPgiIEsjfO/A4tVWwQ92w7ApWkLo
X-Gm-Message-State: AOJu0Yy+Timw2kKqdbgtBPX7wgJIXwRw6a1V4v6Pr1De42+jdNVfMXTM
	L8d5/4ds5GPgP8Ex5JLmRJDMPPMaH9vYZUAiXSb/h3ynI6nJJfeBVDyUVl0oZ54=
X-Google-Smtp-Source: AGHT+IG/YfkF++gD2mlqOUJepSZK7I0ECiDMCZHHrVA+yfv0tmEvQP7liNI3ygazqjrq7uFr3Aj94Q==
X-Received: by 2002:a05:6a00:1803:b0:6eb:3c2d:76e0 with SMTP id y3-20020a056a00180300b006eb3c2d76e0mr1328344pfa.11.1712315389286;
        Fri, 05 Apr 2024 04:09:49 -0700 (PDT)
Received: from localhost ([122.172.85.136])
        by smtp.gmail.com with ESMTPSA id b187-20020a62cfc4000000b006e6b7124b33sm1262793pfg.209.2024.04.05.04.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 04:09:48 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Benno Lossin <benno.lossin@proton.me>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] Rust bindings for cpufreq and OPP core + sample driver
Date: Fri,  5 Apr 2024 16:39:37 +0530
Message-Id: <cover.1712314032.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This RFC adds initial rust bindings for two subsystems, cpufreq and operating
performance points (OPP). The bindings are provided for most of the interface
these subsystems expose.

This series also provides a sample cpufreq driver rcpufreq-dt, which is a
duplicate of the merged cpufreq-dt driver (A generic platform agnostic device
tree based cpufreq driver) used on most of the ARM platforms.

This is tested with the help of QEMU for now and frequency transitions and
configurations work as expected. No performance measurement is done as of now
with this.

These patches (along with a lot of other dependencies) are pushed here for
anyone to give them a try:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git rust/cpufreq-dt


I understand that there is a long road ahead before these patches can get merged
as a lot of other stuff needs to get in first, i.e. Rust bindings for:
- generic device / driver
- platform device / driver
- clk, regulator, OF, cpumask, etc

Because of the missing bindings for above APIs, lot of calls are made directly
into the bindgen generated bindings for now, to make this work. Hopefully we can
have a lot less unsafe code once we get all those things merged.

Based over v6.9-rc1.

Thanks.

Viresh Kumar (3):
  rust: Add bindings for OPP framework
  rust: Add bindings for cpufreq framework
  cpufreq: Add Rust based cpufreq-dt driver

 drivers/cpufreq/Kconfig         |   12 +
 drivers/cpufreq/Makefile        |    1 +
 drivers/cpufreq/rcpufreq_dt.rs  |  264 ++++++++
 rust/bindings/bindings_helper.h |    2 +
 rust/helpers.c                  |   15 +
 rust/kernel/cpufreq.rs          | 1090 +++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |    4 +
 rust/kernel/opp.rs              |  895 +++++++++++++++++++++++++
 8 files changed, 2283 insertions(+)
 create mode 100644 drivers/cpufreq/rcpufreq_dt.rs
 create mode 100644 rust/kernel/cpufreq.rs
 create mode 100644 rust/kernel/opp.rs

-- 
2.31.1.272.g89b43f80a514


