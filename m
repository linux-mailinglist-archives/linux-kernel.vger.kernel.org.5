Return-Path: <linux-kernel+bounces-110641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150338861A3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46BC51C21CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097A5134CDB;
	Thu, 21 Mar 2024 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EvKkldXs"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB5134CC0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052935; cv=none; b=CgNQkG+0QOw0wwNsH2nb/MCPGLahFZEtVcI3Gd5T0tUyqkDMMhv4PSDLjYjWwbX9TcNeJW1YI9zs5ULQOJb50am1gw3IT4PJ/NytrWZ4j+eUFQ2DBT3M1RSkTUGwq4x7fQckZYPtmxLPi/VM1bVVbgqgkVFcG1U9O5Yi2Vdz40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052935; c=relaxed/simple;
	bh=40GFHceNhuZI93Iz7b2NAa2Q0jxRvhqelX0yrPTFuak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+5VP369JhTKYxpjMDqAr4karKN6JOiC4Cgs1LCG0wyyuAzkp7cgT/zn5ympQDeT1ONSy3XfmAca4HamWOEGRtjvA5o2voXtPHjNDm7jTqXF5F0K9J3WpBW/cSkxyBDOu6r1FlPAquX1/w/AyaHjTLkN+g/CasxjiWLWyI1Okec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EvKkldXs; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4644bde1d4so198795066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 13:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711052931; x=1711657731; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yE7KCSgieOxjgQfKXcfdAqspZIz95OJyVI+TAK+VEjU=;
        b=EvKkldXsA72gLUuATxbjNgFAZhbEoU8FoCKUGk/O7aDB8h4LMzcpme0r+kUe+xF1zs
         tf9cOqnsN73TVoztnNG7T2PVxD+TLhwQ++IOKeFRhzlg3pohFVqZF85zgPypmNCRoX1G
         V+O50yUL2DqZFjrly9uq2Fmdy7GfX/KlWuyIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711052931; x=1711657731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yE7KCSgieOxjgQfKXcfdAqspZIz95OJyVI+TAK+VEjU=;
        b=o+oV90P7AH2Tmqa5Ca1l2y/x1/jfZ1Nu8kItWC0KlFi+fB0Qm5KJRKr2SbE5cm2iRJ
         MUQk3B4DvhzZ3b+2zhzzKx/k5nsPLMYT3RfI7euLFXPOtCIhILchNe8Vjl+NSYLLP2oU
         TPOevR5p27OiOkw/IMx5qS59A/VFBe966i6QewxW2ULiYOTuCWtUK4VDWjA7WqKk9aIg
         WoprHqHOowfg75B3tTi4TIbhMl7rLcrfQBvGqcd5zQL8+s8oIbbEG2fwKrryJBtkjPYz
         oFBvcINR4XOjckcigrh04tp89enJiC3UmNP0U0pmqXOAekrgRF0Pojkm+4pQ0J/7W01L
         WsLg==
X-Forwarded-Encrypted: i=1; AJvYcCUSsrRszoYcNH5ee+H6DraiOHOqwgUWwrcTyHYriiwIUy6rZx2XBn5rnYSNm1H744UCSTLoYpeDPJl+yQHA+Or7IJprkQsa/2lxA8sJ
X-Gm-Message-State: AOJu0YwVcYwxX3AI9ZDjlpGmbTzIOPiD0QBvkpBPBik+TAk5BtBajFRX
	XuDUFp/G4jfhFkEnYmkU4UQBoPHameO1PwlR9YW5WyEM+gU5aui1TopLKcEp+sLb79JKbDCCufI
	9GSTT0w==
X-Google-Smtp-Source: AGHT+IFR1Pzi08xs6P16KvATSfxDrRYZSdTNZGBV6WvGd/qzq/fAi8Vafbr6Kb5aFtKkihO0SQEzew==
X-Received: by 2002:a17:906:1391:b0:a47:62f:c0a7 with SMTP id f17-20020a170906139100b00a47062fc0a7mr342384ejc.13.1711052931150;
        Thu, 21 Mar 2024 13:28:51 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id z27-20020a170906715b00b00a470dfe7e06sm276198ejj.118.2024.03.21.13.28.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 13:28:50 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4644bde1d4so198787866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 13:28:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVH0ubYHUzSBjlOw96dHrOjZQJ5CLJK3MfTXJDoJ8NZo8Ff0ziUCyyjaVurLZQIzd5DTHZ20lLuV+dWMU/K+bDCmra9HeL3UHFJt+S
X-Received: by 2002:a17:907:980b:b0:a47:2333:80b9 with SMTP id
 ji11-20020a170907980b00b00a47233380b9mr430172ejc.47.1711052930287; Thu, 21
 Mar 2024 13:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zfwv2y7P7BneKqMZ@kroah.com> <20240321134831.GA2762840@dev-arch.thelio-3990X>
 <CAHk-=wgGhgkEngBBureLRLKe7mQ-sRhYngUQNvxEUqR9mmc60w@mail.gmail.com> <20240321183006.GA2907026@dev-arch.thelio-3990X>
In-Reply-To: <20240321183006.GA2907026@dev-arch.thelio-3990X>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Mar 2024 13:28:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLtUZ8StEZAV194t+A_s9boSR-+ShutdAnahYpxkTXJw@mail.gmail.com>
Message-ID: <CAHk-=wiLtUZ8StEZAV194t+A_s9boSR-+ShutdAnahYpxkTXJw@mail.gmail.com>
Subject: Re: [GIT PULL] Char/Misc driver changes for 6.9-rc1
To: Nathan Chancellor <nathan@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Mar 2024 at 11:30, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Since GCC does not appear emit warnings for newer C features that it
> allows even with older 'gnu' standard values by default (I think it does
> with '-pedantic'?), perhaps we should just disable -Wc23-extensions
> altogether? Not sure how big of a hammer this is, I think this type of
> warning is the only thing I have seen come from -Wc23-extensions...

It looks like adding -Wno-c23-extensions would only work with more
recent clang versions, so it wouldn't actually fix the build problems,
just make them even harder for developers to actually notice.

Oh well. It's not like this is all that common a problem, so I think
we'll just have to live with it, and hope that people don't do that
"label at end of statement" very often.

(I think it's case statements too, not just labels, too lazy to look
up the details again)

                 Linus

