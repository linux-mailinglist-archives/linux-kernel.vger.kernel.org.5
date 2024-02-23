Return-Path: <linux-kernel+bounces-79321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7D18620BC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F241F24CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D5614DFE6;
	Fri, 23 Feb 2024 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cYsHNB1L"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D255014DFDB
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 23:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708731857; cv=none; b=KXayoumJuvjW5ZSW00BELPbLyTiB1uD6sauQ2vqVPx9Gx37qhZyjUQYJtpgDb+tEdNvNYySW4eAHwG767wIWR8FL7/DLEfxq4KtEVD4fxS/30YAEEiuFEEpobHmzohRIAjFk1L2qk6WXkAloyBZf4n9TOeN3sZ1N4y4nLPy9+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708731857; c=relaxed/simple;
	bh=z9xaYwJuacSDor4K3Ga1UnNCIeJNKm5H9N5VdBn0L+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUqZLRPeROOGz4yHCw9BdmFh2H+86rsegqFjNo2wCz2+nOSYrFkAbwl9DFBb7sRL4/9Nz5KKcvHgbpIGo0aBM0ZOoN3XiZ+TVOUz/hV1UqTVcT1pL1UVhzy2zH0c8//c8uGj0R/+R0frnKrXj624yANDoqsSrV0qXA4sCqvW3fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cYsHNB1L; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso1080614a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708731855; x=1709336655; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TG2R+CW7/iYHzGbMjn7YtgeUAnWvwQnPCbApfWV73ww=;
        b=cYsHNB1LS/LlCHW+UmrdOBewb1iptUkyvRMedo2F16nljw+DLSYwHmCOJV0JgBaN8q
         C9aGkwYQxoX54azzj0xuZzJXB1qizrRr2EgwHnTf/v+MqPTnD6qFrkWmKEy1UCOmoU29
         wtAC2NGOAk7sPOCbSJU5O4xAhV67c7cdlF3+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708731855; x=1709336655;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TG2R+CW7/iYHzGbMjn7YtgeUAnWvwQnPCbApfWV73ww=;
        b=Upb7Ala9LSfv3jhNmcjEMBrqvQ1xJNItfQrYPsBq8mg8VSAVdqxJyU7O45dbLensk/
         snf+Tj6XUgHz7AD4i4ZoSmguFC/WOn/EWka5833kjPfzK5UgImTtZ6w30OKZqYkAlTYU
         RCQ53h8amsE0Uhrssf5sNxx5b8KmpSW/FyDpRwgS+PJQEyRwHgk/FElBuWMjfynxA7sT
         +6pBkvbpuOdOYcuHAAa4KCC0XlKLMGUm7Ci7KP1BcLA315hBlaR1WKe4Cs6pN8OBzpqD
         t5cdgATPhMdHFpf/o6A9rn9kHnihy2KMSJWKtRc46gBw7S79pYBvs/7CpNRHHLRE+u+5
         XOGA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ94b57giBIS0L8AtewMhjhqQHIq/QT9rd7C376XVcpOp+UJHNzMl4ShPf3/Ats5VvUrXEyHlQOnLEnV1oIRbu9FwGizwEsOfw3Iia
X-Gm-Message-State: AOJu0Yy+Twv+CkFFUq3HyI4BubrWW5A5RmfSNZ29gz9Nn4Eqy4sVAiX/
	Hl+rpY+0QdeYcx3UZqyy4W/xkhBC8hes2uAzKRUb4SVZNafRiJyfAG7/eALrOA==
X-Google-Smtp-Source: AGHT+IEVacdtWz8DNkk1epMp5zahV7zYT30iXRFJkBYmWNUh7jmj1UM0coHCTaLz6+OEmDMKsa6yMg==
X-Received: by 2002:a05:6a21:6801:b0:1a0:aea4:a1fe with SMTP id wr1-20020a056a21680100b001a0aea4a1femr1461775pzb.1.1708731855120;
        Fri, 23 Feb 2024 15:44:15 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f1-20020a056a000b0100b006e4eb29033asm24889pfu.194.2024.02.23.15.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 15:44:14 -0800 (PST)
Date: Fri, 23 Feb 2024 15:44:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <kees@kernel.org>, James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: lpfc: replace deprecated strncpy with strscpy
Message-ID: <202402231539.BA96B7F0@keescook>
References: <20240222-strncpy-drivers-scsi-lpfc-lpfc_ct-c-v1-1-20c685bd1b43@google.com>
 <BE9C61AA-633F-4CD1-BE5E-B01DC947626E@kernel.org>
 <CAFhGd8rTBqqQvr9vhpbfcSv6cpj5JSPVPSftqOPyWkZEWBP1AQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8rTBqqQvr9vhpbfcSv6cpj5JSPVPSftqOPyWkZEWBP1AQ@mail.gmail.com>

On Fri, Feb 23, 2024 at 12:02:22PM -0800, Justin Stitt wrote:
> Hi,
> 
> On Wed, Feb 21, 2024 at 6:38 PM Kees Cook <kees@kernel.org> wrote:
> >
> >
> >
> > On February 21, 2024 4:41:52 PM PST, Justin Stitt <justinstitt@google.com> wrote:
> > >strncpy() is deprecated for use on NUL-terminated destination strings
> > >[1] and as such we should prefer more robust and less ambiguous string
> > >interfaces.
> > >
> > >We expect ae->value_string to be NUL-terminated because there's a
> > >comment that says as much; these attr strings are also used with other
> > >string APIs, further cementing the fact.
> > >
> > >Now, the question of whether or not to NUL-pad the destination buffer:
> > >lpfc_fdmi_rprt_defer() initializes vports (all zero-initialized), then
> > >we call lpfc_fdmi_cmd() with each vport and a mask. Then, inside of
> > >lpfc_fdmi_cmd() we check each bit in the mask to invoke the proper
> > >callback. Importantly, the zero-initialized vport is passed in as the
> > >"attr" parameter. Seeing this:
> > >|      struct lpfc_fdmi_attr_string *ae = attr;
> > >... we can tell that ae->value_string is entirely zero-initialized. Due
> > >to this, NUL-padding is _not_ required as it would be redundant.
> > >
> > >Conveniently, strscpy also returns the number of bytes copied into the
> > >destination buffer, eliminating the need for strnlen!
> > >
> > >Considering the above, a suitable replacement is `strscpy` [2].
> > >
> > >Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > >Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> > >Link: https://github.com/KSPP/linux/issues/90
> > >Cc: linux-hardening@vger.kernel.org
> > >Signed-off-by: Justin Stitt <justinstitt@google.com>
> > >---
> > > drivers/scsi/lpfc/lpfc_ct.c | 5 ++---
> > > 1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > >diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
> > >index baae1f8279e0..42594ec87290 100644
> > >--- a/drivers/scsi/lpfc/lpfc_ct.c
> > >+++ b/drivers/scsi/lpfc/lpfc_ct.c
> > >@@ -2569,9 +2569,8 @@ lpfc_fdmi_set_attr_string(void *attr, uint16_t attrtype, char *attrstring)
> > >        * 64 bytes or less.
> > >        */
> > >
> > >-      strncpy(ae->value_string, attrstring, sizeof(ae->value_string));
> > >-      len = strnlen(ae->value_string, sizeof(ae->value_string));
> > >-      /* round string length to a 32bit boundary. Ensure there's a NULL */
> > >+      len = strscpy(ae->value_string, attrstring, sizeof(ae->value_string));
> >
> > This could be < 0 on error, and at least lpfc_fdmi_hba_attr_os_ver() may present more than 64 bytes...
> 
> Am I putting too much faith in this comment?
> 
> static inline int lpfc_fdmi_set_attr_string(void *attr, uint16_t
> attrtype, char *attrstring)
> ...
> /*
> * We are trusting the caller that if a fdmi string field
> * is capped at 64 bytes, the caller passes in a string of
> * 64 bytes or less.
> */

This comment is clearly wrong, given lpfc_fdmi_hba_attr_os_ver(). :)
But I feel like I'm misunderstanding it since it was added by the same
commit that added the 256-byte callers, commit 045c58c87560 ("scsi:
lpfc: Rework FDMI attribute registration for unintential padding")

> 
> I see lpfc_fdmi_hba_attr_os_ver() calls lpfc_fdmi_set_attr_string()
> with an attrstring sized at 256 bytes:
> char buf[256] = { 0 };
> 
> Can we really return -E2BIG from strscpy() if the dest buffer is the
> same size as the source buffer?

I see my confusion: I didn't check the size of ae->value_string, which I
assumed was 64 bytes. But it's 256, so in theory we can't overflow.

> I'm happy to just make the standard strncpy -> strscpy replacement and
> drop the len assignment. Let me know what you think, Kees.

For robustness, let's leave the strlen() in place...

-- 
Kees Cook

