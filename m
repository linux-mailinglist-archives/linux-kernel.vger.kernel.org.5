Return-Path: <linux-kernel+bounces-100829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E649879DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86511F227B9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8A5143C4A;
	Tue, 12 Mar 2024 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KKRfRaWe"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F9143C74
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279876; cv=none; b=Pq13MqD6gvf/IN9y8JR+zWHPuH2v/oJP/6dIXo81o25oX1gPlNOftLX6x6xzISCfilieNi9IWQSJCC0PnLKScmLVWT/2M6tzLPx5wo49TcgF7I2uypM12c0GIGLy95ahLyAniBAWeyYFzUQvCwD1YZt7esqU/QwX0H+PMGvPKcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279876; c=relaxed/simple;
	bh=XwiL2+kAZDq+JSypY/KCkgWIbQMNeeVzIuxHI5gIcF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tn+eZnuh44Qwv0jvOZZO35RtbbFRIdEmIemBGhYxjzV1f8+eP0CpD5BW6EFb6M7Hjgp4JLQjxxnCthDHCLtU+tjuwOwCYRb6Cx5+qsnvR2gxV+vMkyhM3bNUtmZyrbV/3BWBStQXlV6PKGBIrOpS8Ni6a4PM22zMMfO2Ubn5QvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KKRfRaWe; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5139d80f8b6so4061192e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710279873; x=1710884673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+QBam0nDIK6OKPia5iCGv4lhBlNNZUHT9InuuVs5DM8=;
        b=KKRfRaWeA6WSJdE01jClK/UZ9c6TbaidThWmnu5tE+bYqU3vaT19gg9q1g4EBuR2hW
         PfrPpUU+cHjfITAphWWvAg/c2+9qxtNLlhQPJHmt0MoogdJ5WuLTFrkz3WbcTb0nRtCo
         PX7RvAUAW8e2nmLuUzA2wIYw+qss/+WxynHU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710279873; x=1710884673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QBam0nDIK6OKPia5iCGv4lhBlNNZUHT9InuuVs5DM8=;
        b=bIerk/Xk5GxlJohdzC3IoNq+HWZfT6HPsXz+z1+lLbqIOL+/tMgJqr6zYFUfcS90IX
         5UvidVHVaDLBL2MNqciEZ9+pjkaAU+bt0wsh8C0rAyjfsqKwkFH3Dtw8xZZ9FG9hxZoa
         Ze4pLnqGVHei3+/RyutThflVDSyPMDw7/i+CtBw87CvOIYtn1XRO/fdZtxsXlTxe/vnu
         N17x6Oz0M9fbyEjivfGRaDxvnphUOsytlUhPMc4JFEo3CeB1sLjFSrXWdlg0qIXr8CU1
         qmaiJ5JXaqBpRZrkN9J5bIiLNc0sMDdHWsPUC9hwppZo19TT57eilV5/aoQCkbO4ind0
         gKXw==
X-Forwarded-Encrypted: i=1; AJvYcCUbmwJIdq1A9LwXHiu+I3M/G92zTqTUaJE0gWHRauI4TEkU8iwi5Ic/0HEykiqGHnQV0uMRkxwWmPW3VosJnzOOG4qfUTVsicSkT01E
X-Gm-Message-State: AOJu0YwKPSUz4DUodiOFgpp79nbjc43ZQDffsAgZd25O1K5T6EupIPdn
	x40sMpXaQjOckljC5YMG3XXO263i1O+aIYmwEHujL+z0IAN/XeXb6JaOKe5ryBk+CVP6i8TwOU6
	aZb2jpA==
X-Google-Smtp-Source: AGHT+IGYXSzui40sAOARuLzSdl3JJ1kMd+x3NuMX/kHb2RliY0ysTU1qQ4bD+SgKmKq4g2uT+iA88g==
X-Received: by 2002:a05:6512:3ae:b0:513:c2aa:6b87 with SMTP id v14-20020a05651203ae00b00513c2aa6b87mr1304155lfp.39.1710279872857;
        Tue, 12 Mar 2024 14:44:32 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id r3-20020ac24d03000000b005139f4ffdd9sm1578659lfi.30.2024.03.12.14.44.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 14:44:31 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d208be133bso69181991fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:44:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAJFYFPZXhC4yecUnUESQVplaTzojRgvkZ0LcQHOwGGuTMjSEiQDPdhQ275Gx0Qz5jxK+1BS5NOG5/n7eWVpmUnruPjnlv8WBJpUGj
X-Received: by 2002:ac2:484a:0:b0:513:5a38:f545 with SMTP id
 10-20020ac2484a000000b005135a38f545mr8283446lfy.62.1710279870592; Tue, 12 Mar
 2024 14:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZetHwrCb0KXE0xFI@tardis> <4274be61-60bd-4e1e-9c16-26e6e5e06f65@gmail.com>
 <ZfDEIs63EBIYBJIC@boqun-archlinux> <c5f9c640-4c06-495e-9c7e-0c208b914fa7@gmail.com>
In-Reply-To: <c5f9c640-4c06-495e-9c7e-0c208b914fa7@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Mar 2024 14:44:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>
Message-ID: <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes for v6.9]
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, paulmck@kernel.org, mingo@kernel.org, 
	tglx@linutronix.de, rcu@vger.kernel.org, joel@joelfernandes.org, 
	neeraj.upadhyay@amd.com, urezki@gmail.com, qiang.zhang1211@gmail.com, 
	frederic@kernel.org, bigeasy@linutronix.de, anna-maria@linutronix.de, 
	chenzhongjin@huawei.com, yangjihong1@huawei.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 14:34, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> and here is a log where this fails:
>
> https://gist.github.com/ffainelli/ed08a2b3e853f59343786ebd20364fc8

You could try the 'initcall_debug' kernel command line.

It will make the above *much* noisier, but it might - thanks to all
the new noise - show exactly *what* is being crazy slow to initialize.

Because right now it's just radio silence in between those

  [    1.926435] bcmgenet f0480000.ethernet: GENET 5.0 EPHY: 0x0000
  [  162.148135] unimac-mdio unimac-mdio.0: Broadcom UniMAC MDIO bus

things, and that's presumably because some random initcall there just
takes forever to time out.

             Linus

