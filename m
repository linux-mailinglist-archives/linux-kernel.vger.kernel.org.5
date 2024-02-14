Return-Path: <linux-kernel+bounces-64678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C19854162
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D231F2563B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B37AD27;
	Wed, 14 Feb 2024 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B8jeg9Bc"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C909449
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 02:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707876564; cv=none; b=eZ8W9YxlmJ6fZYm3GcgWtf4v32SwB0ozZlY4kXEGCOdMIIammcEdnvZb+/6Li7E0u+I+zDXRzHQ+SMMnfrmH3ZdyuQb86sSyEV8nB0h4WLWcFFts6oG7NbhwwTeyfU9+erEAWXha5YZxxT9SKIA383CeGDcSP9uTvSS+v+A2VwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707876564; c=relaxed/simple;
	bh=qPdFwZ8mnINsKo+kaHmLBcNmgicBBXUmqQA5j4kA6R0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=l76ZjBNnXOmDZKiHt99hYLOx8KkcwyXRA64HTUcOeO62zFszBgvkCFhkvX82STLcP9saGNVbc9X8cdd9NzG10A+vqK/ydW7uGpYvc366TE3e/CC8xewTlvXu8cC73NtmQoP8eAc6/hj34mvtq0p8rmgBzn7bqmXT1iE7SKxIcFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B8jeg9Bc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e0eed3a0feso2697424b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707876562; x=1708481362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7v4C1q0Io2313q/W5uOI8OVc5LXFtxFMDUw5WZo5KU=;
        b=B8jeg9BcejyyotqduNDFTiBsW1oihmbDl6vv4V1a3aNOrZUqP92EsbU07+wWlAM5rt
         LNwpkxKvWxytbpLIx1RaOMVk5LYuFFb+HzDp5c85zoeeP48O6sucPbEydjHn/JKceXc/
         XwfviLAX5t/wQ0taDMlsnzmF4O4n7w69JK0ov6LzLH2tyThzYX8jIOsHeV+p4p6uqBIh
         0f0D02zaFGZeXRaoqqBtJBlrJsKLnWEmW79uhOaK6jEk9h7h6UMoszv8r96uHeMnL9Gi
         sPmVHqq8FZ6te38LArAdHkxaJ01+4pn1Qlg5GgHjuGkpy6AifcZKiA66qKdPbPahbQVv
         eIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707876562; x=1708481362;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7v4C1q0Io2313q/W5uOI8OVc5LXFtxFMDUw5WZo5KU=;
        b=pL2ZpIa1jrv+FLiBvIn7aIrL6oci4T4+rp7/tU2jI+zmVs60krrV92thQSEKwlJj05
         yCs8YRms1fbIthpgrMK1HnwkuKqBKLQgpskohsTEtzqozFLRG2lqofMo/jcpzwEK0VCn
         DzcBT33hLFYrMGeBdLsFlBKA94O7ty1y+3eZTIVuN6gRJmQNttrVCBMRO58qJXpJ7Pc8
         UqoV8GnYhA65hbUr0DlyCnPDeMdScQBpH4ry7zWzigy9A8zYVWjT4iBitllZX2n2VYk5
         9WhTFb0yW1XIOD4y1lgC+zsvDF1I1mGk/gtJ06X0YtFn4VeYOnWfSYCWUhBF2FRhO0iu
         Ad4A==
X-Forwarded-Encrypted: i=1; AJvYcCV38kRdjMQlD9QElzlFKSfAajGyWpeygqdI9MnGrdYXZTOLZYElfXlIfa6H1sPxZCwxoN+c/pP16QdfjuVp2smZqGgs4X+gLOZNmS0S
X-Gm-Message-State: AOJu0Yy4RqC9qVno3U3q9EupQcG4uuoGjhtz5nP+EfsT+NCCEjn2h2tR
	dL0xr3lS1l7DLsayHePGLOIF55hWHTCnczBAr+8Din/luOaWD5hCgy6WXEum8O0uUk5kMn7yMCP
	lIw==
X-Google-Smtp-Source: AGHT+IFOtqME2k6mUPFgh63d9O2YFa0HCB1jMzt686qjh7+JgcLUO7AjEIbRv74K7ghAKX7VJVLw/J/O01k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:6582:b0:6e1:e45:3490 with SMTP id
 hd2-20020a056a00658200b006e10e453490mr780pfb.4.1707876562673; Tue, 13 Feb
 2024 18:09:22 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 13 Feb 2024 18:09:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240214020920.1152268-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2024.02.14 - CANCELED
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

PUCK is canceled for tomorrow.  No topic, and I need to catch up on a few things.

My apologies for the late notice.

