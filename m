Return-Path: <linux-kernel+bounces-128073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BF18955AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2321F224B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC7E85645;
	Tue,  2 Apr 2024 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TkkLif0U"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6678564C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065417; cv=none; b=kaPWoXu6u8XqkJ3NE8hhPHAB6a5/9NU0yqFTCy7KbBdBSKnF+LC2RJ+wW5t6+Yhe8JeNJKRCJe7cfuCIxesXckZ6cfjT3vgeJkC5O1kJgiMFCZN2e863SA0itg0pemYriAZJkSgJ+D4/FbiZLadYp1AWtG3zx+YtOHhh4Uo+UjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065417; c=relaxed/simple;
	bh=PjNJYO/L5+j3tfKBrAUwuDdmDkPz9FEqzTqrQE3yBMI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GfnhU/T4/rzR04TpEnshiI+c/DjKJZPUfhvdWiJJJ75rxdmITw0CBACvkSfYUaeXthwP7n5YF4SkvsGJfhdVAdElFLu1PtBwijWo6DEro2OPJc0qJqOkVx1DvfGpYynyGNmk7WWRFJjwUn+Pi5Pt6+omqf4fwm/NC66KSFa9Iz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TkkLif0U; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7cc67249181so44026639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712065415; x=1712670215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apUBHj8RIRW82oHM0rOVcMHYsUZG8rbpOjN5D3JuAew=;
        b=TkkLif0UGPL7Yg0Ii9tBp2N8fRMb+liyVXgAezdQ2NlQipjWsnfg7rY9b862yDJVnO
         +cmreGo3t/aI0So6eXHAgRO8JAOYJZJ+5732AVTVvZYNGEep99cHkgmPvkm9pNQV/04d
         biulQcYPbk8x8FCwV9rpfxhesXHEn+ancJ7DpiAEDA31l9qb/TmVd6viYKHAOuBxfgI/
         yOe+wne8/Wa76NcgwlWxC5ANLMQztiUZMv+PMQfFdaukmsPg4D5YPo4Bg7QT/zM8XJCt
         wf5+2TjoargfyZYwNYOV9qbeZjpkwOnP+L97KH8ytQmw+jD/dUDCqJs3kP2Ff1JFu3s3
         1GyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712065415; x=1712670215;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apUBHj8RIRW82oHM0rOVcMHYsUZG8rbpOjN5D3JuAew=;
        b=sl3AO9l/pqN03UGlvLkij3mLzuW4zE+5KKH2iEH0jXo6KDLpxICo131ow49r5UjjRA
         rFk4lxR0AJgIa6eL/ejDHjnchJ+6uNejhIysDVk+Co2EIZpjOvpJWDOeLJ10hPKElBdz
         xy1Ej//N5JxHUlMMHyyZf1uPE5StCDWumdHnbv315TPkrL1u9m5HiU3CkkgSLrOWTmcw
         X3BHk1V9NjZBhl1soQjnWTgz2ZFUe2nObPMnlV1AMEiAwQoCixMuMkr/nUbcwlYBr7iP
         HIrhztTvf+YoyBFcsKalKqEpPQ8A8M+2gFDz5ZNMTka6+nIiEQHPkLm1DzPZ3kRcZqVj
         PUHw==
X-Forwarded-Encrypted: i=1; AJvYcCVG0nKJNMqBMrjcWaO0Fe2jY3iX+5oH64aNplz/8f9a1W1qVvPngPX3jgnuaBWg8D8cmawZFADCxK/JZkCsedCyiuUbtM85mN4JvzZQ
X-Gm-Message-State: AOJu0YzcfigL5yPIoG6hQ2ao/zjDsDPTA3nIchdRGiSH8lbFIjBfZ3u5
	omigr1M1wUm1lA3aYPhKUeDvTt2tZQCHGVXIDT54oc/8gL9AJDnmZRvaaYODsls=
X-Google-Smtp-Source: AGHT+IGpJDr7ZluMWoQLTy1X/eHuek1XHPY703URWBPiLdS7tEstbXt5tb72nM1T7IftTobzsNzJ2A==
X-Received: by 2002:a05:6602:2b09:b0:7d0:a4d8:f285 with SMTP id p9-20020a0566022b0900b007d0a4d8f285mr12722710iov.0.1712065414734;
        Tue, 02 Apr 2024 06:43:34 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gh8-20020a056638698800b00479d7d5b61csm3197017jab.159.2024.04.02.06.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:43:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linan666@huaweicloud.com
Cc: hch@lst.de, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20240329012319.2034550-1-linan666@huaweicloud.com>
References: <20240329012319.2034550-1-linan666@huaweicloud.com>
Subject: Re: [PATCH] block: fix overflow in blk_ioctl_discard()
Message-Id: <171206541390.1142385.3894757499421059664.b4-ty@kernel.dk>
Date: Tue, 02 Apr 2024 07:43:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 29 Mar 2024 09:23:19 +0800, linan666@huaweicloud.com wrote:
> There is no check for overflow of 'start + len' in blk_ioctl_discard().
> Hung task occurs if submit an discard ioctl with the following param:
>   start = 0x80000000000ff000, len = 0x8000000000fff000;
> Add the overflow validation now.
> 
> 

Applied, thanks!

[1/1] block: fix overflow in blk_ioctl_discard()
      commit: 22d24a544b0d49bbcbd61c8c0eaf77d3c9297155

Best regards,
-- 
Jens Axboe




