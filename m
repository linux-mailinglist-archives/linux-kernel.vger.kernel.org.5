Return-Path: <linux-kernel+bounces-94167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796C7873AD2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1F81F275CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C296413D2E8;
	Wed,  6 Mar 2024 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="d8Fpz0Zy"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C5213BAE5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739338; cv=none; b=kuK1YI4QoMWNTCjqyv7hZ2b1u62wOylEt3fgYRx2fXzHTO8R9LHmURB0byTWQqfN2AqXYty8pKO/zrx0mDEo/QxBETluK7sAKJMH0x/5pQ1VfrNT8piUWEumBNNPxzBQO6+y/VQ7y3l5NUaAzEB9Zx3qak+WpsxFRYn6m147ew8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739338; c=relaxed/simple;
	bh=VBft5w8jsJHzEyBJ6P97EckERupZPHmyvdDoIbCDjQs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AvIvXnGiDLwXUVBpFpDaQ6RYlz8a2iqwYi23g7Uj+1RtETFhT0tXvieLW9ErUrE5yarQWmz6ABRdZF5/LAjY2SWn0ivJcVydNmMAYnUCvTZbmNYlXsjYu/lOCmIYI6eL8vO49hQoYhRXMJQyNqu0VlEtMnT2H4jnhjWN3+W0r0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=d8Fpz0Zy; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7c876b9d070so12649239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 07:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709739336; x=1710344136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSixkOvyAGzPmQR/w8/wd4aDROkCteYD9fEs3nqiTTc=;
        b=d8Fpz0Zy0b6wygN1q8Kl0tL/bmsMH2o4jySgbenFTg+/BwcRrSMoe47vJt8OP5PsOp
         zSh5D96plXFBKplFMAPEXk9LpLGsQtan/9KauT9vWCQAHNZZoi+s8Ez3mMShwhUff/Ws
         tASrgdWTTtBNO1l30UyAnn5dxXlIGn+o3HHfCnoaKoHT3X/cuTifh8npP32vmTV9Rxlw
         Xg3B0sg137IUpqR3N10o0UfDCuTH1BEk7UFjqtUkwAiZDwGTQLqpQCD1VO4UAsJQqeBP
         0gU1YuvXhHqNgX41y+Yb5kEBFsGDnMG47hje6o1dFWFI2ACEQxRsHNRg+HsdX+rxk7YG
         u6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739336; x=1710344136;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSixkOvyAGzPmQR/w8/wd4aDROkCteYD9fEs3nqiTTc=;
        b=P7ZHz4beqCLC6T0DiDC4LGYs937F3IgrCheev0nl48urYCcquZfiqJkj6M6rh9k7AZ
         KZRRGzIjcXBNUIb13BOY5I8y/mkg2sTLM5+pPTrzMvec/SIjjGS9ivz0FEDLMk4K8/zm
         oh/X/8XEgqWgd6MEFYJmjlM8rSPiMI/AJIAAXhgyBZ8nLx1EfqiYQg78h3jdgEw0P0cC
         tGm3H6E/CkCRxTZS4ZCh3/JFussT+qhYKLEd0h56SFQ809yC5fzdyr24jXbDAk4DZvr2
         esxuA4WCJaLHgj27EMfOW3jdkMyGPsLQkLcjjkxt6I0kf6nFYKUbZx0ttDaxfBrphXah
         UI9g==
X-Forwarded-Encrypted: i=1; AJvYcCXoC31h5YJ5aJvJQlvmLs9EiUawwRGBJOQ0f5gF0oWiIJMywTyceR1U9BdKgbUupHV3CgNlHsSXnzt/iPAUjnBpGvbWE22SQvIezD+8
X-Gm-Message-State: AOJu0YzTp7FqnmRGg1xZb7U/JqPhE1FAy8mUuszeZrahZq/hJezZB05z
	dOEbv0BehiDa7IawDbP7hqM7dcoHQidzruULaFcCaeYERVqtyn1eb5ZSyNl6qHQ=
X-Google-Smtp-Source: AGHT+IFSaGBg8sH10us0bskBsK7ms5bsiWhwU8fuVwlEdJVXM3oZMPq6CZjM3bs2N5+keLV24lzbqg==
X-Received: by 2002:a05:6e02:1c46:b0:365:fe09:6431 with SMTP id d6-20020a056e021c4600b00365fe096431mr3733400ilg.3.1709739335996;
        Wed, 06 Mar 2024 07:35:35 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a92cc42000000b003660612cf73sm324467ilq.49.2024.03.06.07.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:35:34 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Justin Sanders <justin@coraid.com>, 
 "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: Pavel Emelianov <xemul@openvz.org>, Kirill Korotaev <dev@openvz.org>, 
 "David S . Miller" <davem@davemloft.net>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chun-Yi Lee <jlee@suse.com>
In-Reply-To: <20240305082048.25526-1-jlee@suse.com>
References: <20240305082048.25526-1-jlee@suse.com>
Subject: Re: (subset) [PATCH] aoe: fix the potential use-after-free problem
 in aoecmd_cfg_pkts
Message-Id: <170973933432.23995.8994501180418490235.b4-ty@kernel.dk>
Date: Wed, 06 Mar 2024 08:35:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 05 Mar 2024 16:20:48 +0800, Lee, Chun-Yi wrote:
> This patch is against CVE-2023-6270. The description of cve is:
> 
>   A flaw was found in the ATA over Ethernet (AoE) driver in the Linux
>   kernel. The aoecmd_cfg_pkts() function improperly updates the refcnt on
>   `struct net_device`, and a use-after-free can be triggered by racing
>   between the free on the struct and the access through the `skbtxq`
>   global queue. This could lead to a denial of service condition or
>   potential code execution.
> 
> [...]

Applied, thanks!

[1/1] aoe: fix the potential use-after-free problem in aoecmd_cfg_pkts
      commit: f98364e926626c678fb4b9004b75cacf92ff0662

Best regards,
-- 
Jens Axboe




