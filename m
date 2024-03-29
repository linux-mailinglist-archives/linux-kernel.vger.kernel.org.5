Return-Path: <linux-kernel+bounces-125065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6038891F82
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567971F30E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A211327F0;
	Fri, 29 Mar 2024 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd4gljn0"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC06A35D;
	Fri, 29 Mar 2024 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711719045; cv=none; b=HdiXMC4TDrkcvPKIMbIFu1toKwHBK/vikAft9pGm1TAG81SmSzdUhG/D6XBYI6EOXcZ9LphNFrd5Ta0CJDNo1pxxUbsuJgO3FY/LlbrSViofQESTpUWQkzWaI1tNWXIyfiA+hz2WpZEVBWq/OhOyYW2E0sH4Bb7guYderzr0Tmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711719045; c=relaxed/simple;
	bh=WF2XgEs+0XF6N1klNHoSW4WcT2PR7Ikg5TSu/HBszLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxmwsUsJHKiqszhnHyyK8d+ed8WLpEBtRM7URrlEGPC1QaOXYAn4dp0QBYWhhOkrSPbb3bSIm1U+AT+W/whEjQ7H/81nGdsR8vnIWTXoohbNmBzxisUfUo2lY2dcQRTDCbwZ9Geu0gJYf5jpGPT0IoakHTk4kMOo+HMrNeT+m5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jd4gljn0; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5688eaf1165so2675618a12.1;
        Fri, 29 Mar 2024 06:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711719042; x=1712323842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XgauylSkuW/80aSrNllgj0l2yuKPPrlurUzNgnxWSgc=;
        b=jd4gljn0d97olS9h3VlNqogmhh1moTq+grvom0C2i3B6pUrCca/xYFtA3gt8I0GIIA
         iwB9BiWINUxQR092fiJYaDF/Y86e4kO4Q2HizqFKIptHWlYlxvZD2CT5NbbH6Dtc64G5
         q9KtgOeaHLkoFqfVzbUWcFmKe0OodLWo6vt/UrHNf1+vW/R/PUrU8Uy321jTM5PG1EN6
         VZgp1cSxqFgFTeKVA661H4PRBiWYOZVG3VY570hrSnbU+m5xH64ZZo32FwH1xlmBP6WG
         sf8B1CwWtVuEUFr3gxwZGhIAbk5khkmaUACjqPmmF1JX8BT+hDNR4wDIkDNCWRBm3bRi
         qOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711719042; x=1712323842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgauylSkuW/80aSrNllgj0l2yuKPPrlurUzNgnxWSgc=;
        b=dzaTudoIctvDLyQXvHdH1iFjROgatuURtjlBhKztRo6JZcFlOAYmUrvVzEnCUr85cq
         7izW15absvK5jUBJ9UZ7w7UloKKOX44VFn5OKDaYapqUyVGS/RTwf5UqbQFtwBwq6Teb
         reR63wzzRJP7pCOPlJMOme2nEcubh1LrOkeYZrsaFeBRi7GQzGODgAiVLvkWquk6nNMo
         0yzjFmw/xhy/61rJF4sk5Qwb9cNUGkfANrYNW1LqaOF7JluxaiAj39e2HUkXGPQPu+cF
         1hIidqgIZqTmHf7HSZec9leXbEdzUOzLJC95GR+jXiJjMUJWIM8+ZBjGFpu9Z3qEZJzs
         +oWw==
X-Forwarded-Encrypted: i=1; AJvYcCXE3TCn3l9qIj4CbUo/g7xVBpBk1H4CKSbigJaAhuPbz6J6ABYdzkIHjSDXpKohLv97fAgADpSn9C8XSUBugU82hRYZC/djH+tko05s3PqLyyrDF95tDjUSn2XFOwR78WcgULwK
X-Gm-Message-State: AOJu0YwpHWCmgueOyH0FXI+qJZkhypS15WHTtaCdF4mPW1jBZQH7cOli
	jfroIQZfvGOgjSFxhEFXprg8WKJqvXeErO59FZlZcOTHei0dWZBv
X-Google-Smtp-Source: AGHT+IF5JrqI2j7OCOT9HREOTWey9jC+t3rdB4i9jzwW1DefulQFZI1SUrPVovQHYjjUzCAFC1PtMw==
X-Received: by 2002:a17:906:228e:b0:a47:38ba:d24a with SMTP id p14-20020a170906228e00b00a4738bad24amr1719224eja.18.1711719041396;
        Fri, 29 Mar 2024 06:30:41 -0700 (PDT)
Received: from gmail.com (84-236-113-97.pool.digikabel.hu. [84.236.113.97])
        by smtp.gmail.com with ESMTPSA id ae12-20020a17090725cc00b00a4e238e46edsm1781467ejc.223.2024.03.29.06.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 06:30:40 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 29 Mar 2024 14:30:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Pavin Joseph <me@pavinjoseph.com>
Cc: Steve Wahl <steve.wahl@hpe.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	stable@vger.kernel.org, Eric Hagberg <ehagberg@gmail.com>,
	Simon Horman <horms@verge.net.au>,
	Eric Biederman <ebiederm@xmission.com>,
	Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
	Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4] x86/mm/ident_map: On UV systems, use gbpages only
 where full GB page should be mapped.
Message-ID: <ZgbCfVPvWroCnGE4@gmail.com>
References: <20240328160614.1838496-1-steve.wahl@hpe.com>
 <ZgZqhWoRZoq5tJoU@gmail.com>
 <47302624-6466-41a7-85db-f6872d58a4d2@pavinjoseph.com>
 <ZgZ4qlbncvxhboQ0@gmail.com>
 <be5982f8-3928-455e-969c-1e4c419d80a2@pavinjoseph.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be5982f8-3928-455e-969c-1e4c419d80a2@pavinjoseph.com>


* Pavin Joseph <me@pavinjoseph.com> wrote:

> On 3/29/24 13:45, Ingo Molnar wrote:
> > Just to clarify, we have the following 3 upstream (and soon to be upstream) versions:
> > 
> >   v1: pre-d794734c9bbf kernels
> >   v2: d794734c9bbf x86/mm/ident_map: Use gbpages only where full GB page should be mapped.
> >   v3: c567f2948f57 Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."
> > 
> > Where v1 and v3 ought to be the same in behavior.
> > 
> > So how does the failure matrix look like on your systems? Is my
> > understanding accurate:

> Slight correction:
> 
>    regular boot  | regular kexec | nogbpages boot | nogbpages kexec boot
> -----------------|---------------|----------------|------------------
> v1:       OK     | OK            | OK             | FAIL
> v2:       OK     | FAIL          | OK             | FAIL

Thanks!

So the question is now: does anyone have a theory about in what fashion 
the kexec nogbpages bootup differs from the regular nogbpages bootup to 
break on your system?

I'd have expected the described root cause of the firmware not properly 
enumerating all memory areas that need to be mapped to cause trouble on 
regular, non-kexec nogbpages bootups too. What makes the kexec bootup 
special to trigger this crash?

	Ingo

