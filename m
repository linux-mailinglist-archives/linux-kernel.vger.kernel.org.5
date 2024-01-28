Return-Path: <linux-kernel+bounces-41638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEC083F5B2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B990F1F22D5A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 14:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE7023748;
	Sun, 28 Jan 2024 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Be6XmJOE"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A883623745
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706450480; cv=none; b=p/m5Nfq5Sfz2X0vaJ3PztWx44ym1Ek3loqYksPk2V01MSK2MNAn24k7rID6fJ2LipDUdBjnpe2e6XNKUmTGgYPCOXd+PbegLTw74iMg/eDegv9jwzi4JLwNbL2lwYU3mLR+OTuM1k7FFEzmgwrCFfqx2Fgh4tEQdj0HpnpTvWZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706450480; c=relaxed/simple;
	bh=avMCpwuFUa2i4x7tiD4dco/h0z+G0ypjNSRfns11g5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8LMxRAZT/KnEUuLTL0IrzTADjKDGTwx7K1sZ/0IvG/5vKqe2Bb82nrxkl+T5NKpjBuTqo5Jcr3tKFtYsSgbnikjFy5k16Fx+/xDrjU+Rj9iNONFXDvZk832e0mqK0TdVcnxJ4+sjtn/elKRq3hKBfmYWIz9skysrkSEJOqmsO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Be6XmJOE; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42a99dc9085so91071cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 06:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706450477; x=1707055277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=avMCpwuFUa2i4x7tiD4dco/h0z+G0ypjNSRfns11g5c=;
        b=Be6XmJOE95K8C9Hr0UPrko3RJZJYUNa/4ZDDUa8aYeKyh+1QVM5hWE0V5HDmcZ3gXh
         BCRX1HHdEQ6Bq5b/FnuMA8uWL0eVrVw1POtn6hT8DgHP4to8breZqXfCY7dVjotRLN0w
         GjWEx6DH0mSE8xH1e9h0MDLxVDQLkzOasfwLGI/ykBn+Wh65WEhHQVq97IC57B83cTZx
         ZKw2TObQ6VeU+5p4qgC6DvA88bSXyc3RsG7/NdTr7QAdOdOIhdLrGf9iTBl4wEsGdKYX
         RfNELY5Kr/Tnv26j3/CIUZYknhIx/KAtaaNpFJpeYhcNieIRS9TTUgJfX0+Vt8k1Io9v
         CsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706450477; x=1707055277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avMCpwuFUa2i4x7tiD4dco/h0z+G0ypjNSRfns11g5c=;
        b=mHcgfitBEm6x/RW6QZUFxJE1HHUrVo2skIVesDleuUe53PNarSNnX6RqdN/zKamsh8
         j3zo/Y5KEsisvpkMwBr4R6F1YJRmadH9blykYr3KheRocZCSIvi4WcLQs6YmiEHAkH+m
         9yBxWpiTsZae9II5ZQkuNencxWqFnmij8UlC9P8lpIlBTNkSkBF74FxxstEogySjqhby
         rQoyTSaS0JI6oCxAMqcl9R1MYgKpz3fYjxFg65y+j9BWWEWTG3ntFjwvCFBLyPMjj54R
         vxb0fbKmtqTU2t/3TZuFmpSegS+8wCWpJmZwAsa7GAqe7BXUiI7RP6/YFMCUNrQ0HP5E
         f8EQ==
X-Gm-Message-State: AOJu0Yy/Ao10N+SxXs837f3ZdthsZaY73OltJg8Dcb+EwcfEaofERdUw
	wogpkwnMUQNUjjYSI/cRgZ9kv19WszeVlr3mXrbEd1jrPQogzpvtcH5/25pg1ED53yeGzQShQCS
	QO3GBk9BV3UWsnAsthDAiXEJMqScSjdzrUl+j
X-Google-Smtp-Source: AGHT+IHh1HEBb8ULsyRDgozer+s4BS5WKyZ75DXxeVJYw3c1vuZ16gFOug+pKMBLafShcXmZ+HFEwzDxpPouZEg7gLM=
X-Received: by 2002:a05:622a:1bab:b0:42a:6b64:da7f with SMTP id
 bp43-20020a05622a1bab00b0042a6b64da7fmr402749qtb.27.1706450476977; Sun, 28
 Jan 2024 06:01:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116141801.396398-1-khtsai@google.com> <02bec7b8-7754-4b9d-84ae-51621d6aa7ec@kernel.org>
 <2024012724-chirpy-google-51bb@gregkh>
In-Reply-To: <2024012724-chirpy-google-51bb@gregkh>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Sun, 28 Jan 2024 22:00:49 +0800
Message-ID: <CAKzKK0oEO5_-CBKvYSw4DKY4Wp5UPrrt1ehBFRd79idy7FsUuQ@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: u_serial: Add null pointer checks after
 RX/TX submission
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, quic_prashk@quicinc.com, 
	stern@rowland.harvard.edu, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg & Jiri,

>> Or you switch to tty_port refcounting and need not fiddling with this at all
>> ;).
> I agree, Kuen-Han, why not do that instead?

Thanks for the feedback! I agree that switching to tty_port
refcounting is the right approach.

I'm currently digging into tty_port.c to understand the best way to
implement this change. Could you confirm if I'm on the right track by
using tty_kref_get() and tty_kref_put() to address race conditions?
Additionally, do I need to refactor other functions in u_serial.c that
interact with the TTY without refcounting?

Regards,
Kuen-Han

