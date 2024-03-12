Return-Path: <linux-kernel+bounces-99908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E83878F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961CB1F22614
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984BC6995A;
	Tue, 12 Mar 2024 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVIe/DKH"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5324E3236
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710228059; cv=none; b=lYxmoXkqeBt49VWTzI30NpxuhRoEIy4aFyuc8id9v6snmqBbRID2qIBYO4rxcg/1bQFm2RrUbzElmFDa310ZJGETc/fCrSl73SvqxTyQQIJ9+qUEG3Fxr+c5j8CRMn+w+5a1ORq4mnnRq5iV2ZvKX8ehlxpiXsQImW2fdobwKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710228059; c=relaxed/simple;
	bh=2wl67+ZhhxIMRnoPbT/hY9khMqXTVMcCWAt86WHGNV8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WDmE7413TLZ/wWYhupw6SUd+54jNyGIzyIWuhTX0zJMg1GYFiVGFRE1UwuuGPmp4t54aEHg5mWcy1tR2dakD1XG+vTc5o4V/nmWy3PSASrrZXLYboFw6PwCpujnSmzut6KTwNiY8ilGAMf5sEPxR+oJaGf30KbZh7t653rmvrTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVIe/DKH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a45ba1f8e89so561445766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 00:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710228057; x=1710832857; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHEMncEPHGZ2c3TepY/ZlanmFHG6kasIOaRNXYyqmiA=;
        b=hVIe/DKHWq/2lInUkQL93kMA0CvgUUp+oP9CZ06aijiMaj9lTbvkFCv8ttsqObwucS
         vit47K1rfHhfvSRyZt3ncIPt94MK6CuopLoXtul8FmidEDHWUaA8/jeu2vtk6pYxy2fT
         iFe60exGXIkBbj+WF/ODnR6HGSMfQdnqO1E1yTkOVtF/WoTQmJY1tanzrbn1aKaWJOkY
         ARAFMUgAdSMJOIiB/8D0b/6ioBiyhN3xlVm1xjXmEYmMIwS9WR//M4HicFSID3xYlr9s
         +OaNS4Ejnfb68XCG7HQky8/3bGvdz5POUZglzGLqsXo5C4qd5MgCiP/uY5wQn7o2/pRP
         E2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710228057; x=1710832857;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHEMncEPHGZ2c3TepY/ZlanmFHG6kasIOaRNXYyqmiA=;
        b=hU+VV8PmjaRUwns5ghMgyzgMi4K/Xj5Dy4XoLdDWLYPulySTgc7bwHoMcruM/MRn5g
         c9VfahEu8RKhz0E4WBElsMOwOLReBRThyiJUWcu5TS7obqaiCPBjHdgG1593hM9N+exj
         c0WGMzAeNqZgOWonHbbqSylaQXO/Vd1tKvN4vW/s/gnel/aulCsY+JGTTtwXHGe5/uWp
         he1VmOsvQJgMqNZgJ+MSDKOKlUQgXJRyMk+E5gttzfjhcOWi5FFXq3PTSyx2Kaltu6DI
         X7ylnjWUjroowVbzP5KV8QmnnKjV9EwtR7frZjYcCbhJhyUVhTeynibyXZPZgWjSdArU
         8yvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiY9do9vwDbZx1NWSeViG6uj52UIyMrCYSv/c3a1UgY7zZW83YLpu+oeT0togt0CN2apPA+bVh9n39CtLvr/6DuMiNlIMwRp5zOivV
X-Gm-Message-State: AOJu0YzWv5lUMbXlwPp5JpnRCKweKngftzRfBN5MsoN+lO5poEA/y0gJ
	RCrWS+Cet2ThQKWOSR6jn07/zk3Mt2HDbWZrOnJ4x5/n93vqXRBM
X-Google-Smtp-Source: AGHT+IFZCLuFzz+8quBbSINzHfVBEJg6UEkuJFvgZaHooKCz3hm4joxwqC5FGefKOMcrh5DFIJvdog==
X-Received: by 2002:a17:906:fb93:b0:a46:275c:a8a7 with SMTP id lr19-20020a170906fb9300b00a46275ca8a7mr3193392ejb.61.1710228056149;
        Tue, 12 Mar 2024 00:20:56 -0700 (PDT)
Received: from smtpclient.apple ([132.69.236.46])
        by smtp.gmail.com with ESMTPSA id lb13-20020a170906adcd00b00a46203a86basm2135550ejb.27.2024.03.12.00.20.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2024 00:20:55 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [RFC 11/14] x86: add support for Dynamic Kernel Stacks
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <11e673cf-8bfa-4493-ab86-2f1f97ddd732@app.fastmail.com>
Date: Tue, 12 Mar 2024 09:20:40 +0200
Cc: Dave Hansen <dave.hansen@intel.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Borislav Petkov <bp@alien8.de>,
 Christian Brauner <brauner@kernel.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ben Segall <bsegall@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 dianders@chromium.org,
 dietmar.eggemann@arm.com,
 eric.devolder@oracle.com,
 Heiko Carstens <hca@linux.ibm.com>,
 "hch@infradead.org" <hch@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Joerg Roedel <jroedel@suse.de>,
 Juri Lelli <juri.lelli@redhat.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 kinseyho@google.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Lorenzo Stoakes <lstoakes@gmail.com>,
 mgorman@suse.de,
 mic@digikod.net,
 michael.christie@oracle.com,
 Ingo Molnar <mingo@redhat.com>,
 mjguzik@gmail.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Petr Mladek <pmladek@suse.com>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Uladzislau Rezki <urezki@gmail.com>,
 vincent.guittot@linaro.org,
 Valentin Schneider <vschneid@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <32BCF7CC-CBE8-45AD-B3D8-2856DD4FFF30@gmail.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-12-pasha.tatashin@soleen.com>
 <3e180c07-53db-4acb-a75c-1a33447d81af@app.fastmail.com>
 <bedfa55b-b1d0-4e59-8c94-dbc5f8485a7f@intel.com>
 <ef0419dd-9d7b-4b77-b63a-5f11aaefb570@app.fastmail.com>
 <08EFDEDB-7BBB-4D9C-B7E5-D7370EC609BE@gmail.com>
 <11e673cf-8bfa-4493-ab86-2f1f97ddd732@app.fastmail.com>
To: Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3774.400.31)



> On 12 Mar 2024, at 2:02, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> Doesn't this buy a new problem?  Install a page, run the thread =
without using the page but speculatively load the PTE as read-only into =
the TLB, context-switch out the thread, (entirely safely and correctly) =
determine that the page wasn't used, remove it from the PTE, use it for =
something else and fill it with things that aren't zero, run the thread =
again, and read from it.  Now it has some other thread's data!

Yes, you are correct. Bad idea of mine. Regardless of data leak, it =
opens the door for subtle hard-to-analyze bugs where 2 reads return =
different values.=

