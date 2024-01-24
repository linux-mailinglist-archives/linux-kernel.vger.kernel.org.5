Return-Path: <linux-kernel+bounces-37558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B24383B19B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71E928775E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E41131E35;
	Wed, 24 Jan 2024 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dM7g1WyC"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CFC7CF1B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122662; cv=none; b=Pod4Q6A7UoUrC9scB4k5bQQtik9h+yl62oCgAtOTDFWVHnGjgyLvSoaKGjQ/d/McaXwRn5ABO+BfXwdZnB25OuRzWpniKrpfbN7LwStaHB887mnsFw8C5uPxG4OiZktkBen7NU0Py5eQNHjxudLGH9TuUcZ48wBIg54ilsIXGyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122662; c=relaxed/simple;
	bh=JbibW8U25bNz/f8wJkz9E5pM/409HM7Q0ODyuc6AO9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dv+/pBMayyh7dEGSd1Mv69kXfzk3hJ8rZpEg7E0O657SbUqqQ76aSS+SguB2fRPzgq+I4AHdq2reDFeA+FFBQySRF9JXJNWLwDx14Hy6luwrxHiElkpPX1cOE2pWxn4BL6f5Qb+Mxgw7t/fyMhuvhTKVbp7Qov/a2OCNVIIsUyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dM7g1WyC; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-361a8bfa168so19957925ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706122659; x=1706727459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dN/DcvuXwyp2yCQExIUGYH7ZCG5JTRWzNGVK64AipF8=;
        b=dM7g1WyC0ZlAX8G1QKMTEI74plEDR8SroJkqsn3vemEIAJh8JR8H5WlktpU0qPjy1w
         dJZ/3ykygHHmngrsQRA2xEZNiFlOT37iisb8b+qhaLIIlhZkc1OPaO2URgIQd8KYQuXD
         D1pAXOPmeMQUmhcFs2zSWPd3QH2sKJ8h3LyAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706122659; x=1706727459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dN/DcvuXwyp2yCQExIUGYH7ZCG5JTRWzNGVK64AipF8=;
        b=AI+jWpprbWSY6yKUdrW9dlQr0B2lOGyNligg99OS2Q/YagIAJrUVA3s1YN5J5Pwuxk
         DGnamGj65/foNGHKokWu5tQQadHu70NMUkbTRjKyq99ryXx6SkAGg8MhJNXSaFae4NXS
         mqq1U0ZeLlwXM/sQragYl+lfuVUOvMVePuBRkIGSr3UnbukOuS/UjNb6syHeMJIpvf14
         R5i3NbcO3bWND1BhFxydFLpFXoYBF5BOdV15SaByNI+tFsphVEON/7oRrcQHd/jJUKdi
         DiG1PwhLY6UJROpCaUwoKI+HRlVeTGLb/6cx3LRS1L1W/evoJfW55vS3o7Ni8Azhuuh6
         VArQ==
X-Gm-Message-State: AOJu0YwxauyGF35TsHJ9pwvJC7E5rUhbMz8+ic9POXLnw9qyyaThTAkK
	wnYmblXcK10sTvdvxU9+o3/4xI/A2Uv5jIpU0uG8zeHY35RF2xzJrV1quTfj2A==
X-Google-Smtp-Source: AGHT+IE9qMB02EEUOxq/2jciZEyscL4XjQWdCqiITyqm3a3wtmsxRnL15cr80ulcxNXnl3HXms9o/Q==
X-Received: by 2002:a05:6e02:16c7:b0:35f:ff56:c0fd with SMTP id 7-20020a056e0216c700b0035fff56c0fdmr2473407ilx.14.1706122659347;
        Wed, 24 Jan 2024 10:57:39 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q22-20020a631f56000000b005cfd6b98d9bsm4724604pgm.87.2024.01.24.10.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:57:38 -0800 (PST)
Date: Wed, 24 Jan 2024 10:57:38 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kevin Locke <kevin@kevinlocke.name>,
	John Johansen <john.johansen@canonical.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Josh Triplett <josh@joshtriplett.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from
 virt-aa-helper
Message-ID: <202401240958.8D9A11E8E@keescook>
References: <ZbE4qn9_h14OqADK@kevinlocke.name>
 <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>

On Wed, Jan 24, 2024 at 09:10:58AM -0800, Linus Torvalds wrote:
> On Wed, 24 Jan 2024 at 08:54, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Hmm. That whole thing is disgusting. I think it should have checked
> > FMODE_EXEC, and I have no idea why it doesn't.
> 
> Maybe because FMODE_EXEC gets set for uselib() calls too? I dunno. I
> think it would be even better if we had the 'intent' flags from
> 'struct open_flags' available, but they aren't there in the
> file_open() security chain.

I've tested AppArmor, and this works fine:

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 7717354ce095..ab104ce05f96 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -470,7 +470,7 @@ static int apparmor_file_open(struct file *file)
 	 * implicit read and executable mmap which are required to
 	 * actually execute the image.
 	 */
-	if (current->in_execve) {
+	if (file->f_flags & __FMODE_EXEC) {
 		fctx->allow = MAY_EXEC | MAY_READ | AA_EXEC_MMAP;
 		return 0;
 	}

Converting TOMOYO is less obvious to me, though, as it has a helper that
isn't strictly always called during open(). I haven't finished figuring
out the call graphs for it...

-- 
Kees Cook

