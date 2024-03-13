Return-Path: <linux-kernel+bounces-102490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F34A87B2DA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5B51C20911
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B51451026;
	Wed, 13 Mar 2024 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="a9W3afKE"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3988347F54
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710361653; cv=none; b=feYxei8kWhgUj6i4YTcAw1MV41ZmiLBY6DpMtkw699lbXVatLaE8IvckyHM1HzUJG81ka4ruonOMnGCKtAWIfZUchUAuB8eBS4MkJqUPyf2d4tAerRrMkhP5M6UjGMMzA5ObabCQOU6Ph9aJ7qSxvuijgaBfN/TfxjtIh8VSVv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710361653; c=relaxed/simple;
	bh=6KYs3BQgjwZsV5TdSedJLoIrS+8iHieLsZx7y+UPnzA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=seprU3IKAfocTC47v32jLKiqphLvkri8erF7o0aLG1PIsZJF3ke8XtXp9rFhpkMh3QK58auI9ueuYSmXlfjMe8Nh+1VESknATtQBEPbd3BVMiC23kINbKon3xn2He0+zI0Uh3qg/gi162l5bb94foZy+nPMOhxTMytb0jBVaCnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=a9W3afKE; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36649b5bee6so426935ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710361651; x=1710966451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eF2DJ3K0vqdhNLJam1R2VnPzYiUW+uxIa0Tf2briAJ4=;
        b=a9W3afKEOxvSY4kRgWoH8PtJzVJNFleJdFpn9old5/tP8Smm2aSsM0K0/N/2Hghx1q
         uOR0RZpDk6mUtd2x4o63GtY6wSr2zWDtxIhmyEhkVaIV3re1VFSlu2+Sreuzaj0/Y0/x
         Xrd8yc9wGEhoSDkHQqmY8G2YZ+kSETC66vzlPvagvvTvK07HAOR/TqVFRNFykAnysI8G
         /a6ICiNZkNY6bTJfqeJ1Vn5SlkdqqkNDklV0tNPSl9GVS4LOEZVow3Pm65V1jO3qPcYi
         ivclXmBUHerME7l2uLTyALkGXpOlZ44+Z7bHSE70cozdlLy3D9y6tsmtZmFpge9lEO1E
         K+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710361651; x=1710966451;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eF2DJ3K0vqdhNLJam1R2VnPzYiUW+uxIa0Tf2briAJ4=;
        b=ks0KyjWhff1kbZDzpSq99qPYeiyAd51L7A4kM4PnMiJLdDBeWikc8xm3TwV8Yif7MN
         kUi9BAQqtOGdHKjFfjdBM2jUbI6blUTP2caQ0+/6rJBKoTto5X/AwPs7lz1yFQ81wqzY
         bOBHC+ZDUMrqfN6YuS01WXXhwgAPgzgwZptqashk5biUdl+KKTmGuZjHIHsb+Hr6iaIC
         H7VHrdrqJzNNGViGuBWb7Amanre2Qk6q3Rdf2l3uiY5YaIisMJdIRiDHy2KkZnjcnoo8
         WDk94p3c+2UB0Q/SIo22i6zvdX/gCxnpRxgTWkPBQaFzre0FGlRSBQ38EGFSsC5MG9GG
         4mbA==
X-Forwarded-Encrypted: i=1; AJvYcCW97KQsxnfsae09UbZ93qtB7NdPUpdILlJ/tqULGD3hVMcn44pdwxfq9DG2k9OxNwiJ64NfJchdDv/crAZnhqyP0SMeCgUCVwIeG2xf
X-Gm-Message-State: AOJu0YyJ94HGrT7U/xuiaTry2HYQC7pMximAyAoMJABnbiBrOhfkz+JW
	gYDVzW7sNzFAStQ1F5QPDwt5DABDA9b2IhlsZRYhyr1g7JaQNm5m+GkJ39yWaJL72jXPsiQVkDd
	4
X-Google-Smtp-Source: AGHT+IHrpTG3IyrY66fdBdCSOtK8R6pRDlYafTxhW5d810MFfjPxeOohqUqtft8HGNclAFoVpU5ASg==
X-Received: by 2002:a6b:e914:0:b0:7c8:bb03:a7a with SMTP id u20-20020a6be914000000b007c8bb030a7amr23560iof.2.1710361651366;
        Wed, 13 Mar 2024 13:27:31 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a42-20020a02942d000000b00476cca7d5b9sm3081057jai.166.2024.03.13.13.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 13:27:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240308133921.2058227-1-colin.i.king@gmail.com>
References: <20240308133921.2058227-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] block: partitions: only define function
 mac_fix_string for CONFIG_PPC_PMAC
Message-Id: <171036165065.297831.13967283119583163229.b4-ty@kernel.dk>
Date: Wed, 13 Mar 2024 14:27:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 08 Mar 2024 13:39:21 +0000, Colin Ian King wrote:
> The helper function mac_fix_string is only required with CONFIG_PPC_PMAC,
> add #if CONFIG_PPC_PMAC and #endif around the function.
> 
> Cleans up clang scan build warning:
> block/partitions/mac.c:23:20: warning: unused function 'mac_fix_string' [-Wunused-function]
> 
> 
> [...]

Applied, thanks!

[1/1] block: partitions: only define function mac_fix_string for CONFIG_PPC_PMAC
      commit: 5205a4aa8fc9454853b705b69611c80e9c644283

Best regards,
-- 
Jens Axboe




