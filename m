Return-Path: <linux-kernel+bounces-31859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE678833596
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 18:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF541F21965
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 17:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624321173C;
	Sat, 20 Jan 2024 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FPx+u6Lq"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C913C26
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705773168; cv=none; b=WSvLKPQWenyQ54JRSdFnyx7eyIEw36YWcTshTxb4fecCmTmWMxrre/ksNXHx9LDP+jZyf6T3OQeigluxyG8a4mUcYZA2ZRboWg19GGeVEpgkV2FpUWJehztFAInEbKQ+v5do9xrcaqUAJzBRETgNroWnVTB7O2Pe/4jG617QAZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705773168; c=relaxed/simple;
	bh=0OynslLcuiszL7t9Q5gMw+ivFZgRtUXMjZlc1SbA09c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMhO3qvQq8Zo98Bz9smBN8Rc/vtv64w391Zb0aIPnrwCNlvkfxDjNH8Df6Bu3jds+C0+ZyYz1/lOUWUyVUmv76FtHGcKyOE8/iU+n2haQ6RUk1+FOOD9ONJfVvjrU1Cs+CNgyXJj2NcIUByB0o8lNsnBSJiEzEQ+tOpBiVWDir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FPx+u6Lq; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2cad931c50so185786166b.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 09:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705773164; x=1706377964; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kifWIuG0Ei4r0wI/Fhxtdo1VJo2+oGLcsnG+Q+O15fM=;
        b=FPx+u6Lqbf6NfPuTjhwYhVJfk7IgkyaYODPIdiXV4gdiHwVkAvbr028o1vab3vCk71
         CTWsbaneGSWna18U2237Y0BfPsTdTzAK0NhMMY2Pbg/PWPhHwaz7zpzMOl9n2UBfhmZG
         BLxXBrt7cb9AjcINdO3vzHIiMk9h5HZ8DNb9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705773164; x=1706377964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kifWIuG0Ei4r0wI/Fhxtdo1VJo2+oGLcsnG+Q+O15fM=;
        b=JqUoNQKQ7EiMTIhxN9/vZJVrK4RzJCEh+qhTqumTMBIscv9d0sqn2KMD2d47o4pkMi
         oTzWASKsJ62AZ5+AKPDQLPyw6CrjmOXUzOw0n8Xv3YqZqdDxZU8+tq/xqh2kPKr0+Obx
         MyeJvTEVb6qVrgnT+WSGLE31krbFVF4V9HqggrU+udW9fuxF3e7vtfAAIZVL8NBjW3Mu
         Pu8MG1I/JC4VCsO8D/EFY/5ypgFmS6IogKZpq1RFgw8NUUcwOemQmCC+F2JtxA21IBQh
         LC14SzKWuFAi0oKGcCph9aEIOu8zTLZPel0YfeiBE8EBHHqQdqLzpWo0RBMmDiFMf5h6
         8kKQ==
X-Gm-Message-State: AOJu0YwRBqi+G5KbC8GN3TH3Nnni0RwQdgG8uGGr2++QSH+2aoN2xDUh
	tiQ5UGxSGN4XnRDvjaEq0HXpPP9ABzbuUqDnzkNBxttlAc5eE0vAPTaZdl0bMsysQgnh9es65Yy
	ywfQHMg==
X-Google-Smtp-Source: AGHT+IGkS+1n62pDnUokXnGanaLCif0+FPJqfFU3JXFspSszpMYEkYHOd8hiUsPZQpLko774IwdHIQ==
X-Received: by 2002:a17:907:68af:b0:a2e:bc31:e4c1 with SMTP id qy47-20020a17090768af00b00a2ebc31e4c1mr754003ejc.142.1705773164685;
        Sat, 20 Jan 2024 09:52:44 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709060f0900b00a28f6294233sm11540958eji.76.2024.01.20.09.52.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jan 2024 09:52:44 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55a349cf29cso2094058a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 09:52:44 -0800 (PST)
X-Received: by 2002:a05:6402:3486:b0:559:eca8:fdb3 with SMTP id
 v6-20020a056402348600b00559eca8fdb3mr1068788edc.66.1705773163764; Sat, 20 Jan
 2024 09:52:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d2ce7bc75cadd3d39858c02f7f6f0b4286e6319b.camel@HansenPartnership.com>
In-Reply-To: <d2ce7bc75cadd3d39858c02f7f6f0b4286e6319b.camel@HansenPartnership.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 20 Jan 2024 09:52:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi8-9BCn+KxwtwrZ0g=Xpjin_D3p8ZYoT+4n2hvNeCh+w@mail.gmail.com>
Message-ID: <CAHk-=wi8-9BCn+KxwtwrZ0g=Xpjin_D3p8ZYoT+4n2hvNeCh+w@mail.gmail.com>
Subject: Re: [GIT PULL] final round of SCSI updates for the 6.7+ merge window
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Jan 2024 at 07:26, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> As requested, I did a longer extension of my gpg keys, so my key needs
> refreshing, before you pull, to fix the expiry date.  You can get my
> updates via DANE using:
>
> gpg --auto-key-locate dane --recv D5606E73C8B46271BEAD9ADF814AE47C214854D6

No I can't.

I get

  $ gpg --auto-key-locate dane --recv D5606E73C8B46271BEAD9ADF814AE47C214854D6
  gpg: key 814AE47C214854D6: "James Bottomley
<James.Bottomley@HansenPartnership.com>" not changed
  gpg: Total number processed: 1
  gpg:              unchanged: 1

Fine - maybe I already had the update from the last time...

But no:

  git log --show-signature

says

  commit c25b24fa72c734f8cd6c31a13548013263b26286 (HEAD -> master)
  merged tag 'scsi-misc'
  gpg: Signature made Sat 20 Jan 2024 07:22:08 PST
  gpg:                using ECDSA key E76040DB76CA3D176708F9AAE742C94CEE98AC85
  gpg:                issuer "james.bottomley@hansenpartnership.com"
  gpg: Good signature from "James Bottomley
<James.Bottomley@HansenPartnership.com>" [full]
  gpg:                 aka "James Bottomley <jejb@kernel.org>" [full]
  gpg:                 aka "[jpeg image of size 5254]" [full]
  gpg:                 aka "James Bottomley <jejb@linux.vnet.ibm.com>" [unknown]
  gpg:                 aka "James Bottomley <jejb@linux.ibm.com>" [unknown]
  gpg: Note: This key has expired!
  Primary key fingerprint: D560 6E73 C8B4 6271 BEAD  9ADF 814A E47C 2148 54D6
       Subkey fingerprint: E760 40DB 76CA 3D17 6708  F9AA E742 C94C EE98 AC85

and fighting that ^&%%$^ gpg command to try to figure out why, I still see

  gpg: Note: signature key E742C94CEE98AC85 expired 2024-01-16 11:39:15
  sub   nistp256 2018-01-23 [S] [expired: 2024-01-16]
        E760 40DB 76CA 3D17 6708  F9AA E742 C94C EE98 AC85

and that's the one you signed with.

This mess continues to happen only with your crazy setup.

                        Linus

