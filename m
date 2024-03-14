Return-Path: <linux-kernel+bounces-103520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5837D87C08A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7891F23A21
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDA71EB5A;
	Thu, 14 Mar 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="emwi8bEM"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7934771723
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430860; cv=none; b=elkPPBCK0WSljlcE99pUnfhCjlScFvLfAlN7uMzTQkOL9pLXm9eZrXifug9WQR8VtGyU3m3u1q8kbTIOmvi/BH9Ma6RAcwYWO75aGgpS5sstgshNFx4AHdPBqoODHuP4Dm8EXasQR1UDb6AIkFt2Q2W6exAOMWIm/RRtvsYfEJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430860; c=relaxed/simple;
	bh=/5uCrSMDBFyGla1m9uaT0nTzpm5OUlZpQX6m2xgE05s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J34gvU8raSlSQNmo1unBxUBVHOnYVdhAs2zgmgH3faWwJhb+xDDedHn4c/IV/jOio5BKxan5lwj+5vs/pRBUjQl5c66TTI+JW0dfxziNH4V0HUeHP2xlIcLoLTewPGy7Tb2OTh5VsCOz+ga8dGMQWRStgIwbxhXUwKy7PIOn76w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=emwi8bEM; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-366478a02baso1922685ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710430857; x=1711035657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cN3wJipUzIRqQXP/cAUfx2YIxzvE49bUSL1Bir0Ob8k=;
        b=emwi8bEM0nmb1pNy2anF+B82GznZzs6UgnsXkT1ClkcFkN5bMc8uQ5gvn3MSHxafVp
         WJeIDmfvWSsVt6JF2MJbgfWTR/GiqtVmzvskceJrKLNAQng+e8n6c/HhZQrluZnCegKV
         yH2eGhXIoRRYEI6KcUXBqlzHUuFRsbtkVG7mRqiI/LDOdSzXGWDZEN27ZuRy2TCjJBWN
         VSr4aFnTLiHWE32LgUqdcnKlXOUYxJ2P4xhoiZLZooaL5G7y4Yz/WWh3EnM+FJ+Ao/h+
         xUREhPN+IoO0+xG9Jg5R4HfZ+QQk2/EeCqIU88ubC+gkY+l93FaNnofOGxvRFx0jRwd7
         1Gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710430857; x=1711035657;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cN3wJipUzIRqQXP/cAUfx2YIxzvE49bUSL1Bir0Ob8k=;
        b=bdtjaYUQ6/zTV9L9f/N9/2poWoto8V10XXgy/T7MDSZ9qSKuMS5PeTEg+pNK2H3Z2p
         Ge4Qo1W3TzjO8YWJYY+mpfVJpPIcClXwJ90LQWTrYZxNzBVcuXtimxkgwFpne1dlBNFL
         q/9wRCDOh6J3fUPtjFVDI26thp19vJBPCxB0vbuGlB2ttndVhtT2wuWMcFetJs3V0CxI
         rIfaZZszxtMEvvbEvEC+FsHpZbYHQgjrp/JADZQLuFZthVMKAolGNRxO91GNXRer7iww
         ZbDnO6ZEohlozhgQtjo7Mpa0XytR/21rVNxqC2anlo4eAdSoOPRWBPUk3+YnviuiaTyL
         P4gw==
X-Forwarded-Encrypted: i=1; AJvYcCVMPh1gDisea99/Pp+tMU68xdmrzmIzYOpQIMGw909ASnOwa4XVvASXTj85Jja1yz6hm/hpD5aqm0+wxmDedOhNERvyzo0rfirJkxVz
X-Gm-Message-State: AOJu0YwN8/teXAU+Jg1oXCLaTqbCnwtsFasny2njw+xOUIo/csc1phYa
	Pf3eBI6+4FIYHE8Utkmwr5+VpdhtDuzpJQ7B27R5JA1zHHPw7q+wd6Yx2dPGQ+Q=
X-Google-Smtp-Source: AGHT+IFJ6pYR9vLOwDNozHOTxDbPfRax0OlGL69G4vVjlV2U9T0TDI2POP4vUTk66XeFhVtY86swtA==
X-Received: by 2002:a5d:9253:0:b0:7c8:bd77:b321 with SMTP id e19-20020a5d9253000000b007c8bd77b321mr2404861iol.2.1710430857576;
        Thu, 14 Mar 2024 08:40:57 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x12-20020a02970c000000b0047469899515sm216690jai.154.2024.03.14.08.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 08:40:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20240314025615.71269-1-jiapeng.chong@linux.alibaba.com>
References: <20240314025615.71269-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] block: Modify mismatched function name
Message-Id: <171043085688.105465.17983722271829476482.b4-ty@kernel.dk>
Date: Thu, 14 Mar 2024 09:40:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 14 Mar 2024 10:56:15 +0800, Jiapeng Chong wrote:
> No functional modification involved.
> 
> block/blk-settings.c:281: warning: expecting prototype for queue_limits_commit_set(). Prototype was for queue_limits_set() instead.
> 
> 

Applied, thanks!

[1/1] block: Modify mismatched function name
      commit: 4c4ab8ae416350ce817339f239bdaaf351212f15

Best regards,
-- 
Jens Axboe




