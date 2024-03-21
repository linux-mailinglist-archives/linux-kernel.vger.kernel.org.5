Return-Path: <linux-kernel+bounces-110694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63545886282
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7A9FB213F1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9908D135A72;
	Thu, 21 Mar 2024 21:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="PPg4n7vg"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281361353EC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711056328; cv=none; b=SnBMxnakB46FmA9KUYQHzdVYLzXPFhBlWl8136wTe27txX+2fH4O+9iVWnNLtCjuaFodldm0Gqc3XmHFJFYBYbXes4/HZ1yPzDfmrkPc24kM41ScGpwioIWm6FARwGm3h45wPkLNjNMMEj43LVjiybz1cC0cUieiImMGKRnO2Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711056328; c=relaxed/simple;
	bh=ZmeXOty/8haX7G/IQpzwTPK1G6wnQWo2YpkXl5B1tEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iib8f9dcvogkLElgcHEV91TER0ueXGNr6/JjIZfKT+4rQJPmv2Gq/5OQiJm6F2sncmOYpHAYscEg/27wkp5xX4PevQP6wWDQz7qltMHpEHYLYOneyouY1u57/Qi+Ro9azvF2YyTikuDNEh/y/YjNBCm3CAdcjQaTQwd1++MRD5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net; spf=pass smtp.mailfrom=iwanders.net; dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b=PPg4n7vg; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7e096ab9287so543832241.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1711056325; x=1711661125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmeXOty/8haX7G/IQpzwTPK1G6wnQWo2YpkXl5B1tEw=;
        b=PPg4n7vgZMhHVL7qHRoVMVdHbuRJDg3UmZHpH3eKGVgp/BZE8Mx+s/3obwSClXiyFM
         XRdM9Y6j6B2X/HMJVLa4F8+wipXXNISLg5WHuU/+2Av0dvyEnIQ0YaS6ejH2vE0iwUEB
         9iWqPoYjrBBxwLvDEBCpiCayYgRwebKWJwRC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711056325; x=1711661125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmeXOty/8haX7G/IQpzwTPK1G6wnQWo2YpkXl5B1tEw=;
        b=NVBTRuDnQXoZu7IISqI/QQ3Jh7k7VAq9ZGkqS61ZKQW5736ZM35v/8/lZ0bzq7m0Ck
         /z+/cJ4R/b6VWdgrWlzsRfCV92DMjh0DIyuG5koJNU6XMg4WssFER77A7ZIndZ5nsowa
         YzwTzQCCB8vDUxK1RsPlNkSoOvnsZ444ytBbfH4IrHhYmBwZtFUJb/X5x238VeQf9d/q
         XMSoL7gYC0VTsFnLhFkKkNqYtC8595V9FG7HM66Vl6INwQSk6Q69OM7ZoZyr4uVpFbMp
         VMsWK9r2iybHajA54FMg2P9yTltnxrl3mLXHnZjD5P8xiY5XiMSAAAj/BMfKr8h6o0Uu
         xzCw==
X-Forwarded-Encrypted: i=1; AJvYcCWPqiRsAXq0Lr/FDAkk6dL+bPyjHiQFFL+OWfQ2f+J67tbNpnljUIWhbAZwSCZ7OzwnmocDQQN9jLQ7ZHQdGUvn3w7nlfI2KNsYXGk1
X-Gm-Message-State: AOJu0YxgTCbUAopovaf/pLfFL0vovVrR+5hOcFFlDAqQNSPRvWdwa7EX
	SlCxPHDAShtiFSgMThrF1JhukfYDKD2hzgpKHvYYarPo31POvCgG9ogwjZWA+RA=
X-Google-Smtp-Source: AGHT+IFGVoYlWmW/2LhORkKDCpnHJ5RgISbUB2EttX/8dcFtWMsr/KoKwOBaHZgcy59oLKuTzjc1+g==
X-Received: by 2002:a67:eb57:0:b0:473:3801:e113 with SMTP id x23-20020a67eb57000000b004733801e113mr777972vso.23.1711056324851;
        Thu, 21 Mar 2024 14:25:24 -0700 (PDT)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id js4-20020a0562142aa400b0069049298fccsm313202qvb.65.2024.03.21.14.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 14:25:24 -0700 (PDT)
From: Ivor Wanders <ivor@iwanders.net>
To: ilpo.jarvinen@linux.intel.com
Cc: hdegoede@redhat.com,
	ivor@iwanders.net,
	linux-kernel@vger.kernel.org,
	luzmaximilian@gmail.com,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/1] platform/surface: platform_profile: add fan profile switching
Date: Thu, 21 Mar 2024 17:25:21 -0400
Message-Id: <20240321212521.3834-1-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <71c9e24b-c64b-581c-87f0-fb0c58066ceb@linux.intel.com>
References: <71c9e24b-c64b-581c-87f0-fb0c58066ceb@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

What is the process to get this merged if no further review is coming in?
Maximilian Luz approved v1 already. I just confirmed this patch still
applies cleanly on the latest upstream master. Do I need to send v3 with
this reviewed-by tag added to the commit or can this version be merged?

Thanks,

~Ivor

