Return-Path: <linux-kernel+bounces-110620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9096E88615C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A070B21079
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B8E134438;
	Thu, 21 Mar 2024 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EUKc5GZ0"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEDA86254
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711051057; cv=none; b=oTtmi2fLteEfLnKXA6QMUWc6X5kOpVPQdJ6vbd+1PjOStzprKf3lMK4+S1+itrEbVQYPPKiT2ePbM7AEb+f6Do8KuZwKNgWg8tQWy/+wziQL20hOiE4O0793L995lW246tiYeZejm2wnas3/N1qzUbMzIQsNUDtHL17qwtV6S6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711051057; c=relaxed/simple;
	bh=ACQEgjHXrHrKmVUN1e84w9K08GUoD7rvTF7AzK/2oLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMeHaGdMZ074F1jUJYTPwGabvTNAi+mno/+CPknJQE1MZmGQp2yk6LHKluH+fi7EPBK1niTNqw57A8T+eqS0nz73c814xEiOxXsO16mhE3kyUT+fhFT6mqFXOWb6oW0IO63MiS7OssFujlGbSyPdImJIRmrMsWr8JruWT5rAurw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EUKc5GZ0; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5101cd91017so1583629e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711051054; x=1711655854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck9XtKTBgRiwFDSQngG8cInr2uoxIAAWioBX8TmAnyo=;
        b=EUKc5GZ0tCVMydYn4Zjgc59pIQW6FtI3oUrKP4tTiXmoc4Wf7NYzII4ZrHP4zdeKJP
         4ztu6DX4lhWEeF9WTMioGrhUhtLIhYI/UZNeSY4V1BsqVecn881JdG71Cw1ORYnXx7Fw
         oozS2IzoiNesxe8stXlvIE93EKHi8/yS//19piK1S62M5nZQzuU3dBLCTxQSDez193lH
         zvsmtvlnqsMAjDRwaLkV/PKjSmPuGJgvGip9fV1lw+tkxMPjyqJuhViNWrureVqF/B1p
         BuGryC1FS8bW+O2zzKxHesVlgNNFZFKur3Z/HSI8JAPbbVxYnSeEPQnkMabrmvCrn+aN
         txOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711051054; x=1711655854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ck9XtKTBgRiwFDSQngG8cInr2uoxIAAWioBX8TmAnyo=;
        b=JI+X/vLr4rdZIdcxmpqyoIbT4GV4W5G0T9TYeSPMX6nog79S15Zh7x5A0t5ZLhmZ0c
         wB/YYZF6LpwtJVxo7lJKp8Mk7rccxZgWH6Q0EoYcxUCXWLurIrwMALx6yRvk11LkKlF+
         0l32LxEFmaWarE+o0KPd9lgIl1wbQTxHLTqvUpSWBq/2dRF7trfZgb11ddWXUv8eWZGw
         06TB8M+l/Ti52+mwwCUEkT81ZnlHk+fzjKLlB0e1pcdfgKmPPrKAwiEEr+ycUAkAVL7T
         4hNyVEIkyIdwx0MTS/2AVyxWKqQ0BiYgRuZuBTQDbVO247UMD4/iilvwRoFKcWwrNmug
         iT0w==
X-Forwarded-Encrypted: i=1; AJvYcCXElDw6S3NYjQ8S722APHxnm1ewBHBx2miYD1Bn1311EbS0uTtx712BcIhjUpKAbf4NW2wEKzEqL0PNKNIkfl1j6fQ7aS6X7SMJan14
X-Gm-Message-State: AOJu0YzDPxezKoEYKibvVaKAt+WgBcbcpGxpHZVe7olaQDg5I6gS2a18
	LVdgDu8OnmKYATxgyOHnC2JoBWQocEYSVWEf6V+j7g6GklVY97DHXQtwmJNEO/MD2BqTFjiC19C
	bJEqkTA63WS7ry/hG4yFUybzaVAuTTPDL0j8Y
X-Google-Smtp-Source: AGHT+IEm3LB16hV2ttktwzI7uFI9wHrobF/GyRBvFlFKy38e078SgRE+nrCXL99kg0aKWSlsYgwHdwgeQSI3HPnhMyQ=
X-Received: by 2002:a19:ca13:0:b0:513:da24:fc0b with SMTP id
 a19-20020a19ca13000000b00513da24fc0bmr247849lfg.33.1711051053968; Thu, 21 Mar
 2024 12:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321-strncpy-fs-binfmt_elf_fdpic-c-v1-1-fdde26c8989e@google.com>
 <871q83eepl.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <871q83eepl.fsf@email.froward.int.ebiederm.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 21 Mar 2024 12:57:21 -0700
Message-ID: <CAFhGd8r_Z2m4akKTBvxy7s8Nwc1HLUE+uKu31mAya5QQyhBhig@mail.gmail.com>
Subject: Re: [PATCH] binfmt: replace deprecated strncpy with strscpy_pad
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 21, 2024 at 9:23=E2=80=AFAM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
>
> I am perplexed.  Why not use get_task_comm fill_psinfo like binfmt_elf
> does?
>
> It seems very silly to copy half the function without locking and then
> not copy it's locking as well.
>
> Given that the more highly tested binfmt_elf uses get_task_comm I can't
> imagine a reason why binfmt_elf_fdpic can't use it as well.

I am not sure why the original opted for strncpy over get_task_comm
but I made the replacement without being aware of the literally
identical code present in binfmt_elf.c

I'll send a v2.

>
> Eric

Thanks
Justin

