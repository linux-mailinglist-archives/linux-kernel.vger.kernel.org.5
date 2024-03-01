Return-Path: <linux-kernel+bounces-89001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E245F86E94C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085061C2555D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA3A39FF2;
	Fri,  1 Mar 2024 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a/B6/TFt"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B939AD3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709320501; cv=none; b=CLjDCZf5sGhZcnHDzjdu9tHqylWEjU6H0nHPDed0cqF8J7nP2XDy3hf/jn4EaL/WQTVT/PXmy9xnD2vc2lRL9zGoh0MiuBEpMkgOfdTHH+XA9daAFJdwT3ILyF3pLzpN+pZWmdo5mIFDMu5UTgV2eAc1TQCqe8kWW+ujAb9ld5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709320501; c=relaxed/simple;
	bh=DoHD+IlZGZGFnoeTiJY7tCzcXTc9M0i8ugtMzjvfO2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Srh5EKDzwP94oQCG3PTFmzA1fYcX+3/h/AdV1jN33B/99OrIWtrawC3O37A9hPSEKbxF/BHFd1bx/o9wfpOo1ZAE4/RVfeyggt4BI5Jlq12M341vX/ftIO3MXog71pXYqlsXEf4OesV5Y1FU4iVDjD3pyt29ZFLgKpE47s2adVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a/B6/TFt; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a441d7c6125so318095866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 11:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709320497; x=1709925297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b3NhK1nZHCx+JgrAFg4MO5evKGLZk3EUlzp4L7qpvxU=;
        b=a/B6/TFtNlCUdMeKXfJLX/fNvyIO7tdq8xWf9VOJ+AdMsZodb3veF+XyBCE+4EcBF+
         JJMr9aznjP05YAyoRMjjnBv9RJb2sk2db/4VB+/T0/qr0vMgsv5Yxjp0cyUohKhnAKuy
         DFcN/RrKaF2vyl3+XojFB9S1+gz4oTnt6fwEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709320497; x=1709925297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3NhK1nZHCx+JgrAFg4MO5evKGLZk3EUlzp4L7qpvxU=;
        b=tbfH/rqPdsUTUAogDb4eTGATrHhO39f/CzXI3JQ6f7yGsDSj7kR88YDLiyHOLJxfUc
         TIN6mnSL5P61hOy7o81tMJYhmmBMPa1TOsExBhPhAW+yuc8/gJ+iCcqpbyRGyPS7U6Ul
         bb6mE5gft55xa+WLkDThCE038bajxqMP2AKc/OuMoHf18v0+qAGD85qKIEXU87ZdTR6N
         2OgjlKqqrb+RBWS/4/TUjhUtPJFzJbsn9/cFn6RIGuavRhpxYb/NGgfrZAzbe2180Qrt
         8fVZ9wGhtrcG+9ILirsLZNTit3PFuOEMOKfsthQG5ZmmlLmaTB/YnCH3mtEXyhuLxady
         iz6A==
X-Forwarded-Encrypted: i=1; AJvYcCVgAzrP1qNvjcWCmzRjRc+8m0y9U8T4hF/lJBO5rOtX7aetYkyiDTXigB+BqRBXhIwS/sYMcw4BRLZU6xtvKEBA4RO3DeNI3U65DzHC
X-Gm-Message-State: AOJu0YwMbMbpfgnTENz4h1OXqKBVUyOrbYcuNfdDPOIgQzcdvkUbToUD
	5WD4aXdFTFJTObo1xnXw5dgLBYdcQHHYCj2nP1GArKSiJMaDdzZStvrDdhOmoI7xK1mlZ0jCz2i
	PWFvLzQ==
X-Google-Smtp-Source: AGHT+IHJxQNr4wNsnhSir1j6mt+bIw1ZjppTQINTpBICzeDpgQNablDHpcc6xaS8sl69p3DBMVfu5g==
X-Received: by 2002:a17:906:264b:b0:a43:d1a5:e907 with SMTP id i11-20020a170906264b00b00a43d1a5e907mr1914009ejc.58.1709320497633;
        Fri, 01 Mar 2024 11:14:57 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709063b0e00b00a449e480f76sm629426ejf.44.2024.03.01.11.14.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 11:14:56 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-566df43a1f8so1283393a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 11:14:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLFirEnG6jQz/qnASVnW4oC6TvTE0OK8KSISCiEbadql+sNthH/ulSLL8EycAqrgQGPsaan2up3XJTt6V0Iy/iN8LOqXgvVVn37XUs
X-Received: by 2002:a17:906:6c8b:b0:a44:8daa:684a with SMTP id
 s11-20020a1709066c8b00b00a448daa684amr1910978ejr.23.1709320496462; Fri, 01
 Mar 2024 11:14:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYNDspuGxYx5kym8Lvp--D36CMDUErg4rxfWFJuPbbji8g@mail.gmail.com>
 <70bfa1c9-6790-4537-bdc5-5d633c6ea806@I-love.SAKURA.ne.jp>
In-Reply-To: <70bfa1c9-6790-4537-bdc5-5d633c6ea806@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Mar 2024 11:14:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjnYs-jYR-omTJGB-WAH4RQH4b=9NU6N_7foZxjTWK-fQ@mail.gmail.com>
Message-ID: <CAHk-=wjnYs-jYR-omTJGB-WAH4RQH4b=9NU6N_7foZxjTWK-fQ@mail.gmail.com>
Subject: Re: [PATCH for 6.8] tomoyo: fix UAF write bug in tomoyo_write_control()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Sam Sun <samsun1006219@gmail.com>, paul@paul-moore.com, 
	syzkaller@googlegroups.com, takedakn@nttdata.co.jp, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Mar 2024 at 05:04, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> I couldn't reproduce this problem in my environment, but I believe
> this does fix a bug. Linus, can you directly apply to linux.git ?

Thanks. Applied,

        Linus

