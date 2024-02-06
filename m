Return-Path: <linux-kernel+bounces-55403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA5084BC49
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E20C1F255B6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7B4134BC;
	Tue,  6 Feb 2024 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ipqxh0l6"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C26134AE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241083; cv=none; b=AcLvqzrHx7Bk1UqMd69zTZmQf+s2CE8LPAqhN+sayMZvpbvMIvBy8fC/RRwyF1XrBQnS76BW9qr+ydtuWfC50mHvnrl1kDNGHXUUchEVjx1hajO8qDUIT1vyUFuetgsZuYFZs+sL0PqEfXil87ZQ27ycc1VWPgHOWD7BWxNvCP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241083; c=relaxed/simple;
	bh=KQbCmnitv0k1LLwn7oEC/AixKic6k/VPvPtV4osW4MU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mpcm0uxyjzun/5AGXTqS2e0BGLfPGwgEd/h/OQfzeklgc2juZamONwKvOIifX3CkEMnbiP0lS91H0kyLotGUMPrZ9gqoW+4P88gL3ex7rGIkNPo0ZKrXH1q7cQevck7zQWkme7MmVoyDmRauaMxXKaZ7nYKaFlgo6B9Edl+1tIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ipqxh0l6; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-363ce7a4823so1348675ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 09:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707241080; x=1707845880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHeZBe3Fk+KenUqO1LTAqEelhejPJ4++IUeui67/UbA=;
        b=ipqxh0l6BVwa7PqAc2BdvqcEakTVAR6b8Zhz8aNiibNaV0mege6MvQeqAn/ZXRKOBe
         1P3H5IvoBsPpHohxpt/tvCFz2NElPAJVUO7QVp/06X1I5OtfEXtKxihWrvScOH2iT/kj
         LDjnArRA1UOt0JrzajuGhJREqmeP12xKKpFSG+9bOA5+W47V/gst/RgDDZPNqWzkZU0O
         tGZKol5V5nqcrwWB60Sw9CJLIVQlkC65pJNIE8/mTQ0rlGt1Lk4LTif/MxPsNWsb5u+A
         kKkt5IVO3L3S71RtZZjSKFvxqRbAblfKzA9EH0H/+Y6hCTC144CLwVmwz0z3HdALvSsM
         pZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707241080; x=1707845880;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHeZBe3Fk+KenUqO1LTAqEelhejPJ4++IUeui67/UbA=;
        b=KaSFnUDFPNa2IjVNFsLnHMCug+phPLed+8YioK1OSbEd1fuFaVNeh9Vr860HBSkFgg
         lBKuXYqHbn+vpPnA8XfkmVkrcSgxBD4XsFPEuubhE2sOAhZL7mofW3qubZozgko2/RtZ
         AUk7y5b0WhL+UwEfl5pHe0WDd8rWrMe3JHwRad6cr4Njrc9sK6HabgfIdTCoiQdbhERu
         9I+pspQGBr4hWVHdCk9tIdwj5xvWPMmeRc35YspAj6nOsmp7vvdfgaMQJ9zWZAvXoBsE
         8meY3j6voDwBP/tdEKi2sf2VizpuoWkshgQaQgbRkTtkVmJi+vNCV3EIeS+vNQUcySBi
         lzAg==
X-Forwarded-Encrypted: i=1; AJvYcCW7sfNkiihuRZYy/arIcnT77yqcw5dFB+T7q9krjlMY00tdRic9JVZDE4mB01G6QmAcaoz9gUBScSj4EIoZjWeSYs0qAgmrC8DdidEe
X-Gm-Message-State: AOJu0YzqA4s9FWxFodoFLKe08t1ljBYV3GjWNgjpK23BhQ6TvZEObLfw
	vuBLSma0le2vONwaQM1kmniNafIxTvJ/9f7TQ+hOHYSg9RiCD8+Bz3YSblKItqo=
X-Google-Smtp-Source: AGHT+IHJc4Y+eVIAoCTbaYDMcfv6I51/alz2oF9TMTtGokeuVLGEccpMFBGX/yAdugyerwstGLh8EQ==
X-Received: by 2002:a05:6e02:1d16:b0:363:d7d2:1ddb with SMTP id i22-20020a056e021d1600b00363d7d21ddbmr1203386ila.0.1707241080351;
        Tue, 06 Feb 2024 09:38:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWI9Krn+0a55HFgNC/H5xZp13k1ntpc3z/n+GVKN6EfAzlcrCazxE+DvdITm7NbVgZbxXVMIKz4QGgVzDMnHpZxEhp6ggLLHtIxVo+bTiiFbGFYeeB5dyqAvDl+oxB+9bqqudnZTuufuq66/nh2d5k+eXtEZvrMc8Jk4zSEf1M7hH4kKhQML+dKqMcKCF9YgjQYWNYvz/G2WOyYG+9QxqjMRtebnkaXUsA9ydQ1SiPW6DWx021jboAy
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l2-20020a922902000000b0036381c9572fsm635952ilg.43.2024.02.06.09.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:37:59 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ilya Dryomov <idryomov@gmail.com>, 
 Dongsheng Yang <dongsheng.yang@easystack.cn>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240204-bus_cleanup-block-v1-1-fc77afd8d7cc@marliere.net>
References: <20240204-bus_cleanup-block-v1-1-fc77afd8d7cc@marliere.net>
Subject: Re: [PATCH] block: rbd: make rbd_bus_type const
Message-Id: <170724107961.667433.12411261808893534881.b4-ty@kernel.dk>
Date: Tue, 06 Feb 2024 10:37:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Sun, 04 Feb 2024 12:31:42 -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the rbd_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> 

Applied, thanks!

[1/1] block: rbd: make rbd_bus_type const
      commit: 052618c71c66d5de5e9b6cbcbad26932d951919c

Best regards,
-- 
Jens Axboe




