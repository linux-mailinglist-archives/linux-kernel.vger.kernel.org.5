Return-Path: <linux-kernel+bounces-142776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956BB8A2FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63641C23D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECEA8564A;
	Fri, 12 Apr 2024 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixZlBc86"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2AC83CDD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930188; cv=none; b=msrRBlNb5ufz3/nDB2X9j1u6dKhmgFrpGLX0Lsl8x+wTr4vFRU8g6fDFQK2YG9/JVSbSciBpqNSkI7Zkziw0QF2zyHn3fu8iRGf5jgywTJ9az9OSTLJF3YM9oij8IMjwFu8BUfY9d+CjJ6Hx5bqkVZzg7HsRG/WTN1pzql6sta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930188; c=relaxed/simple;
	bh=ZJ7SAOS7xGxTsMVG6sFaevHFQfwYJuNhpZbGStyKNJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNzkRTHfB3kfeVX/E8yF+yWVrDH1wfZ0J8yKNJKegdlX4xvh9gRlem9re4B0yStsbBnmO80NXl0TEou0Sovofm/UVpBeUFkCdx3952jZktumphN7firtuUV7Ddnmi8Trl67xFMHRkyQkiZnnvAc6WOOAMddI1ijOhOFokCCiSjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixZlBc86; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a51969e780eso127232866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712930185; x=1713534985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ7SAOS7xGxTsMVG6sFaevHFQfwYJuNhpZbGStyKNJE=;
        b=ixZlBc86h+s2zLgKwGXYTLSPw3Nnb8tjl/QDQst5FsQ7+Lq7E4J9qFaNSk4h8uIE4J
         N4NU720jmRo7lzGwHl9dzgkqBwUFB1Yy2TZXQpI88oRSR53pw+GQvbhowi/egljK0Mlx
         ihECOJDuOaEhzU6gcjTaSEGrYgfMmUr5Jh7BO8nGHwtqfpKIfnybsD86sDlvWEH42A/6
         j0N37lNGyZEdMlzb9WqO+J+16yMAFQYf7JW9mmUJtEosjXFdVG9iSvFLas1XnLj65rQw
         el6k5i7kh8qAaCzRoAb0yeZRgT8gtf2UHsBzgRRSsK7EUKMChgJwIAMc09dlsyWdiqjG
         UEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712930185; x=1713534985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJ7SAOS7xGxTsMVG6sFaevHFQfwYJuNhpZbGStyKNJE=;
        b=XXVYKtX7uvc5FIcv6Uvj2R4uCBK/J8fdmysTTMIbJMk/Q3h6Bl/807l0AecdpfR9Ne
         +nB+tYoe7SpAfVJCcBa7jTy+Fyc4BTTBlUN063dbvGHgYebO8xfmuUDVRh54bbwtJPhr
         kb6Hfv/3EU3Dmx1v5pGOj73sIq/FDqa55Nsfp3lPHicf3mWbn3D6E7leGS94Q1JWxzcP
         2b/ZUwZZkj03nkHRox7/r1HFoySJdgwsxzkfsJ6Qj0HaRMQEI8/Yl6eqgGjC99jn8Zqb
         +MhaUdbsDYG+NRc9/1w8/z9Y2UZzwpfjNZ0ezNU/t6stanzN+xUsfUF0P1cXWzvpkCAS
         YC6A==
X-Forwarded-Encrypted: i=1; AJvYcCUkCv1sZTuJe0WJjwC0YTe2U0cpaOzYQQi3WXW2Lb+pPUR3ZPWJE3Vz4G/LJFRxauADc6nfwTOV+ztLG6nPF8tA8HPlKj44m8YyxpZR
X-Gm-Message-State: AOJu0Yxt5QvLrGmeli8vr8YvHtRJKG+6Z9gBJvxz72HRgf9LIxcMiNZ7
	5d4ttkaIN73ZOmKsYfOuj2bEyRaW7W/K1RSN8q4btSJz8M7LWSH3/MGnbKTS8uc45JQcBkTOZdP
	hIumeHz93NWghgAaEbq5X0rfQfAoEKaPsRhPhJmwjOq0=
X-Google-Smtp-Source: AGHT+IEDXrLG8FZXTHsCQpLYzMx6KHxkb2zPWOAEXIY9YlFLnDUe2aW5heCn4m5K9ZB7wM2LnpcDeVIEPG0fxFDQF48=
X-Received: by 2002:a17:906:4c45:b0:a4e:9962:2dfc with SMTP id
 d5-20020a1709064c4500b00a4e99622dfcmr1455682ejw.21.1712930185309; Fri, 12 Apr
 2024 06:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407132054.12170-1-qq810974084@gmail.com> <2024041153-undrilled-partition-2a9e@gregkh>
 <CAH9++vFsOUADuQ5Rnx1Kv-Q7Y54pZMh_Ou46OPp9xZ2va6EpBQ@mail.gmail.com>
In-Reply-To: <CAH9++vFsOUADuQ5Rnx1Kv-Q7Y54pZMh_Ou46OPp9xZ2va6EpBQ@mail.gmail.com>
From: Huai-Yuan Liu <qq810974084@gmail.com>
Date: Fri, 12 Apr 2024 21:55:46 +0800
Message-ID: <CAH9++vG2f7Lrs=dq_RB7d9Lkni0kUL6LKA12KUU_SqwJ=GCnGw@mail.gmail.com>
Subject: Re: [PATCH V3] ppdev: Add an error check in register_device
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sudipm.mukherjee@gmail.com, arnd@arndb.de, linux-kernel@vger.kernel.org, 
	baijiaju1990@outlook.com
Content-Type: text/plain; charset="UTF-8"

Hi,

I sincerely apologize for my negligence in not noticing the branch
changes,, resulting in this patch not being applicable to the tree. I
have regenerated a new patch and sent it. I apologize once again for
any trouble caused by my oversight. And thanks to Greg KH for pointing
this out.

Best regards,

Liu.

