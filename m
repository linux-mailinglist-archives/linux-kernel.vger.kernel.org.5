Return-Path: <linux-kernel+bounces-130236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC0D8975C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184A9282827
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB0A152181;
	Wed,  3 Apr 2024 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TCCp6BSw"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EF818E20
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163596; cv=none; b=UMxIMKe5qodPvbDkC7h7rd4JditLw9gPQO6yn9c6pwcO07McLTZWzm75/VbPQUgdPlZLiDG8Gx6I1mWdobRLHtErWC1STKYq76BF7sBUAtHeH0r/N7gshbxLYjTDxjWlJFpkCJHWkVZ6Y2bLn3wXX4+Erh+d4NpDSQtN2tZvJ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163596; c=relaxed/simple;
	bh=1QHEDPpqFRVTaMitRFRECKns1ULA3ceFkMwOdLkg8FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbUqYyIF4cLqQu8QtqaNW8wRIEB6CxclmPo/LHGCBduDarVxPQGL2YerPHAjZqQYhJxE50Uhav3j3PTBxEJztTUNDefLiDhG6XA3e8pp3eL8M0Cp2yIn3lZRMMYLB5CL9TexM+FPGSVG8lxdta5Kz1Fx8D6/BfH4+xVeqbIZuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TCCp6BSw; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56c583f5381so31594a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712163593; x=1712768393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9zZqVSe49xG+Cuf6x2/pIzSVIeoqPFNTQJEfQlqHLac=;
        b=TCCp6BSwTIKImCa6ejUZOPRl8RsaJEURQMAwwU7IHez/VMYlGRhnn9pSN9ctNafl5+
         6iHtQuJA4ZXkg4Ce42HjQ660rSmAhMRbGLX1VBWYeMrG/P9SYdN7TXCF970dSrzMsUPd
         a2WRC79HWKBeNYRUnQL8ddgSmlswDktck7p7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712163593; x=1712768393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zZqVSe49xG+Cuf6x2/pIzSVIeoqPFNTQJEfQlqHLac=;
        b=saxRwyP/BnHPhVYNzHZl0coBXHa4W5NdhAUDysj/lBOAaLWlx9kQaIYIJBFhWIlmnX
         ZyKblsOgxwqOEJnph+k6hDKauFlOTLbGUcLcCveSyTCnXVjX4Lm0r2zD+x+bkk6IeGKu
         chnoaYAKol5J0cP072Qis6Ycu3KlQfRNGv2L6sQGBO4/yWMaaJimsmLfRMZZw42dC4ac
         eD4n6PngggPpbQmTGVY4dY2j+I7Z0YqlvVEeswx6jJYt0zpNGxJdQBgoa3ZPQT+Tpt+3
         hu3RuewyGlIejw87r3ymRB83RvGRqMPNUB8WkEFjvhQqv0kYJuG16TuDksK6PUDz5wgf
         epdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV28+VWAynzRClqp1qcE8tIHf0mncJ26rKUKGbronuPk00n1ssh3jXYJk3/cx7XYw89D4lYSXG4pzDtEMw6LlKvfIQV9XaboO9n9cwm
X-Gm-Message-State: AOJu0YxuAp8EKEi1h6MiSNGRRTC5HpCFigss8fRsnDcPptgDCYyxWZ6Y
	mDRB0J7xN3n/HBYYvHtMclNeTAwVvv984B8IsYwfuQJaqdpv2eAL7UB+IYdwYbqU2sNggl6g447
	eD32TzA==
X-Google-Smtp-Source: AGHT+IGFcUcKE8xBWlQHBHh8Ky7wWnA5poHa0wgnwOyjVbemyKgANEtyPTlm2qEvgmpxK12AwMsn6Q==
X-Received: by 2002:a50:d503:0:b0:56d:c85a:7893 with SMTP id u3-20020a50d503000000b0056dc85a7893mr235930edi.8.1712163592906;
        Wed, 03 Apr 2024 09:59:52 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a17-20020a05640233d100b0056ded9bc62esm2039272edc.43.2024.04.03.09.59.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 09:59:52 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a47385a4379so231978766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 09:59:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGJbfXEKRVmasv8vM2pw/Pua4LY/DnBvOvs2ixgqC/XvMx7Dp9Xvl3cjc42SwiydkQP+eZgmvhXHcHyAKQ+TyLEIabWbFJq/vRhEjl
X-Received: by 2002:a17:906:4f0f:b0:a47:3afd:4739 with SMTP id
 t15-20020a1709064f0f00b00a473afd4739mr2945922eju.6.1712163592316; Wed, 03 Apr
 2024 09:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403090749.2929667-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240403090749.2929667-1-roberto.sassu@huaweicloud.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Apr 2024 09:59:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjG-V-9USyDTWqUhY7YxEwSfwC9yA7LJkT7uGbHHFZeYQ@mail.gmail.com>
Message-ID: <CAHk-=wjG-V-9USyDTWqUhY7YxEwSfwC9yA7LJkT7uGbHHFZeYQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v3] security: Place security_path_post_mknod()
 where the original IMA call was
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-integrity@vger.kernel.org, pc@manguebit.com, 
	Roberto Sassu <roberto.sassu@huawei.com>, Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 02:10, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> Move security_path_post_mknod() where the ima_post_path_mknod() call was,
> which is obviously correct from IMA/EVM perspective. IMA/EVM are the only
> in-kernel users, and only need to inspect regular files.

Thanks, applied,

              Linus

