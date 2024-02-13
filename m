Return-Path: <linux-kernel+bounces-64558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A5D854044
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011DF28BC25
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B752634F4;
	Tue, 13 Feb 2024 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dHI12NHQ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1935F633E8
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867736; cv=none; b=hXIudnhzb8HLxLmEQu3Kv5KnQkisKt0eW7T9r0Zi2Mr+5rAxVBculnH1WHX8u6fb94LQsqjI/8Le3BY5P9ivWeTzqtCVi4k3ONw/jU3hsqERo0Q0a/HgZDRXBqzAF7OOyydoS0/LtCIlstnxHmpjrswH6AhfVC3tyvQb3QAn1VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867736; c=relaxed/simple;
	bh=hW38y6WJPmsQKEP/qFrXd2E/XyKsm+Fe0LPU3IywHpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g/CFxI7Bg6MEP/62sgIPmQSCWocQ1bpCR13N1n6+GAKG6fHDiS8qp+CrTm9Y9mDKZ76ZXO9aJtGMl5hlLx336ZTI1vWorvOjT5Gufxwg0mGOET9bS65UzGdoNYo5XoPizxr5KzPWuy4oRxKdn4Pj7HCzwyWRRH0jRPFvATqVRo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dHI12NHQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d7881b1843so44920165ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707867734; x=1708472534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w0mtIXHXlHD45+RwrtuutvVPykfnjMAD2MPuh04ZZ3s=;
        b=dHI12NHQ5dgAHFBfowyiQtKNdHLqZd/wG1vOdk6njRdmkBp5lGO1RxOpRi9Swt6y+W
         dzzUna8hGb5ESOxrHsebVb4zwRyRT2Zn3n2mItOWGqfH1oAGO/SIkbGqVvD5z23LFjYV
         2KSVGM51OoMvtrRb26c5EecAkiKDcx3vTZ/Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707867734; x=1708472534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0mtIXHXlHD45+RwrtuutvVPykfnjMAD2MPuh04ZZ3s=;
        b=qeevAvuEbJi4VfOcr+kxBOnplEHIGxf2KdlrO0eoaYFyzo8jnLYoKDU3dBmtUYZix5
         lT0XSXqeRU6Zb1HUc+grMIO0MBX07BzkRiEKOrxbmH7NfgmDKN9goxGflxSc/34Zbs7t
         I5+TE5u2+pmZFQ4zVeeL9DIK8EOYVpBeGdywlPqtsmqi9w8m8pTZWtUCNDPY2aGsvh/s
         VqNN2qXZCs7B0+A6JgHOpNoPrjP2dcPI5+bePC7HAdRSfX2PCUlaIVOlVmnThoGF2or7
         I0HRsNOKZovCGcxswBESC1DXP/bSvvdfLSTEKrhZ/UvAYP0JvQIwtoEBLLHhiQ5HHshR
         kDLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1SfuDg0k6q0Voi46QuaozlqVziXnDxU/hgJ8BHr5SYDKfNjQJQHWpNs4bphJBQFSF03Qt4wqd9ruybTVyYwbAGh3vTaLBiszXwDzE
X-Gm-Message-State: AOJu0YyzX8+fnjyGqE33s1wI/WM3Li3sLk3sMeSMc7GULKrj8cLilXaM
	2HO43z3j9WT+ham7mi3cR3OSIeeESzZP6usbc38UBik4g+RQ3rCko7b4iKrg7A==
X-Google-Smtp-Source: AGHT+IHDJgqPv/xuU8lFld0zKdNYV8TeMbseDl3sf1xG7aS5xoPNoFvvAKYSASG5Iou256qbZKti8w==
X-Received: by 2002:a17:90a:16cf:b0:298:b8e0:43d8 with SMTP id y15-20020a17090a16cf00b00298b8e043d8mr904976pje.27.1707867734338;
        Tue, 13 Feb 2024 15:42:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRaKZwxlf/vLGJiePIxgGvw+Rh+hGu6ddU0v9g5Xv63csNEKWIXEHNQFWqF83g7BtryViuHLdyX9GpftZ2jYcHge2r6MPIxZsoC5+4PLqHru+VjG6wsfRfIohT6O5MFCawb9bwDrtTWGlTx4M1nz6+6Q25Zy08Tio6b+3WoQUIZTwV578VHh67spTB96xOFgSn+FdY1Sr0McJtkJTsCv+1me0fxK4lrg40lWlk1Y1obC/7RiOUSNhwhxc+xyCas7WzKzFMqvisnw3Y/iKVYD5eNHNgAexuRE/CLWAGf1Usetwc3HEzuJ+zUtx7DeQXox8LlP57OX0QDlAJlvPTTEQzdbjWkgBEzn6f5x7zhHrG6ZGyW9ikxY4lHLMhhrgQaZ8in9hCooYWIYQIDM0GnnyVymtAnNtWA7ebpn5poU53f8yuRzQxTBQiVrbGCfNCgDAdZDxoVFrj7Gs2w+iuML0xF0HLkr+8HuulAmBBH0abPnv8ohzwxDlgpMswmyej
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fs9-20020a17090af28900b00298c686c621sm80939pjb.56.2024.02.13.15.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 15:42:13 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	Keith Packard <keithp@keithp.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/2] stddef: Allow attributes to be used when creating flex arrays
Date: Tue, 13 Feb 2024 15:42:09 -0800
Message-Id: <20240213234023.it.219-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=810; i=keescook@chromium.org;
 h=from:subject:message-id; bh=hW38y6WJPmsQKEP/qFrXd2E/XyKsm+Fe0LPU3IywHpE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBly/5T6BEAiVA8ujTLHGCLG3BpSzMgWwdTvSXxf
 E7rKurlcc2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcv+UwAKCRCJcvTf3G3A
 JqBqD/9mIQzk9MdkbeFAYfVd/iZ0m2dYUxas19LCSHaOrGZQI0szGULd0bqf13dJVpN2tvCFgmj
 GCEuMWeucp8FI1zC6dhnBVakXkFa1ZKBl4XNDXuCJoAi7VbUxUJXfZHRiBuJ1Lcud8m7K4TMU+4
 qI/M91c4TTVupB1sJeX4AWVCQx+6ASKMbc+OUa6JTKaRAruQIOgQTHKMKO9CP97AdFaz5ffz/V4
 v+OzLD/klAGQgHjCsaklLQFPyTcH9kSoDH0cd2lZSN0f11rcNZwjvoBTbhq6LyH2orvO6iE8M96
 eJB2MQReblKhqrfAUC3xclD1TTjJtIfCM4u+Wlndnf7QUCY9+GaBiDJSvfrHoHOIEboNUwHikNN
 Z4oTgT/Swk93oWAY1ZKdLROZsSwl430zoc6+wim/hhog/jqgFyxFauzsLZV0XOjgxp6RG2VTFOX
 pDYM/xs6WoYE1BgtdNq0GvzFBzFm/h07v7DwhFjX91nhz6LU2ydcyqCUHTCHVcFYHs99E7m7M9n
 PrAjBAycwW8n3aqBVwGkYl/J4MnWnxjOE/xhEuDYjyXKP82yI5RPTjb+ivNXAJ8o7JUW7bRJKkx
 AFHR/FWOYIth6aRlgFwNxfbDizVarYamv9scUJksPEj3CfUEDNsZboESdmhTDEVh4UdwTZ2XFye
 TVR7dxwK 7sp99PA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

v2:
 - don't add a new helper, just add __VA_ARGS__ (Rasmus)
v1: https://lore.kernel.org/all/20240210011452.work.985-kees@kernel.org/

Hi,

We're going to have more cases where we need to apply attributes
(e.g. __counted_by) to struct members that have been declared with
DECLARE_FLEX_ARRAY. Add an optional 3rd argument to allow for this and
annotate one such user in linux/in.h.

I kept the acks/reviews since it's effectively the same...

-Kees

Kees Cook (2):
  stddef: Allow attributes to be used when creating flex arrays
  net/ipv4: Annotate imsf_slist_flex with __counted_by(imsf_numsrc)

 include/linux/stddef.h      |  6 +++---
 include/uapi/linux/in.h     |  3 ++-
 include/uapi/linux/stddef.h | 10 +++++-----
 3 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.34.1


