Return-Path: <linux-kernel+bounces-128871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5D8896158
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5840928862C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40E6D272;
	Wed,  3 Apr 2024 00:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rCctj4kc"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94DE1870
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 00:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712103959; cv=none; b=V0zsqLRKijnLs+9iIfEyk94P19vTM+d8biC7LHvxjDP0IpZzsPkGHH8C0f9rArYRpeSx3uGTW9Zpu1qgmkdqwbQWX7ANgj5kYziQKFUMk54BLO55K5Y2NlwKzaewMkM+iZ5damZYs1OvqE4apvTBxjVdDX8jaTR9kLRyw6hot5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712103959; c=relaxed/simple;
	bh=CMZjqoXY0RIZMdPXHMDU53a4jFQWckzmNS0LQOaH+CA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=A2BkACxcg+mBxg+rmGIGVaPaXhNVpFoW0iERqScHqoQ1u1i7DmmmLaRIffb8X+sp5cgDmIypzWEHbrXvoDbWoso/ZVmY9WEMiG9/NaJYfpcNnsueKva3MjEmZksS7r5tWfNOUxwBokUR0j9c0dBLZquwUqNdaS0gYX7XEBRba8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rCctj4kc; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5dcbb769a71so5804072a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 17:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712103957; x=1712708757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kr9KWWXSbwQMl1W3P1ShdqzyIsb6ffEOm9kzhYBT1o=;
        b=rCctj4kcQ6NwtKYTUUG9MvaaeiL8UYKbuLsZM1ZqJ8TGliaPu0Eg6Uax48S+IDKXel
         1XfZtsLr0HqaGljpu2T7taI5DnjBLJDEhK5ElbeRWQ8m8qs8XRg3ctocGvu7UWDNWKcb
         NGlXpxTxIkJUkZZclov/Hfgx/6PSlBMsrpOim64Zmk1EhQuuqK/1dlfehoSHYLba0kMf
         Of3Tfq0ygP52hyR1TxXicD/Wm3E1ZSuF+5A+Z0sOijDJ8wMCfYW5N0wJxbO5Gl9kz8XU
         YxEuPUcDUeqVSnWVW/1MLdOXN2aMvHoRkJsisO8XLpmtnQ+5v9zRhPX7yN2QWIsoXLBB
         OZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712103957; x=1712708757;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0kr9KWWXSbwQMl1W3P1ShdqzyIsb6ffEOm9kzhYBT1o=;
        b=FXPOiW8vY+PxnTlJpGYApZZPROlOBSD0bYD9nAebSKjpRby0uQF7BVo2mF3w7rFtn3
         2xR4nje+ujEeWor2gUe8NYldenCBCgJb6RFrdZq14t8eUbMn28Lyrd84ar8CwX/NoC3p
         mJybBhfSrNVygrUJY/uqAWYou+QjLPLNsbv2jUGQkJme+btDlB9H1+A3mtN9M+rbzspM
         MJTcp4K1M2EdAANnG6VvkYNgbhijQ/BuPI+lSrecmV841rEcRknua0f+Dd0WdiXQ+s0P
         +BnJVw20JswWsphx7D+I0QpnzjTyg0UFva7H85SKgm5CiQOTcsE4by6/VVDnZdDV/LO4
         nqQg==
X-Forwarded-Encrypted: i=1; AJvYcCWj/1JY6u4+zlEmTQRoST5MMTKGCaLjR5QE7lLeILD34HdOz/WVmZoUUQgg2+whuNYvtIDRCvOShOqqkwHpejgagGrqror/Uaafha9Y
X-Gm-Message-State: AOJu0YwXBXIEDsW5sVNz1XYbIkPYCBtUCLwHYPfU9hUfWgyDhRUx0qI6
	aapCdzeju701mXc7rONUOV4idZ2/g4/khL2XdhDBmIczKvdoL/xIrG2vxtQLh/hXrIDISv1AaBo
	27g==
X-Google-Smtp-Source: AGHT+IG9MI8Qnt15d8mR4lpsuvXzZoy/+itHKZOa4aH+2/d2VW5Qk0S0HV6LV4xAAm4immTfskhZnGmM1Vo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ea0b:b0:1e2:26de:c622 with SMTP id
 s11-20020a170902ea0b00b001e226dec622mr1094018plg.12.1712103957230; Tue, 02
 Apr 2024 17:25:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  2 Apr 2024 17:25:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403002554.418953-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2024.04.03 - TDX upstreaming strategy
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Wei W Wang <wei.w.wang@intel.com>, David Skidmore <davidskidmore@google.com>, 
	Steve Rutherford <srutherford@google.com>, Pankaj Gupta <pankaj.gupta@amd.com>
Content-Type: text/plain; charset="UTF-8"

The primary topic for tomorrow is how to get the beast that is TDX across the
merge finish line.

If time permits, and no one has other topics, live migration support for TDX
and SNP might also be discussed, but I don't expect that to be much more than a
high-level overview-ish discussion at this point.  In other words, I honestly
wouldn't join *just* for the (potential) live migration discussion.

Future Schedule:
April 10th - Available
April 17th - Available
April 24th - Available

