Return-Path: <linux-kernel+bounces-94166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61548873ACF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933671C21530
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3250813BAEE;
	Wed,  6 Mar 2024 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1NfdmbxN"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8C17FBBD
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739336; cv=none; b=Z9EKB+UBFkseJmqHH3Oa/VL3WZYMMGW5rzfcnYT6ORed8Xv9NC2T7UejET9vAIvTrAMLOCYAjv+Z2jmkkbb/YSLdEc4Mwi1GQvTnKlGOdOO80wrpWyVANjevRkDCPoxHDNfAkM1gJoDg2SjoALywZFdzmaesj9mhCTmyAQKbCA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739336; c=relaxed/simple;
	bh=RMLirXxHWn/zaqTvbOTlLpDe6jJA4f9Dl7DhP8Uavmk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gj2AcP2vUMSC5qCusVJ+2X6fJb+5AmmuakU1EWvZ8aGqUaDfu/5Y0HsU/ZdtINx8I2VFcfvlFIZrUA2Ogo1Cncv+zNKMuJOSuwgxCtxz7DLnwrt+Xm1VHIKcyCK/1augynfx2ZJcsQ6lJQ1f/z29xX5+PLejghk7rATYIptWjRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1NfdmbxN; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso102582139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 07:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709739334; x=1710344134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcPNflyLdlXskf3m71pC6TFH9duPdZoJWrtZCnymGWk=;
        b=1NfdmbxNbjRkTy/3KgT/960Fqa/prghzoQQiZXKJfor61iWeaSxtEJ/AEXGge/vFkw
         I6VhUbD47vMo9p+T1hd4nOBHvAjz240PTyJiMLitoGmTuNMETMTpGjjEuU5v5P8OL3M4
         qpigo1x+cFq0D9E30983ORfs80w2/e1C1aB6J/DNi05CJsZdltbh2iZwN5HrMn5T65i3
         /rjgHBf9pV0kPFyzCpQN5zZHUc/oXTxy1jEanA3aAfSAlYqpuT6gc1ryo+7tq3t2YfWB
         E8qb+W3XJkaPlxv18hr93kz1qYjBtB/kyxm5wtHbEpawBGf3Hp9z/Ej9topYeQE7NEvi
         Wk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739334; x=1710344134;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcPNflyLdlXskf3m71pC6TFH9duPdZoJWrtZCnymGWk=;
        b=Qzq/6klIylYAviYLGd/w+9PwjoDqhKdyoQXAhdUdyuMIqJJodKSsS0qgt3r3AcktI8
         k4Y4nncHZsaa0aYgaWE/eVyNZk8q47kCVsFmZmuirbWW4CsBxwsCslxCZVdI4dCS1Jhx
         JihTYYbj5WpNXMcj3yMRs7nVpUskPjUGkp6ac1/XI0AX9EW9x/QL4LaYSJctFF/O5evG
         qexrKpItQm//F4yFBBWUb261eGYGjqwVu1UWaSyRDLNaPkd+gOCyZaruQ8G0yBKtiJ+D
         oKqA/Bu+hEuIke85LlgPYJ++DlPuaubP7JQ3QHgVfbjl6iOkNkU/rmvTpc/V4ciQBOqL
         u0KA==
X-Forwarded-Encrypted: i=1; AJvYcCXeCBC+6w3qk0WHtiCXlQvbAlPu/4KatgP50BBAkkqHuzfKzxGFB8GgeSqAP9yeJ+9jjIY8MjRiJY+gO65W0QBeSLfGO++wSR7naoSM
X-Gm-Message-State: AOJu0Yy3EEq8hXTGHv/q1lLkLkGvSEyqUkhSpAOUrZEMc3Ho95/n//Tv
	tkGW88ticuDCVnLJ8fCryEQLRynmvLzZdicHu4TPDY1XT/CzEZCMh+fm7zAl2C0=
X-Google-Smtp-Source: AGHT+IGz0kK2Gm/omlmXhDHb8MGU4KnmMphDBDEMzD4Uzab2yV4++ZQpPSeCzWLyG1Scvsgn1qdMdg==
X-Received: by 2002:a05:6e02:1d87:b0:365:3fb7:f77 with SMTP id h7-20020a056e021d8700b003653fb70f77mr3993151ila.3.1709739334193;
        Wed, 06 Mar 2024 07:35:34 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a92cc42000000b003660612cf73sm324467ilq.49.2024.03.06.07.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:35:32 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: min15.li@samsung.com, Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dlemoal@kernel.org, hch@lst.de, yangerkun@huawei.com, 
 yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com
In-Reply-To: <20240305032132.548958-1-lilingfeng@huaweicloud.com>
References: <20240305032132.548958-1-lilingfeng@huaweicloud.com>
Subject: Re: [PATCH] block: move capacity validation to blkpg_do_ioctl()
Message-Id: <170973933258.23995.5282067244237610258.b4-ty@kernel.dk>
Date: Wed, 06 Mar 2024 08:35:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 05 Mar 2024 11:21:32 +0800, Li Lingfeng wrote:
> Commit 6d4e80db4ebe ("block: add capacity validation in
> bdev_add_partition()") add check of partition's start and end sectors to
> prevent exceeding the size of the disk when adding partitions. However,
> there is still no check for resizing partitions now.
> Move the check to blkpg_do_ioctl() to cover resizing partitions.
> 
> 
> [...]

Applied, thanks!

[1/1] block: move capacity validation to blkpg_do_ioctl()
      commit: b9355185d2aeef11f6e365dd98def82212637936

Best regards,
-- 
Jens Axboe




