Return-Path: <linux-kernel+bounces-94164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11087873ACA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6001F25AE1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212421350EB;
	Wed,  6 Mar 2024 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qs21YGN0"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1343B137938
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739331; cv=none; b=nqi+WPp/KJOOyZclrx2FAsVWYEQYmQN6W+gUVicLV9Upg9dR5CTIy3+ulHYpSoScbXjSCQxKEMbtazTEZfWN/4SIGIVfbBwuZfRDaNS/7QMUlZ6r7wykwIPL8rlEm8gBWTkWbQCk+/qPFSFyeTrrxrmdO2bZJ49ABZVLBZmb3RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739331; c=relaxed/simple;
	bh=dZsHluELpxThA4ufzRXLg1tsWuDW0EQo81tF4SvlUgo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DCq4DvVeEYEBdpat127wgsGDCglJBj/2CD8eCtr/KdfRc3rJIiMJ5b2h9UZMHqv1DfB6skrT9v/bTPlZ0vsbwFeJQeejZixwPNwWWpdJxMfo2WKn6EeEs+1UfayBXBRWbyrOmsJgAPEAFUy9iiX3mhtkqKCXMaOKnkSaZwq5J0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qs21YGN0; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3652ab8766cso2353255ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 07:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709739329; x=1710344129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSdm3xCNOw5L3H2ytBNDBWUHcL57v7ZuHcJR5VEh1eE=;
        b=qs21YGN0dtshHxBrRyAEeniJksLrWeGfp8udtJJbn1A3j7eW87/aQipDtUHdVM4WAI
         ktjGl7lcT05fjMw5MQN3de1AynoKhv7JoHWCdJpECdV4aAibNWU4ztUqauEFYJJCOkCO
         gDkd+WTEsQ/jiqQx3ZUJNWUe7cbs8JwYtc5HhZyRcyS+HWNTr5B8/iu3HY4NPWMELVcf
         Mmw7cR8OstCgjdwPh9ssqv5Hqg3zLBVtFHHd3Vn7IjlNm6RKRZp/AGgYiDiAeoLtdTRL
         uTrIVTS1p7bRt+gaqptVChRA1k04mgKDC8w1SzLVk/A08JpG6O4AEKV5+u7D1rHhARRU
         PNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739329; x=1710344129;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSdm3xCNOw5L3H2ytBNDBWUHcL57v7ZuHcJR5VEh1eE=;
        b=QCiER7DD5pa2/iD7NuUmPWsjrHjG5ckghzI1s9O2KoQ2j4wEH4v47FLo2U28e6HYWD
         ot2wiQgQOTkwR8JozQK3eZiQJKmpi6L8KE2Z4ZRG/II3FVKL8tVoYLxnTPLko91Qi20R
         f8sX3U1YfBHVGUiJqxQP+jofDjIyhYEoegD+MhVEsrui01apOT5p/UjJ/FEM5zPiwDWY
         n873LnGjylSZk3tgwKof4z7MqrqgOtg7MamX0hyyhHWXM/B1PSY2f9kiEk4kmh+feQWf
         Us4CRec61ZWfLsNOhRSVWvw7fDz9x1i2VKeMpl34GkO1tMwp617VHXumvBI0Yi0f34Re
         ot+w==
X-Forwarded-Encrypted: i=1; AJvYcCXZ45y71GafvIVwCjQQ/DqAb4gZuXY52bL6yngtKKPBKwooknzg5VkL+dv5+CwCMheljPnkfAKaqR5Fk34dlJ76+HCCLbEiLoQZLRmb
X-Gm-Message-State: AOJu0Yw4ZSXQcpR0AQQxAETpwU7QAe9bNrKtMXj5tgZst6wCiT4APH5b
	4+A1hzq+NGEevCufERYM+6mgckkntikM62F0m3gZ5cGrAyh2TDY9o4yF37E0dAWStAwcZ7AnFMP
	r
X-Google-Smtp-Source: AGHT+IEZTHfIPT4859zUUwoBO7opktZe1dXZGddcV+g22sdFWDq2aD+qE5us/9CWULIsvAEGwxSDkg==
X-Received: by 2002:a05:6e02:152b:b0:365:a792:3749 with SMTP id i11-20020a056e02152b00b00365a7923749mr3880459ilu.3.1709739329270;
        Wed, 06 Mar 2024 07:35:29 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a92cc42000000b003660612cf73sm324467ilq.49.2024.03.06.07.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:35:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: jonathan.derrick@linux.dev, Li kunyu <kunyu@nfschina.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240306101444.1244-1-kunyu@nfschina.com>
References: <20240306101444.1244-1-kunyu@nfschina.com>
Subject: Re: [PATCH] sed-opal: Remove the ret variable from the function
Message-Id: <170973932758.23995.16246146995676914461.b4-ty@kernel.dk>
Date: Wed, 06 Mar 2024 08:35:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 06 Mar 2024 18:14:44 +0800, Li kunyu wrote:
> The ret variable in the function has not yet been effective and can be
> removed.
> 
> 

Applied, thanks!

[1/1] sed-opal: Remove the ret variable from the function
      commit: 5f2ad31fbb18565645f121b413837f260748e963

Best regards,
-- 
Jens Axboe




