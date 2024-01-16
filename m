Return-Path: <linux-kernel+bounces-28328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15A182FCF9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 288C7B27AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CC241C94;
	Tue, 16 Jan 2024 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QdQDZgKz"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F11320B02
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442630; cv=none; b=LPNCgxRtKLUlBTuQ9RmepT/N2oxiSFLrlFof45pxa4m6GGmHprjV0EM6gG8454ZdxTiYgRjR2atve8j10qAOG6SegSB95T1HG5q9xBtHRZcv1rs9K8Vkr38J/Qer899fpgby5ts4hkJn5ReM6l5GPQiryEhEm8Z/SDrK8aMQR3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442630; c=relaxed/simple;
	bh=D7xRpJrIqjZP5jeWAvqMV/IYv+apGd28JjwDTM2diXs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer; b=SPLdPyJOTsVsdp0VZIKG5LFXTkyBpl5/7TBZyJ0xoQQhmNQAsx1oOf0/AVTuUY7CF2RJc5On8ZDc59q20x+ATGGemavgokcWkIa4yIRjL12G3SjRVzAYY0E5+0yLpSpJleurKNaHNJptYA3A3iuCogpk4tCx3MzGGypdJIrFggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QdQDZgKz; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bb5be6742fso100224939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705442627; x=1706047427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIyU1BRIYxs21GRQFw4kCtrNUaHNQwollWRLcZszYHA=;
        b=QdQDZgKzmk0ADC5AWridK+DepYtS6VQc7YzHXcMvZ84IwZqjHceQrKLJtcmjvKB4VD
         2Almx5GkfUd+joveVXgAivBVxPpTl1z3nDN3Eu7iR2VkuIIeUeIdsmmfdW2S2owV9mwG
         7r0sWBAQDAmUx4ZiRZLoTejTagPqSfR5hkX30nbjsWHDesxyA/vTMaCl4wtt6D0asu7A
         5ll+b37D5twOG/a4WFJfwJuN7irrRrMPZsFJZSPlKMr7E1cQVNlljl+e0rnWJDjA73Mb
         7WAKMMafQd2JQ9UdGiLURYCQXa5y4Ym52OlkOlJHDQ2dVaJJ3IxUHkV3tD+jsiFiBoP9
         x7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442627; x=1706047427;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIyU1BRIYxs21GRQFw4kCtrNUaHNQwollWRLcZszYHA=;
        b=l1BxQGJUoluUn3esVkS1CH2WqeEIDH5lOaL0cRhJgVNPszZaUHhKWSV2pbkbBwVmdF
         FltMiIs+LhmWvz0Wch84fATv7/my0j+IVrmf1Xee2E/IfNgdVu+bR3BCm7ICxqk6C19w
         ORL5egUreqtmAlMbF17SHmon2X06bsK6k/F7S8tJ8l93eS1V6H0Hv9/LLRG2ri5H+Iii
         oD7qQx1krldH/6I/8vKz9rIRKJ+x7QJR5HFklkeb4Yj8/QQRrgsp1Svet2m1wG5O9By+
         XKcOfZJB/wm7/l21NUiCxq/6f1ft3lfM6wwSZH67avC2Yp0TmADHyvqVxW4oCRqZGYhF
         LGLg==
X-Gm-Message-State: AOJu0Ywi25y76X9UDV/7IYeU2vmnCTZgM4jvK4/qJSLR20VIw4FhwfpA
	scJWczqyuI1OdQ9N/zIJA0rP+i2LjEmudQ==
X-Google-Smtp-Source: AGHT+IEBhVEzbxUPC/dV36xmsUmmiGJEMiU22plQpZdebatedQSaUvgxWn8PYaTSAsQLbvD5Z+85NA==
X-Received: by 2002:a05:6602:2c95:b0:7be:e080:6869 with SMTP id i21-20020a0566022c9500b007bee0806869mr14083792iow.1.1705442627249;
        Tue, 16 Jan 2024 14:03:47 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l14-20020a056602276e00b007beea806d89sm2964862ioe.41.2024.01.16.14.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:03:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+8b23309d5788a79d3eea@syzkaller.appspotmail.com, 
 syzbot+004c1e0fced2b4bc3dcc@syzkaller.appspotmail.com, 
 stable@vger.kernel.org
In-Reply-To: <20240116212959.3413014-1-willy@infradead.org>
References: <20240116212959.3413014-1-willy@infradead.org>
Subject: Re: [PATCH] block: Fix iterating over an empty bio with
 bio_for_each_folio_all
Message-Id: <170544262659.494117.14502342650352587808.b4-ty@kernel.dk>
Date: Tue, 16 Jan 2024 15:03:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 16 Jan 2024 21:29:59 +0000, Matthew Wilcox (Oracle) wrote:
> If the bio contains no data, bio_first_folio() calls page_folio() on a
> NULL pointer and oopses.  Move the test that we've reached the end of
> the bio from bio_next_folio() to bio_first_folio().
> 
> 

Applied, thanks!

[1/1] block: Fix iterating over an empty bio with bio_for_each_folio_all
      commit: 7bed6f3d08b7af27b7015da8dc3acf2b9c1f21d7

Best regards,
-- 
Jens Axboe




