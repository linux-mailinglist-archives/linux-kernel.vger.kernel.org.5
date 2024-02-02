Return-Path: <linux-kernel+bounces-49866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBE18470A9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ECA8B28583
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D845253;
	Fri,  2 Feb 2024 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7d74Z6e"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F5E4428
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878384; cv=none; b=lhk0ilWbnYudkzN66LhvVKGxQTWU082vePGMlvtCaUkP2fEQw7SgBp79H/pVkZnZloR2V+FJKPhiPp/05T7IMxM60BFaJq8zrUJRYbi6nLddoxVHjAwVLYsdMguJGfn0pk9tN1MkJpz6XnwYH9ypirv/azWs9+rJfcgbxyvSG2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878384; c=relaxed/simple;
	bh=uRWwHyoDqw4F+LcubyhbFy0WTRbHEZvIDfkqsptYoKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SA6j8G2MmOCc3qK4zRfN/+8l5d4aTwUYd5gnQheFjZAJ76ivysEZr5YxOOynPrW8ImzskOvu8vMjuxkQvSIY85mY3vEKVTxMKenocdKYDX/7r98dzselyzX1/gGyon+Uhk1m5TanaWJ2ZNrruLf/RuEFZjNSRUP9M237mRTEeA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7d74Z6e; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6d5206f18so2016986276.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 04:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706878382; x=1707483182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRWwHyoDqw4F+LcubyhbFy0WTRbHEZvIDfkqsptYoKs=;
        b=Y7d74Z6e9SEJUVQ4XfwbTLTHcer6sTnrYjh1S30fQgVP3ayr8HLkbfVM57+sKQQPrf
         9fJcFibgrSOWnWmqAykCXQNeO7C7Hrh6xcP+Iq4+3jXk8HDylQExMD2ajwCRnSVNudD8
         aLPnO5uDv2BXbmp652tPSTMwa9CbL6pslRC26jN4geFwg2qswS7TwxXl5EnB05zJP2Me
         xvE5IMQE6ZejATK07rOi+KrzDIha8rgDQA4wWRtn+yYnYqe99IFOkfkkG+pAGt2T1c78
         w4AZXVAYM6IeANRrduj3Fy7GxI360UL5FJwLtpRoBzmugQKk6ofxpMgkDt+/k83LJhNV
         nmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706878382; x=1707483182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRWwHyoDqw4F+LcubyhbFy0WTRbHEZvIDfkqsptYoKs=;
        b=Bgrwg6xjg9vtSsmaIhQWoPwZrbsD+XrwV/w27ds6neVOWOh9gN0710OgS32yiegq4J
         7i0MCwrfy4u3OpQ3O4mjrF/dt4yUEoLuoJE9BhvTRyg0CTTZ81XGUeV0k3TywHmju4fH
         U9FujtHZGNrmR/hqZDUFqz+nAIfC2OgI8cEJXT1HBt5qNH+3Mn3uh3qtQRquCQnWykoo
         oyUm9hSTnoaV2DgCXK89yPO08rBe4BWzk5rbL9t4nNx/pe5YlIEFDOz6gUvB2WCIs9/W
         sIFRdECgSELdCa7Hv1cx5JqTfhpdVQ+LQSvrE+D5iijbrbyPeOTwjje0I4mpf/xCFIl2
         CdOg==
X-Gm-Message-State: AOJu0YxMA/UpbYs/nwOiEmiTDiTZ1CWcR6STMg7NR0NvBa/oy7tqCyaI
	8rgAtWEqY3gnFKrgLEuJ55bl8FpIT843IzJQ+uf2ES6ejaPrk9bB515nvVE7Jv6UTlPW0WDTIgO
	CHOG0ii/0ZUsrHRcLCa44Ht9+J+g=
X-Google-Smtp-Source: AGHT+IEVwsS41bhKowc+2g3IteSOCMf7c4xkXbS8bpePW360AFCPZR0/4nOiOmtp7Z3g1CTElPcncPZKBKRacQ9mLMA=
X-Received: by 2002:a25:d3d1:0:b0:dc2:470b:8883 with SMTP id
 e200-20020a25d3d1000000b00dc2470b8883mr8155620ybf.11.1706878382468; Fri, 02
 Feb 2024 04:53:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201125226.28372-1-ioworker0@gmail.com> <Zby-sHLDlmTRaUcd@tiehlicka>
 <CAK1f24=7sy_Bczpt5YeDbkhfriYUc1=zreSFdGCxfF3R0D6sRQ@mail.gmail.com> <ZbzfxNn4AYnTVFLh@tiehlicka>
In-Reply-To: <ZbzfxNn4AYnTVFLh@tiehlicka>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 2 Feb 2024 20:52:48 +0800
Message-ID: <CAK1f24mvBkc2c=fHL6UxMhL2mgLHVrSwZfE5516bOR0yVdfZpQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on collapse
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com, 
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 8:27=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Fri 02-02-24 19:18:31, Lance Yang wrote:
> > IMO, since it's treated the same as pte_none,
> > perhaps lazyfree pages shouldn't be copied to
> > the new huge page.
>
> Why? The content of MADV_FREE page is valid until it is reclaimed.

IMO, if MADV_FREE pages are considered valid until
reclaimed, treating them the same as pte_none might
pose a conflict.

Thanks,
Lance

> --
> Michal Hocko
> SUSE Labs

