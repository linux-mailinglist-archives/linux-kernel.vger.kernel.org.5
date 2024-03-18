Return-Path: <linux-kernel+bounces-106763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C7187F33B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527FF1C215E4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42405A793;
	Mon, 18 Mar 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FI3PzdQM"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74995A786
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710801877; cv=none; b=B/OSbE77E72e0kaLkADH2rUK/V2VDdkegkNR2YZnfNui3s8GmmATvTBZQgjV+8fk8oNE/3dBXztsPI6Cxwq9gWVsDnELEhiW/EosuHpMtbPtdEwm9skRdHOfvqpr2wu1fZOOxN8iK86lI79O9OcCuHeCOuk6OLJZ+zP5Z38zxuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710801877; c=relaxed/simple;
	bh=eduRgU53QZDWrAPUCPvkckYSrnk3rAFitEKcGg7eVzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOCdKPUfOM1kMZcuScVNbHf2UtNsgZHpJIuIIqb219F29vA+ok7YuKsRgxQuzqhBnsrS7YiY1Qefy0EJgIwPFUOdIZg3C+aCpiM6OypsmrXgSP4AzyNoqS5NbCNkroPBkxIbIE/wu3zrl3QIm/8hu3WY2vCZQPIJOuyFRcOq0XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FI3PzdQM; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513e14b2bd9so2974212e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710801873; x=1711406673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MH75aKXvoDEeQu9H6jcn+rQWkXLmzRwG/v/RnlP4n7w=;
        b=FI3PzdQM/4ZwZs3RqUCo3hbFtP1BItkG6RrfxDVMLw65eI6HuT/ZeDkwwRVN/17fPw
         PLEWcsmTKIds+MGi+j038dWhguNMe1Qd3o3BdfG5iMZ4cxpJtZrA0PV6kZuoVgMG+3ci
         uRukA+pfmefgzCzV/YYSR/R7ue8y98oafP60Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710801873; x=1711406673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MH75aKXvoDEeQu9H6jcn+rQWkXLmzRwG/v/RnlP4n7w=;
        b=v3sq6v7gvXcmuAARHdbLTYVMOXMtC/t9NWXFdUBm7v55U/JiR305pmS5931Y4mpsJd
         oTxIY3uCzji1jRLJq7AGwrAXpn0CzhMvgZzoZBGEUBkl/zS4rS2zVX8MbRLoqBgJL9k9
         xhc9zp/rQEGRz8/DOgV6sNYEfG0VRlJIL6TRn/I0f1r3/LoZPg0Pg2kjLvD1qXktvUXY
         iWvJ0Y2yYmXeDMkeAyxIbKXfxp0f7eo6px7eNHHjtxna28g17igg63iF5IKbVuHokSAE
         O0f6NgAIWQdKVFl4L0Lvw0SPn/RtA/yoTLPuyCoPqwjSyvJxeIlhfvUW+CMbFCS7uslL
         qumg==
X-Gm-Message-State: AOJu0YwwDLCFxRIJXORnTWtB0ZRXoasZBMzkcEhyDzkVTaBcrtMHXboz
	4bIwpo4NR4yDCmoijScsBXMdwB1eg8VemuYc5vLazZeJQDQ/AhwfLysVK1FshPd5umY6peUu4Vk
	icHClPw==
X-Google-Smtp-Source: AGHT+IHTbxaZzR3+4/XP/5KT/d0zEcBoiRHLkcjnm6OlsVompUoLoRczUpZS0Mz6TWEiSY/RF+zbYg==
X-Received: by 2002:a05:6512:1c7:b0:513:d640:ff16 with SMTP id f7-20020a05651201c700b00513d640ff16mr8482195lfp.29.1710801872718;
        Mon, 18 Mar 2024 15:44:32 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id dx9-20020a0565122c0900b00513ee207982sm348108lfb.198.2024.03.18.15.44.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 15:44:32 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512e4f4e463so5583130e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:44:32 -0700 (PDT)
X-Received: by 2002:a19:ee14:0:b0:513:aef9:5401 with SMTP id
 g20-20020a19ee14000000b00513aef95401mr9139293lfb.66.1710801871842; Mon, 18
 Mar 2024 15:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfixMxRWFNmkf-Ta@redhat.com>
In-Reply-To: <ZfixMxRWFNmkf-Ta@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 Mar 2024 15:44:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjnxmpk1L9+ibbZmia0qNNwa8Qnk31_57O-DZqQfL08OQ@mail.gmail.com>
Message-ID: <CAHk-=wjnxmpk1L9+ibbZmia0qNNwa8Qnk31_57O-DZqQfL08OQ@mail.gmail.com>
Subject: Re: [GIT PULL v2] dlm fixes for 6.9
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Mar 2024 at 14:25, David Teigland <teigland@redhat.com> wrote:
>
> I dropped the commit with the bad atomic usage, and replaced it with two
> other commits: the first reverts the unnecessary change that began using
> atomic_t for lkb_wait_count, and the second adds comments to the recovery
> code that forcibly resets the wait_count state.

Ok, the diff certainly looks saner. I didn't look at the code outside
the context of the diff, so that's literally just going by the patches
themselves, but I appreciate the comment ("The wait_count will almost
always be 1, but in case of an overlapping unlock/cancel it could be
2: see ..") and yes, it just makes the old atomic thing sound even
odder.

Thanks,

            Linus

