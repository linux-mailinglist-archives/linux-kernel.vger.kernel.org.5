Return-Path: <linux-kernel+bounces-33845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322A1836F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33B21F28AFF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D4A4177A;
	Mon, 22 Jan 2024 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eXaC9LBN"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4522C4175F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945166; cv=none; b=jWpkngAl2lpn7iCzum8tx1mmg7DRZX71u9sGsPRUk+LrN/4+aPEun+jptyRUwEyrbrTSWIu6iqQ0yQcmHnYPn45eUtTZ/07uzD9WeTTthRHYe4wAbhG6WYHBNAnQF7cwwqWkRvIyhwvL1zruB2Jj8BIT2cwtRNL0MsGnv+feSn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945166; c=relaxed/simple;
	bh=CAvYeYI2kz8KoiZF3Lrxx88mx+1idoUbkJ6hLoT8C20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gl77l77giwaWXCju0HqzPcw/7NG38PY+LuSB3fSUtfUIygUcygLijHmNykDuG0fkyi8OoiRlaobsbeUGCDqTmYvDxwJ2jHfzcyYYmuLUrRkcSn5ALAqWDkGXM9PL+ty81uiuDtz5TRQalD8dPXybmy0r3l3vJSY+uIxcvP3QsGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eXaC9LBN; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e78f1f41fso3367361e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705945163; x=1706549963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fa8a4vXTHxkTgPqpvg8FT2cqTtekezDLhidpa4qyO/I=;
        b=eXaC9LBNyCoFkhW4P0MWX7otpt9jANXihntAwpFaHJqQVRNvQhMSCnOWjw4Ais8S4A
         C6aK8zmrvM0RbY2Qh9uRVSX+FlEEy9W3XTuewxC8hd6UNgOj7bDpqM5MSO+hk593jMF5
         bTU/wsTixpQlNCkO5zud8ETdmKXs0cAu8LQG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705945163; x=1706549963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fa8a4vXTHxkTgPqpvg8FT2cqTtekezDLhidpa4qyO/I=;
        b=KnEu3Mq1ki00hkLljCTVSkPnWAfgrvgpgVUHG2grndWy82Szf6kvXGXQJUwLu5utiM
         nRbg0lDV327HCaC0baOTMLGNRQuxa7sc0vCDEkrRnCKL0Cs1xr8uu2uwqaOED27JMtjY
         apNi6DXYaYY7tlXcpRujTwZRg8ivBvzrHzzd8etWm+JQ2aFBwnaG6aplfSNyrUoTN6Nz
         Uc8NlFLPDnaYGsWdYZtS21mYS6EI/MbLLAcVMX0xoZXbsbQRipusQ+eMtbIO5I4F4fRF
         H5lzrLntl0N3/VocS4x4wfRSYmRyPthCNvoVEkC2RHrlPQik1JW8zcIvXHVRzC/tYay0
         iA0Q==
X-Gm-Message-State: AOJu0Ywv7xO9zzaJOnnyiqFex7qM5r0f3TgNsGwieareRolOnLdie1yl
	vPGKosRdJ4Zpi9ZFos4i2kJdxx/yM+aNPeqYA1ASjbZToWrgkYyPXhngYMuGRV6//HuJ7I2VK5R
	MZJIC7A==
X-Google-Smtp-Source: AGHT+IEULYFuTGI6kGgL6cSejMwVCQ+D3b6WEstREz2WOIndAiIkWzyFDdGv0ZFrZ5SqNY6cyGeQWg==
X-Received: by 2002:ac2:4c90:0:b0:50e:73af:598f with SMTP id d16-20020ac24c90000000b0050e73af598fmr1486587lfl.64.1705945163046;
        Mon, 22 Jan 2024 09:39:23 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id br2-20020a056512400200b0050e75eba7dbsm2060567lfb.213.2024.01.22.09.39.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 09:39:22 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cca8eb0509so39005141fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:39:22 -0800 (PST)
X-Received: by 2002:a05:651c:124b:b0:2cc:b9c2:1b50 with SMTP id
 h11-20020a05651c124b00b002ccb9c21b50mr1489308ljh.106.1705945162034; Mon, 22
 Jan 2024 09:39:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117143548.595884070@goodmis.org> <20240117143810.531966508@goodmis.org>
 <CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
 <20240122100630.6a400dd3@gandalf.local.home> <CAMuHMdXD0weO4oku8g2du6fj-EzxGaF+0i=zrPScSXwphFAZgg@mail.gmail.com>
 <20240122114743.7e46b7cb@gandalf.local.home> <CAHk-=wiq5mr+wSb6pmtt7QqBhQo_xr7ip=yMwQ5ryWVwCyMhfg@mail.gmail.com>
In-Reply-To: <CAHk-=wiq5mr+wSb6pmtt7QqBhQo_xr7ip=yMwQ5ryWVwCyMhfg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Jan 2024 09:39:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjGxVVKvxVf=NDnMhB3=eQ_NMiEY3onG1wRAjJepig=aw@mail.gmail.com>
Message-ID: <CAHk-=wjGxVVKvxVf=NDnMhB3=eQ_NMiEY3onG1wRAjJepig=aw@mail.gmail.com>
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files and
 directories all be the same
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <keescook@chromium.org>, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher <ajay.kaher@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 09:37, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Yeah, limiting it to directories will at least somewhat help the
> address leaking.

Actually, why not juist add an inode number to your data structures,
at least for directories? And just do a static increment on it as they
get registered?

That avoids the whole issue with possibly leaking kernel address data.

              Linus

