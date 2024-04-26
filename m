Return-Path: <linux-kernel+bounces-160072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBEC8B38B3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFE3288C14
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8047C148303;
	Fri, 26 Apr 2024 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="edkAi9YZ"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBDE147C7D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138854; cv=none; b=q4I7ax3MNJP20rAz1XTc6cJH4pKrU/cD2Onh1VEOxkZKjn44Xy7aUhHdy5mjreP29MAG0IloVUHhwWZjRDo9fIQK8YbGMLy+A0ZkUtu1HEdq+nwBo6nWb+um9vejmcrvDJKSocOnUGgt/uppgxoNi2gJp7ulZSLG6ShE4FRlVW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138854; c=relaxed/simple;
	bh=qSR9KdDtou4elM0dFMdXIBi+jhpmshH2TEdB7PPNUzY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X/ETkDB5i1MCJmFW4zQF+lw+aIA6q1JMjFEP0EmUxowt77xC1+AI+7G8kT4eg1EssgqqQEbgo1B4LtLJ/etOzfIIKrljuR1NOcY2uozBig0MzKdkMgzU2dhg4B1QzXbLCKlGSXBBE85LbLJRJgZi0jTtt6YREnmXj5XuA4KGgR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=edkAi9YZ; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d9a64f140dso20168139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714138852; x=1714743652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xyNmLTuWEvR72GEYCrL1zsIHBKSa0ehqFFEtMyryas=;
        b=edkAi9YZffOLOLGTJY1+vu0uEJ6hu+Ubudm0SeI8FWgRiYb0H7QBxEkNOe87Tz+NYI
         nOLI3UTrmKxU2sYPnU4tYzoA32axjVZPsb5HsMUre5n3cYPA6JlzQlSGKMfNxkSaC+q/
         ZSt8uKUAFS8P/dWB+3NSCvz+HFIRD1eHAE7A1RQC3dddoYJwLmhQx/kiW0qiez7tCdLE
         Tx8SHF4t82W81E3Yppw0fdkHLggugAcILU8o8OhLJJvQQltjVe5TKPZjtSzxvWbkoK7u
         vADQg8opR2CwDHD+dhS02w8mv2L2uI1STlVfK1noTn8TY2f2AMS8YiPcUjBLEkHVclBp
         u8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714138852; x=1714743652;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xyNmLTuWEvR72GEYCrL1zsIHBKSa0ehqFFEtMyryas=;
        b=o6VtukuLY0mQfJfGbafVmuu0GBKCqWsBw55+fO0Jws43yDhE8dxJktdLFnNjqz3l/0
         EvKVSKMyXYyNTtmdGgTdSu7GEmxMjYa2ZdXTnzaIz6tAxB8+joqiN+AhdEcSSJesFeyc
         3FAJYT+YA/oS7USXxrsCKVMmFqfeUzFjdspnsIsRuSUMZJ1i1r+byemLixbHEyKI0fko
         22nycayfGKORBHjdK6irZ9Kl947wfHVhuIrrqxSj15ruriwQDQBSg/6FTTG60lWNoGt1
         ps1tWc5RV0hoXP/s3j8vk3Hp++e/sm8W4xFPZQ53OMEEwjD/BUr/ddJUhuyD/rqK1i0J
         1ZZA==
X-Forwarded-Encrypted: i=1; AJvYcCWVoW5IbN9eU31Qcx7qloHupfSz2a0nyqirRNT+NvW+3gFnPx0cTFjQ+k7S4p5hA0/mwdnys/lXI87w3Fjk541697Dnzwt3DUu7GROa
X-Gm-Message-State: AOJu0Yw5CLmte0jQRRUDT1HMOLKxY5PK9vcS5nR6yJEF4s/BGWDhixJB
	4Ms07lgbLlGKWylF7a9LSyV8iF3GMvdFRSOSNxBpB0Da20em+zfQFoKXghvP5iA=
X-Google-Smtp-Source: AGHT+IF3mQB5HbulQg2CkJsEpbjz+y2/5fbhgBJ11VqFeOjJoS9ZZYtH/6hDcxbjMNxULlO5LHj3bw==
X-Received: by 2002:a5d:8ac8:0:b0:7da:8d35:8a5e with SMTP id e8-20020a5d8ac8000000b007da8d358a5emr3331600iot.2.1714138852673;
        Fri, 26 Apr 2024 06:40:52 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j13-20020a0566022ccd00b007dead4fd0efsm255275iow.18.2024.04.26.06.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:40:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linke li <lilinke99@qq.com>
Cc: xujianhao01@gmail.com, Andrew Morton <akpm@linux-foundation.org>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <tencent_0B517C25E519D3D002194E8445E86C04AD0A@qq.com>
References: <tencent_0B517C25E519D3D002194E8445E86C04AD0A@qq.com>
Subject: Re: [PATCH] sbitmap: use READ_ONCE to access map->word
Message-Id: <171413885096.211722.564458609126458139.b4-ty@kernel.dk>
Date: Fri, 26 Apr 2024 07:40:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 26 Apr 2024 18:34:44 +0800, linke li wrote:
> In __sbitmap_queue_get_batch(), map->word is read several times, and
> update atomically using atomic_long_try_cmpxchg(). But the first two read
> of map->word is not protected.
> 
> This patch moves the statement val = READ_ONCE(map->word) forward,
> eliminating unprotected accesses to map->word within the function.
> It is aimed at reducing the number of benign races reported by KCSAN in
> order to focus future debugging effort on harmful races.
> 
> [...]

Applied, thanks!

[1/1] sbitmap: use READ_ONCE to access map->word
      commit: 6ad0d7e0f4b68f87a98ea2b239123b7d865df86b

Best regards,
-- 
Jens Axboe




