Return-Path: <linux-kernel+bounces-160488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5E08B3E25
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D670B25F58
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB53A16F29B;
	Fri, 26 Apr 2024 17:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aowMBbYA"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9731F16C854
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152280; cv=none; b=Jq1ohuxb6QROF7cO0dEYoxEirw+xv6NP7jRfOP6Ni923bU5sAa6zQgKi3IFbnfK5IxZ2/Y19PRMjB2uxd1B8gA+IB6m6tjkIVTv0YS1GGeUdkf5ThaLuslB/83RyZIqZnOEjHpmkOYtOhRjDhU+59JB+x6lEM2BdqpUJcQb8+Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152280; c=relaxed/simple;
	bh=Iclu990lRFenX/h45ADE9tFK10iq+PjFzAcrQETKNVE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uxWC2dxQvufBHYowDUpG065v8XALAqMBFUFWTgCanNKO6FHJnHnYkG6rnJT2IJ0aIPZK3X4J/CfripItcEqk2z6IcicSOEOd8HE6p8jr1stM5rIT8qM1Of5hjLv5EPjfZsE3MyZu3Es65E89HnnTlhufM6H8S/KIK2yK4WEvh6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aowMBbYA; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2db7c6b5598so29820721fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714152276; x=1714757076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3GKYPgMw6Lvr3eDC6BYSdtSYACljMb8A9MuoJMLK5g=;
        b=aowMBbYA/Jkccphirg0PWcih4fb0sJ2MLcREbvwlGtKNTtN2dUeuSj8aZsGAksg6+H
         RdNk3v7SnbML1ol/ZQp0ONfK1UAZAC9F6SxOTyFMStlwn23Lcfrsl9z9V4ZSQ5nOaxjQ
         +NXX5XQbuib5Ra9Q+SpPSsJ3H3tGc+DBDBtHZcFBagrLxrLU1UtffeFBa9uI+ab3AWur
         GbLhpvykGT0oBT7WKxv2ifEcEfGZ1ybQ80rKYnc58LZnvKrnFYcQOPbRTtBzh56oLFLp
         955xxuIX3M0mhPpWVOF067EV8vn8GV2ciVQilzifnsbbAmAlJ6wHPsF7XS/VQi2h1HLl
         kj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714152276; x=1714757076;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3GKYPgMw6Lvr3eDC6BYSdtSYACljMb8A9MuoJMLK5g=;
        b=WFLlGGJt+idkuAcmRTUvbBrbsg7gbxcLLJid3zG+ORTJOurDgyHD1/5ornCvhM/+Ut
         XoV7gKAqbdTtm2zR/EjUJmiDDNH1CsGzeCh/OGfS7d2hegvV/3PC2nJe7rwtox3yXk+y
         qjJM44AVZgMquIVRRqctnuPKo+ODEQsK+aXo6qNTifRBmOE6sp2x67loHrKKADVfpNCI
         YpG+p0O/g1yeGvpzpJmyYkg7hJLOY/9bNT25h8RFpxTIjc86QPB0arh4hmfXeJHMpsf/
         M/V+lt3Y0n8v+Yy1CdHFGyCU9ajPBTVteijwIoFwXdvBmSiyimmYeUPiKRdGPx9nCtrV
         1lMg==
X-Forwarded-Encrypted: i=1; AJvYcCX8dPsMBQOslLgMHAw4E2RzyEO2HfEKLsUb73ZLbgBJGbXmKaP3Rrk4dQ4QZx9G/NRbSfR0HfIYeIAbP2V2TRKWXIad3tkyR0vRWXES
X-Gm-Message-State: AOJu0Yxxh+sBaZrTlycEZHNXHStNcj5cRXLeso2u9NPbeSR+Gc00xiJl
	gvt95nr7oRoeHBYMhUGfjOnr8cTeCJ3LnSVSgJehs75WMtvhKlqxGevJZQxrAXxVhamr+xttCDr
	3Hhk=
X-Google-Smtp-Source: AGHT+IGnmjsT9stCfMQVjm140H2VH/lZoA+XnC59AYuSbNO1QesGaoD/Op7V0EaA98IKFqmgM1P/0w==
X-Received: by 2002:a05:651c:1716:b0:2d8:8232:8c6d with SMTP id be22-20020a05651c171600b002d882328c6dmr282437ljb.52.1714152275687;
        Fri, 26 Apr 2024 10:24:35 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id z2-20020adff742000000b00343ca138924sm22893737wrp.39.2024.04.26.10.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 10:24:35 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Justin Stitt <justinstitt@google.com>, stable@vger.kernel.org
In-Reply-To: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
References: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
Subject: Re: [PATCH v3 0/7] kdb: Refactor and fix bugs in kdb_read()
Message-Id: <171415227516.138568.15976914533950726973.b4-ty@linaro.org>
Date: Fri, 26 Apr 2024 18:24:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 24 Apr 2024 15:03:33 +0100, Daniel Thompson wrote:
> Inspired by a patch from [Justin][1] I took a closer look at kdb_read().
> 
> Despite Justin's patch being a (correct) one-line manipulation it was a
> tough patch to review because the surrounding code was hard to read and
> it looked like there were unfixed problems.
> 
> This series isn't enough to make kdb_read() beautiful but it does make
> it shorter, easier to reason about and fixes two buffer overflows and a
> screen redraw problem!
> 
> [...]

Applied, thanks!

[1/7] kdb: Fix buffer overflow during tab-complete
      commit: e9730744bf3af04cda23799029342aa3cddbc454
[2/7] kdb: Use format-strings rather than '\0' injection in kdb_read()
      commit: 09b35989421dfd5573f0b4683c7700a7483c71f9
[3/7] kdb: Fix console handling when editing and tab-completing commands
      commit: db2f9c7dc29114f531df4a425d0867d01e1f1e28
[4/7] kdb: Merge identical case statements in kdb_read()
      commit: 6244917f377bf64719551b58592a02a0336a7439
[5/7] kdb: Use format-specifiers rather than memset() for padding in kdb_read()
      commit: c9b51ddb66b1d96e4d364c088da0f1dfb004c574
[6/7] kdb: Replace double memcpy() with memmove() in kdb_read()
      commit: 80bd73c154e3063c4f9293163daf3262335f9f86
[7/7] kdb: Simplify management of tmpbuffer in kdb_read()
      commit: 64d504cfcd514743aaed3a5b79c060f0143149e9

Best regards,
-- 
Daniel Thompson <daniel.thompson@linaro.org>


