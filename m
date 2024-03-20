Return-Path: <linux-kernel+bounces-108903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CBD8811A5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9E8CB22765
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B403FBB4;
	Wed, 20 Mar 2024 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaqzUsks"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11AF3FB95;
	Wed, 20 Mar 2024 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710937714; cv=none; b=bSw9IrQq9WfCEqSqUu93Sxit7iUjrqWjhq/5qwYO53vu4zak/kQ9FOXUsq1xgndJKSLzeaPJ0hqjfwviZwdosB4CsdD5vDyHLhXnReTRenO+87ycWQGTIOMxpnKg5TRi4moG3BxHizWjwrcIPCkEsteRVo4eCCJrF4A1XCI2hgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710937714; c=relaxed/simple;
	bh=NXymN6d151ajo67O/+ECjgKwOOheDmG+BgY+3iMrzSI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lZdToIV5+j16FrylZtYTXBd3LDk4dckuubayi18U3L+ckpdjHtN/4e2Unrz0kHdqAvvM1UmOqaY6WzWfBM1S5TSaEXLUsjwob2S0xxc23GrYVNA0C+J1q3hgjEnwcp/3ckd9OjAQ8vnLkvkNbMyosEsbawGDeKOTmmUSyFQfcmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaqzUsks; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56ba73c02b2so1497280a12.0;
        Wed, 20 Mar 2024 05:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710937711; x=1711542511; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bdUMDayjgwY4ifcDBF0amt72RjSwOT8m0FQhkrxhi5E=;
        b=KaqzUsksVlU3HgzJN7SytUXe+j/wRneOOi9QVn8TwSf19QmxmfflOis3fcariSDV9v
         /VAj7Rf1n9LiDhP9jlP7rYuzO5Hxmu6jXRPh3rCriRk7lSqapEm99xLWRCE9IpBs2wkl
         fgllUMLKzrPA3z0PKolL9i077xFbxBHO55xImXpuerY3Ze+1QsXRY64YBT/NdJMHiHRl
         A3BIyZh1ee+v2B7cupxX5In8qtvQT4OyZaANtEaVUS0z4RLyot4vSgPHhK4XlA7OUdNw
         +1Q45IS8mjIWoFmhkgE1W7dyW2yBAve1vG+GFsAldsnTq+sqZvdZHlEDPvih7QAD++Qn
         DPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710937711; x=1711542511;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bdUMDayjgwY4ifcDBF0amt72RjSwOT8m0FQhkrxhi5E=;
        b=g0jNNyMlw4sA8xyaKnhUT8Od3ecR2L46gJ5rAPm92bgYSNBIhIqTKpnwk03vTv8/qs
         MrVWC636okZbPfm7nWDxdi+t47D9+kNZrPm6RY3SXfBJnFe2e1OAbAi8RnNEWVqbpFOx
         JcuMV0xFkXpqti+5WvGdogqYjtb8E8Z6oZZ2+SkcHgxSsARYBHOURaGfU+rjF7SQk5U7
         hP/ObugU8zalaDkFXj6AGLXSQwVRgSbsDG6FvwxEFlQjla0mM+fNbbhBg9E9bp3n9Lmj
         BrFWj3AvQK2P4mqFOk2U1cFDYo3wi7WLthd+YuTWIbOC0QC240Ph0doY0gl9+wj9lR+r
         p6wg==
X-Forwarded-Encrypted: i=1; AJvYcCXdjrC3eH8/nq+JSlrK8hcyKatLKdVvZjhmyBAElMDH3aEHSG+3FRyqqDxyTgFgA4dWHOzAgF/4snx+hJJrxx2Hysy6SNNaBYkl3BrtrPbMAIfKHiqdI4MwaHORJmWNo/uHVbO2R7dcTQ==
X-Gm-Message-State: AOJu0YzCvbDqChFN6PxVt1cuUv21QibHxDR66Jcy4OEv1AiBLZSp9Xsg
	M9Rtks2D/9dvkwSbNcUGKPffdYMEJq4KyS0CDG2ys2VEF6iePbLcI1Sy+T/2I1QYO7utMk6L2iW
	NxffLki8NrfNSYC2hzQqWk6fPJWY=
X-Google-Smtp-Source: AGHT+IGOIbmdUnhCSYcULvDcwIIZ5WOCfD6T2cbHYI6yQL/t1zgl2lfCuC3N+Jp8O3Js/oAzUBJWFNtd2jCadNraakI=
X-Received: by 2002:a17:906:c106:b0:a46:9e89:cae9 with SMTP id
 do6-20020a170906c10600b00a469e89cae9mr11909879ejc.39.1710937710775; Wed, 20
 Mar 2024 05:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Maxim Kiselev <bigunclemax@gmail.com>
Date: Wed, 20 Mar 2024 15:28:19 +0300
Message-ID: <CALHCpMhc1F5Ue7U_gsDXREHUZRVQJNYRCJxYxoNqbN=-39jf7A@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] riscv: dts: thead: Enable LicheePi 4A eMMC and microSD
To: xry111@xry111.site
Cc: Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, 
	dfustini@baylibre.com, guoren@kernel.org, jkridner@beagleboard.org, 
	jszhang@kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	open list <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	robertcnelson@beagleboard.org, Rob Herring <robh+dt@kernel.org>, wefu@redhat.com, 
	Maksim Kiselev <bigunclemax@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Xi, Drew

I have the same problem with SD on my LicheePi 4A.

After some investigations I found how to fix this tuning error.
Here is the patch that increases tuning loop count from
40(MAX_TUNING_LOOP at sdhci.c) to 128.

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c
b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 8d6cfb648096..da8f5820fb69 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -706,6 +706,7 @@ static int th1520_execute_tuning(struct sdhci_host
*host, u32 opcode)

        /* perform tuning */
        sdhci_start_tuning(host);
+       host->tuning_loop_count = 128:
        host->tuning_err = __sdhci_execute_tuning(host, opcode);
        if (host->tuning_err) {
                /* disable auto-tuning upon tuning error */

After that change tuning works fine. The same value of loop count is
used in RevyOS BSP
https://github.com/revyos/thead-kernel/blob/c6d4e5df18a17903d012ffd89e67d0ee5ce6cf2d/drivers/mmc/host/sdhci-of-dwcmshc.c#L185

Honestly, it looks a little bit strange for me.

It seems that the tuning algorithm requires to move through
all the taps of delay line(128 taps?) even if we use THRESHOLD_MODE
instend LARGEST_WIN_MODE (I mean bit 2 in AT_CTRL_R(0x540) register).

Xi, could you also test my fix on your board?

Best regards,
Maksim

