Return-Path: <linux-kernel+bounces-40710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83AC83E470
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33AC7B22385
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A429250FE;
	Fri, 26 Jan 2024 22:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f/w9skPW"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C13124B29
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306571; cv=none; b=P11tXHgYfMIke/E+3E/+jM/VQg/SSP7pH7/be3xLqszXECodX1E7LCVQdiDKMtrmI1JNxgPnj8wAw7NBfJF3TNox842wb6RQC2JVDZ1j+Wu+lOH6AqFBKUar0bi1f72U6hMYt2N5/ogGB8o9vmc6Z/whXIH/SEXIjYDuivI3gtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306571; c=relaxed/simple;
	bh=VRUIw7uC6cqt3OzoHQtSD0pyn1Xety3jUHglg9LCNCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrDF6+jdjgoGhAZVI73pymBNVk+FZepPIHy8KMN2hE65iOTu1js1z1DYQ2vwChMpMVQl2NC/j7Wp735Sh+ev4+t1lWKjIscv4yYxzXiUPKWhtp577nCN3dIrGlu+gOt2IpnuQtyqqluI12GlxKUaC8Z4bT6zkms5ZlRd0oTTar8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f/w9skPW; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5100cb238bcso1511550e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706306567; x=1706911367; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LZbBryar9KtG8ez0HuKdIzGYRXSfuC+F7NhfNZW+cM0=;
        b=f/w9skPW05v46xigv3yeeXmegPZRIgGANgsY8NcxLgAjzRke9bl+aRF6iUiPl9asVo
         Umfia9sRoTQhJfPeM2DJaK/Q0rzblh26Wem0VefO/YWGjSHs5Vyn9XzblKEoH6LsNNsU
         pD1A4ocQVeprOjj/SsWXo8xBs1H2GUF3HC594=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706306567; x=1706911367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZbBryar9KtG8ez0HuKdIzGYRXSfuC+F7NhfNZW+cM0=;
        b=M1sKo6RAJ1wBzIJm8Ddj6kKExk169obKXvwIDNmsrSNYR93cUbUANs27wHG+ptzsNg
         H7jh0mfUTbbaYkkveDnx6CsSaoE63034DMi+tzdYe2c63NDjLmAI1Xoykh0VfLe3UYGg
         poIwNlEXlWSTk9SFxdNRy8Vuzt6rIwPCalFyXcA4ILT0TtdAnax/tKPYIx84urAbJMpC
         8qX6wCVti8DiUouL7V+9nItjXwGjCxnK+7aEgQD32QYvxGcP89roOXrih3+FAcwdKyIt
         XlL6rAnBTnMv1ASMtSWk2neKLwhPqrYehtXbnEmuDl1nvtimHg+IBXCz78IGVdHcK52Q
         CTzQ==
X-Gm-Message-State: AOJu0YxpjVnLhjA0kzT8FPw508M74etlShi3S7swkn0267TBzYCTWcRd
	9hDmgtRfHmTNtwHJ/+AUcwF9LFNacCxr5sFziC0QSR0EAcRYfwjox8pWKtCCyx9GinOv9JfV0/c
	fmbiHrw==
X-Google-Smtp-Source: AGHT+IGvO5/5oi5WgoM3ylfS7fvfnU2STGwq5+Fih2pc+36ooA+zJxxBNAr72255imy6XY8vvuZ8Pw==
X-Received: by 2002:a05:6512:358c:b0:50d:1c9d:59e4 with SMTP id m12-20020a056512358c00b0050d1c9d59e4mr208775lfr.47.1706306567270;
        Fri, 26 Jan 2024 14:02:47 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id gg25-20020a170906e29900b00a33608fbf6csm1055911ejb.62.2024.01.26.14.02.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 14:02:46 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a50649ff6so581850a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:02:46 -0800 (PST)
X-Received: by 2002:a05:6402:430b:b0:55c:7ab7:d349 with SMTP id
 m11-20020a056402430b00b0055c7ab7d349mr267672edc.3.1706306566363; Fri, 26 Jan
 2024 14:02:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705946889.git.dsterba@suse.com> <CAHk-=whNdMaN9ntZ47XRKP6DBes2E5w7fi-0U3H2+PS18p+Pzw@mail.gmail.com>
 <20240126200008.GT31555@twin.jikos.cz> <8b2c6d1f-2e14-43a0-b48a-512a3d4a811d@suse.com>
 <CAHk-=wjhtqo_FEqZkPuOVUNZzsGhjftdcN9aQpA3f3WD0qS1pA@mail.gmail.com> <7c4bc81e-51b4-4b93-8cae-f16663b1c820@suse.com>
In-Reply-To: <7c4bc81e-51b4-4b93-8cae-f16663b1c820@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 14:02:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj1h8GhhEuqmiCMZW7iBu3k7hn3mJSO9kTm7P31BCZExA@mail.gmail.com>
Message-ID: <CAHk-=wj1h8GhhEuqmiCMZW7iBu3k7hn3mJSO9kTm7P31BCZExA@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc2
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 13:56, Qu Wenruo <wqu@suse.com> wrote:
>
> On 2024/1/27 08:21, Linus Torvalds wrote:
> >
> > Allocation lifetime problems?
>
> Could be, thus it may be better to output the flags of the first page
> for tree-checker.

Note that the fact that it magically went away certainly implies that
it never "really" existed, and that something was using a pointer or
similar.

IOW, this is not some IO that got scribbled over, or a cache that got
corrupted. If it had been real corruption, I would have expected that
it would have stayed around in memory.

                 Linus

