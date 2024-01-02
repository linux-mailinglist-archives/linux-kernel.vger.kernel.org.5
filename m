Return-Path: <linux-kernel+bounces-13966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD6982161E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3C92816A9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 01:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D3BA38;
	Tue,  2 Jan 2024 01:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EbE2JiAj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EDC390
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 01:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d420aaa2abso30483835ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 17:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704158316; x=1704763116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zRWE3E5XMrumruVdwn+4Yp8n2CImJBlUHIVxV/N3g8o=;
        b=EbE2JiAjcRZefpwwQV36HgERWZ90KV74QcoUVCzayDpOgJUJnXkZxGavMLbStDBQAZ
         A/AYWfQhz6dVybZ/1vVpc6xUPtHyGqQF/L6ycKBzUcfdKs5sunfJmuS3HDxbncKT7yxi
         X+vipx+kkpwfafiUPCARKAIcSBXkNMFDQFsSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704158316; x=1704763116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRWE3E5XMrumruVdwn+4Yp8n2CImJBlUHIVxV/N3g8o=;
        b=bv7pyA5TZvG6DK9Do7SY6BDQJZJYAtBJ5cM/JnYF/5O6XFFzliIBcmTyBAYXFOTK/x
         BDPqo+BU9BCPpwhSgc1272lK4S4Dj6teiDTZYlMTG7bs36JHwCjrPZLo+gzfVxzb/86m
         tJ+jMHQGwWdCkN3/NF6HqtzY6vuM+5lNW5zmMfhod55piGvg9pnD/DLr3ivdBGyIUKs0
         pvMcc6lpJrG0Jo7oqfmj22Y1oHhoNJfZ6EQBzvHR/tvCQgfg3qcSMePjKcm8eKkupwwj
         su7O7FA3d+QbDOwrm1pUljpCcOAWZ/yNjvq1fnEIKogap/Ox5Ka7tFfWUhiqk/e8eeIh
         F54A==
X-Gm-Message-State: AOJu0YxzAiXuhngas3DHc9nQ9NxtwK2sNJzOaPVPE+vObuFtjIBFXGPP
	xVADQWDRbTSLlSPy6uDOigNtf4HYK7T+
X-Google-Smtp-Source: AGHT+IG/0/8JPP8Sqc/3WIgIkW3oddIth292cDOhlF/c6lDdjIIuS/fk+/h37aIq3zXL9fPkYf+8Rw==
X-Received: by 2002:a05:6a20:7495:b0:196:dff9:3989 with SMTP id p21-20020a056a20749500b00196dff93989mr730269pzd.64.1704158315944;
        Mon, 01 Jan 2024 17:18:35 -0800 (PST)
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902ead200b001d4bb7cdc11sm1924886pld.88.2024.01.01.17.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 17:18:35 -0800 (PST)
Date: Tue, 2 Jan 2024 10:18:30 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Patrick Georgi <pgeorgi@google.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stefan Reinauer <reinauer@google.com>
Subject: Re: [PATCH] kconfig: WERROR unmet symbol dependency
Message-ID: <20240102011830.GB21409@google.com>
References: <20231122034753.1446513-1-senozhatsky@chromium.org>
 <20231128053443.GA6525@google.com>
 <CAK7LNAT_Z4TeNzngMskEoNdSTWUH5gGzYm5MfO6C_H8rFcF6ng@mail.gmail.com>
 <20231129041307.GB6525@google.com>
 <CAK7LNAS8q9eDerwVRbPbqd+AKjNVkEKLOW+NAKaD4duP-gViqw@mail.gmail.com>
 <20231222025701.GA3568309@google.com>
 <CAK7LNARa3WrRp5vmX5M3tTkS-jdno-vFe8WLPXjF8+hHxVUmFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARa3WrRp5vmX5M3tTkS-jdno-vFe8WLPXjF8+hHxVUmFA@mail.gmail.com>

On (23/12/29 22:41), Masahiro Yamada wrote:
> > > > We do exit(1) for KCONFIG_WARN_UNKNOWN_SYMBOLS in conf_read().
> > > >
> > > > I can introduce two new helpers that will tell if confdata.c and symbol.c
> > > > triggered any warnings and if KCONFIG_WERROR is set. And then different
> > > > code paths can call them and handle exit gracefully, depending on the
> > > > context (ncurses, menu, etc.).
> > > >
> > > > Something like this
> > >
> > >
> > > I do not want to patch warnings one by one.
> > >
> > >
> > > I will take some time to think about it.
> >
> > Gentle ping on this.
> >
> > We are not concerned with every possible warning at the moment, however,
> > we do want the critical ones from CI and (semi)automated continuous uprev
> > PoV to be covered by WERROR. We do experience real life problems with
> > "missing direct dependency" not being a terminal condition under WERROR.
> 
> 
> Applied to linux-kbuild.

Thanks!

