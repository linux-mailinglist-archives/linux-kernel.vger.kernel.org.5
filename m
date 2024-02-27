Return-Path: <linux-kernel+bounces-84075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD0586A1FF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7D91F275C7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86BA14F9E5;
	Tue, 27 Feb 2024 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/vEyZ0e"
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D3314F998
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709070960; cv=none; b=H3OBGIr8TzHkDU531dGokGq/AIzMKdiIabRStuDeX3dHtRKn0JT8/ND/RsoxvhyPkUlEhPiGuK91OsKmpHYnPBOPDaTcnYg8SYvIwXQKiaOwSngh1A6PY99PqVQH4juVt1/c4MKtSQ7833D/dkrOrCxMZ9xXsJVrJzwdnvKiENM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709070960; c=relaxed/simple;
	bh=urvRmO/BB0org3T+bWCoJmBHPVohfg+sLocBgxLbZtk=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=HFS+fGsWR43mlZLkkQU8Ouhr/XtgNB0/sGmv0egVAmLik/ogeT6cZLvC0WM75QFoaa5r6W5Sjjmi9ESIsOfooNURrbq+dS/s5bNg6flY35HKCPxZUwCTCTFW+/E/w8fFYwa4FF0mSDiCwPkqKC7uXK+d93ViIcYfvIoCJkTOGDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/vEyZ0e; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-513173e8191so752504e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709070956; x=1709675756; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeKiWniNAHDy2y0S2uIJuqwc541LmuBH8Tb5HcbqtbY=;
        b=c/vEyZ0emAAA3C9UtnxvMByXqJk0nSTc2wf7+bD6mqvagKO0r0RLO8hbSAaE/CuxjO
         jk7LrON11T6aIM1/SYgxQsOJgtKsjtvKy1ygbTmPNWmHKCZ+g44qaj+2gpHCMcIl5lS2
         RQ/Jo1JkcNODSQOmz9weHqZ+rGS/rhR9dc6pOsXhVIDSU9vvCG+BhK3fkchsX4+lIRDp
         CZTcusjl9FwMFMOWN6eKzJL9h7+rCg8Cb94z4/8NnECIzunV+A/NAk7DJp3bS5hoisFZ
         hUwtK+IMso3hu00fYP0zCJclf8WmKvYQO6ZB8SBWUd+mQUP6/e56Vnzrj9cor68Be53z
         M15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709070956; x=1709675756;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XeKiWniNAHDy2y0S2uIJuqwc541LmuBH8Tb5HcbqtbY=;
        b=NcEJE33AQKPjdRd0lZ7taqVDqqiZ0ENaBrDzaP06mrPetqRDe3lCUO32XSFRU1GPhY
         S/Xp0LAb11OONVtP0+xbhVysUwe63XVQjtC87BH46Tc5BKM7w4jBwPwOZkBfPS78IFwS
         MJ2OP7AWW8m2ySxz9QmJgY04/gVOS/5C1iqCXTzEbQoENcBudw8TrQ8OKVFPC6eRHMSI
         zolV8444qua5kfe+Ac0NBMYQnW8DQdEZAkb2DXBVOW2JIpZHLwcxli7Le87DpCaRYOoH
         2M3GSfMquQriiBjYYDQkDcPH8LUokVRL/legbATeYuD5b4S8n7kDr0FY70JCF9AUwLmt
         SciA==
X-Gm-Message-State: AOJu0Yx7rpWjM027ImHGoqWoB12wrEbnmlpv/z0inUjVG4DI1FxFduB5
	gQm75nzp57WzCTkMSEupjzuxNbNxQBNee5D6vesOgMzyCjZGc46EYy5aaRmaat0=
X-Google-Smtp-Source: AGHT+IHcNHe4Szhobg3mCS/pmDM1ulrqeT4BHi6GlVx1JD7age0lqDLVHD+wPhuGf2IW8Pm5cgn1KA==
X-Received: by 2002:a05:6512:33ce:b0:512:fdb4:b1ec with SMTP id d14-20020a05651233ce00b00512fdb4b1ecmr6044331lfg.67.1709070956389;
        Tue, 27 Feb 2024 13:55:56 -0800 (PST)
Received: from [185.222.58.100] ([185.222.58.100])
        by smtp.gmail.com with ESMTPSA id gg3-20020a170906e28300b00a3edb758561sm1148701ejb.129.2024.02.27.13.55.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2024 13:55:56 -0800 (PST)
From: Sarenaa Fuller <maisakhatun56321@gmail.com>
X-Google-Original-From: Sarenaa Fuller <castillom551@outlook.com>
Message-ID: <55ff479d0fb106f17ecb01ca7dd7d3032552a07956be507e80061886d78f8816@mx.google.com>
Reply-To: sarenaa.fuller@outlook.com
To: linux-kernel@vger.kernel.org
Subject: Acoustic Instrument!
Date: Tue, 27 Feb 2024 22:55:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I'm offering my late husband's Yamaha Baby Grand Piano to any passionate music enthusiast. Please inform me if you are 
interested or know someone who would appreciate having this instrument.

Thanks,
Sarenaa Fuller

