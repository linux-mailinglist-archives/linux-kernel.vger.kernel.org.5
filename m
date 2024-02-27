Return-Path: <linux-kernel+bounces-84152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0668486A2E2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3846D1C23058
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D175D56742;
	Tue, 27 Feb 2024 22:58:09 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410555E4A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074689; cv=none; b=I+26nOCQfo1imtNs7JfzK9SmXieZbV99P9LKBQNc6iaP2AYcfR7549Y63OsXeYXWnro6kAXpfcyKTi81z3Ctv8H/Vh0+RbXGRb6q/ZWeh6m33Qo1nyoYAsHly4yHyeUvHoqLsih7flllx7DqRAWx1vyHaasGBoF3GFvnMiL7uto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074689; c=relaxed/simple;
	bh=ck2Bpm9vcnmnA7VPiReoASiqij5RSPlXtN8btx6/xnU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iuyTQaO/AzW58MyZFsK1LNDxBQmXWLcZ8GCPz2BohV+BLn1f/WFU+eshFqb2cVfKLi6UFFOTDlGGsZjee6wtTZRg4mo84x0mPjNe2+q/vw2xqMrgDCnseB0p+s/FsD+UL4cA25mYmv5Z6afdqFXaQ3RzoiZ+H/Or5WK6PZxVjOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4Tkt6N50vpz1s94j;
	Tue, 27 Feb 2024 23:52:28 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4Tkt6N3fBtz1qqlW;
	Tue, 27 Feb 2024 23:52:28 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id ZgYzovAitFOO; Tue, 27 Feb 2024 23:52:27 +0100 (CET)
X-Auth-Info: GYlOfxn5ZQFEUug8eHWWxrd5sgHu2V9FIyeNiDzF3b0+1WGgO5321EFxoDg/KbX8
Received: from igel.home (aftr-62-216-202-59.dynamic.mnet-online.de [62.216.202.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Tue, 27 Feb 2024 23:52:27 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 44CEE2C1A60; Tue, 27 Feb 2024 23:52:27 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Kees Cook <keescook@chromium.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,  Guenter Roeck
 <linux@roeck-us.net>,  linux-m68k@lists.linux-m68k.org,
  linux-kernel@vger.kernel.org
Subject: Re: stackinit unit test failures on m68k
In-Reply-To: <202402271423.270DBF1@keescook> (Kees Cook's message of "Tue, 27
	Feb 2024 14:25:33 -0800")
References: <a0d10d50-2720-4ecd-a2c6-c2c5e5aeee65@roeck-us.net>
	<CAMuHMdXMsxRRMV8g6+9vTy_4o8HF49SUh2deNdFjgKwDLEWrxQ@mail.gmail.com>
	<202402271401.CB43AB2E8@keescook> <202402271423.270DBF1@keescook>
X-Yow: Is this ANYWHERE, USA?
Date: Tue, 27 Feb 2024 23:52:27 +0100
Message-ID: <87y1b5zfis.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Feb 27 2024, Kees Cook wrote:

> Oh, no, that wasn't it. Something else is happening. The stack pointer
> isn't moving between them. Is there anything special about character
> arrays on m68k?

You mean, beyond undefined behaviour?

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

