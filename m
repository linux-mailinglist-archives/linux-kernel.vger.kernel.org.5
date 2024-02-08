Return-Path: <linux-kernel+bounces-58534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADC584E7B7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D5F1F2C612
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9511E89E;
	Thu,  8 Feb 2024 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="V7f0Fo8O"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F3C1C6A8
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417169; cv=none; b=X21hEhZHshIRobepP8AHwgTsydBsOOcYxfjTuCQER5qm2/6oSfTGtQEU4qJlKJRnzF9P8ZgIwTatR1LOBa0iA7hlftDdbXpZzZxdSNG4GbxEtuzA+A+o+bvDEIYMIyTeQU++VYEd3dYgq6b8YePKwTneyPXf2IQVajRxcO153Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417169; c=relaxed/simple;
	bh=tPG2L0PFFFvPH17p6jT3vsgyDqO0Ow7iaEmNEza7wAk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RhKif5cl2DnyuFUybhkzRRVrm+UC3US04Bb5SEDX4oGoOEVAitW20BkollWPkHxFxmilGrINPtAwWbh0CWV6CwrA2AjSXlLvysPq7ESrMXMfJGqXu7YGw+fgQHj+Vg5iAsPw8KYG45zWzw4VXGt57NFT1b8GElqq2GDp8FgcSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=V7f0Fo8O; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-363ce7a4823so87175ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 10:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707417167; x=1708021967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nr00YgHg0eap+hVTbhFLAb3+BozI0aJmEwESPqYLYlk=;
        b=V7f0Fo8OOABrGFSz1LmIa4jFGuYKc0Kl7JpYBNI4TTsR3u+A1NuGXYOIdTIc9w1kRW
         pHoUTVCxJnWOmvtG7eWj/fFliCBHfCDSf38Q5X1l0VIjIkFCg2Y8Ii2cH+loo4VQkhZ+
         ABl6xYZDqD/7YLUB/17Xnv2PhPWrlXcrk5h90j+P3QCHeQv3QXZbvpgCOJeIP0aJux6T
         SvgyPv++nev0ATApZT+QhC07yxUN6aDLB3t5eYICftcZIZNI+MjEAv3n/SnJNEnK2Mo6
         jsdp+zOA3LHTHhNDaLyz/JEtyPUgRsemAsuy9ma/UyMAWfPGbevivA2KTV1HFpfXn+XV
         I1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707417167; x=1708021967;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nr00YgHg0eap+hVTbhFLAb3+BozI0aJmEwESPqYLYlk=;
        b=UyZWSBqLfcVxj2Seg70kEIsCduRU0abrInlMO5wGPOQst1obknpjZ6NCENYePdAYEx
         SH1TqEALD62bGHEgEBe7nscNALSXxHzvtLxAd5Y7LINvtPFFYvUOaCNNyM/lFDVpp9lA
         kn2I4N+xlPP8xmVoR6crTBgp5j0Gapu5ypRLwXN9cGbHGlvOeFw1q2ECZjg/a6qGETaN
         Vru1zqE8ZkCMxyA0i7FF3vlxO88qOgOowwKpwtfB0K0ljmuN14IiqhTeWYPQANn4vt2C
         Ur1rPkCY9aEdJnjoMFaKNm06TySfeQ4qbgnoGyxah6zug4RbfWt0KgJTKwUoGfVmx6PN
         7q5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW05lhAXcf+v37MUusBpXRa3shMmldAaTLIwykapk9bnnXyvHyr66dEMea/9HPV6uExkanII2cxV4GbpqxGdIWTvDP4eIMRUTQzgu9x
X-Gm-Message-State: AOJu0YxukUnvRB+4+fePz2K8/4il2DMZhzXUDm4uKimSUrbjKxYnFQZx
	RjrhnB9tEUv8iEMDkztaQ+vorez0KredXSdBmD7mtPgEKobUAIyixfRgaV78iac=
X-Google-Smtp-Source: AGHT+IFAvqlSrBCQWpuejC3u4ynmLUFR513jOu3UsTa/NZ/FzFI6YPc3xiUkiJmHYAWGWy+VajjAaQ==
X-Received: by 2002:a5e:9409:0:b0:7c4:965:f8c0 with SMTP id q9-20020a5e9409000000b007c40965f8c0mr424407ioj.2.1707417166776;
        Thu, 08 Feb 2024 10:32:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX5+2PSYipu58OQZUMJJN8fnU2HCB8D8EcGHMM3AVBOVRYlAJguXndVTBIvBchiOORXCFtdNsK4Blm9wUOZJKiheWWbUgJxs47TgaZB
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t13-20020a6bdb0d000000b007c3fbe781f2sm50823ioc.5.2024.02.08.10.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 10:32:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240131094323.146659-1-chentao@kylinos.cn>
References: <20240131094323.146659-1-chentao@kylinos.cn>
Subject: Re: [PATCH] block: Simplify the allocation of slab caches
Message-Id: <170741716606.1391883.6304906990225431733.b4-ty@kernel.dk>
Date: Thu, 08 Feb 2024 11:32:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 31 Jan 2024 17:43:23 +0800, Kunwu Chan wrote:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> 

Applied, thanks!

[1/1] block: Simplify the allocation of slab caches
      commit: 48ff13a618b54aabc447659a9016068cf0cae322

Best regards,
-- 
Jens Axboe




