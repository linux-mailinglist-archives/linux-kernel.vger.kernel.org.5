Return-Path: <linux-kernel+bounces-106574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE7987F081
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D131F21F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5E25730B;
	Mon, 18 Mar 2024 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AfMjhp6J"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889E25676D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710790931; cv=none; b=Clmf4MCD3fkGWVD2xH0hI0OQ19x0OJmqGMdjFFP6uTKh+HE5GE6+lW1+dxUodLJUguhqtR2Y/VfPq2Wbr6CBK+awsWAI+CdjpED4XudObU7YWho1CootxWkwpaMVLU2OnRyqyE5He3cMWYjf7dZONvtlr/rTmD535Rez1oSvrUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710790931; c=relaxed/simple;
	bh=ale89vUoJpMEo0+ss4tyzF52HWPdXyIN0XFezNPuRKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bw9WEB/whefDdaCLl5IF12sElGUloJmuTuLVgFFkM4O7AwxUQvH7mS1ux9pFSuqkrLmX+m1H+Vi4m3jV0Q6HmWDi+JNdw+dlp/lUr+VwwNmbmgRLzE73WFrbrdqXANH09l6Ysci7lcOCTJ+mdRSuc13Tgd/cQEcijby3wJ6xWes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AfMjhp6J; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a450bedffdfso584415466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710790927; x=1711395727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HaVbhTB7mAtrZZxFWhtZksrr9aUMglMdAVpXYeAu2e4=;
        b=AfMjhp6J/UzX6s5qFzabyYGp7QmaIXMOOknFIp/AyY/LYLuAiRnoePKgpf9LWVbqUL
         +2PkwfFnnrvyxPK6gAgKr7BwnObUtSRonhXd+r1sBPwiy+ffpS5XDtBgL6f5SzGrGiSj
         oU1s3IydBzBDUlPAq2cNLFbJucWSiCq/tVEeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710790927; x=1711395727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HaVbhTB7mAtrZZxFWhtZksrr9aUMglMdAVpXYeAu2e4=;
        b=ZBHCNjzDeR1Wx2XqxeNf7pw3HyrynLp1Oq1m6K+eKK6rZab5YOxvZFAO4sJQKJhwpQ
         3GrS2w4OLoE+mBAO0EfTGl+oXKruQELAsg8aruqfNmQP0iTMloi5zZKGK+qw7F94G8MN
         UspDR38tfo4UKVioTVLl+HKl5wgQi8hj58E05/gukbWyxJRlFSmKsADx9TX5RJbqZ12m
         VDKfLRCJ7O1hMU/4+qY2IuAVv0juKAnn4WwECTjWnqwjKwoaoX8sJCrzqCR47Ra3t5vd
         RWcUYKCapY/6ra7FFNOiz/bLjUQUY4O1ONfykHVu2eIRJEBUkZuBp1RjdRxyz9oVb5OE
         oaMg==
X-Forwarded-Encrypted: i=1; AJvYcCWLp5srCnEROZYl8FgVhKAi9KHsH6+ixIZS7wqINshyQB9nLNfG4Wg0cxWqVAM7folKMPcLXoH+Yw4lc6rmG6CUOuykewPAHTUsaDnm
X-Gm-Message-State: AOJu0YwLLDyMCoXVfB0wOAR7LpGPncLVMSfZbn0p0yPFUJLAGAaZg/k0
	yzrGlKzknKlimFq0gv+uOjyo2orbNsnXNK6183rPBZ2Qxud2JS6wzR+AnM1r5DefTbrCt3MUchZ
	bzb1O1g==
X-Google-Smtp-Source: AGHT+IH4ZDKGtMXA2uqQ1O2dd31c0XCWuKUfEr8O+mclA2nw3qXmE9Io61jbkUNdk+uaTlXuNr9QMg==
X-Received: by 2002:a17:906:b853:b0:a46:bfac:fb9f with SMTP id ga19-20020a170906b85300b00a46bfacfb9fmr2261230ejb.0.1710790927480;
        Mon, 18 Mar 2024 12:42:07 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id h25-20020a17090634d900b00a454438091fsm5150576ejb.70.2024.03.18.12.42.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 12:42:07 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46c2f29325so165057866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:42:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAOc8ffhao/6Tc/IyhEIBEOIvyxAeIkmXx8eDggGUGmaV+ewlX/Wf3e6G/zopxZpO9SGYgRnarxhtnTdBuKxh+ohd+hvVwSK+IaG2K
X-Received: by 2002:a17:907:d40f:b0:a46:6b11:b861 with SMTP id
 vi15-20020a170907d40f00b00a466b11b861mr10285439ejc.33.1710790926761; Mon, 18
 Mar 2024 12:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-vfs-fixes-e0e7e114b1d1@brauner> <CAHk-=wj-uKiYKh7g1=R9jkXB=GmwJ79uDdFKBKib2rDq79VDUQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj-uKiYKh7g1=R9jkXB=GmwJ79uDdFKBKib2rDq79VDUQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 Mar 2024 12:41:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRukhPxmDFAk+aAZEcA_RQvmbOoJGOw6w2RBSDd1Nmwg@mail.gmail.com>
Message-ID: <CAHk-=wjRukhPxmDFAk+aAZEcA_RQvmbOoJGOw6w2RBSDd1Nmwg@mail.gmail.com>
Subject: Re: [GIT PULL] vfs fixes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Mar 2024 at 12:14, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> IOW, isn't the 'get()' always basically paired with the mounting? And
> the 'put()' would probably be best done iin kill_block_super()?

. or alternative handwavy approach:

 The fundamental _reason_ for the ->get/put seems to be to make the
'holder' lifetime be at least as long as the 'struct file' it is
associated with. No?

So how about we just make the 'holder' always *be* a 'struct file *'? That

 (a) gets rid of the typeless 'void *' part

 (b) is already what it is for normal cases (ie O_EXCL file opens).

wouldn't it be lovely if we just made the rule be that 'holder' *is*
the file pointer, and got rid of a lot of typeless WTF code?

Again, this comment (and the previous email) is more based on "this
does not feel right to me" than anything else.

That code just makes my skin itch. I can't say it's _wrong_, but it
just FeelsWrongToMe(tm).

          Linus

