Return-Path: <linux-kernel+bounces-51932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB4F849192
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576FC282533
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046F7C2D0;
	Sun,  4 Feb 2024 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jBqqpKB8"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF591BE5D
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 23:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707089257; cv=none; b=JQEeFZXOU6t1G7ceKrp8hsh+y3Kd//FCOL703PgIWMwbonMEY9X+xonvgsY371f7L/AxHWO3d+9t2OH04+gJlHncwOmeZWDO24fUAdtN/G64iuDcRWZL/GBWt2Y30RoRUcG0HoWRPzzXIpTfb0fPkb1nB/hisXf9qGpJt32qdvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707089257; c=relaxed/simple;
	bh=MAjIol0GMAbNG1XtptnpLn4hnzS07i0B7wM2K4Nfk5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZR6r7JdfiiAEWwYEtwLyER3/5IvHVmb9S0fQKovpNyrqoaU0vdAxOKY+OULM5pvQTWl6nel/J+/3VawQgvfbPMWdP5jaiL/8a/BnmkNxgaUfUzCV3cWITD4Jo/3Wz2KLWbXWWYpxQlw837VzDug+p3yzBXeUGzFCZTi68RSJRkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jBqqpKB8; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-363b361ba6dso7945235ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 15:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707089255; x=1707694055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2B0ik/kzubl2ohroAMvpSs7bJe3x1W1deMGszOUAAz0=;
        b=jBqqpKB8cIVfJqTX3DyOvjd5BBd/3+HF9SLSTZ9CwyqFdvNU2/eLNaSbTyujMQhWEM
         ob0xcsP8yjpXYwNeuRsbUV5+bQfrhc2p23Na9gxRbETSXwL+q0VvA9Ik9VT0D5H0intA
         ca4brRwKdD3OxOCETDm2e4CPSFteP2nqMnnYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707089255; x=1707694055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2B0ik/kzubl2ohroAMvpSs7bJe3x1W1deMGszOUAAz0=;
        b=Hjf4ZxMa4sLomAiXfydwdXZ+Awr6qEKQj3FvMg2QgfzRh9B8+IC0BrrUooBD8rc+p5
         huzq+uHZR10BIoCBC6C4VcWrMrVGkXWzUuRS2ih3B9mw/1IUMvxRlgyqCaxQ9H4hY7hQ
         71Vd6nUDwc1LsJliOkJOP0Vs+5FJuBr4GGBD3ABnAgNbPOs7t8L/8XiLHs7z9RaJbojk
         Jai95fVUpvj9Qid/+NhswNZ/X8IMFv9x0Isy9Hwzohe7l9pzkZ5YsKlDo9Sy5sXXW/D9
         jo15Ic23bWDnV6Job45Jy6ComD5eXP4/hYj5hKk5fvnNFmEvIGphyYaBHQ72fCT4cfem
         LNPg==
X-Gm-Message-State: AOJu0YycQifCkpsV5OjCqquFvMXzmwo4w4My2mgxSegSVOxhA/LFa5WB
	pfC6tW5qxIQBgx+GRQiz0kv0bsvHOPXt7AseEB1h6tNKl8C/WHXouJSz5TsfWw==
X-Google-Smtp-Source: AGHT+IELS2HMKrbocabiUC9EdzHbrbzqRol0OG6EbLJH83pJP4kqomPSMPylSJJzAnmfnbyw5cSlZQ==
X-Received: by 2002:a05:6e02:2185:b0:363:8919:814d with SMTP id j5-20020a056e02218500b003638919814dmr18898992ila.22.1707089254874;
        Sun, 04 Feb 2024 15:27:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVNxPgkoSegRvKBH/4yZ3pchmWlBdXmDwQ4EzB5pgM9U4b1ZoYZYxPITBku/U7SW/5mDtdxmD0ua75P3dqb7kyzYQEwKXk/fqy38qsfw58wbPtrzh0dXaREQFUpEMH/8tFCM03h1rNuWYOriXvy6RJRjsDmI5kooK19/aO/TC09kKfaHNDQM3eYDocMtofXFJjgVvetCdJd93etxAALMb5j0FGg11lmA/dyZPcVXovwjPZXXnn/ohU=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j32-20020a632320000000b005cd821a01d4sm5690137pgj.28.2024.02.04.15.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 15:27:33 -0800 (PST)
Date: Sun, 4 Feb 2024 15:27:33 -0800
From: Kees Cook <keescook@chromium.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Jan Bujak <j@exia.io>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: Recent-ish changes in binfmt_elf made my program segfault
Message-ID: <202402041526.23118AD@keescook>
References: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io>
 <874jf5co8g.fsf@email.froward.int.ebiederm.org>
 <202401221226.DAFA58B78@keescook>
 <87v87laxrh.fsf@email.froward.int.ebiederm.org>
 <202401221339.85DBD3931@keescook>
 <95eae92a-ecad-4e0e-b381-5835f370a9e7@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95eae92a-ecad-4e0e-b381-5835f370a9e7@leemhuis.info>

On Thu, Feb 01, 2024 at 11:47:02AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
> 
> Eric, what's the status wrt. to this regression? Things from here look
> stalled, but I might be missing something.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

If Eric doesn't beat me to it, I'm hoping to look at this more this
coming week.

-- 
Kees Cook

